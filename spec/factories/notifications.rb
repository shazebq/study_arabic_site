# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notification do
    recipient_id 1
    responsible_party_id 1
    recipient_object_id 1
    recipient_object_type "MyString"
    responsible_party_object_id "MyString"
    responsible_party_object_type "MyString"
  end
end
