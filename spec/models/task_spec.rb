require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'Associations' do
    it { should belong_to(:project) }
    it { should have_many(:comments).dependent(:destroy) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:title) }
  end

  describe '#as_json' do
    it 'include comments to json' do
      task = create(:task).as_json
      expect(task).to have_key('comments')
    end
  end
end
