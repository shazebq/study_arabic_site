# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :categories_categorizable do
    category_id 1
    categorizable_id 1
    categorizable_type "MyString"
  end
end
