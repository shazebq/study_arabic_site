SELECT categories.*, COUNT(*) AS number_of_forum_posts
FROM categories
JOIN categories_categorizables ON categories_categorizables.category_id = categories.id
WHERE categorizable_type = 'ForumPost'
GROUP BY categories.id
ORDER BY number_of_forum_posts DESC;