require 'spec_helper'

describe Vote do
  before :each do
    @vote1 = FactoryGirl.create(:vote, user_id: 2, voteable_id: 2)
  end

  describe "validation" do
    it "prevents duplicate records" do
      vote2 = FactoryGirl.build(:vote, user_id: 2, voteable_id: 2)
      vote2.should_not be_valid
    end

    it "does not prevent duplicates if the voteable type is different" do
      vote2 = FactoryGirl.build(:vote, user_id: 2, voteable_id: 2, voteable_type: "Answer")
      vote2.should be_valid
    end
  end
end
