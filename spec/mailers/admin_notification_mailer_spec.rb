require 'rails_helper'

RSpec.describe AdminNotificationMailer, type: :mailer do
  let(:buyer) { create(:buyer, email: 'buyer@example.com') }

  before do
    create(:admin_user, email: 'subbed_admin@example.com', notify_signup: true)
    create(:admin_user, email: 'admin@example.com')
  end

  describe 'new_registration' do
    subject(:mail) { described_class.new_registration(buyer) }

    it 'sends the email to subcribed admins' do
      expect(mail.to).to eq(['subbed_admin@example.com'])
    end

    it 'includes the new buyers email' do
      expect(mail.body).to include('buyer@example.com')
    end

    it 'sets the subject' do
      expect(mail.subject).to match('New Buyer Registration')
    end
  end
end
