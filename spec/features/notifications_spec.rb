require "spec_helper"
include Devise::TestHelpers

describe "notifications" do
  # test if they get marked as checked when they are checked
  create_categories
  initialize_records
  # create a notification with valid attributes
  let!(:notification) { FactoryGirl.create(:notification, recipient_id: user.id, responsible_party_id: user1.id) }

                                           #:recipient_object_id: forum_post.id, :recipient_object_type: "ForumPost", 
                                           #responsible_party_object_id: answer1.id, responsible_party_object_type: "Answer") }

  describe "a user clicks on one of his notifications" do

    # something weird going on here...figure this out

    before :each do
      sign_in_user(user)
      visit forum_post_path(forum_post)
      save_and_open_page
    end

    it "is just a test" do
      click_link "#{user1.username} answered your question"
    end
  end

end

