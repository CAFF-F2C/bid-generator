require 'administrate/base_dashboard'

class RfpDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    buyer: Field::BelongsTo,
    id: Field::Number,
    school_year: Field::String,
    procurement_type: Field::BelongsTo,
    positive_scores: ScoresField,
    total_score: Field::Number,
    item_list: AttachedDocumentField.with_options(destroy_url: proc { |resource| [:admin_rfp_item_list_destroy, {id: resource.id}] }),
    download: DownloadDocumentField,
    draft: AttachedDocumentField.with_options(destroy_url: proc { |resource| [:admin_rfp_draft_destroy, {id: resource.id}] }),
    reviewed: AttachedDocumentField.with_options(destroy_url: proc { |resource| [:admin_rfp_reviewed_destroy, {id: resource.id}] }),
    final: AttachedDocumentField.with_options(destroy_url: proc { |resource| [:admin_rfp_final_destroy, {id: resource.id}] }),
    status: StatusField,
    deliveries: Field::HasMany,
    created_at: Field::DateTime.with_options(format: :long),
    updated_at: Field::DateTime.with_options(format: :long),
    start_year: Field::Number
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    buyer
    procurement_type
    school_year
    status
    created_at
    updated_at
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    buyer
    procurement_type
    school_year
    created_at
    updated_at
    positive_scores
    total_score
    deliveries
    item_list
    download
    draft
    reviewed
    final
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

  # Overwrite this method to customize how rfps are displayed
  # across all pages of the admin dashboard.
  #

  FORM_ATTRIBUTES = %i[
    procurement_type
    start_year
    item_list
  ].freeze

  def display_resource(rfp)
    rfp.name
  end
end
