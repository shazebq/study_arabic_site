class Category < ActiveRecord::Base
  #include PgSearch
  #multisearchable :against => :name
  
  attr_accessible :name, :category_parent_id, :as => [:default, :admin] 

  has_many :categories_categorizables, dependent: :destroy

  # source and source_type is needed because it's a polymorphic join table
  has_many :resources, through: :categories_categorizables, source: :categorizable, source_type: "Resource"
  has_many :forum_posts, through: :categories_categorizables, source: :categorizable, source_type: "ForumPost"
  has_many :articles, through: :categories_categorizables, source: :categorizable, source_type: "Article"

  belongs_to :category_parent

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def self.popular_forums
    select("categories.*, COUNT(*)").
    joins("JOIN categories_categorizables ON categories_categorizables.category_id = categories.id").
    where("categorizable_type = ?", "ForumPost").
    group("categories.id").
    order("COUNT(*) DESC")
  end
end
