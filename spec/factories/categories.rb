# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :category do
    name "MyString"
    category_parent_id 1
    #forum_posts {|forum_posts| [forum_posts.association(:forum_post)]}
  end

  factory :category_with_categories_forum_posts do
    after_create do |category|
      FactoryGirl.create(:forum_post, :category => category)
    end
  end
end
