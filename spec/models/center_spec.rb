require 'spec_helper'

describe Center do
  let!(:country1) { FactoryGirl.create(:country) }
  let!(:country2) { FactoryGirl.create(:country) }
  let!(:address1) { FactoryGirl.create(:address, country_id: country1.id) }
  let!(:address2) { FactoryGirl.create(:address, country_id: country2.id) }

  let!(:center1) { FactoryGirl.create(:center, address_id: address1.id) }
  let!(:review1a) { FactoryGirl.create(:review, rating: 3, reviewable_type: "Center", reviewable_id: center1.id) }
  let!(:review1b) { FactoryGirl.create(:review, rating: 2, reviewable_type: "Center", reviewable_id: center1.id) }
  let!(:review1c) { FactoryGirl.create(:review, rating: 2, reviewable_type: "Center", reviewable_id: center1.id) }

  let!(:center2) { FactoryGirl.create(:center, address_id: address2.id) }
  let!(:review2a) { FactoryGirl.create(:review, rating: 5, reviewable_type: "Center", reviewable_id: center2.id) }
  let!(:review2b) { FactoryGirl.create(:review, rating: 5, reviewable_type: "Center", reviewable_id: center2.id) }

  let!(:center3) { FactoryGirl.create(:center, address_id: address2.id) }
  let!(:review3a) { FactoryGirl.create(:review, rating: 4, reviewable_type: "Center", reviewable_id: center3.id) }

  before :each do
    @center = FactoryGirl.build(:center)
  end

  subject { @center }

  it { should respond_to :address }
  it { should respond_to :images }
  it { should respond_to :reviews }

  describe "filtering options" do
    describe "filtering by number of reviews" do
      it "should order the centers by the number of reviews they have" do
        Center.order_by_reviews.should == [center1, center2, center3]
      end
    end

    describe "filtering by average reivew rating" do
      it "should order the centers by the average review rating" do
        Center.order_by_average_rating.should == [center2, center3, center1]
      end
    end

    describe "filtering by country" do
      it "should filter the centers based on the selected country" do
        Center.country_option(country1.id).should == [center1]        
      end

      it "should filter the centers based on the selected country (two centers)" do
        Center.country_option(country2.id).should include(center2, center3)
        Center.country_option(country2.id).count.should == 2
      end
    end
  end

end

#comments
