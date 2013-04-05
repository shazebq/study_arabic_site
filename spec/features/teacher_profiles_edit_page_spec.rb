require "spec_helper"

describe "teacher profile edit page" do
  create_teacher_records
  before :each do
    sign_in_user(user) 
    visit edit_teacher_profile_path(teacher_profile)  
  end
  subject { page }

  describe "general contents" do
    it { should_not have_selector("#teacher_profile_user_attributes_password") } 
  end 
  
  describe "general contents" do
    it { should_not have_selector("#teacher_profile_user_attributes_password_confirmation") } 
  end

end

# comments
