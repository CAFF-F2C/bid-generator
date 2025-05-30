class Buyers::DownloadsController < Buyers::ApplicationController
  after_action :verify_authorized

  def show
    authorize(current_rfp)
    ::RfpCompositor.new(current_rfp).create do |download|
      send_data download.read, filename: "DRAFT_RFP_#{Time.current.to_fs(:number)}.docx"
    end
  end

  private

  def current_rfp
    @current_rfp ||= Rfp.find(params[:rfp_id])
  end
end
