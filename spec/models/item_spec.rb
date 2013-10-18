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
      expect(Item.score_collection).to eq({'?' => '1', 'S' => '1', 'M' => '2',
                                           'L' => '3', 'XL' => '5'})
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
end
