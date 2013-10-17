require 'spec_helper'

describe ProjectsController do
  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe :index do
    let(:project) { double(:project) }
    before do
      Project.stub(all: [project])
      get :index
    end

    it 'returns 200 success' do
      expect(response.status).to eq(200)
    end

    it 'gets all the projects' do
      expect(assigns[:projects]).to eq([project])
    end
  end

  describe :new do
    before do
      get :new
    end

    it 'returns 200 success' do
      expect(response.status).to eq(200)
    end

    it 'initialises a new project' do
      expect(assigns[:project]).to be_a_new(Project)
    end
  end

  describe :create do
    let(:project) { double(:project, save: true) }
    before do
      Project.stub(new: project)
    end

    it 'initialises the new project from the parameters' do
      expect(Project).to receive(:new).with({'name'=>'Test'}).and_return(project)
      post :create, project: { name: 'Test' }
    end

    it 'saves the project' do
      expect(project).to receive(:save)
      post :create, project: { name: 'Test' }
    end

    context 'when saving is successful' do
      it 'redirects to the projects index' do
        post :create, project: { name: 'Test' }
        expect(response).to redirect_to projects_path
      end
    end

    context 'when saving is not successful' do
      before do
        project.stub(save: false)
      end

      it 'renders the new template' do
        post :create, project: { name: 'Test' }
        expect(response).to render_template 'new'
      end
    end
  end

  describe :edit do
    let(:project) { double(:project, name: 'Test project') }
    before do
      Project.stub(find: project)
      get :edit, id: 1
    end

    it 'renders 200 success' do
      expect(response.status).to eq(200)
    end

    it 'finds the project' do
      expect(assigns[:project]).to eq(project)
    end
  end

  describe :update do
    let(:project) { double(:project, name: 'Test project') }
    before do
      Project.stub(find: project)
      project.stub(update_attributes: true)
    end

    it 'finds the project' do
      put :update, id: 1, project: { name: 'Test' }
      expect(assigns[:project]).to eq(project)
    end

    it 'updates the project with the params' do
      expect(project).to receive(:update_attributes).with({'name'=>'Test'})
      put :update, id: 1, project: { name: 'Test' }
    end

    context 'when updating attributes succeeds' do
      it 'redirects to the projects index' do
        put :update, id: 1, project: { name: 'Test' }
        expect(response).to redirect_to projects_path
      end
    end

    context 'when updating attributes fails' do
      before do
        project.stub(update_attributes: false)
      end

      it 'renders the edit template' do
        put :update, id: 1, project: { name: 'Test' }
        expect(response).to render_template 'edit'
      end
    end
  end

  describe :destroy do
    let(:project) { double(:project, name: 'Test project') }
    before do
      Project.stub(find: project)
      project.stub(destroy: true)
    end

    it 'finds the project' do
      delete :destroy, id: 1
      expect(assigns[:project]).to eq(project)
    end

    it 'destroys the project' do
      expect(project).to receive(:destroy)
      delete :destroy, id: 1
    end

    it 'redirects to the projects list' do
      delete :destroy, id: 1
      expect(response).to redirect_to projects_path
    end
  end

end
