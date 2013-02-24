module ReviewableScoping
  def self.included(c)
    c.scope :order_by_reviews, c.order("reviews_count DESC")
  end
end




