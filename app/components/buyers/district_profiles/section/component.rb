class Buyers::DistrictProfiles::Section::Component < ApplicationComponent
  attr_accessor :name, :description, :path

  renders_many :fields, Buyers::DistrictProfiles::Section::Field::Component
end
