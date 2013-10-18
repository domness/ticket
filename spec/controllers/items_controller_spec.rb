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

end
