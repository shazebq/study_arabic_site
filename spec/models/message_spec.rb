require 'spec_helper'

describe Message do
  let(:message) { FactoryGirl.build(:message) }
  subject { message }

  it { should respond_to :recipient }
  it { should respond_to :sender }
  it { should respond_to :conversation }
  it { should respond_to :replies }

  describe "message scopes and other methods" do
    let!(:user1) { FactoryGirl.create(:user) }
    let!(:user2) { FactoryGirl.create(:user) }
    let!(:original_message) { FactoryGirl.create(:message, sender_id: user1.id, recipient_id: user2.id, conversation_id: nil) }
    let!(:first_reply) { FactoryGirl.create(:message, sender_id: user2.id, recipient_id: user1.id, conversation_id: original_message.id) }
    let!(:second_reply) { FactoryGirl.create(:message, sender_id: user1.id, recipient_id: user2.id, conversation_id: original_message.id) }
    
    describe "direct_parent" do
      it "should return the message from the same conversation which the calling record is a reply to" do
        second_reply.direct_parent.should == first_reply
      end

      it "should return the overall parent if that is the direct parent of the calling recrod" do
        first_reply.direct_parent.should == original_message
      end

      it "should return nil if it's the original message" do
        original_message.direct_parent.should == nil 
      end
    end

    describe "in_reply_to scope" do 
      it "should return all the messages in the conversation" do
        Message.in_reply_to(original_message).first.should == second_reply
      end
    end

    describe "user2's received messages" do
      it "should return 2 messages" do
        user2.received_messages.count.should == 2
      end
    end

    
    describe "active messages scope" do
      before { original_message.update_attributes(recipient_delete: true) }
      it "should return only those messages which have not been marked as deleted by the recipient" do
        user2.received_messages.active_messages("recipient").count.should == 1
        user2.received_messages.active_messages("recipient").should == [second_reply]
      end
    end

    describe "unread messages scope" do
      before { original_message.update_attributes(checked: true) }
      it "should return messages which are unread i.e. where checked is not true" do
        user2.received_messages.unread_messages.should_not include(original_message)  
        user2.received_messages.unread_messages.should include(second_reply)
      end
    end

  end
  
  describe "validations" do
    before { @message = Message.new(sender_id: 1, recipient_id: 8) }

    context "when content is blank" do
      before { @message.subject = "hello there" }
      it "should not be valid" do
        @message.should_not be_valid
      end
    end

    context "when subject is blank" do
      before { @message.content = "this is the content" }
      it "should not be valid" do
        @message.should_not be_valid
      end
    end

    context "when subject and content are present and valid" do
      before do
        @message.content = "some content here"
        @message.subject = "subject line"
      end
      it "should be valid" do
        @message.should be_valid
      end
    end
  end
end
