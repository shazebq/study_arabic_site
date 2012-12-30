require 'spec_helper'
include Devise::TestHelpers

describe "forum post index page" do
  let!(:user) { FactoryGirl.create(:user)}
  let!(:parent) { FactoryGirl.create(:category, name: "Study Abroad") }
  let!(:post) { FactoryGirl.create(:forum_post, title: "Cool Restaurants in Cairo",
                                   content: "what is the best arabic center in cairo?",
                                   category_ids: [parent.id]) }
  let!(:answer) { FactoryGirl.create(:answer, content: "first answer to the post", forum_post_id: post.id,
                                     user_id: User.first.id) }
  subject { page }

  create_categories

  before do
    FactoryGirl.create(:view, viewable_id: post.id, viewable_type: "ForumPost")
    FactoryGirl.create(:view, viewable_id: post.id, viewable_type: "ForumPost", session_id: "abc345")
    visit forum_posts_path
  end

  describe "general content" do
    it { should have_selector("title", text: "Arabic Forums") }
  end

  #describe "forum post items" do
  #  it { should have_content(post.title)}
  #  it { should have_content(post.categories.first.name)}
  #  it { should have_content(post.votes.count)}
  #
  #  describe "forum post title" do
  #    it "should be a link to the show page of the forum post" do
  #      click_link post.title
  #      current_path.should == forum_post_path(post)
  #    end
  #  end
  #end

  #describe "filter links" do
  #  describe "most views link" do
  #    it "should redirect to the index page with posts sorted by views" do
  #      click_link "Most Views"
  #      uri = URI.parse(current_url)
  #      "#{uri.path}?#{uri.query}".should == forum_posts_path(:order_by => 'most_views')
  #    end
  #  end
  #
  #  describe "most votes link" do
  #    it "should redirect to the index page with posts sorted by views" do
  #      click_link "Most Votes"
  #      uri = URI.parse(current_url)
  #      "#{uri.path}?#{uri.query}".should == forum_posts_path(:order_by => 'most_votes')
  #    end
  #  end
  #
  #  describe "most answers link" do
  #    it "should redirect to the index page with posts sorted by views" do
  #      click_link "Most Answers"
  #      uri = URI.parse(current_url)
  #      "#{uri.path}?#{uri.query}".should == forum_posts_path(:order_by => 'most_answers')
  #    end
  #  end
  #
  #  describe "unanswered link" do
  #    it "should redirect to the index page with posts sorted by views" do
  #      click_link "Unanswered"
  #      uri = URI.parse(current_url)
  #      "#{uri.path}?#{uri.query}".should == forum_posts_path(:order_by => 'unanswered')
  #    end
  #  end
  #
  #  describe "most_recent link" do
  #    it "should redirect to the index page with posts sorted by views" do
  #      click_link "Most Recent"
  #      uri = URI.parse(current_url)
  #      "#{uri.path}?#{uri.query}".should == forum_posts_path(:order_by => 'most_recent')
  #    end
  #  end
  #
  #  describe "filter link that is clicked" do
  #    it "should become part of the active class (most recent link)" do
  #      click_link "Most Recent"
  #      page.should(have_selector(".active", text: "Most Recent"))
  #    end
  #
  #    it "should become part of the active class (most views link)" do
  #      click_link "Most Views"
  #      page.should(have_selector(".active", text: "Most Views"))
  #    end
  #
  #    it "should become part of the active class (most votes link)" do
  #      click_link "Most Votes"
  #      page.should(have_selector(".active", text: "Most Votes"))
  #    end
  #
  #    it "should become part of the active class (most answers link)" do
  #      click_link "Most Answers"
  #      page.should(have_selector(".active", text: "Most Answers"))
  #    end
  #
  #    it "should become part of the active class (unanswered)" do
  #      click_link "Unanswered"
  #      page.should(have_selector(".active", text: "Unanswered"))
  #    end
  #  end
  #end

  describe "sidebar" do
    it "should have links to each category" do
      page.should(have_selector("a", text: "Arabic Centers"))
    end

    describe "clicking a on a forum category" do
      it "should redirect the forum post index page with categories that belong to clicked category" do
        click_link("Arabic Centers")
        current_path.should == category_forum_posts_path(Category.find_by_name("Arabic Centers"))
      end

      it "should ensure that the currently selected filter option remains intact" do
        click_link("Most Votes")
        click_link("Arabic Centers")
        uri = URI.parse(current_url)
        "#{uri.path}?#{uri.query}".should == category_forum_posts_path(Category.find_by_name("Arabic Centers"), :order_by => 'most_votes')
      end

      it "should make that forum category part of the active class" do
        click_link("Arabic Centers")
        page.should(have_selector(".active", text: "Arabic Centers"))
      end

      context "where the forum category that is clicked on is a parent category" do
        it "should redirect to all of the parent category's posts" do
          click_link("Arabic Language")
          page.should(have_selector(".active", text: "Arabic Language"))
        end
      end
    end
  end
end

# comments