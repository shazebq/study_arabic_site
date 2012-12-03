require 'spec_helper'

describe ForumPostsController do
  initialize_records()

  describe "GET #show" do
    it "assigns the requested forum_post to @forum_post" do
      get :show, id: forum_post
      assigns(:forum_post).should == forum_post
    end
  end

end





