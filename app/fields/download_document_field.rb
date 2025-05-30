require 'administrate/field/base'

class DownloadDocumentField < Administrate::Field::Base
  def to_s
    'Download'
  end

  def rfp_valid?
    resource.valid?(:complete?)
  end
end
