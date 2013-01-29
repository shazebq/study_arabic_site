require 'spec_helper'

describe "new review page" do
  create_categories
  let(:resource) { FactoryGirl.create(:resource, category_ids: [Category.first.id])}
  subject { page }

  before do
    sign_in_user( FactoryGirl.create(:user, email: "shazebq@gmail.com") )
    visit new_resource_review_path(resource)
  end

  describe "page title" do
    it "has the title Submit a Review" do
      page.html.should have_selector("title", text: "Submit a Review")
    end
  end

  describe "validations" do
    context "when no title is given" do
      before :each do
        fill_in "review_content", with: "Great resource!"
      end

      it "should not create a review upon submitting the form" do
        expect { click_button "Submit" }.to change(Review, :count).by(0)
      end

      it "should display an error" do
        click_button("Submit")
        page.should(have_content("Your review could not be submitted."))
      end
    end

    context "when no content is given" do
      before :each do
        fill_in "review_title", with: "Nice resource!"
      end

      it "should not create a review upon submitting the form" do
        expect { click_button "Submit" }.to change(Review, :count).by(0)
      end

      it "should display an error" do
        click_button("Submit")
        page.should(have_content("Your review could not be submitted."))
      end
    end
  end

  describe "general content" do
    it { should have_selector("#review_title")}
    it { should have_selector("#review_content")}
    it { should have_selector("#review_rating")}
  end

end

# comment