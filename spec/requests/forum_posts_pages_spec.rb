require 'spec_helper'
include Devise::TestHelpers

describe User do
  let!(:user) { FactoryGirl.create(:user)}
  subject { page }

  describe "new forum post page" do
    create_categories

    before do
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

  describe "forum post show page" do
    let!(:parent) { FactoryGirl.create(:category, name: "Study Abroad") }
    let!(:post) { FactoryGirl.create(:forum_post, title: "Arabic Centers in Cairo",
                                     content: "what is the best arabic center in cairo?",
                                     category_ids: [parent.id]) }
    let!(:answer) { FactoryGirl.create(:answer, content: "first answer to the post", forum_post_id: post.id,
                                      user_id: User.first.id) }

    before do
      @views = post.views_count
      visit forum_post_path(post)
    end

    describe "general content" do
      it { should have_selector("title", text: post.title)}
      it { should have_selector(".post_content", text: post.content)}
      it "displays answers" do
        page.should have_content(answer.content)
      end
    end

    #describe "vote up for post", :js => true do
    #  it "is a test" do
    #    find("#up_vote").click
    #    #page.should have_selector(".vote_count", text: "+1")
    #    page.should have_selector("#greeting")
    #  end
    #end
  end

  describe "forum post index page" do

    before do
      visit forum_posts_path
    end

    describe "general content" do
      it { should have_selector("title", text: "Arabic Forums") }
    end





  end


end
