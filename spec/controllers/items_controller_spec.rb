require 'spec_helper'

describe ItemsController do
  let(:project) { double(:project, id: 1, name: 'Test project') }

  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe :new do
    before do
      Project.stub(find: project)
      get :new, project_id: 1
    end

    it 'returns 200 success' do
      expect(response.status).to eq(200)
    end

    it 'initialises a new item' do
      expect(assigns[:item]).to be_a_new(Item)
    end

    it 'finds the project' do
      expect(assigns[:project]).to eq(project)
    end
  end

  describe :edit do
    let(:item) { double(:item, id: 2) }
    before do
      Project.stub(find: project)
      Item.stub(find: item)
      get :edit, project_id: 1, id: 2
    end

    it 'returns 200 success' do
      expect(response.status).to eq(200)
    end

    it 'finds the item' do
      expect(assigns[:item]).to eq(item)
    end

    it 'finds the project' do
      expect(assigns[:project]).to eq(project)
    end
  end

  describe :create do
    let(:item) { double(:item, save: true).as_null_object }
    before do
      Project.stub(find: project)
      Item.stub(new: item)
    end

    it 'initialises the new item from the parameters' do
      expect(Item).to receive(:new).with({'description'=>'Test'})
                                   .and_return(item)

      post :create, project_id: 1, item: { description: 'Test' }
    end

    it 'finds the project' do
      post :create, project_id: 1, item: { description: 'Test' }
      expect(assigns[:project]).to eq(project)
    end

    it 'sets the current user' do
      expect(item).to receive(:creator_id=).with(@user.id)
      post :create, project_id: 1, item: { description: 'Test' }
    end

    it 'sets the project ID' do
      expect(item).to receive(:project_id=).with(project.id)
      post :create, project_id: 1, item: { description: 'Test' }
    end

    it 'saves the item' do
      expect(item).to receive(:save)
      post :create, project_id: 1, item: { description: 'Test' }
    end

    context 'when saving is successful' do
      it 'redirects to the items project#show' do
        post :create, project_id: 1, item: { description: 'Test' }
        expect(response).to redirect_to project_path(project)
      end
    end

    context 'when saving is not successful' do
      before do
        item.stub(save: false)
      end

      it 'renders the new template' do
        post :create, project_id: 1, item: { description: 'Test' }
        expect(response).to render_template 'new'
      end
    end
  end

  describe :update do
    let(:item) { double(:item, id: 2, update_attributes: true) }
    before do
      Project.stub(find: project)
      Item.stub(find: item)
    end

    it 'finds the item' do
      put :update, project_id: 1, id: 2, item: { description: 'test' }
      expect(assigns[:item]).to eq(item)
    end

    it 'finds the project' do
      put :update, project_id: 1, id: 2, item: { description: 'test' }
      expect(assigns[:project]).to eq(project)
    end

    it 'updates the item' do
      expect(item).to receive(:update_attributes)
      put :update, project_id: 1, id: 2, item: { description: 'test' }
    end

    context 'when update is successful' do
      it 'redirects to the project#show' do
        put :update, project_id: 1, id: 2, item: { description: 'test' }
        expect(response).to redirect_to(project_path(project))
      end
    end

    context 'when update is not successful' do
      it 'renders the form' do
        item.stub(update_attributes: false)
        put :update, project_id: 1, id: 2, item: { description: 'test' }
        expect(response).to render_template('edit')
      end
    end
  end

  describe :start do
    let(:item) { double(:item, status: 'backlog', save: true).as_null_object }
    before do
      Project.stub(find: project)
      Item.stub(find: item)
    end

    it 'calls start on the item' do
      expect(item).to receive(:start)
      put :start, project_id: 1, id: 1
    end

    it 'redirects to the project#show' do
      put :start, project_id: 1, id: 1
      expect(response).to redirect_to project_path(project)
    end
  end

  describe :stop do
    let(:item) { double(:item, status: 'current', save: true).as_null_object }
    before do
      Project.stub(find: project)
      Item.stub(find: item)
    end

    it 'calls stop on the item' do
      expect(item).to receive(:stop)
      put :stop, project_id: 1, id: 1
    end

    it 'redirects to the project#show' do
      put :stop, project_id: 1, id: 1
      expect(response).to redirect_to project_path(project)
    end
  end

  describe :complete do
    let(:item) { double(:item, status: 'current', save: true).as_null_object }
    before do
      Project.stub(find: project)
      Item.stub(find: item)
    end

    it 'calls complete on the item' do
      expect(item).to receive(:complete)
      put :complete, project_id: 1, id: 1
    end

    it 'redirects to the project#show' do
      put :complete, project_id: 1, id: 1
      expect(response).to redirect_to project_path(project)
    end
  end

  describe :reject do
    let(:item) { double(:item, status: 'complete', save: true).as_null_object }
    before do
      Project.stub(find: project)
      Item.stub(find: item)
    end

    it 'calls start on the item' do
      expect(item).to receive(:start)
      put :reject, project_id: 1, id: 1
    end

    it 'redirects to the project#show' do
      put :reject, project_id: 1, id: 1
      expect(response).to redirect_to project_path(project)
    end
  end

  describe :destroy do
    let(:item) { double(:item).as_null_object }
    before do
      Project.stub(find: project)
      Item.stub(find: item)
      delete :destroy, project_id: 1, id: 2
    end

    it 'finds the project' do
      expect(assigns[:project]).to eq(project)
    end

    it 'finds the item' do
      expect(assigns[:item]).to eq(item)
    end

    it 'destroys the item' do
      expect(item).to receive(:destroy)
      delete :destroy, project_id: 1, id: 2
    end

    it 'redirects to the project#show' do
      expect(response).to redirect_to(project_path(project))
    end
  end
end
