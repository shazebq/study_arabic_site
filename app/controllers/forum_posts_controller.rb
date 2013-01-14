class ForumPostsController < ApplicationController
  #after_filter :add_views, only: :show
  before_filter :require_sign_in, only: [:new, :update, :destroy]
  before_filter(:only => [:destroy, :update]) { |c| c.require_user_is_owner(params[:controller], params[:id]) }
  before_filter :count_view, only: :show

  def index
    @scopes = ForumPost::SCOPES
    @current_scope = params[:order_by] || "most_recent"  # default the scope to most_recent
    if params[:category_id]
      @category = CategoryParent.find(params[:category_id])
        if @category.categories.any?
          @forum_posts = @category.collect_all_posts.send(@current_scope)
        else
          @forum_posts = @category.forum_posts.send(@current_scope)
        end
    else
      # call appropriate scope here
      @forum_posts = ForumPost.send(@current_scope)
    end


  end

  def new
    @forum_post = ForumPost.new
  end

  def create
    @forum_post = ForumPost.new(params[:forum_post])
    @forum_post.user_id = current_user.id
    if @forum_post.save
      flash[:success] = "Your post has been added"
      redirect_to forum_post_path(@forum_post)
    else
      # note here, you're simply rendering the template with the variables from here
      render action: "new"
    end
  end

  def show
    @forum_post = ForumPost.find(params[:id])
    @answer = ForumPost.find(@forum_post.id).answers.new
  end

  def edit
    @forum_post = ForumPost.find(params[:id])
  end

  def update
    @forum_post = ForumPost.find(params[:id])
    @forum_post.update_attributes(params[:forum_post])
    redirect_to @forum_post
  end

  def destroy
    ForumPost.find(params[:id]).destroy
    redirect_to forum_posts_path()
  end
end

# commentsss