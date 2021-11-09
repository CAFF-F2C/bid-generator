class Buyers::Steps::Component < ApplicationComponent
  attr_accessor :current_controller, :title

  renders_many :steps, Buyers::Steps::Step::Component
end
