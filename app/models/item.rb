# A single item/story assignment
class Item < ActiveRecord::Base
  belongs_to :project
  belongs_to :creator, class_name: 'User'
  belongs_to :assignee, class_name: 'User'

  SCORE_COLLECTION = {
    '?' => '0', 'S' => '1', 'M' => '2', 'L' => '3', 'XL' => '5'
  }

  SCORE_TO_TEXT = {
    '0' => '?', '1' => 'S', '2' => 'M', '3' => 'L', '5' => 'XL'
  }

  validates_presence_of :project_id, :creator_id, :item_type
  validates_inclusion_of :item_type, :in => %w( story task defect test )

  scope :backlog, -> { where(status: 'backlog') }
  scope :current, -> { where(status: 'current') }
  scope :completed, -> { where(status: 'complete') }

  def self.score_collection
    SCORE_COLLECTION
  end

  def self.score_to_text
    SCORE_TO_TEXT
  end

  def backlog?
    self.status == 'backlog'
  end

  def current?
    self.status == 'current'
  end

  def assigned_to
    assignee ? assignee.to_s : 'unassigned'
  end

  def human_score
    Item.score_to_text["#{self.score}"]
  end

  def start
    self.status = 'current'
    self.save
  end

  def stop
    self.status = 'backlog'
    self.save
  end

  def complete
    self.status = 'complete'
    self.save
  end
end
