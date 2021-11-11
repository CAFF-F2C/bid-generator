class Admin::ScoreCategoriesController < Admin::ApplicationController
  def default_sorting_attribute
    :position
  end

  def default_sorting_direction
    :asc
  end
end
