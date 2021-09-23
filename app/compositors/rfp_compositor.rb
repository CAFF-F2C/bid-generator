class RfpCompositor
  include ActiveModel::Validations

  attr_accessor :rfp

  delegate :buyer, to: :rfp
  delegate :district_profile, to: :buyer
  delegate :complete?, :present?, to: :district_profile, prefix: true
  delegate :complete?, :present?, to: :rfp, prefix: true

  validates :district_profile, presence: true
  validates :district_profile_complete?, inclusion: {in: [true]}, if: :district_profile_present?

  validates :rfp, presence: true
  validates :rfp_complete?, inclusion: {in: [true]}, if: :rfp_present?

  delegate  :district_name,
            :city,
            :county,
            :contact_full_name,
            :contact_department_name,
            :contact_mailing_address_city,
            :contact_mailing_address_state,
            :contact_mailing_address_street,
            :contact_mailing_address_zip,
            :contact_phone_number,
            :contact_title,
            :enrolled_students_number,
            :daily_meals_number,
            :allow_piggyback,
            :local_percentage,
            :price_verified,
            :required_insurance_aggregate,
            :required_insurance_automobile,
            :required_insurance_per_incident,
            to: :district_profile

  delegate :bid_type, :school_year, :start_year, :deliveries, to: :rfp
  delegate :count, to: :deliveries, prefix: :delivery_locations

  def initialize(rfp)
    @rfp = rfp
  end

  def attach
    return false unless valid?

    tempfile = Tempfile.new(['temp_rfp', '.docx'], binmode: true)
    begin
      tempfile.write(template.render_to_string(context))
      tempfile.rewind
      rfp.draft.attach(io: tempfile, filename: "DRAFT_RFP_#{Time.current.to_s(:number)}.docx")
    ensure
      tempfile.close
      tempfile.unlink
    end

    true
  end

  def context
    {
      district_name: district_name,
      city: city,
      county: county,
      contact_full_name: contact_full_name,
      contact_department_name: contact_department_name,
      contact_mailing_address_city: contact_mailing_address_city,
      contact_mailing_address_state: contact_mailing_address_state,
      contact_mailing_address_street: contact_mailing_address_street,
      contact_mailing_address_zip: contact_mailing_address_zip,
      contact_phone_number: contact_phone_number,
      contact_title: contact_title,
      enrolled_students_number: enrolled_students_number,
      local_percentage: "#{local_percentage}%",
      price_verified: price_verified,
      allow_piggyback: allow_piggyback,
      required_insurance_aggregate: required_insurance_aggregate,
      required_insurance_automobile: required_insurance_automobile,
      required_insurance_per_incident: required_insurance_per_incident,
      bid_type: bid_type,
      school_year: school_year,
      daily_meals_number: daily_meals_number,
      case_demonstrated_price_start: previous_november.strftime('%B %Y'),
      case_demonstrated_price_end: previous_july.strftime('%B %Y'),
      price_period_start: Date.new(start_year, 7, 1).strftime('%B %-d, %Y'),
      price_period_end: Date.new(start_year + 1, 6, 30).strftime('%B %-d, %Y'),
      price_verification_date_1: previous_november.end_of_month.strftime('%B %-d, %Y'),
      price_verification_date_2: previous_july.end_of_month.strftime('%B %-d, %Y'),
      price_verification_invoice_date_1: previous_november.strftime('%B %Y'),
      price_verification_invoice_date_2: previous_july.strftime('%B %Y'),
      delivery_days: delivery_days,
      total_deliveries_count: deliveries.sum(:deliveries_per_week),
      delivery_locations_count: delivery_locations_count,
      deliveries: serialized_deliveries,
      scores: serialized_scores,
      vendor_questions: serialized_vendor_questions
    }
  end

  private

  def serialized_deliveries
    deliveries.map do |delivery|
      {
        name: delivery.location_name,
        address: delivery.location.full_address,
        delivery_window: delivery.display_delivery_window,
        delivery_days: delivery.display_delivery_days,
        deliveries_per_week: delivery.deliveries_per_week
      }
    end
  end

  def serialized_scores
    rfp.positive_scores.joins(:score_category).order(position: :asc).map do |score|
      {
        name: score.name,
        point_awarded_basis: score.point_awarded_basis,
        point_split_descriptions: score.point_split_descriptions,
        value: score.value
      }
    end
  end

  def serialized_vendor_questions
    rfp.positive_scores.joins(:score_category).order(position: :asc).map do |score|
      score.score_category.vendor_questions
    end
  end

  def delivery_days
    deliveries.collect(&:delivery_days).flatten.uniq.map { |d| Date::DAYNAMES[d] }.join(', ')
  end

  def previous_november
    Date.current.month >= 11 ? Date.new(Date.current.year, 11) : Date.new(Date.current.prev_year.year, 11)
  end

  def previous_july
    Date.current.month >= 7 ? Date.new(Date.current.year, 7) : Date.new(Date.current.prev_year.year, 7)
  end

  def template
    file_name = Dir.glob('vendor/assets/templates/rfp/*.docx').first
    Sablon.template(File.expand_path(file_name))
  end
end
