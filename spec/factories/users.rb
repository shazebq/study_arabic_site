# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    first_name "Billy"
    last_name "Jones"
    bio "a cool arabic teacher"
    country_id 1
    #encrypted_password "foobar"
    sequence(:username) { |i| "person_#{i}"}
  end
end
