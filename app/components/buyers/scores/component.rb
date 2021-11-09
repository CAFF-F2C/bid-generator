class Buyers::Scores::Component < ApplicationComponent
  attr_accessor :name, :description, :path

  renders_many :categories, Buyers::Scores::Category::Component
end
