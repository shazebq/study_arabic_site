require 'spec_helper'
include Devise::TestHelpers

describe User do
  initialize_records
  create_categories
  subject { page }

  describe "forum post edit page" do
    describe "editing the form and submitting it" do
      before do
        sign_in_user(user)
        forum_post.user_id = user.id
        forum_post.save
        visit edit_forum_post_path(forum_post)
        fill_in "forum_post_title", with: "new title for this forum post"
      end

      it "updates the post" do
        click_button("Update")
        forum_post.reload
        forum_post.title.should  == "new title for this forum post"
      end
    end
  end
end

#comment
