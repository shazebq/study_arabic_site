require "spec_helper"

describe ReviewsController do

  describe "Authorization" do
    let!(:language) { FactoryGirl.create(:language) }
    let!(:degree) { FactoryGirl.create(:degree) }
    let!(:city) { FactoryGirl.create(:city) }
    let!(:teacher_profile) { FactoryGirl.create(:teacher_profile, degree_id: degree.id, city_id: city.id, language_ids: [language.id]) }
    let!(:user) { FactoryGirl.create(:user, profile_type: "TeacherProfile", profile_id: teacher_profile.id) }

    context "when teacher tries to review himself" do
      before :each do 
        user.confirm!
        sign_in(user)
      end
      it "should not create the review" do
        expect do
          post :create, review: { title: "new review", content: "content here", rating: 4 }, teacher_profile_id: teacher_profile.id
        end.to change(Review, :count).by(0)
      end
    end

    context "when user tries to post multiple reviews" do
      let!(:user1) { FactoryGirl.create(:user) }
      let!(:review) { FactoryGirl.create(:review, user_id: user1.id, reviewable_type: "TeacherProfile", reviewable_id: teacher_profile.id) }

      before :each do 
        user1.confirm!
        sign_in(user1)
      end

      specify "the review cannot be submitted" do
        request.env["HTTP_REFERER"] = root_path
        expect do
          post :create, review: { title: "new review", content: "content here", rating: 4 }, teacher_profile_id: teacher_profile.id
        end.to change(Review, :count).by(0)
      end
    end

    context "when a user submits a review for a teacher" do
      let!(:reviewer_profile) { FactoryGirl.create(:teacher_profile, degree_id: degree.id, city_id: city.id, language_ids: [language.id]) }
      let!(:user2) { FactoryGirl.create(:user, profile_type: "TeacherProfile", profile_id: reviewer_profile.id) }
      
      before :each do
        user2.confirm!
        sign_in(user2)
      end

      it "should create the review" do
        expect do
          post :create, review: { title: "new review", content: "content here", rating: 4 }, teacher_profile_id: teacher_profile.id
        end.to change(Review, :count).by(1)
      end

      it "should create a notification for the teacher is who reviewed" do
        expect do
          post :create, review: { title: "new review", content: "content here", rating: 4 }, teacher_profile_id: teacher_profile.id
        end.to change(Notification, :count).by(1)
         
        Notification.last.recipient.should == teacher_profile.user
        Notification.last.responsible_party.should == user2
        Notification.last.recipient_object.should == teacher_profile
        Notification.last.responsible_party_object.should == Review.last
      end
    end

  end
  
end

