require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  subject(:admin) { FactoryBot.create(:admin_user) }

  it { is_expected.to validate_presence_of(:email) }

  describe '#send_devise_notification' do
    it 'sends the notification later' do
      expect do
        admin.send_devise_notification(:reset_password_instructions, 'very_secret_token')
      end.to have_enqueued_job.with(
        'Devise::Mailer',
        'reset_password_instructions',
        'deliver_now',
        args: [admin, 'very_secret_token']
      )
    end
  end
end
