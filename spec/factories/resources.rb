# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :resource do
    title "MyText"
    description "MyText"
    downloads_count 1
    views_count 1
    votes_count 1
    difficulty_level 1
    user_id 1
  end
end
