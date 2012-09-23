class ForumPost < ActiveRecord::Base
  # in this case, I'm maintaining a has_one relationship between forum_posts and categories
  # but the important point the category that is listed as a post's category is merely it's
  # most specific catgegory and not it's only one
  belongs_to :user
  has_many :ca

  attr_accessible :category_id, :content, :title, :user_id, :views_count, :votes_count



end
