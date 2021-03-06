require 'spec_helper'
include Devise::TestHelpers

describe "forum post show page" do
  initialize_records
  create_categories
  let!(:answer_other) { FactoryGirl.create(:answer, user_id: 99) }

  describe "answers form when user is not signed in" do
    before :each do
      visit forum_post_path(forum_post)
    end
    it "should not be displayed" do
      page.should_not have_selector("#answer_content")
      page.should_not have_content("Submit Answer")
    end
  end

  describe "when user is signed in" do
    before :each do
      sign_in_user(user)
      visit forum_post_path(forum_post)
    end

    subject { page }

    describe "general content" do
      describe "page title" do
        it "has the title Forum Categories" do
          page.html.should have_selector("title", text: forum_post.title)
        end
      end

      it "displays answers" do
        page.should have_content(answer.content)
      end
    end

    describe "delete answer links" do
      it "should not appear for answers that do not belong to the logged in user" do
        page.should_not have_selector("#delete_answer#{answer_other.id}")
      end

      it "should appear for answers that do belong to the logged in user" do
        page.should have_selector("#delete_answer#{answer.id}")
      end

      describe "edit answer links" do
        it "should not appear for answers that do not belong to the logged in user" do
          page.should_not have_selector("#edit_answer#{answer_other.id}")
        end

        it "should appear for answers that do belong to the logged in user" do
          page.should have_selector("#edit_answer#{answer.id}")
        end
      end

      describe "post links" do
        describe "delete post link" do
          it "should appear for posts that belong to the logged in user" do
            page.should have_selector("#delete")
          end
        end

        describe "edit post link" do
          it "should appear for post that belong to the logged in user" do
            page.should have_selector("#edit")
          end
        end
      end
    end

    describe "visiting a post page" do
      it "should increment the number of views" do
        forum_post.views.count.should == 1
      end
    end

    
    describe "clicking delete link of an answer" do
      it "should delete the answer" do
        expect { click_link("delete_answer#{answer.id}") }.to change(Answer, :count).by(-1)
      end
    end

    describe "clicking update link of an answer" do
      it "should redirect to the edit page of the answer" do
        click_link("edit_answer#{answer.id}")
        current_path.should == edit_forum_post_answer_path(forum_post, answer)
      end
    end

    describe "clicking post links" do
      let!(:post_other) { FactoryGirl.create(:forum_post, title: "Arabic Centers in Cairo",
                                            content: "what is the best arabic center in cairo?",
                                            category_ids: [parent.id], user_id: 99) }

      describe "clicking delete link of the post" do
        it "should delete the answer" do
          expect { click_link("delete") }.to change(ForumPost, :count).by(-1)
        end
      end


      describe "clicking edit link of the post" do
        it "should redirect user to edit post page" do
          click_link("edit")
          current_path.should == edit_forum_post_path(forum_post)
        end
      end
    end
  end
  
  describe "posting an answer to a post" do
    let(:user_5) { FactoryGirl.create(:user) }
    before :each do
      sign_in_user(user_5)
      visit forum_post_path(forum_post)
      fill_in "answer_content", with: "Hi there, I'm looking for a great Arabic teacher"
    end

    it "should create an answer when an answer is submitted" do
      expect { click_button("Submit Answer") }.to change(Answer, :count).by(1)
    end

    it "should create a notification for the question owner" do
      expect { click_button("Submit Answer") }.to change(Notification, :count).by(1) 
    end

    specify "the notification should have the correct attributes" do
      click_button("Submit Answer")
      Notification.first.recipient.should == forum_post.user
      Notification.first.responsible_party.should == user_5
      Notification.first.recipient_object.should == forum_post
      Notification.first.responsible_party_object.should == Answer.find_by_content("Hi there, I'm looking for a great Arabic teacher")
    end
  end

  # figure out a way for this to work
  #describe "vote up for post", :js => true do
  #  it "is a test" do
  #    find("#up_vote").click
  #    #page.should have_selector(".vote_count", text: "+1")
  #    page.should have_selector("#greeting")
  #  end
  #end
  #commentsss
end
