require 'rails_helper'

RSpec.describe Buyer, type: :model do
  subject(:buyer) { FactoryBot.create(:buyer) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to have_many(:rfps).inverse_of(:buyer) }
  it { is_expected.to have_many(:locations).inverse_of(:buyer) }
  it { is_expected.to have_one(:district_profile).inverse_of(:buyer) }

  describe '#send_devise_notification' do
    it 'sends the notification later' do
      expect { buyer.send_devise_notification(:reset_password_instructions, 'z') }.to have_enqueued_job.with(
        'Devise::Mailer',
        'reset_password_instructions',
        'deliver_now',
        args: [buyer, 'z']
      )
    end
  end
end
