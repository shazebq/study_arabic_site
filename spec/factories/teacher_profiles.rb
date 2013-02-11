# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :teacher_profile do
    education "MyText"
    online false
    in_person false
    years_of_experience 1
  end
end
