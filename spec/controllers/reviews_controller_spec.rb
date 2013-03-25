require "spec_helper"

describe ReviewsController do

  describe "Authorization" do
    let!(:teacher_profile) { FactoryGirl.create(:teacher_profile) }
    let!(:user) { FactoryGirl.create(:user, profile_type: "TeacherProfile", profile_id: teacher_profile.id) }

    context "when teacher tries to review himself" do
      before { sign_in(user) } 
      it "should not create the review" do
        expect do
          post :create, review: { title: "new review", content: "content here", rating: 4 }, teacher_profile_id: teacher_profile.id
        end.to change(Review, :count).by(0)
      end
    end

    context "when user tries to post multiple reviews" do
      let!(:user1) { FactoryGirl.create(:user) }
      let!(:review) { FactoryGirl.create(:review, user_id: user1.id, reviewable_type: "TeacherProfile", reviewable_id: teacher_profile.id) }
      before { sign_in(user1) }
      specify "the review cannot be submitted" do
        expect do
          post :create, review: { title: "new review", content: "content here", rating: 4 }, teacher_profile_id: teacher_profile.id
        end.to change(Review, :count).by(0)
      end
    end
  end
  
end

