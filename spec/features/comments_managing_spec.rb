require 'rails_helper'

feature 'comments managing', js: true do
  given(:user) { create(:user) }

  background do
    login_as(user, scope: :user)
    @project = create(:project, user: user)
    @task = create(:task, project: @project)
    @comment = create(:comment, task: @task)
    visit '/'
  end

  context 'adding comments' do
    scenario 'when valid title' do
      find('.task-container').hover
      find('.glyphicon-comment').click
      within '.comments-container' do
        find('.comment-edit').set 'new comment'
        find('.glyphicon-ok').click
      end

      expect(page).to have_content('new comment')
    end

    scenario 'when invalid title' do
      find('.task-container').hover
      find('.glyphicon-comment').click
      within '.comments-container' do
        find('.comment-edit').set ''
        find('.glyphicon-ok').click
      end

      expect(page).to have_content "Title can't be blank"
    end
  end

  scenario 'remove task' do
    find('.task-container').hover
    find('.glyphicon-comment').click
    find('.comment').hover
    within '.comment' do
      page.find('.glyphicon-trash').click
    end

    expect(page).not_to have_content @comment.title
  end
end
