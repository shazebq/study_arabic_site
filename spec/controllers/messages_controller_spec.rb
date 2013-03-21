require "spec_helper"

describe MessagesController do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:original_message) { FactoryGirl.create(:message, sender_id: user1.id, recipient_id: user2.id, conversation_id: nil) }
  let!(:first_reply) { FactoryGirl.create(:message, sender_id: user2.id, recipient_id: user1.id, conversation_id: original_message.id) }
  let!(:second_reply) { FactoryGirl.create(:message, sender_id: user1.id, recipient_id: user2.id, conversation_id: original_message.id) }

  describe "authorization" do
    describe "accessing the new reply page" do
      before { sign_in(user1) }
      context "when signed in user is not the recipient of the message" do
        specify "user should not be able to reply to the message" do
          get :new_reply, id: original_message.id      
          response.should redirect_to(root_path)
        end
      end

      context "when signed in user is the recipient of the message" do
        specify "user should be able to reply to the message" do
          get :new_reply, id: first_reply.id      
          response.should_not redirect_to(root_path) 
        end
      end
    end

    describe "accessing the destroy action for a message" do
      context "when user is not signed in" do
        specify "user should not be able to mark the message as deleted" do
          delete :destroy, id: original_message.id
          response.should redirect_to(new_user_session_path)
        end
      end

    end
  end
end

# comments
