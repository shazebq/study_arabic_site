# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :level do
    title "Advanced"
    description "Formal classes or self study equivalent to four university level years"
    years_of_study 4
  end
end
