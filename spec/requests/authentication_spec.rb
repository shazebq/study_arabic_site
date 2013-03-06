require "spec_helper"
include Devise::TestHelpers

describe "Authentication" do
  create_categories
  let(:user) { FactoryGirl.create(:user)}
  let(:forum_post) { FactoryGirl.create(:forum_post, category_ids: [Category.first.id], user_id: user.id) }
  let(:answer) { FactoryGirl.create(:answer, forum_post_id: forum_post.id) }
  let(:resource) { FactoryGirl.create(:resource, user_id: user.id, category_ids: [Category.first.id])}
  let(:review) { FactoryGirl.create(:review, reviewable_type: "Resource", reviewable_id: resource.id)}

  subject {page}

  describe "Authorization" do
    describe "for non-signed in users" do

      describe "in forum post controller" do
        describe "voting up a post" do
          before { post(vote_forum_post_path(forum_post), voteable_type: "ForumPost", type: "up") }
          it "should not up vote the forum post" do
            response.response_code.should_not == 200
          end
        end

        describe "deleting a post" do
          before { delete(forum_post_path(forum_post)) }
          it "should not delete the forum post" do
            response.should(redirect_to(new_user_session_path))
          end
        end

        describe "creating a post" do
          before { post(forum_posts_path()) }
          it "should not create the forum post" do
            response.should(redirect_to(new_user_session_path))
          end
        end

        describe "updating a post" do
          before { put(forum_post_path(forum_post)) }
          it "should not update the forum post" do
            response.should(redirect_to(new_user_session_path))
          end
        end
      end

      describe "in answers controller" do
        describe "voting up a post" do
          before { post(vote_forum_post_answer_path(forum_post, answer), voteable_type: "Answer", type: "up") }
          it "should not up vote the answer" do
            response.response_code.should_not == 200
          end
        end

        describe "voting down a post" do
          before { post(vote_forum_post_answer_path(forum_post, answer), voteable_type: "Answer", type: "down")}
          it "should not down vote the answer" do
            response.response_code.should_not == 200
          end
        end
      end

      describe "in resources controller" do
        describe "deleting a resource" do
          before { delete(resource_path(resource))}
          it "should not delete the resource" do
            response.should(redirect_to(new_user_session_path))
          end
        end

        describe "creating a resource" do
          before { post(resources_path())}
          it "should not create the resource" do
            response.should(redirect_to(new_user_session_path))
          end
        end

        describe "updating a resource" do
          before { put(resource_path(resource))}
          it "should not update the resource" do
            response.should(redirect_to(new_user_session_path))
          end
        end

      end
    end

    #describe "for signed-in users" do
    #  describe "voting up a post" do
    #    before :each do
    #      post(vote_forum_post_path(forum_post), voteable_type: "ForumPost", type: "up")
    #    end
    #
    #    it "should not up vote the forum post" do
    #      response.response_code.should == 200
    #    end
    #  end
    #end


  end


end

# comment
