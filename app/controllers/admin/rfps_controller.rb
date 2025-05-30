class Admin::RfpsController < Admin::ApplicationController
  def destroy_item_list
    requested_resource.item_list.purge
    redirect_back(fallback_location: requested_resource)
  end

  def download
    rfp = Rfp.find(params[:rfp_id])
    ::RfpCompositor.new(rfp).create do |download|
      send_data download.read, filename: "DRAFT_RFP_#{Time.current.to_fs(:number)}.docx"
    end
  end
  def destroy_draft
    requested_resource.draft.purge
    redirect_back(fallback_location: requested_resource)
  end

  def destroy_reviewed
    requested_resource.reviewed.purge
    redirect_back(fallback_location: requested_resource)
  end

  def destroy_final
    requested_resource.final.purge
    redirect_back(fallback_location: requested_resource)
  end

  def default_sorting_attribute
    :updated_at
  end

  def default_sorting_direction
    :desc
  end
end
