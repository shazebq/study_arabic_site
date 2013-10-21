class UsersController < ApplicationController
  before_filter :check_if_notification_destination, only: :show

  def show
    @user = User.find(params[:id])
    @forum_posts = @user.forum_posts
    @answers = @user.answers
    @reviews = @user.reviews
    @comments = @user.comments
  end

  def test_method
    "blah"
  end
end
