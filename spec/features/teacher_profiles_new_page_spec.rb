require "spec_helper"

describe "new teacher profile page" do
  before :each do
    sign_in_user( FactoryGirl.create(:user, email: "shazebq@gmail.com") )
    FactoryGirl.create(:country, name: "Egypt")
    visit new_teacher_profile_path
  end

  describe "page contents" do
    it "should include fields for the teacher profile" do
      page.should have_selector("#teacher_profile_education")
    end
  end

  describe "creating a new teacher account" do
    before :each do
      fill_in "teacher_profile_education", with: "bachelors degree in Arabic"
      fill_in "teacher_profile_years_of_experience", with: "5"
      choose "teacher_profile_online_1"
      choose "teacher_profile_in_person_1"
      fill_in "teacher_profile_user_attributes_first_name", with: "Bill"
      fill_in "teacher_profile_user_attributes_last_name", with: "Jones"
      fill_in "teacher_profile_user_attributes_email", with: "bjones@example.com"
      fill_in "teacher_profile_user_attributes_password", with: "cool123"
      fill_in "teacher_profile_user_attributes_password_confirmation", with: "cool123"
      fill_in "teacher_profile_user_attributes_bio", with: "great teacher with lots of experience"
      select "Egypt", from: "teacher_profile_user_attributes_country_id"
      attach_file "teacher_profile_user_attributes_image_attributes_image", "/Users/shazeb/Pictures/test_image.jpg" 
    end

    specify "clicking create account button should create a user and a new teacher_profile" do
      expect { click_button "Create account" }.to change(TeacherProfile, :count)
    end

    specify "clicking create account button should create a user and a new user" do
      expect { click_button "Create account" }.to change(User, :count)
    end

    specify "clicking create account button should create an image which belongs to the user" do
      click_button "Create account"
      User.last.image.should_not be_nil 
    end

  end
end

#commentsss
