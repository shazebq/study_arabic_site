# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    address_line "MyText"
    city_id 1
    city_name "Cairo"
  end
end
