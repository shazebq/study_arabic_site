require "spec_helper"

describe "message index page" do
  create_teacher_records
  let!(:user_new) { FactoryGirl.create(:user) }
  let!(:message) { FactoryGirl.create(:message, subject: "a new message", sender_id: user_new.id, recipient_id: user.id) }
  before :each do
    sign_in_user(user)
    visit user_messages_path(user)  
  end

  describe "page title" do
    it "should be Your Messages" do
      page.html.should have_selector("title", text: "Your Messages")
    end
  end

  describe "clicking a subject link" do
    it "should redirect to the show page for the message" do
      click_link("a new message")
      current_path.should == message_path(message)
    end
  end
end

#comment
