require 'spec_helper'
include Devise::TestHelpers

#comments

describe User do
  let!(:user) { FactoryGirl.create(:user)}
  let!(:parent) { FactoryGirl.create(:category, name: "Study Abroad") }
  let!(:post) { FactoryGirl.create(:forum_post, title: "Arabic Centers in Cairo",
                                   content: "what is the best arabic center in cairo?",
                                   category_ids: [parent.id]) }
  let!(:answer) { FactoryGirl.create(:answer, content: "first answer to the post", forum_post_id: post.id,
                                     user_id: User.first.id) }
  subject { page }

  create_categories

  describe "new forum post page" do
    before do
      sign_in_user
      visit new_forum_post_path
    end

    it { should have_selector("title", text: "Post a Question") }
    it { should have_selector("form")}
    it { should have_content("Sign Out")}

    describe "creating a new post" do

      context "with valid information" do
        before do
          fill_in "forum_post_title", with: "living abroad in cairo"
          fill_in "forum_post_content", with: "some stuff about cairo"
          select "Egypt", from: "forum_post_category_ids"
          select "Arabic Centers", from: "forum_post_category_ids"
        end

        specify "clicking submit button should create a forum post" do
          expect { click_button "Submit" }.to change(ForumPost, :count)
          ForumPost.find_by_title("living abroad in cairo").categories.count.should == 2
        end

        specify "the new forum post should be the current user's" do
          click_button "Submit"
          ForumPost.find_by_title("living abroad in cairo").user.email.should == "shazebq@gmail.com"
        end

        specify "page should redirect to the forum post detail page" do
          click_button "Submit"
          current_path.should == forum_post_path(ForumPost.find_by_title("living abroad in cairo"))
        end

      end

      context "with missing information" do
        before do
          fill_in "forum_post_title", with: "living abroad in cairo"
          select "Arabic Centers", from: "forum_post_category_ids"
        end

        it "should not create a forum post" do
          expect { click_button "Submit" }.to_not change(ForumPost, :count)
          page.should have_selector(".alert-error", text: "Your post could not be submitted.")
        end

      end

      context "with invalid information" do
        before do
          fill_in "forum_post_title", with: ("a" * 70)
          fill_in "forum_post_content", with: "some stuff about cairo"
          select "Egypt", from: "forum_post_category_ids"
          select "Arabic Centers", from: "forum_post_category_ids"
        end

        it "should not create a forum post" do
          expect { click_button "Submit" }.to_not change(ForumPost, :count)
          page.should have_selector(".alert-error", text: "Your post could not be submitted.")
        end

      end

    end

  end

  describe "forum post show page" do

    before do
      sign_in_user
      @views = post.views_count
      @answer1 = FactoryGirl.create(:answer, content: "Another answer to the post", forum_post_id: post.id,
                                   user_id: User.find_by_email("shazebq@gmail.com").id)
      visit forum_post_path(post)
    end

    describe "general content" do
      it { should have_selector("title", text: post.title)}
      it { should have_selector(".post_content", text: post.content)}
      it "displays answers" do
        page.should have_content(answer.content)
      end

      describe "delete answer links" do
        it "should not appear for answers that do not belong to the logged in user" do
          page.should_not have_selector("#delete_answer#{answer.id}")
        end

        it "should appear for answers that do belong to the logged in user" do
          page.should have_selector("#delete_answer#{@answer1.id}")
        end

      end

      describe "edit answer links" do
        it "should not appear for answers that do not belong to the logged in user" do
          page.should_not have_selector("#edit_answer#{answer.id}")
        end

        it "should appear for answers that do belong to the logged in user" do
          page.should have_selector("#edit_answer#{@answer1.id}")
        end
      end

      describe "post links" do
        describe "delete post link" do
          it "should appear for posts that belong to the logged in user" do
            page.should have_selector("#delete_post")
          end
        end

        describe "edit post link" do
          it "should appear for post that belong to the logged in user" do
            page.should have_selector("#edit_post")
          end
        end

      end

    end

    describe "visiting a post page" do
      it "should increment the number of views" do
        post.views.count.should == 1
      end
    end

    describe "posting an answer to a post" do
      it "should create an answer when an answer is submitted" do
        expect { click_button("Submit Answer") }.to change(Answer, :count).by(1)
      end
    end

    describe "clicking delete link of an answer" do
      it "should delete the answer" do
        expect { click_link("delete_answer#{@answer1.id}") }.to change(Answer, :count).by(-1)
      end
    end

    describe "clicking update link of an answer" do
      it "should redirect to the edit page of the answer" do
        click_link("edit_answer#{@answer1.id}")
        current_path.should == edit_forum_post_answer_path(post, @answer1)
      end
    end

    describe "clicking post links" do
      let!(:post_mine) { FactoryGirl.create(:forum_post, title: "Arabic Centers in Cairo",
                                       content: "what is the best arabic center in cairo?",
                                       category_ids: [parent.id], user_id: User.find_by_email("shazebq@gmail.com").id) }
      before do
        visit forum_post_path(post_mine)
      end

      describe "clicking delete link of the post" do
        it "should delete the answer" do
          expect { click_link("delete_post") }.to change(ForumPost, :count).by(-1)
        end
      end

      describe "clicking edit link of the post" do
        it "should redirect user to edit post page" do
          click_link("edit_post")
          current_path.should == edit_forum_post_path(post_mine)
        end
      end
    end

    #describe "vote up for post", :js => true do
    #  it "is a test" do
    #    find("#up_vote").click
    #    #page.should have_selector(".vote_count", text: "+1")
    #    page.should have_selector("#greeting")
    #  end
    #end
    #commentsss
  end


  #describe "forum post edit page" do
  #  describe "editing the form and submitting it" do
  #    before do
  #      sign_in_user
  #      post.user_id = User.find_by_email("shazebq@gmail.com").id
  #      post.save
  #      visit edit_forum_post_path(post)
  #      fill_in "forum_post_title", with: "new title for this forum post"
  #    end
  #
  #    it "updates the post" do
  #      click_button("Update")
  #      post.reload
  #      post.title.should  == "new title for this forum post"
  #    end
  #  end
  #end


end

#comment