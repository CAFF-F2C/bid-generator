class RfpStatusComponent < ViewComponent::Base
  def initialize(rfp:)
    @rfp = rfp
  end

  def status
    'In Progress'
  end

  def status_class
    'in-progress'
  end
end
