# Display Rails error messages
class FlashComponent < ViewComponent::Base
  def initialize(flash:)
    @flash = flash
  end
end
