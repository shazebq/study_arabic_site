module Voting
  def count_vote(voteable_id, voteable_type, user_id, type)
    if type == "up"
      new_vote = Vote.create(voteable_id: voteable_id, voteable_type: voteable_type, user_id: user_id)
    else
      down_vote = Vote.where("voteable_id = ? AND voteable_type = ? AND user_id = ?", voteable_id, voteable_type, user_id).first
      down_vote.destroy if down_vote
    end

    return get_item_votes(voteable_type, voteable_id)

  end

  def get_item_votes(voteable_type, voteable_id)
    if voteable_type == "ForumPost"
      ForumPost.find(voteable_id).votes.count
    else
      Answer.find(voteable_id).votes.count
    end
  end

end