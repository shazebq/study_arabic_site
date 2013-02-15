# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :teacher_profile do
    university "Cairo University"
    field_of_study "Arabic Literature"
    online false
    in_person false
    years_of_experience 1
    specialties "Classical Arabic, tajweed, grammar"
  end
end