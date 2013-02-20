# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :center, :class => 'Centers' do
    name "MyText"
    description "MyText"
    short_term false
    long_term false
    website "MyString"
    email "MyString"
    phone_number "MyString"
    address_id 1
    program_length "MyText"
    user_id 1
    private_instruction false
    group_instruction false
    year_established 1
    price_per_hour_private "9.99"
    price_per_hour_group "9.99"
    total_price "9.99"
    housing_provided false
  end
end
