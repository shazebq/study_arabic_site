require "spec_helper"

describe "Authorization" do
  let!(:language) { FactoryGirl.create(:language) }
  let!(:teacher_profile) { FactoryGirl.create(:teacher_profile, language_ids: [language.id]) }
  let!(:user) { FactoryGirl.create(:user, profile_id: teacher_profile.id, profile_type: "TeacherProfile") }
  
  context "when user is not signed in" do
    describe "updating a profile" do
      before { put(teacher_profile_path(teacher_profile)) }
      it "should not update the teacher profile" do
        response.should(redirect_to(root_path))
      end
    end
  end

end

# comments
