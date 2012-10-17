require 'spec_helper'
include Devise::TestHelpers

describe User do

  subject { page }

  describe "new forum post page" do
    create_categories
    let!(:user) { FactoryGirl.create(:user)}

    before do
      # just do it the regular way!!!
      sign_in
      visit new_forum_post_path
    end

    it { should have_selector("title", text: "Post a Question") }
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

        it "should create a forum post" do
          expect { click_button "Submit" }.should change(ForumPost, :count)
          ForumPost.first.categories.count.should == 2
        end

        it "should redirect to the forum post detail page" do
          click_button "Submit"
          current_path.should == forum_post_path(ForumPost.first)
        end

      end

      context "with missing information" do
        before do
          fill_in "forum_post_title", with: "living abroad in cairo"
          select "Arabic Centers", from: "forum_post_category_ids"
        end

        it "should not create a forum post" do
          expect { click_button "Submit" }.should_not change(ForumPost, :count)
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
          expect { click_button "Submit" }.should_not change(ForumPost, :count)
          page.should have_selector(".alert-error", text: "Your post could not be submitted.")
        end

      end

    end

  end


  describe "forum post show page" do
    let!(:parent) { FactoryGirl.create(:category, name: "Study Abroad") }
    let!(:post) { FactoryGirl.create(:forum_post, title: "Arabic Centers in Cairo",
                                     content: "what is the best arabic center in cairo?",
                                     category_ids: [parent.id]) }

    before do
      @views = post.views_count
      visit forum_post_path(post)
    end

    it { should have_selector("title", text: post.title)}
    it { should have_selector(".post_content", text: post.content)}

    specify {  }

  end

end
