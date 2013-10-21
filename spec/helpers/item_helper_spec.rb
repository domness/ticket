require 'spec_helper'

describe ItemHelper do

  describe :item_buttons do
    let(:project) { double(:project, id: 1) }
    let(:item)    { double(:item, id: 2, backlog?: true) }

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
        item.stub(backlog?: false)
        item.stub(current?: true)
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
  end

end
