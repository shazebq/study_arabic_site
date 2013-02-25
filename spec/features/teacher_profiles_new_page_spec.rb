require "spec_helper"

describe "new teacher profile page" do
  before :each do
    sign_in_user( FactoryGirl.create(:user, email: "shazebq@gmail.com") )
    FactoryGirl.create(:country, name: "Egypt")
    visit new_teacher_profile_path
  end

  describe "page contents" do
    it "should include fields for the teacher profile" do
      page.should have_selector("#teacher_profile_university")
      page.should have_selector("#teacher_profile_field_of_study")
      page.should have_selector("#teacher_profile_specialties")
    end
  end

  describe "creating a new teacher account" do
    before :each do
      fill_in "teacher_profile_university", with: "Cairo University"
      fill_in "teacher_profile_field_of_study", with: "Arabic Literature"
      fill_in "teacher_profile_years_of_experience", with: "5"
      fill_in "teacher_profile_price_per_hour", with: "5.50"
      fill_in "teacher_profile_specialties", with: "grammar, quran, islamic arabic"
      choose "teacher_profile_online_true"
      choose "teacher_profile_in_person_true"
      fill_in "teacher_profile_user_attributes_first_name", with: "Bill"
      fill_in "teacher_profile_user_attributes_last_name", with: "Jones"
      fill_in "teacher_profile_user_attributes_email", with: "bjones@example.com"
      fill_in "teacher_profile_user_attributes_password", with: "cool123"
      fill_in "teacher_profile_user_attributes_password_confirmation", with: "cool123"
      fill_in "teacher_profile_user_attributes_bio", with: "great teacher with lots of experience"
      fill_in "teacher_profile_user_attributes_skype_id", with: "billyjones"
      select "Egypt", from: "teacher_profile_user_attributes_country_id"
      attach_file "teacher_profile_user_attributes_image_attributes_photo", "/Users/shazeb/Pictures/test_image.jpg" 
    end

    specify "clicking create account button should create a user and a new teacher_profile" do
      expect { click_button "Submit" }.to change(TeacherProfile, :count)
    end

    specify "clicking create account button should create a user and a new user" do
      expect { click_button "Submit" }.to change(User, :count)
    end

    specify "clicking create account button should create an image which belongs to the user" do
      click_button "Submit"
      User.last.image.should_not be_nil 
    end

  end
end

#comments
