class Buyers::Proposals::Section::Component < ApplicationComponent
  attr_accessor :name, :description, :path

  renders_many :fields, Buyers::Proposals::Section::Field::Component
end
