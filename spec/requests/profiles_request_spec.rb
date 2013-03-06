require "spec_helper"

describe "Authorization" do
  let!(:teacher_profile) { FactoryGirl.create(:teacher_profile) }
  let!(:user) { FactoryGirl.create(:user, profile_id: teacher_profile.id, profile_type: "TeacherProfile") }
  
  context "when user is not signed in" do
    describe "updating a profile" do
      before { put(teacher_profile_path(teacher_profile)) }
      it "should not update the teacher profile" do
        response.should(redirect_to(new_user_session_path))
      end
    end
  end

  #context "when user is signed in and is the owner of the profile" do
  #  describe "updating  a profile" do
  #  end
  #end
    
end

# comments
