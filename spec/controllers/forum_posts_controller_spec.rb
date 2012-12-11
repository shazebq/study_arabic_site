require 'spec_helper'

describe ForumPostsController do
  initialize_records()

  describe "GET #show" do
    it "assigns the requested forum_post to @forum_post" do
      get :show, id: forum_post
      assigns(:forum_post).should == forum_post
    end
  end

  describe "Authorization" do
    describe "deleting and update an forum_post" do

      context "when user is not signed in" do
        it "should not delete the forum_post and should redirect to the new_user_session_path" do
          delete :destroy, id: forum_post.id, forum_post_id: forum_post.id
          response.should redirect_to(new_user_session_path)
        end

        it "should not update an forum_post" do
          put :update, id: forum_post.id, forum_post_id: forum_post.id
          response.should redirect_to(new_user_session_path)
        end
      end

      context "when signed in user is not the owner of the forum_post" do
        before do
          @different_user = FactoryGirl.create(:user, email: "bob@gmail.com")
          sign_in(@different_user)
        end

        it "should not delete the forum_post" do
          delete :destroy, id: forum_post.id, forum_post_id: forum_post.id
          response.should redirect_to(new_user_session_path)
        end

        it "should not delete the forum_post" do
          put :update, id: forum_post.id, forum_post_id: forum_post.id
          response.should redirect_to(new_user_session_path)
        end
      end

      context "when signed in user is the owner of the forum_post" do
        before do
          sign_in(user)
        end
        it "should delete the forum_post" do
          delete :destroy, id: forum_post.id, forum_post_id: forum_post.id
          response.should redirect_to(forum_posts_path)
        end
      end
    end
  end

end



# commentss

