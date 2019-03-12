require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Associations' do
    it { should belong_to(:task) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:title) }
  end
end
