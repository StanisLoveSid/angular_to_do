require 'rails_helper'

feature 'project edit', js: true do
  given(:user) { create(:user) }

  background do
    login_as(user, scope: :user)
    create(:project, user: user)
    visit '/'
  end

  scenario 'user can cahnge project title' do
    page.find('.glyphicon-pencil').click
    page.find('.edit-input').set 'new title'
    page.find('.glyphicon-ok').click

    expect(page).to have_content 'new title'
  end
end
