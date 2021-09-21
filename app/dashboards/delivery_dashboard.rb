require 'administrate/base_dashboard'

class DeliveryDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    rfp: Field::BelongsTo,
    location: Field::BelongsTo,
    id: Field::Number,
    delivery_days: Field::Number,
    deliveries_per_week: Field::Number,
    display_delivery_days: Field::String,
    display_delivery_window: Field::String,
    location_name: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    window_start_time: Field::Number,
    window_end_time: Field::Number
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    location
    deliveries_per_week
    display_delivery_window
    display_delivery_days
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    rfp
    location
    deliveries_per_week
    display_delivery_window
    display_delivery_days
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    rfp
    location
    delivery_days
    deliveries_per_week
    window_start_time
    window_end_time
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

  # Overwrite this method to customize how deliveries are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(delivery)
  #   "Delivery ##{delivery.id}"
  # end
end
