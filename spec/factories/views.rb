# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :view, :class => 'Views' do
    user_id 1
    viewable_id 1
    viewable_type "ForumPost"
  end
end
