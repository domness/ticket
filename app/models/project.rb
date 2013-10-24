# A collection or grouping of items
class Project < ActiveRecord::Base
  include Tokenable
  has_many :items
end
