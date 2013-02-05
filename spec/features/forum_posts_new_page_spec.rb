require 'spec_helper'
include Devise::TestHelpers
include Warden::Test::Helpers
Warden.test_mode!

describe User do
  initialize_records
  create_categories
  subject { page }

  describe "new forum post page" do
    before :each do
      sign_in_user(user)
      #login_as(user, :scope => :user)  this also works to login user with out filling out form etc
      visit new_forum_post_path
    end

    describe "page title" do
      it "has the title Forum Categories" do
        page.html.should have_selector("title", text: "Post a Question")
      end
    end

    it { should have_selector("form")}
    it { should have_content("Sign Out")}

    describe "creating a new post" do

      context "with valid information" do
        before do
          fill_in "forum_post_title", with: "living abroad in cairo"
          fill_in "forum_post_content", with: "some stuff about cairo"
          select "Egypt", from: "forum_post_category_ids"
          select "Arabic Centers", from: "forum_post_category_ids"
        end

        specify "clicking submit button should create a forum post" do
          expect { click_button "Submit" }.to change(ForumPost, :count)
          ForumPost.find_by_title("living abroad in cairo").categories.count.should == 2
        end

        specify "the new forum post should be the current user's" do
          click_button "Submit"
          ForumPost.find_by_title("living abroad in cairo").user.email.should == "shazebq@gmail.com"
        end

        specify "page should redirect to the forum post detail page" do
          click_button "Submit"
          current_path.should == forum_post_path(ForumPost.find_by_title("living abroad in cairo"))
        end

      end

      context "with missing information" do
        before do
          fill_in "forum_post_title", with: "living abroad in cairo"
          select "Arabic Centers", from: "forum_post_category_ids"
        end

        it "should not create a forum post" do
          expect { click_button "Submit" }.to_not change(ForumPost, :count)
          page.should have_selector(".alert-error", text: "Your post could not be submitted.")
        end

      end

      context "with invalid information" do
        before do
          fill_in "forum_post_title", with: ("a" * 70)
          fill_in "forum_post_content", with: "some stuff about cairo"
          select "Egypt", from: "forum_post_category_ids"
          select "Arabic Centers", from: "forum_post_category_ids"
        end

        it "should not create a forum post" do
          expect { click_button "Submit" }.to_not change(ForumPost, :count)
          page.should have_selector(".alert-error", text: "Your post could not be submitted.")
        end

      end

    end
  end
end

# comment