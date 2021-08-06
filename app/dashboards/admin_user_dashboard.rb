require 'administrate/base_dashboard'

class AdminUserDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    full_name: Field::String,
    email: Field::String,
    reset_password_sent_at: Field::DateTime.with_options(format: :long),
    current_sign_in_at: Field::DateTime.with_options(format: :long),
    last_sign_in_at: Field::DateTime.with_options(format: :long),
    current_sign_in_ip: Field::String,
    last_sign_in_ip: Field::String,
    confirmed_at: Field::DateTime.with_options(format: :long),
    confirmation_sent_at: Field::DateTime.with_options(format: :long),
    unconfirmed_email: Field::String,
    created_at: Field::DateTime.with_options(format: :long),
    updated_at: Field::DateTime.with_options(format: :long)
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    full_name
    email
    last_sign_in_at
    created_at
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    full_name
    email
    reset_password_sent_at
    current_sign_in_at
    last_sign_in_at
    confirmed_at
    confirmation_sent_at
    unconfirmed_email
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    full_name
    email
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

  # Overwrite this method to customize how admin users are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(admin_user)
    admin_user.full_name
  end
end
