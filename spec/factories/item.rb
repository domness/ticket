FactoryGirl.define do
  factory :item do
    project_id    { FactoryGirl.create(:project).id }
    creator_id    1
    item_type     'story'
    who           'user'
    what          'something'
    why           'something'
  end
end
