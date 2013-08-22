require 'spec_helper'

describe Notification do
  it { should respond_to(:recipient) }
  it { should respond_to(:recipient_object) }

  it { should respond_to(:responsible_party) }
  it { should respond_to(:responsible_party_object) }

  describe "new_only scope" do
    let(:notification) { FactoryGirl.create(:notification) }

    it "should return only unchecked notifications" do
      Notification.only_new.should == [notification]
    end

    it "should not return a notification that has been checked" do
      notification.checked = true
      notification.save
      Notification.only_new.should be_empty
    end
  end

end
