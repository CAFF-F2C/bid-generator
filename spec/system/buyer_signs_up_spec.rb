require 'rails_helper'

RSpec.describe 'Buyer signs up', type: :system do
  before do
    create(:admin_user, email: 'admintest@example.com', notify_signup: true)
  end

  it 'creates an account', :js do
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

    check 'I have read and agreed to the Terms of Conditions.'

    perform_enqueued_jobs { click_on 'Sign up' }

    open_email('admintest@example.com')
    expect(current_email).to have_content 'A new buyer account has signed up with the email: buyer@example.com.'

    expect(page).to have_content(/confirmation link/i)
    expect(page).to be_axe_clean

    click_on "Didn't receive confirmation instructions?"

    fill_in 'Email', with: 'buyer@example.com'
    perform_enqueued_jobs { click_on 'Resend instructions' }

    expect(page).to have_content(/confirm your email address/i)

    open_email 'buyer@example.com'
    current_email.click_link('Confirm my account')

    expect(page).to have_content(/sign into your account/i)
    expect(page).to be_axe_clean

    fill_in 'Email', with: 'buyer@example.com'
    fill_in 'Password', with: 'password'

    click_on 'Log in'

    expect(page).to have_content(/requests for proposals/i)
    click_on 'Log out'
    expect(page).to have_content(/sign into your account/i)

    click_on 'Forgot your password?'
    expect(page).to have_content(/forgot your password/i)
    expect(page).to be_axe_clean

    fill_in 'Email', with: 'buyer@example.com'
    perform_enqueued_jobs { click_on 'Send reset instructions' }

    open_email 'buyer@example.com'
    current_email.click_link('Change my password')

    expect(page).to have_content(/Change your password/i)
    expect(page).to be_axe_clean

    fill_in 'New password', with: 'password1'
    fill_in 'Password confirmation', with: 'password1'

    click_on 'Change my password'

    expect(page).to have_content(/password has been changed successfully/)
  end
end
