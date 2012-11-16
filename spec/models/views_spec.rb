require 'spec_helper'

describe "View" do
  before :each do
    @view1 = FactoryGirl.create(:view, user_id: 2, viewable_id: 2)
  end

  describe "validation" do
    it "prevent duplicate records" do
      view2 = FactoryGirl.build(:view, user_id: 2, viewable_id: 2)
      view2.should_not be_valid
    end
  end
end
