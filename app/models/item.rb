# A single item/story assignment
class Item < ActiveRecord::Base
  belongs_to :project
  belongs_to :creator, class_name: 'User'
  belongs_to :assignee, class_name: 'User'

  SCORE_COLLECTION = {
    '?' => '1', 'S' => '1', 'M' => '2', 'L' => '3', 'XL' => '5'
  }

  validates_presence_of :project_id, :creator_id, :item_type
  validates_inclusion_of :item_type, :in => %w( story task defect test )

  scope :backlog, -> { where(status: 'backlog') }

  def self.score_collection
    SCORE_COLLECTION
  end

  # title: returns all the details regarding the ticket text if it's a story
  # i.e. who + what + why
end
