# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer do
    content "MyText"
    forum_post_id 1
    user_id 1
  end
end
