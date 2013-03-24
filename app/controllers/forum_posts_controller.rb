class ForumPostsController < CategorizableItemsController
  #after_filter :add_views, only: :show
  before_filter :authenticate_user!, only: [:new, :edit, :update, :destroy, :create]
  before_filter(:only => [:destroy, :update]) { |c| c.require_user_is_owner(params[:controller], params[:id]) }
  before_filter :count_view, only: :show
  before_filter :limit_user_content, only: [:new, :create]

  def new
    @forum_post = ForumPost.new
  end

  def create
    @forum_post = current_user.forum_posts.new(params[:forum_post])
    if @forum_post.save
      current_user.add_rep_points(:forum_post)
      flash[:notice] = "Your question has been added"
      redirect_to forum_post_path(@forum_post)
    else
      # note here, you're simply rendering the template with the variables from here
      render "new"
    end
  end

  def show
    @forum_post = ForumPost.find(params[:id])
    @answer = @forum_post.answers.new
  end

  def edit
    @forum_post = ForumPost.find(params[:id])
  end

  def update
    @forum_post = ForumPost.find(params[:id])
    if @forum_post.update_attributes(params[:forum_post])
      flash[:notice] = "Your question has been successfully updated"
      redirect_to @forum_post
    else
      render "edit"
    end
  end

  def destroy
    ForumPost.find(params[:id]).destroy
    flash[:notice] = "Your resource has been successfully deleted"  
    redirect_to forum_posts_path()
  end
end

# commentsss
