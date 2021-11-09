class Buyers::DistrictProfiles::Errors::Component < ApplicationComponent
  attr_accessor :district_profile, :sections

  def errors_count
    @errors_count ||= section_errors.values.sum(&:count)
  end

  def render?
    errors_count.positive?
  end

  def section_errors
    @section_errors ||= sections.reduce({}) do |result, section|
      district_profile.valid?(section)
      result.merge(section => district_profile.errors.dup)
    end
  end
end
