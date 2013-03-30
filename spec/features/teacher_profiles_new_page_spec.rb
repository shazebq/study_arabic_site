require "spec_helper"

describe "new teacher profile page" do
  before :each do
    FactoryGirl.create(:country, name: "Egypt")
    FactoryGirl.create(:language, name: "Mandarin")
    FactoryGirl.create(:language, name: "Arabic")
    FactoryGirl.create(:degree, name: "Master")
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
      fill_in "teacher_profile_age", with: 29
      select "Male", from: "teacher_profile_gender"
      fill_in "teacher_profile_employment_history", with: "some arabic center"
      fill_in "teacher_profile_field_of_study", with: "Arabic Literature"
      fill_in "teacher_profile_years_of_experience", with: "5"
      fill_in "teacher_profile_price_per_hour", with: "5.50"
      fill_in "teacher_profile_specialties", with: "grammar, quran, islamic arabic"
      choose "teacher_profile_online_true"
      choose "teacher_profile_in_person_true"
      fill_in "teacher_profile_user_attributes_username", with: "Bill"
      fill_in "teacher_profile_user_attributes_last_name", with: "Jones"
      fill_in "teacher_profile_user_attributes_email", with: "bjones@example.com"
      fill_in "teacher_profile_user_attributes_password", with: "cool123"
      fill_in "teacher_profile_user_attributes_password_confirmation", with: "cool123"
      fill_in "teacher_profile_user_attributes_bio", with: "great teacher with lots of experience"
      fill_in "teacher_profile_user_attributes_skype_id", with: "billyjones"
      select "Egypt", from: "teacher_profile_user_attributes_country_id"
      select "Mandarin", from: "teacher_profile_language_ids"
      select "Arabic", from: "teacher_profile_language_ids"
      select "Master", from: "teacher_profile_degree_id"
    end

    specify "clicking create account button should create a user and a new teacher_profile" do
      expect { click_button "Submit" }.to change(TeacherProfile, :count)
    end

    specify "clicking create account button should create a user and a new user" do
      expect { click_button "Submit" }.to change(User, :count)
    end

    specify "clicking submit button should add the selected languages to the teacher profile" do
      click_button "Submit"
      TeacherProfile.find_by_age(29).languages.should include(Language.find_by_name("Mandarin"), Language.find_by_name("Arabic"))
    end

    specify "clicking submit should add the selected degree to the teacher profile" do
      click_button "Submit"
      TeacherProfile.find_by_age(29).degree.name.should == "Master"
    end

  end
end

#comments
