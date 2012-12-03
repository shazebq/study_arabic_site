require "spec_helper"

include Devise::TestHelpers

describe "Authentication" do
  create_categories
  let(:user) { FactoryGirl.create(:user)}
  let(:forum_post) { FactoryGirl.create(:forum_post, category_ids: [Category.first.id], user_id: user.id) }
  let(:answer) { FactoryGirl.create(:answer, forum_post_id: forum_post.id) }

  subject {page}

  describe "Authorization" do
    describe "for non-signed in users" do

      describe "in forum post controller" do
        describe "voting up a post" do
          it "should not up vote the forum post" do
            post(vote_forum_post_path(forum_post), voteable_type: "ForumPost", type: "up")
            response.response_code.should_not == 200
          end
        end
      end

      describe "in answers controller" do
        describe "voting up a post" do
          it "should not up vote the answer" do
            post(vote_forum_post_answer_path(forum_post, answer), voteable_type: "Answer", type: "up")
            response.response_code.should_not == 200
          end
        end
      end
    end
  end
end
