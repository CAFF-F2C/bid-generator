class FlashComponentPreview < ViewComponent::Preview
  def default(title: 'Everything is fine')
    render(FlashComponent.new(flash: {notice: title, alert: 'Someone on the internet is wrong'}))
  end
end
