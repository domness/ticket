# A collection or grouping of items
class Project < ActiveRecord::Base
  has_many :items
end
