require 'spec_helper'

describe "View" do
  before :each do
    @view1 = FactoryGirl.create(:view)
  end

  describe "validation" do
    it "prevent duplicate records" do
      view2 = FactoryGirl.build(:view)
      view2.should_not be_valid
    end

    it "allows view with different session_id to be created" do
      view2 = FactoryGirl.build(:view, session_id: "abc456")
      view2.should be_valid
    end

    it "allows view with different ip_address to be created" do
      view2 = FactoryGirl.build(:view, ip_address: "343.234.543")
      view2.should be_valid
    end
  end
end

# comment sadf
