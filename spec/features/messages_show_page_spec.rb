require "spec_helper"

describe "message show page" do
  create_teacher_records
  let!(:sender) { FactoryGirl.create(:user) }
  let!(:message) { FactoryGirl.create(:message, recipient_id: user.id, sender_id: sender.id) } 
  before :each do
    sign_in_user(user)
    visit message_path(message) 
  end

  describe "hitting reply" do
    it "should redirect to the new_reply action" do
      click_button("Reply")
      current_path.should == new_reply_message_path(message)
    end
  end

  describe "hitting delete" do
    before do
      click_button("Delete")
      message.reload
    end
    it "should delete the message and redirect to the user's mailbox" do
      message.recipient_delete.should == true
    end
  end
end

# comment
