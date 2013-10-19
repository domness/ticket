require 'spec_helper'

describe Item do
  describe 'associations' do
    it { should belong_to :project }
    it { should belong_to :creator }
    it { should belong_to :assignee }
  end

  describe 'validations' do
    it { should validate_presence_of :project_id }
    it { should validate_presence_of :creator_id }
    it { should validate_presence_of :item_type }
    it { should ensure_inclusion_of(:item_type)
         .in_array(['story', 'task', 'defect', 'test']) }
  end

  describe :score_collection do
    it 'returns possible score values' do
      expect(Item.score_collection).to eq({'?' => '0', 'S' => '1', 'M' => '2',
                                           'L' => '3', 'XL' => '5'})
    end
  end

  describe :score_to_text do
    it 'returns the score values to the text values' do
      expect(Item.score_to_text).to eq({'0' => '?', '1' => 'S', '2' => 'M',
                                        '3' => 'L', '5' => 'XL'})
    end
  end

  describe :backlog do
    let(:backlog_item) { FactoryGirl.create(:item, status: 'backlog') }
    let(:current_item) { FactoryGirl.create(:item, status: 'current') }
    let(:backlog) { Item.backlog }

    it 'gets all the items with the status of backlog' do
      expect(backlog).to include(backlog_item)
    end

    it "doesn't get items that aren't in the backlog" do
      expect(backlog).not_to include(current_item)
    end
  end

  describe :assigned_to do
    context 'when the item is not assigned' do
      it 'returns unassigned' do
        item = Item.new
        expect(item.assigned_to).to eq('unassigned')
      end
    end

    context 'when the item is assigned to someone' do
      it 'returns the assignees name' do
        item = Item.new
        item.stub(assignee: User.new(first_name: 'John', last_name: 'Doe'))
        expect(item.assigned_to).to eq('John Doe')
      end
    end
  end

  describe :human_score do
    context 'when the score is nil' do
      it 'returns ?' do
        item = Item.new
        expect(item.human_score).to eq('?')
      end
    end

    context 'when the score is not nil' do
      it 'returns the score in a t-shirt size' do
        item = Item.new(score: 2)
        expect(item.human_score).to eq('M')
      end
    end
  end
end
