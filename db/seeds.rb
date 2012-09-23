# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

category_names = [ "Egypt", "Jordan", "Yemen", "Morocco", "Lebanon", "Qatar", "Oman",
              "United States", "United Kingdom", "Study Abroad", "Other Country",
              "Arabic Centers", "Books", "Housing", "Universities", "Traveling Abroad",
              "Sightseeing", "Study Advice", "Roommates", "Getting Around", "Tutoring"]

category_names.each do |category_name|
  Category.create!(name: category_name)
end