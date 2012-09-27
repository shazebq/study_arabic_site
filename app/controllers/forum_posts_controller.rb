class ForumPostsController < ApplicationController

  def create
    return render text: "hello"
  end

  def new
    @forum_post = ForumPost.new
  end

end