# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :teacher_profile do
    university "Cairo University"
    field_of_study "Arabic Literature"
    online false
    in_person false
    years_of_experience 1
    specialties "Classical Arabic, tajweed, grammar"
    reviews_count 0
    price_per_hour 5
    approved true
    gender "m"
    employment_history "previous job"
    city_name "Cairo"
    city_id 5
    date_of_birth Date.today - 20.years
  end
end
