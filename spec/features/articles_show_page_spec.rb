require 'spec_helper'
include Devise::TestHelpers

describe "articles show page" do
  create_categories
  create_student_records
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
        page.should have_content("Already have an account?")
        page.should have_content("Don't have an account yet?")
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
      sign_in_user(user)
      visit article_path(article)
      fill_in "comment_content", with: "Fabulous article. Keep up the good work!"
    end

    it "should create a comment and redirect to the same article path" do
      expect { click_button "Submit Comment" }.to change(Comment, :count).by(1)   
    end

    specify "clicking on submit button should increase the current user's reputation by 1 points" do
      click_button "Submit"
      user.reload
      user.reputation.should == 1
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
