require "spec_helper"

describe NotificationsHelper do

  describe "sentence method" do

    context "when the notification is not a teacher review" do
      create_categories
      initialize_records
      context "when notification is a comment to a user's answer" do
        let!(:comment) { FactoryGirl.create(:comment, content: "new comment") }
        let!(:comment_notification) { FactoryGirl.create(:notification, recipient_id: user.id, recipient_object_id: answer.id,
                                                        recipient_object_type: "Answer", responsible_party_id: user1.id,
                                                        responsible_party_object_id: comment.id, 
                                                        responsible_party_object_type: "Comment") }
        it "should create an appropriate sentence" do
          notification_sentence(comment_notification).should == "#{user1.username} commented on your answer"     
        end
      end

      context "when notification is an answer to a user's question" do
        let!(:answer_notification) { FactoryGirl.create(:notification, recipient_id: user.id, recipient_object_id: forum_post.id,
                                                        recipient_object_type: "ForumPost", responsible_party_id: user1.id,
                                                        responsible_party_object_id: answer.id, 
                                                        responsible_party_object_type: "Answer") }
        it "should create an appropriate sentence" do
          notification_sentence(answer_notification).should == "#{user1.username} answered your question"     
        end
      end
    end

    context "when notification is a review to a teacher's profile" do
      create_teacher_records
      let!(:teacher_reviewer) { FactoryGirl.create(:user, email: "shazebq@gmail.com", password: "cool123") }
      let!(:review_notification) { FactoryGirl.create(:notification, recipient_id: user.id, recipient_object_id: teacher_profile.id,
                                                      recipient_object_type: "TeacherProfile", 
                                                      responsible_party_id: teacher_reviewer.id,
                                                      responsible_party_object_id: teacher_review.id, 
                                                      responsible_party_object_type: "Review") }


      it "should create an appropriate sentence" do
        notification_sentence(review_notification).should == "#{teacher_reviewer.username} wrote a review about you"     
      end
    end

  end

end
