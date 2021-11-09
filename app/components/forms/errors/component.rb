class Forms::Errors::Component < ApplicationComponent
  attr_accessor :messages

  def render?
    messages.present?
  end
end
