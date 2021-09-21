class RfpStatusComponent < ViewComponent::Base
  def initialize(rfp:)
    @rfp = rfp
  end

  def status
    @status ||=
      [
        ['Final', @rfp.final.attached?],
        ['Review', @rfp.reviewed.attached?],
        ['Draft', @rfp.draft.attached?],
        ['Complete', @rfp.complete?],
        ['In Progress', true]
      ].find { |s| s[1] }[0]
  end

  def status_class
    status.parameterize(separator: '-')
  end
end
