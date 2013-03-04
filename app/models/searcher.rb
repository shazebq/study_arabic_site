class Searcher

  def search(query)
    PgSearch.multisearch("query")
  end

end
