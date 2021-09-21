require "administrate/field/base"

class StatusField < Administrate::Field::Base
  def to_s
    data.to_s.humanize
  end
end
