class Buyers::DocumentsController < Buyers::ApplicationController
  def index
    flash.now[:warning] = t('.complete_your_profile_html', complete_link: view_context.link_to(t('.complete_link_html'), edit_buyers_district_profile_path, class: 'flash__link')).html_safe unless current_buyer.district_profile&.complete?
    @documents = current_buyer.rfps.order(updated_at: :desc).page(params[:page] || 1).per(params[:per_page] || Kaminari.config.default_per_page)
  end
end
