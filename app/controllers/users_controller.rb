class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @forum_posts = @user.forum_posts
    @answers = @user.answers
    @reviews = @user.reviews
    @comments = @user.comments
  end
end
