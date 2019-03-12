require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  let(:user) { create(:user) }
  before { sign_in user }

  describe 'GET #index' do
    context 'when user loged in' do
      let(:project) { create(:project, user: user) }
      before { get :index, format: :json }

      it 'responds with status 200' do
        expect(response).to be_success
      end

      it 'responds with json' do
        expect(response.content_type).to eq('application/json')
      end

      it 'assigns the requested projects to @projects' do
        expect(assigns(:projects)).to eq user.projects
      end
    end

    context 'when user loged out' do
      it 'responds with status 401' do
        sign_out user
        get :index, format: :json
        expect(response.status).to eq(401)
      end
    end
  end

  describe 'POST #create' do
    before { post :create, format: :json }

    it 'responds with status success' do
      expect(response).to be_success
    end

    it 'responds with json' do
      expect(response.content_type).to eq('application/json')
    end

    it 'creates new project' do
      expect do
        post :create, format: :json
      end.to change(Project, :count).by(1)
    end
  end

  describe 'PUT #update' do
    let(:project) { create(:project, user: user) }
    before { put :update, format: :json, params: { id: project.id, title: 'Test' } }

    it 'responds with success' do
      expect(response).to be_success
    end

    it 'change project title' do
      project.reload
      expect(project.title).to eq('Test')
    end

    it "doesn't change wrong project" do
      project = create(:project)
      put :update, format: :json, params: { id: project.id, title: 'Test' }
      project.reload
      expect(project.title).not_to eq('Test')
    end
  end

  describe 'DELETE #destroy' do
    before(:each) { @project = create(:project, user: user) }

    it 'responds with success' do
      delete :destroy, format: :json, params: { id: @project.id }
      expect(response).to be_success
    end

    it 'delete project' do
      expect do
        delete :destroy, format: :json, params: { id: @project.id }
      end.to change(Project, :count).by(-1)
    end

    it "doesn't delete wrong project" do
      project = create(:project)
      delete :destroy, format: :json, params: { id: project.id }
      expect(response.status).to eq(401)
    end
  end
end
