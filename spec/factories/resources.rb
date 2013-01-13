# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :resource do
    title "MyText"
    description "MyText"
    downloads_count 1
    views_count 1
    votes_count 1
    difficulty_level 1
    user_id 1
    # if there's validation for an image (not, specs run very slow)
    #resource_file File.open('/home/shazeb/Documents/test.pdf')
  end

  factory :resource_with_categories_categorizable do
    after_create do |forum_post|
      FactoryGirl.create(:category, :resource => resource)
    end
  end
end
