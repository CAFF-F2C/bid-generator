class Buyers::RfpNavComponent < ViewComponent::Base
  def initialize(current_path:, current_rfp:)
    @current_path = current_path
    @current_rfp = current_rfp
  end

  def progress_percent
    case @current_path
    when edit_buyers_rfp_path(@current_rfp)
      '12.5%'
    when buyers_rfp_scores_path(@current_rfp)
      '37.5%'
    when buyers_rfp_deliveries_path(@current_rfp)
      '62.5%'
    when edit_buyers_rfp_item_list_path(@current_rfp)
      '87.5%'
    end
  end

  def classes(path)
    current_page?(path) ? 'current' : ''
  end

  def current_page?(path)
    path == @current_path
  end
end
