class Buyers::DistrictProfiles::Section::Field::Component < ApplicationComponent
  attr_accessor :section, :name, :district_profile

  def valid?
    district_profile.valid?(section)
    !district_profile.errors.include?(name)
  end
end
