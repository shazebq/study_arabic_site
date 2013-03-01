module ReviewableScoping
  def self.included(c)
    c.scope :order_by_reviews, c.order("reviews_count DESC")
    c.scope :zero_review_records, c.where("reviews_count = 0")
  end

  def order_by_average_rating()
   table_name = self.name.underscore.pluralize # this is either TeacherProfiles or Centers for now
   profiles = select("#{table_name}.*, AVG(reviews.rating) AS average_rating").
              joins("JOIN reviews ON reviews.reviewable_id = #{table_name}.id").
              where("reviews.reviewable_type = ?", self.name).
              group("#{table_name}.id").
              order("average_rating DESC")
  end
end




