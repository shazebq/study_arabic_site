require "spec_helper"

describe "comment edit page" do
  create_categories
  create_student_records
  let!(:article) { FactoryGirl.create(:article, title: "Advice for everyone", category_ids: [Category.first.id], user_id: user.id) }
  let!(:comment) { FactoryGirl.create(:comment, content: "fabulous article", commentable_id: article.id, commentable_type: "Article", user_id: user.id) } 

  before :each do
    sign_in_user(user)
    visit edit_article_comment_path(article, comment)  
  end

  describe "page title" do
    it "should be edit your comment" do
      page.html.should have_selector("title", text: "Edit Your Comment")
    end
  end

  describe "editing something and submitting changes" do
    before :each do
      fill_in "comment_content", with: "updating the comment here!"   
      click_button "Update Comment"
    end

    it "should update the comment" do
      comment.reload
      comment.content.should == "updating the comment here!"
    end
  end
end
