class Buyers::NavigationComponentPreview < ViewComponent::Preview
  def default
    render(Buyers::NavigationComponent.new(current_path: Rails.application.routes.url_helpers.buyers_documents_path))
  end
end
