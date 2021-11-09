class Buyers::Navigation::Sidebar::Component < ApplicationComponent
  attr_accessor :namespace, :current_controller

  class Route
    include ActiveModel::Validations
    include ActiveModel::AttributeAssignment

    attr_accessor :namespace, :controller, :actions

    validates :controller, format: {with: ->(route) { %r{\A#{route.namespace}/[^/]+\z} }}

    validates :path, presence: true

    def initialize(attributes = {})
      assign_attributes(attributes) if attributes
      super()
    end

    def path
      return url_helpers.url_for(controller: controller, action: 'index', only_path: true) if actions.include?('index')

      url_helpers.url_for(controller: controller, action: 'show', only_path: true)
    rescue ActionController::UrlGenerationError
      nil
    end

    def action
      Rails.application.routes.recognize_path(path)[:action] if path.present?
    end

    private

    def url_helpers
      Rails.application.routes.url_helpers
    end
  end

  def routes
    all_routes.map { |controller, actions| Route.new(namespace: namespace, controller: controller, actions: actions) }.select(&:valid?)
  end

  private

  def all_routes
    Rails.application.routes.routes.each_with_object({}) do |route, routes|
      controller, action = route.defaults.values_at(:controller, :action)
      routes[controller.to_s] ||= []
      routes[controller.to_s] = routes[controller.to_s].concat([action.to_s]).uniq
    end
  end
end
