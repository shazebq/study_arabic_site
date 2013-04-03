module CategoriesSeed
  category_set = [ [ "Egypt", "Jordan", "Yemen", "Morocco", "Syria", "Lebanon", "Qatar", "Oman",
                      "United States", "United Kingdom", "Saudi Arabia", "Tunisia" "Other",
                      "Kuwait"],

                  [ "Arabic Centers/Programs", "Traveling Abroad", "Sightseeing", "Roommates", "Getting Around", 
                    "Food", "Housing" ],

                  [ "Grammar", "Vocabulary", "Morphology",
                    "Verbs", "Exercises", "Rhetoric", "Poetry", "Classical Arabic", "Islamic Texts", 
                    "Quran", "Hadith", "Books", "Study Advice" ] ]

  parents = [ "Countries", "Study Abroad", "Arabic Language" ]

  # first create parent categories
  parents.each do |parent|
    Category.create(name: parent)
  end

  count = 0
  category_set.each do |set|
    parent = parents[count]
    set.each do |name|
      Category.create(name: name, category_parent_id: Category.find_by_name(parent).id)
    end
    count += 1
  end

end
