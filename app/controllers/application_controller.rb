class ApplicationController < ActionController::Base
  include ActionView::Helpers::TextHelper
  helper_method :answer_link
  helper_method :comment_link
  helper_method :review_link
  helper_method :vote_link
  helper_method :notification_link

  before_filter :set_locale

  PER_PAGE = 10 
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
    render :json => { votes: pluralize(vote_count, 'vote') }
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
    unless resource.user == current_user || current_user.try(:admin?)
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

  # link generators for non conventional objects (answers, reviews)
  def answer_link(answer, options = {})
    forum_post_path(answer.forum_post, anchor: "answer_#{answer.id}", notification: options[:notification])
  end

  def review_link(review, options = {})
    user_path(review.reviewable.user, anchor: "review_#{review.id}", notification: options[:notification])
  end

  # create link generators for comments and votes
  def comment_link(comment, options = {})
    parent = get_comment_parent(comment)
    if parent.is_a?(Answer)
      parent = parent.forum_post
    end
    send("#{parent.class.name.underscore}_path", parent, anchor: "comment_#{comment.id}", notification: options[:notification])
  end

  def vote_link(vote, options = {})
    if vote.voteable.is_a?(Answer)
      forum_post_path(vote.voteable.forum_post, anchor: "answer_#{vote.voteable.id}")
    else
      send("#{vote.voteable.class.name.underscore}_path", vote.voteable, notification: options[:notification])
    end
  end

  def get_comment_parent(comment, options = {})
    if comment.respond_to?(:commentable)
      get_comment_parent(comment.commentable)
    else
      comment
    end
  end

  def notification_link(notification)
    send("#{notification.responsible_party_object_type.underscore}_link", 
         notification.responsible_party_object, notification: notification.id)
  end

  def check_if_notification_destination
    if params[:notification]
      Notification.find_by_id(params[:notification]).try(:update_attributes, :checked => true)
    end
  end

  private

  def set_locale
    I18n.locale = params[:locale] || "en"
  end
end

