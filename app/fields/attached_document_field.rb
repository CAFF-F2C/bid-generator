require 'administrate/field/base'

class AttachedDocumentField < Administrate::Field::Base
  def to_s
    data.filename
  end

  def filename
    data.filename
  end

  def attached?
    data.present? && data.attached?
  end

  def destroy_url
    options.fetch(:destroy_url, nil)
  end
end
