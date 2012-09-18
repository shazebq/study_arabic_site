# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :forum_post do
    title "MyText"
    content "MyText"
    views_count 1
    votes_count 1
    user_id 1
    category_id 1
  end
end
