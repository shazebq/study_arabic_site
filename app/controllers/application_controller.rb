class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!, only: :vote
  # for devise, save the last page user was on before doing something that required authentication
  #after_filter :store_location

  def store_location
    # store last url as long as it isn't a /users path
    session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
  end

  #def after_sign_in_path_for(resource)
    #logger.fatal "Terminating application, raised unrecoverable error!!! #{resource.class.name}"
    #if resource.is_a?(Answer) 
    #  session[:previous_url] || root_path
    #elsif resource.is_a?(ForumPost)
    #  new_forum_post_path
    #end
  #end
    
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
    controller_name.classify.constantize.find(params[:id]).views.create(ip_address: request.remote_ip, session_id: session[:session_id])
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

  # necessary because reviews are polymorphic
  def get_reviewable(params)
    params.each do |key, value|
      if key =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
  end

end

