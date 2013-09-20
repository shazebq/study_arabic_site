require "spec_helper"

describe NotificationsHelper do

  context "when the notification is comment to a user's answer" do
    create_categories
    initialize_records
    let!(:comment) { FactoryGirl.create(:comment, content: "new comment") }
    let!(:comment_notification) { FactoryGirl.create(:notification, recipient_id: user.id, recipient_object_id: answer.id,
                                                      recipient_object_type: "Answer", responsible_party_id: user1.id,
                                                      responsible_party_object_id: comment.id, 
                                                      responsible_party_object_type: "Comment") }
    describe "sentence method" do
      it "should create an appropriate sentence" do
        notification_sentence(comment_notification).should == "#{user1.username} commented on your answer"     
      end
    end

    describe "link method" do
      it "should return a link to forum_post page, comment element" do

      end
    end

    describe "public_activity_sentence" do
      it "should create an appropriate sentence for the public activity feed" do
        public_activity_sentence(comment_notification).should == "#{user1.username} commented on #{user.username}'s answer"   
      end
    end
  end

  context "when notification is an answer to a user's question" do
    create_categories
    initialize_records
    let!(:answer_notification) { FactoryGirl.create(:notification, recipient_id: user.id, recipient_object_id: forum_post.id,
                                                      recipient_object_type: "ForumPost", responsible_party_id: user1.id,
                                                      responsible_party_object_id: answer.id, 
                                                      responsible_party_object_type: "Answer") }
    describe "sentence method" do
      it "should create an appropriate sentence" do
        notification_sentence(answer_notification).should == "#{user1.username} answered your question"     
      end
    end

    describe "public_activity_sentence" do 
      it "should create an appropriate sentence for the public activity feed" do
        public_activity_sentence(answer_notification).should == "#{user1.username} answered #{user.username}'s question"
      end
    end

    describe "link method" do
      it "should return a link to the forum_post page, answer element" do
        #link(answer_notification).should == forum_post_path(forum_post, :anchor => "answer_#{answer_notification.responsible_party_object.id}")
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

    describe "sentence method" do
      it "should return an appropriate sentence" do
        notification_sentence(review_notification).should == "#{teacher_reviewer.username} reviewed you"     
      end
    end

    describe "public_activity_sentence" do 
      it "should create an appropriate sentence for the public activity feed" do
        public_activity_sentence(review_notification).should == "#{teacher_reviewer.username} reviewed #{teacher_profile.user.username}'s teacher profile"
      end
    end

    describe "link method" do 
      it "should create a link to to the teacher profile page, review element" do

      end
    end

  end



end
