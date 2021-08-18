# == Schema Information
#
# Table name: buyers
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  full_name              :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class Buyer < ApplicationRecord
  devise :database_authenticatable, :confirmable, :registerable, :recoverable, :rememberable, :validatable

  has_one :district_profile, inverse_of: :buyer, dependent: :destroy
  has_many :rfps, inverse_of: :buyer, dependent: :destroy
  has_many :locations, inverse_of: :buyer, dependent: :destroy

  delegate :district_name, to: :district_profile, allow_nil: true

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
