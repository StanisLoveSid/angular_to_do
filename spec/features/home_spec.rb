require 'rails_helper'

feature 'Home page', js: true do
  given(:user) { create(:user) }

  background do
    login_as(user, scope: :user)
    visit '/'
  end

  scenario 'user can logout' do
    click_button 'Log Out'

    expect(page).to have_button 'Log in'
  end

  scenario 'user can add project' do
    click_button 'Add TODO List'

    expect(page).to have_content 'New TODO List'
  end

  scenario 'user can delete project' do
    click_button 'Add TODO List'
    page.find('.glyphicon-trash').click

    expect(page).not_to have_content 'New TODO List'
  end
end
