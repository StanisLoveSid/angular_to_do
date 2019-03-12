require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let(:task) { create(:task, project: project) }
  before { sign_in user }

  describe 'POST #create' do
    context 'when params valid' do
      def send_post
        post :create, format: :json,
                      params: { task: { title: 'Test', project_id: project.id } }
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
        expect { send_post }.to change(Task, :count).by(1)
      end
    end

    context 'when params invalid' do
      before do
        post :create, format: :json,
                      params: { task: { title: '', project_id: project.id } }
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
                        params: { task: { title: '', project_id: project.id } }
        end.not_to change(Task, :count)
      end
    end
  end

  describe 'PUT #update' do
    context 'when params valid' do
      before { put :update, format: :json, params: { id: task.id, task: { title: 'new title' } } }

      it 'responds with success' do
        expect(response).to be_success
      end

      it 'change task title' do
        task.reload
        expect(task.title).to eq('new title')
      end

      it "doesn't change wrong task" do
        task = create(:task)
        put :update, format: :json, params: { id: task.id, task: { title: 'Test' } }
        task.reload
        expect(task.title).not_to eq('Test')
      end
    end

    context 'when params invalid' do
      before { put :update, format: :json, params: { id: task.id, task: { title: '' } } }

      it 'responds with 422' do
        expect(response.status).to eq(422)
      end

      it "doesn't change task title" do
        task.reload
        expect(task.title).to eq('My task')
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) { @task = create(:task, project: project) }

    it 'responds with success' do
      delete :destroy, format: :json, params: { id: @task.id }
      expect(response).to be_success
    end

    it 'delete task' do
      expect do
        delete :destroy, format: :json, params: { id: @task.id }
      end.to change(Task, :count).by(-1)
    end

    it "doesn't delete wrong task" do
      task = create(:task)
      delete :destroy, format: :json, params: { id: task.id }
      expect(response.status).to eq(401)
    end
  end

  describe 'PUT #reorder' do
    before do
      @task1 = project.tasks.create(title: '1')
      @task2 = project.tasks.create(title: '2')
      @task3 = project.tasks.create(title: '3')
    end

    context "when direction 'up'" do
      before { put :reorder, format: :json, params: { id: @task2.id, direction: 'up' } }

      it 'responds with success' do
        expect(response).to be_success
      end

      it 'change task position' do
        @task2.reload
        expect(@task2.position).to eq(1)
      end
    end

    context "when direction 'down'" do
      before { put :reorder, format: :json, params: { id: @task2.id, direction: 'down' } }

      it 'responds with success' do
        expect(response).to be_success
      end

      it 'change task position' do
        @task2.reload
        expect(@task2.position).to eq(3)
      end
    end
  end
end
