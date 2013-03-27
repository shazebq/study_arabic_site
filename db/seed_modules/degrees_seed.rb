module DegreesSeed
  ["Bachelor", "Master", "PhD"].each { |degree| Degree.create(name: degree) }
end
