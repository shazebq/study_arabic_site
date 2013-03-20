# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    subject "MyText"
    content "MyText"
    sender_id 1
    recipient_id 1
    conversation_id 1
  end
end
