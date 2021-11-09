class Buyers::Proposals::Documents::Component < ApplicationComponent
  attr_accessor :proposal

  def render?
    proposal.valid?(:complete?)
  end
end
