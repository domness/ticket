class Comment < ActiveRecord::Base
  belongs_to :item
  belongs_to :user

  validates_presence_of :body
end
