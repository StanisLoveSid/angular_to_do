require 'rails_helper'

feature 'tasks managing', js: true do
  given(:user) { create(:user) }

  background do
    login_as(user, scope: :user)
    @project = create(:project, user: user)
    @task = create(:task, project: @project)
    visit '/'
  end

  context 'adding tasks' do
    scenario 'when valid title' do
      page.find("input[placeholder='Start typing here to create a task...']")
          .set 'new task'
      click_button 'Add Task'

      expect(page).to have_content 'new task'
    end

    scenario 'when invalid title' do
      page.find("input[placeholder='Start typing here to create a task...']")
          .set ' '
      click_button 'Add Task'

      expect(page).to have_content "Title can't be blank"
    end
  end

  scenario 'remove task' do
    within '.task-control' do
      page.find('.glyphicon-trash').click
    end

    expect(page).not_to have_content @task.title
  end

  context 'editing tasks' do
    scenario 'when valid title' do
      within '.task-container' do
        page.find('.glyphicon-pencil').click
        page.find('.form-control').set 'edited task'
        page.find('.glyphicon-ok').click
      end

      expect(page).not_to have_content 'edited task'
    end

    scenario 'when invalid title' do
      within '.task-container' do
        page.find('.glyphicon-pencil').click
        page.find('.form-control').set('')
        page.find('.glyphicon-ok').click
      end

      expect(page).to have_content "Title can't be blank"
    end
  end

  scenario 'mark as done' do
    within '.task-status' do
      page.find('.ng-valid').set(true)
    end

    expect(page).to have_css('.done')

    within '.task-status' do
      page.find('.ng-valid').set(false)
    end

    expect(page).not_to have_css('.done')
  end
end
