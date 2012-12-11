class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :check_if_signed_in, only: :vote

  # ajax call to vote is directed to this action
  def vote
    item = params[:voteable_type].constantize.find(params[:id])
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

  def count_view
    ForumPost.find(params[:id]).views.create(ip_address: request.remote_ip, session_id: session[:session_id])
  end

  def require_sign_in
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def require_user_is_owner(controller, id)
    resource = controller.classify.constantize.find(id)
    unless resource.user == current_user
      redirect_to new_user_session_path
    end
  end
end
