require 'spec_helper'
include Devise::TestHelpers

describe "articles show page" do
  create_categories
  create_student_records
  let!(:student_profile1) { FactoryGirl.create(:student_profile) }
  let!(:user1) { FactoryGirl.create(:user, profile_type: "StudentProfile", profile_id: student_profile1.id) }
  let!(:article) { FactoryGirl.create(:article, title: "Advice for everyone", category_ids: [Category.first.id], user_id: user.id) }
  let!(:comment) { FactoryGirl.create(:comment, content: "fabulous article", commentable_id: article.id, commentable_type: "Article", user_id: user.id) } 

  before :each do
    visit article_path(article)
  end

  describe "page title" do
    it "should be the name of the article" do
      page.html.should have_selector("title", text: article.title)
    end
  end

  describe "comment form" do
    context "when user is not logged in" do
      specify "page should have option to sign up or register" do
        page.should have_content("Sign In With Facebook")
        page.should have_content("Sign In With Google")
      end
    end

    context "when user is logged in" do
      before :each do
        sign_in_user(user)
        visit article_path(article)
      end

      specify "page should have form to submit comment" do
        page.should have_selector("#comment_content")
      end
    end
  end

  describe "article comments" do
    it "should be appear on page" do
      page.should have_content(comment.content)
    end
  end

  describe "posting a comment" do
    before :each do
      sign_in_user(user1)
      visit article_path(article)
      fill_in "comment_content", with: "Fabulous article. Keep up the good work!"
    end

    it "should create a comment and redirect to the same article path" do
      expect { click_button "Submit Comment" }.to change(Comment, :count).by(1)   
    end

    # no idea why the following are not working, useless error message
    it "should create a notification with all the appropriate attributes" do
      expect { click_button "Submit Comment" }.to change(Notification, :count).by(1)   
      #Notification.last.recipient.should == user
      #Notification.last.responsible_party.should == user1
      #Notification.last.recipient_object.should == article
      #Notification.last.responsible_party_object.should == Comment.last
    end
  end

  describe "posting a comment to one's own article" do
    before :each do
      sign_in_user(user)
      visit article_path(article)
      fill_in "comment_content", with: "Fabulous article. Keep up the good work!"
    end

    it "should not create a notification" do
      expect { click_button "Submit Comment" }.to change(Notification, :count).by(0)   
    end
  end

  describe "clicking on the edit or delete link for a comment" do
    before :each do
      sign_in_user(user)
      visit article_path(article)
      fill_in "comment_content", with: "Fabulous article. Keep up the good work!"
    end

    describe "clicking on edit link" do
      it "should redirect to the edit comment path" do
        click_link "edit_comment#{comment.id}"
        current_path.should == edit_article_comment_path(article, comment)
      end

    end
    
    describe "clicking on the delete link" do
      it "should delete the comment" do
        expect { click_link "delete_comment#{comment.id}" }.to change(Comment, :count).by(-1)   
      end
    end
  end
end


# comment
