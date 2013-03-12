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

  
  describe "validations" do
    before :each do
      @center1 = Center.new(name: "New Center", description: "A wonderful place to study")
    end
    describe "website validation" do
      
      describe "when the website is formatted correctly" do
        before { @center1.website = "http://www.google.com" }
        it "should be valid with a valid url" do
          @center1.should be_valid
        end
      end

      describe "when the website is not formatted correctly" do
        before { @center1.website = "yahooooo" }
        it "should not be valid with an invalid url" do
          @center1.should_not be_valid  
        end
      end
    end
    
    describe "price field validations" do

      describe "when a price field is not a number" do
        before { @center1.price_per_hour_private = "hello" }
        it "should not be valid" do
          @center1.should_not be_valid
        end
      end

      describe "when a price field is more than 100" do
        before { @center1.price_per_hour_private = 200 }
        it "should not be valid" do
          @center1.should_not be_valid
        end
      end

      describe "when a price field is less than 1" do
        before { @center1.price_per_hour_private = 0 }
        it "should not be valid" do
          @center1.should_not be_valid
        end
      end

      describe "when a price field is between 1 and 100" do
        before { @center1.price_per_hour_private = 5 }
        it "should be valid" do
          @center1.should be_valid
        end
      end

    end

    describe "description validation" do
      describe "when description is longer than 2000 characters" do
        before { @center1.description = "a" * 2001 }
        it "should no be valid" do
          @center1.should_not be_valid 
        end
      end

      describe "when description is less than 2000 characters" do
        before { @center1.description = "a" * 2000 }
        it "should be valid" do
          @center1.should be_valid
        end
      end
    end

    describe "year established validation" do
      
      describe "when an invalid year is entered" do
        before { @center1.year_established = 19991 }
        it "should not be valid" do
          @center1.should_not be_valid
        end
      end

      describe "when an invalid year is entered" do
        before { @center1.year_established = 1998 }
        it "should not valid" do
          @center1.should be_valid
        end
      end

    end



  end

end

#comments
