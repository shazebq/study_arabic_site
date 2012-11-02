class ApplicationController < ActionController::Base
  protect_from_forgery

  def vote
    if params[:voteable_type] == "ForumPost"
      item = ForumPost.find(params[:id])
    elsif params[:voteable_type] == "Answer"
      item = Answer.find(params[:id])
    end

    vote_count = item.count_vote(params[:id], params[:voteable_type], current_user.id, params[:type])
    respond_to do |format|
      format.json { render :json => vote_count }
    end
  end
end
