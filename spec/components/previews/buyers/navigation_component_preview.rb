class Buyers::NavigationComponentPreview < ViewComponent::Preview
  def default
    render(Buyers::NavigationComponent.new)
  end
end
