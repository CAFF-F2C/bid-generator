class Buyers::Proposals::Errors::Component < ApplicationComponent
  attr_accessor :proposal, :sections

  def errors_count
    @errors_count ||= section_errors.values.sum(&:count)
  end

  def render?
    errors_count.positive?
  end

  def section_errors
    @section_errors ||= sections.reduce({}) do |result, section|
      proposal.valid?(section)
      result.merge(section => proposal.errors.dup)
    end
  end
end
