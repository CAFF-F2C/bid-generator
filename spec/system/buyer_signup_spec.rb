require 'rails_helper'

RSpec.describe 'Sign up', type: :system do
  it 'allows a buyer to sign up', :js do
    visit root_path

    click_on 'Sign up'
    # expect(page).to be_axe_clean

    fill_in 'Full name', with: 'Buyer Name'
    fill_in 'Email', with: 'buyer@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_on 'Sign up'

    # disable until sendgrid works
    # expect(page).to have_content(/confirmation link/i)

    # open_email 'buyer@example.com'
    # current_email.click_link('Confirm my account')

    # click_on 'Log in'

    # fill_in 'Email', with: 'buyer@example.com'
    # fill_in 'Password', with: 'password'

    # click_on 'Log in'

    expect(page).to have_content(/my documents/i)
    click_on 'Sign out'
    expect(page).to have_content(/log in/i)
  end
end
