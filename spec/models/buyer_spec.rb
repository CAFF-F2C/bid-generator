# == Schema Information
#
# Table name: buyers
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  full_name              :string           not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_buyers_on_confirmation_token    (confirmation_token) UNIQUE
#  index_buyers_on_email                 (email) UNIQUE
#  index_buyers_on_reset_password_token  (reset_password_token) UNIQUE

require 'rails_helper'

RSpec.describe Buyer, type: :model do
  subject(:buyer) { FactoryBot.create(:buyer) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
  end

  describe '#send_devise_notification' do
    it 'sends the notification later' do
      expect {
        buyer.send_devise_notification(:reset_password_instructions, 'very_secret_token')
      }.to have_enqueued_job.with(
        'Devise::Mailer',
        'reset_password_instructions',
        'deliver_now',
        args: [buyer, 'very_secret_token']
      )
    end
  end
end
