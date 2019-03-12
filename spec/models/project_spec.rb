require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'Associations' do
    it { should belong_to(:user) }
    it { should have_many(:tasks).dependent(:destroy) }
  end

  describe '#as_json' do
    it 'include tasks to json' do
      project = create(:project).as_json
      expect(project).to have_key('tasks')
    end

    it 'include comments to task as json' do
      project = create(:project)
      project.tasks.create(attributes_for(:task))
      expect(project.as_json['tasks'][0]).to have_key('comments')
    end
  end
end
