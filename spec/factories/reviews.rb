# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :review do
    title "MyText"
    content "MyText"
    rating 1
    user_id 1
    reviewable_id 1
    reviewable_type "MyString"
  end
end
