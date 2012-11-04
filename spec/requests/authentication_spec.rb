require "spec_helper"

describe "Authentication" do
  create_categories
  let(:user) { FactoryGirl.create(:user)}
  let(:forum_post) { FactoryGirl.create(:forum_post, category_ids: [Category.first.id]) }
  let(:answer) { FactoryGirl.create(:answer, forum_post_id: forum_post.id) }

  subject {page}

  describe "for non-signed in users" do

    describe "in forum post controller" do
      describe "voting up a post" do
        it "should not up vote the forum post" do
          post(vote_forum_post_path(forum_post), voteable_type: "ForumPost", type: "up")
          response.should redirect_to(new_user_session_path)
        end
      end
    end

    describe "in answers controller" do

    end

  end

end