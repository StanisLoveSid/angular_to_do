require 'rails_helper'

feature 'Sign up', js: true do
  given(:user) { build(:user) }
  background { visit '#!/signup' }

  scenario 'sign up with valid data' do
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button 'Sign up'

    expect(page).to have_content 'Log Out'
    expect(page).to have_content 'Add TODO List'
  end

  scenario 'when invalid data' do
    fill_in 'email', with: 'qwe@qwe'
    fill_in 'password', with: '123'
    click_button 'Sign up'

    expect(page).to have_content 'Passwordis too short (minimum is 6 characters)'

    user = create(:user)
    fill_in 'email', with: user.email
    fill_in 'password', with: '123qwe'
    click_button 'Sign up'

    expect(page).to have_content 'Email has already been taken'
  end

  scenario 'log in link' do
    click_link 'Log In'

    expect(page).to have_button 'Log in'
  end
end
