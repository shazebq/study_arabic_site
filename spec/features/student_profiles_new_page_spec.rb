require "spec_helper"

describe "student profile new page" do
  before :each do
    sign_in_user( FactoryGirl.create(:user, email: "shazebq@gmail.com") )
    FactoryGirl.create(:country, name: "Egypt")
    visit new_student_profile_path
  end

  describe "general content" do
    it "should include fields specific for student profile" do
      page.should have_selector("#student_profile_level_id")
    end
  end
end

# comment
