class Item < ActiveRecord::Base
  belongs_to :project
  belongs_to :creator, class_name: 'User'
  belongs_to :assignee, class_name: 'User'

  # title: returns all the details regarding the ticket text
  # i.e. who + what + why
end
