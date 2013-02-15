require "spec_helper"

describe "teacher profile edit page" do
  let!(:teacher_profile) { FactoryGirl.create(:teacher_profile) }
  let!(:user) { FactoryGirl.create(:user, profile_type: "TeacherProfile", profile_id: teacher_profile.id) }
  before :each do
    visit edit_teacher_profile_path(teacher_profile)  
  end
  subject { page }

  describe "general contents" do
    it { should_not have_selector("#teacher_profile_user_attributes_password") } 
  end 
  
  describe "general contents" do
    it { should_not have_selector("#teacher_profile_user_attributes_password_confirmation") } 
  end

  describe "editing a field and submitting the form" do
    before :each do
      fill_in "teacher_profile_field_of_study", with: "Rhetoric" 
    end

    it "should redirect to the user's page" do
      click_button "Submit"
      current_path.should == user_path(user)
    end
  end
end

# comments
