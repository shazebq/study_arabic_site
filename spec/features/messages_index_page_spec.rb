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

  describe "clicking check boxes for multiple messages and hitting delete" do
    let!(:message1) { FactoryGirl.create(:message, subject: "a new message", sender_id: user_new.id, recipient_id: user.id) }
    let!(:message2) { FactoryGirl.create(:message, subject: "a new message", sender_id: user_new.id, recipient_id: user.id) }
    before :each do
      visit user_messages_path(user)
      check "message_#{message1.id}" 
      check "message_#{message2.id}" 
      click_button "Delete"
      message1.reload
      message2.reload
    end

    it "should mark all of the specified messages as deleted" do
      message1.recipient_delete.should == true
      message2.recipient_delete.should == true
    end
  end
end

#comment
