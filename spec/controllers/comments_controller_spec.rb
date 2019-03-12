require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let(:task) { create(:task, project: project) }
  before { sign_in user }

  describe 'POST #create' do
    context 'when params valid' do
      def send_post
        post :create, format: :json,
                      params: { comment: { title: 'Test', task_id: task.id } }
      end

      it 'responds with status success' do
        send_post
        expect(response).to be_success
      end

      it 'responds with json' do
        send_post
        expect(response.content_type).to eq('application/json')
      end

      it 'creates new task' do
        expect { send_post }.to change(Comment, :count).by(1)
      end
    end

    context 'when params invalid' do
      before do
        post :create, format: :json,
                      params: { comment: { title: '', task_id: task.id } }
      end

      it 'responds with status 422' do
        expect(response.status).to eq(422)
      end

      it 'responds with json' do
        expect(response.content_type).to eq('application/json')
      end

      it "doesn't creates new task" do
        expect do
          post :create, format: :json,
                        params: { comment: { title: '', task_id: task.id } }
        end.not_to change(Comment, :count)
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) { @comment = create(:comment, task: task) }

    it 'responds with success' do
      delete :destroy, format: :json, params: { id: @comment.id }
      expect(response).to be_success
    end

    it 'delete task' do
      expect do
        delete :destroy, format: :json, params: { id: @comment.id }
      end.to change(Comment, :count).by(-1)
    end

    it "doesn't delete wrong task" do
      comment = create(:comment)
      delete :destroy, format: :json, params: { id: comment.id }
      expect(response.status).to eq(401)
    end
  end
end
