FactoryGirl.define do
  factory :item do
    project_id    1
    creator_id    1
    item_type     'story'
    who           'user'
    what          'something'
    why           'something'
  end
end
