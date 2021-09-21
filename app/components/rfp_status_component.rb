class RfpStatusComponent < ViewComponent::Base
  def initialize(rfp:)
    @rfp = rfp
  end

  def display_status
    @rfp.status.to_s.humanize
  end

  def status_class
    @rfp.status.to_s.dasherize
  end
end
