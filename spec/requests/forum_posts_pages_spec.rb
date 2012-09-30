require 'spec_helper'

describe User do

  subject { page }

  describe "new forum post page" do
    create_categories

    before do
      visit new_forum_post_path
    end

    it { should have_selector("title", text: "Post a Question") }

    it { should have_selector("form")}

    describe "creating a new post" do

      context "with valid information" do

        # try filling out the form and adding the category?
        before do
          fill_in "forum_post_title", with: "living abroad in cairo"
          select "Egypt", from: "forum_post_category_ids"
          select "Arabic Centers", from: "forum_post_category_ids"
        end

        it "should create a forum post" do
          expect { click_button "Submit" }.should change(ForumPost, :count)
          ForumPost.first.categories.count.should == 2
        end

        it "should redirect to the forum post detail page" do
          click_button "Submit"
          current_path.should == forum_post_path(ForumPost.first)
        end

      end

      context "with invalid information" do
        # leave some things out here

      end

    end

  end

end
