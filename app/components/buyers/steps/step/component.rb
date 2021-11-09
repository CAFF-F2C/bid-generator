class Buyers::Steps::Step::Component < ApplicationComponent
  attr_accessor :index, :current_index, :section, :path, :valid

  def self.initialize_parameter_names
    [:index, :section, :path]
  end
end
