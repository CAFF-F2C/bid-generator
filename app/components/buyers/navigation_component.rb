# Display a navigation sidebar for Buyers
class Buyers::NavigationComponent < ViewComponent::Base
  def initialize(current_path:, user:)
    @current_path = current_path
    @user = user
  end

  def current_page?(path)
    path == @current_path
  end
end
