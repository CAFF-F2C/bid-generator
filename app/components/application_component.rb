class ApplicationComponent < ViewComponent::Base
  include ActiveModel::AttributeAssignment

  def initialize(attributes = {})
    assign_attributes(attributes) if attributes

    super()
  end
end
