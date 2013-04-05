require "spec_helper"

describe "new article page" do
  create_categories
  let(:user) { FactoryGirl.create(:user, staff_writer: true) }  # only staff writers and admin can write articles

  before :each do
    sign_in_user(user)
    visit new_article_path
  end

  describe "page contents" do
    it "should have the appropriate page title" do
      page.html.should have_selector("title", text: "Submit an Article")
    end
  end

  describe "filling out the form" do
    context "with valid information" do
      before do
        fill_in "article_title", with: "How to study Arabic"
        fill_in "article_content", with: "some advice and other stuff here blah"
        select "Egypt", from: "article_category_ids"
        select "Arabic Centers", from: "article_category_ids"
      end

      it "should create a new Article" do
        expect { click_button "Submit" }.to change(Article, :count)
      end
    end

    context "with invalid information i.e. category ids not provided" do
      before do
        fill_in "article_title", with: "How to study Arabic"
        fill_in "article_content", with: "some advice and other stuff here blah"
      end

      it "should not create a new article" do
        expect { click_button "Submit" }.to_not change(Article, :count)
      end
    end

  end
  
end


# comment
