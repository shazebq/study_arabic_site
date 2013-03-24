module ApprovedScoping
  def self.included(c)
    c.scope :only_approved, c.where(approved: true)
  end
end
 
