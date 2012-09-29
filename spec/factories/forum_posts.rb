# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :forum_post do
    title "MyText"
    content "MyText"
    views_count 1
    votes_count 1
    user_id 1
    #categories {|categories| [categories.association(:category)]}
  end

  factory :forum_post_with_categories_forum_posts do
    after_create do |forum_post|
      FactoryGirl.create(:category, :forum_post => forum_post)
    end
  end

end
