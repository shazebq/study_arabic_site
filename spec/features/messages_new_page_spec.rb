require "spec_helper"

describe "new messages page" do
  create_teacher_records
  let(:user1) { FactoryGirl.create(:user) }

  before :each do
    sign_in_user(user1)
    visit new_user_message_path(user, Message.new)
  end

  describe "page title" do
    it "should be relevant" do
      page.html.should have_selector("title", text: "Send Message")
    end
  end

  describe "filling out the form and sending the message" do
    before :each do
      fill_in "message_subject", with: "looking for a tutor"
      fill_in "message_content", with: "Hi there, I'm looking for a great Arabic teacher"
    end

    it "should increase the number of messages" do
      expect { click_button "Send" }.to change(Message, :count).by(1) 
    end
  end

end
