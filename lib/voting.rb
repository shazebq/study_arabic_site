module Voting
  def count_vote(voteable_id, voteable_type, user_id, type)
    if type == "up"
      new_vote = Vote.create(voteable_id: voteable_id, voteable_type: voteable_type, user_id: user_id)
      vote_recipient = voteable_type.constantize.find(voteable_id).user
      vote_recipient.add_rep_points(voteable_type)
      # notify the user whose item was voted up
      Notification.generate_notification(vote_recipient, User.find(user_id), new_vote.voteable, new_vote)
    else
      down_vote = Vote.where("voteable_id = ? AND voteable_type = ? AND user_id = ?", voteable_id, voteable_type, user_id).first
      if down_vote
        # only situation, so far, when points need to be subtracted
        voteable_type.constantize.find(voteable_id).user.subtract_rep_points(voteable_type)
        down_vote.destroy
      end
    end
    get_item_votes(voteable_type, voteable_id)
  end

  def get_item_votes(voteable_type, voteable_id)
    voteable_type.constantize.find(voteable_id).votes.count
  end

end
