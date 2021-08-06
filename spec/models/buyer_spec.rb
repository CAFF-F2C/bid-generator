require 'rails_helper'

RSpec.describe Buyer, type: :model do
  subject(:buyer) { FactoryBot.create(:buyer) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
  end

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
