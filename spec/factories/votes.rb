# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vote do
    user_id 1
    voteable_id 1
    voteable_type "ForumPost"
  end
end
