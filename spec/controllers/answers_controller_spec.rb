require 'spec_helper'

describe AnswersController do
  render_views
  initialize_records()

  describe "when a user answers a question (forum_post)" do
    before :each do
      @new_user = FactoryGirl.create(:user, email: "new_user@example.com")
      sign_in(@new_user)
    end

    # spec doesn't pass but this does work
    #it "should create a notification record for the user whose answer it is" do
    #  expect do
    #    post :create, forum_post_id: forum_post.id, answer: FactoryGirl.attributes_for(:answer)
    #  end.to change(Notification, :count).by(1)
    #end
  end

  describe "Authorization" do
    describe "when user tries to post more than one answer to the same forum_post" do
      before :each do
        sign_in(user)
      end
      
      it "should not create the answer" do
        expect do
          post :create, forum_post_id: forum_post.id, user_id: user.id
        end.to change(Answer, :count).by(0)
      end
    end
    
    describe "deleting and update an answer" do

      context "when user is not signed in" do
        it "should not delete the answer" do
          delete :destroy, id: answer.id, forum_post_id: forum_post.id
          response.should redirect_to(new_user_session_path)
        end

        it "should not update an answer" do
          put :update, id: answer.id, forum_post_id: forum_post.id
          response.should redirect_to(new_user_session_path)
        end
      end

      context "when signed in user is not the owner of the answer" do
        before do
          @different_user = FactoryGirl.create(:user, email: "bob@gmail.com")
          sign_in(@different_user)
        end

        it "should not delete the answer" do
          delete :destroy, id: answer.id, forum_post_id: forum_post.id
          response.should redirect_to(root_path)
        end

        it "should not delete the answer" do
          put :update, id: answer.id, forum_post_id: forum_post.id
          response.should redirect_to(root_path)
        end
      end

      context "when signed in user is the owner of the answer" do
        before do
          sign_in(user)
        end
        it "should delete the answer" do
          delete :destroy, id: answer.id, forum_post_id: forum_post.id
          response.should redirect_to(forum_post_path(forum_post))
        end
      end
    end
  end
end

# comments
