module VotingHelper
  # for making an arrow appear selected if the user has already voted for the item
  def arrow_class(item)
    if current_user.try(:voted_up?, item)
      # due to an answers being on the same page as forum posts
      return "selected_arrow_answer" if item.kind_of? Answer 
      return "selected_arrow"
    end
  end
end
