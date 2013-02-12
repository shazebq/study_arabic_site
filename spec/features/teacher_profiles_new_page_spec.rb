require "spec_helper"

describe "new teacher profile page" do
  before do
    sign_in_user( FactoryGirl.create(:user, email: "shazebq@gmail.com") )
    visit new_teacher_profile_path

  end

  describe "page contents" do
    it "should include fields for the teacher profile" do
      page.should have_selector("#profile_education")
    end
  end
end

#comments
