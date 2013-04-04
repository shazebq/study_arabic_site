class ApplicationController < ActionController::Base
  include ActionView::Helpers::TextHelper
  before_filter :set_locale

  PER_PAGE = 3
  protect_from_forgery
  before_filter :require_sign_in, only: :vote
  # for devise, save the last page user was on or tyring to access before doing something that required authentication
  before_filter :store_location

  # Rails will call this method to determine the default options that 
  # should be passed in to URL generators. We need to set the locale option so 
  # that this is automatically set whenever a URL is generated.
  #def default_url_options(options = {})
  #  {locale: I18n.locale}
  #end
  
  def store_location
    # store last url as long as it isn't a /users path
    session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
  end

  # devise method for specifying where user should be redirect after signing in
  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end 

  def after_update_path_for(resource)
    session[:previous_url] || root_path
  end

  # ajax call to vote is directed to this action
  def vote
    item = params[:voteable_type].constantize.find(params[:id])
    vote_count = item.count_vote(params[:id], params[:voteable_type], current_user.id, params[:type])
    respond_to do |format|
      format.json { render :json => pluralize(vote_count, 'vote') }
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
      redirect_to root_path 
    end
  end

  def prevent_if_signed_in()
    if user_signed_in?
      redirect_to root_path
    end
  end

  # before_filter for forum_posts, comments, reviews, answers, resources, centers
  def limit_user_content
    if current_user.send(params[:controller]).where("created_at > ?", 24.hours.ago).count == 5 && !(current_user.admin?)
      flash[:alert] = "Sorry, you have exceeded the maximum number of submissions in a 24 hour period.  Try again later."
      redirect_to :back || root_path
    end
  end

  # necessary because reviews are polymorphic
  def get_somethingable(params)
    params.each do |key, value|
      if key =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
  end


  # needed because teacher_profiles are reviewable but I want the redirection
  # to go to the user show page
  def redirect_to_reviewable(reviewable)
    if reviewable.is_a?(TeacherProfile)
      redirect_to user_path(reviewable.user)
    else
      redirect_to reviewable
    end
  end

  private

  def set_locale
    I18n.locale = params[:locale] || "en"
  end

end

