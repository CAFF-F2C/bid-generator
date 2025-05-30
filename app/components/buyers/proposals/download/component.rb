class Buyers::Proposals::Download::Component < ApplicationComponent
  attr_accessor :proposal

  def render?
    proposal.valid?(:complete?)
  end
end
