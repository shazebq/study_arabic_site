# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

categories_all = ["Egypt", "Jordan", "Yemen", "Morocco", "Lebanon", "Qatar", "Oman",
                  "United States", "United Kingdom", "Other Country",  "Arabic Centers",
                  "Traveling Abroad", "Sightseeing", "Roommates", "Getting Around", "Housing",
                  "Books", "Universities", "Study Advice", "Tutoring", "Grammar", "Vocabulary", "Morphology",
                  "Countries", "Study Abroad", "Arabic Language"]

categories_all.each { |category_name| Category.create(name: category_name)}


category_set = [ [ "Egypt", "Jordan", "Yemen", "Morocco", "Lebanon", "Qatar", "Oman",
                    "United States", "United Kingdom", "Other Country" ],
                 [ "Arabic Centers", "Traveling Abroad", "Sightseeing", "Roommates", "Getting Around", "Housing" ],
                 [ "Books", "Universities", "Study Advice", "Tutoring", "Grammar", "Vocabulary", "Morphology"] ]

parents = [ "Countries", "Study Abroad", "Arabic Language" ]

count = 0
category_set.each do |set|
  parent = parents[count]
  set.each do |name|
    Category.find_by_name(name).update_attributes(category_parent_id: Category.find_by_name(parent).id)
  end
  count += 1
end