require 'rails_helper'

RSpec.describe 'Buyer signs up', type: :system do
  before do
    create(:admin_user, email: 'admintest@example.com', notify_signup: true)
  end

  it 'creates an account', :js, skip: 'testing devise?' do
    visit root_path

    expect(page).to have_content('Sign into your account')
    expect(page).to be_axe_clean

    click_on 'create an account'

    expect(page).to have_content('Create your account')
    expect(page).to be_axe_clean

    fill_in 'Full name', with: 'Buyer Name'
    fill_in 'Email', with: 'buyer@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    check 'I have read and agreed to the Terms and Conditions.'

    click_on 'Sign up'

    expect(page).to have_content(/confirmation link/i)
    expect(page).to be_axe_clean

    expect(page).to have_content(/receive confirmation instructions?/i)
    click_on 'receive confirmation instructions?'

    expect(page).to have_content(/resend instructions/i)

    fill_in 'Email', with: 'buyer@example.com'
    perform_enqueued_jobs do
      click_on 'Resend instructions'
      expect(page).to have_content(/sign into your account/i)
    end

    perform_enqueued_jobs do
      open_email 'buyer@example.com'
      current_email.click_link('Confirm my account')
    end

    open_email 'admintest@example.com'
    expect(current_email).to have_content 'A new buyer account has signed up with the email: buyer@example.com.'
  end
end
