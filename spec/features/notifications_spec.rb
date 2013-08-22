require "spec_helper"
include Devise::TestHelpers

describe "notifications" do
  initialize_records
  create_categories
  let!(:notification) { FactoryGirl.create(:notification, recipient_id: user.id, responsible_party_id: user1.id,
                                          recipient_object_id: forum_post.id, recipient_object_type: "ForumPost",
                                          responsible_party_object_id: answer1.id, responsible_party_object_type: "Answer") }
  before do
    sign_in_user(user)
    visit forum_posts_path
  end

  describe "clicking on a notification link" do
    it "should change the notification's checked attribute to true" do
      click_link "#{user1.username} answered your question"
      notification.reload
      notification.checked.should == true
    end

    it "should redirect the user the appropriate page" do
      click_link "#{user1.username} answered your question"
      current_path.should == forum_post_path(forum_post)
    end
  end
end

                                           
                                           


