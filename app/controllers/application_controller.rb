class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :check_if_signed_in, only: :vote

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

  def check_if_signed_in
    # 401 means an unauthorized request
    unless user_signed_in?
      respond_to do |format|
        format.json { render(json: "unauthorized action", status: 401) }
      end
    end
  end


end
