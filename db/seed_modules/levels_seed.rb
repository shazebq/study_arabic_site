module LevelsSeed
  #create levels
  levels = 
  {
    "Beginner" => "Little to no prior experience", 
    "Elementary" => "Formal classes or self study equivalent to one university level year",
    "Intermediate" => "Formal classes or self study equivalent to two university level years", 
    "Advanced" =>  "Formal classes or self study equivalent to three university level years",
  }
  year = 0
  levels.each do |key, value|
    Level.create(title: key, description: value, years_of_study: year)
    year += 1
  end
end
