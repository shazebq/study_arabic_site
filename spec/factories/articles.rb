# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    user_id 1
    title "MyText"
    content "MyText"
    views_count 1
    votes_count 1
  end
end
