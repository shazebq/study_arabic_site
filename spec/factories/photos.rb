# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :photo do
    photographable_id 1
    photographable_type "MyString"
    photo_file "MyString"
  end
end
