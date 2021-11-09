class Buyers::Proposals::Section::Field::Component < ApplicationComponent
  attr_accessor :section, :name, :proposal

  def valid?
    proposal.valid?(section)
    !proposal.errors.include?(name)
  end
end
