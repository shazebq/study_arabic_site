SELECT teacher_profiles.*, AVG(reviews.rating) AS average_rating
  FROM teacher_profiles
  JOIN reviews ON reviews.reviewable_id = teacher_profiles.id
  WHERE reviews.reviewable_type = 'TeacherProfile'
  GROUP BY teacher_profiles.id
  ORDER BY average_rating DESC


 