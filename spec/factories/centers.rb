# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :center do
    name "Super Cool Arabic Center"
    description "An excellent top notch arabic center"
    short_term false
    long_term false
    website "http://www.coolarabiccenter.com"
    email "bob@coolarabic.com"
    phone_number "405-234-2939"
    address_id 1
    program_length "MyText"
    user_id 1
    private_instruction false
    group_instruction false
    year_established 1998
    price_per_hour_private "9.99"
    price_per_hour_group "9.99"
    total_price "9.99"
    housing_provided false
  end
end
