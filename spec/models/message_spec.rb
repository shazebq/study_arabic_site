require 'spec_helper'

describe Message do
  let(:message) { FactoryGirl.build(:message) }
  subject { message }

  it { should respond_to :recipient }
  it { should respond_to :sender }
  it { should respond_to :conversation }
  it { should respond_to :replies }

  describe "in_reply_to scope" do 
    let!(:user1) { User.create() }
    let!(:user2) { User.create() }
    let!(:original_message) { FactoryGirl.create(:message, sender_id: user1.id, recipient_id: user2.id, conversation_id: nil) }
    let!(:first_reply) { FactoryGirl.create(:message, sender_id: user2.id, recipient_id: user1.id, conversation_id: original_message.id) }
    let!(:second_reply) { FactoryGirl.create(:message, sender_id: user1.id, recipient_id: user2.id, conversation_id: original_message.id) }
    
    it "should return all the messages in the conversation" do
      Message.in_reply_to(original_message).first.should == first_reply
    end

  end
end
