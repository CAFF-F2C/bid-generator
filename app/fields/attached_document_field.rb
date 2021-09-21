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
end
