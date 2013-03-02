SELECT * FROM teacher_profiles
JOIN users on teacher_profiles.id = users.profile_id
WHERE users.profile_type = 'TeacherProfile'
AND users.country_id IS NOT NULL

DELETE FROM 