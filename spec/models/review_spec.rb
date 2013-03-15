require 'spec_helper'

describe Review do
  let(:review) { FactoryGirl.build(:review) }
  subject { review }

  it { should respond_to(:user) }
  it { should respond_to(:reviewable) }

  describe "validations" do
    before { @review1 = Review.new(title: "great product", content: "excellent, would recommend again", rating: 5) }

    describe "when all required fields are provided" do
      it "should be valid" do
        @review1.should be_valid
      end
    end

    describe "rating is too high" do
      before { @review1.rating = 10 }
      it "should not be valid" do
        @review1.should_not be_valid
      end
    end
  end
end

# comments
