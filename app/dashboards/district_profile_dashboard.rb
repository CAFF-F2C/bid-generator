require 'administrate/base_dashboard'

class DistrictProfileDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    buyer: Field::BelongsTo,
    id: Field::Number,
    district_name: Field::String,
    city: Field::String,
    county: Field::String,
    enrolled_students_number: Field::Number,
    daily_meals_number: Field::Number,
    schools_number: Field::Number,
    production_sites_number: Field::Number,
    created_at: Field::DateTime.with_options(format: :long),
    updated_at: Field::DateTime.with_options(format: :long)
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    district_name
    buyer
    city
    county
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    buyer
    id
    district_name
    city
    county
    enrolled_students_number
    daily_meals_number
    schools_number
    production_sites_number
    created_at
    updated_at
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how district profiles are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(district_profile)
    district_profile.district_name
  end
end
