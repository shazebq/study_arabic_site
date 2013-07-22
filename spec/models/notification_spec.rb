require 'spec_helper'

describe Notification do
  create_categories
  initialize_records

  it { should respond_to(:recipient) }
  it { should respond_to(:recipient_object) }

  it { should respond_to(:responsible_party) }
  it { should respond_to(:responsible_party_object) }

  describe "situations when a notification is sent to a user" do

    context "when a user's question is answered" do
      

      it "should be added to the user's notifications" do
        expect {FactoryGirl.create(:answer, forum_post_id: forum_post.id, user_id: user.id)}.to change(Notification, :count).by(1) 
      end

    end
  end
end
