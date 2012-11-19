# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :view, :class => 'View' do
    ip_address "123.456.789"
    session_id "abc123"
    viewable_id 1
    viewable_type "ForumPost"
  end
end
