require 'spec_helper'

describe ItemHelper do

  describe :item_buttons do
    let(:project) { double(:project, id: 1) }
    let(:item)    { double(:item, id: 2, status: 'backlog') }

    context 'item is in backlog' do
      before do
        @buttons = item_buttons(project, item)
      end

      it 'includes the start text' do
        expect(@buttons).to include('Start')
      end

      it 'renders the correct URL' do
        expect(@buttons).to include('/projects/1/items/2/start')
      end
    end

    context 'item is in current' do
      before do
        item.stub(status: 'current')
        @buttons = item_buttons(project, item)
      end

      it 'includes the stop text' do
        expect(@buttons).to include('Stop')
      end

      it 'renders the stop URL' do
        expect(@buttons).to include('/projects/1/items/2/stop')
      end

      it 'includes the complete text' do
        expect(@buttons).to include('Complete')
      end

      it 'renders the complete URL' do
        expect(@buttons).to include('/projects/1/items/2/complete')
      end
    end

    context 'item is in complete' do
      before do
        item.stub(status: 'complete')
        @buttons = item_buttons(project, item)
      end

      it 'includes the reject text'do
        expect(@buttons).to include('Reject')
      end

      it 'renders the reject URL' do
        expect(@buttons).to include('/projects/1/items/2/reject')
      end
    end
  end

  describe :item_panel_class do
    it "returns the panel class for stories" do
      item_panel_class('story').should == "panel-success"
    end

    it "returns the panel class for tasks" do
      item_panel_class('task').should == "panel-warning"
    end

    it "returns the panel class for defects" do
      item_panel_class('defect').should == "panel-danger"
    end

    it "returns the panel class for tests" do
      item_panel_class('test').should == "panel-info"
    end
  end

end
