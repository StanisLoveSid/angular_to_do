require 'rails_helper'

feature 'Log in', js: true do
  given(:user) { create(:user) }
  background { visit '/' }

  scenario 'log in as persisted user' do
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button 'Log in'

    expect(page).to have_content 'Log Out'
    expect(page).to have_content 'Add TODO List'
  end

  scenario 'when invalid data' do
    fill_in 'email', with: 'qwe@qwe'
    fill_in 'password', with: '123'
    click_button 'Log in'

    expect(page).to have_content 'Invalid Email or password.'
  end

  scenario 'sign up link' do
    click_link 'Sign Up'

    expect(page).to have_button 'Sign up'
  end
end
