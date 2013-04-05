require 'spec_helper'
include Devise::TestHelpers

describe "user show page when user has a student profile" do
  let!(:country) { FactoryGirl.create(:country) }
  let!(:level) { FactoryGirl.create(:level) }
  let!(:student_profile) { FactoryGirl.create(:student_profile, level_id: level.id) }
  let!(:user) { FactoryGirl.create(:user, profile_type: "StudentProfile", profile_id: student_profile.id, country_id: country.id) }
  let!(:teacher_review) { FactoryGirl.create(:review, reviewable_type: "TeacherProfile") }

  before do
    visit user_path(user)
  end

  subject { page }

  describe "general contents" do
    describe "page title" do
      it "has the user's username as the title" do
        page.html.should have_selector("title", text: user.username) 
      end
    end
    
    it "should display the user's name" do
      page.should have_content(user.username)
    end

    it "should display a student badge" do
      page.should have_content("Student")
    end

    it "should display the user's bio" do
      page.should have_content(user.bio)
    end

    it "should display the students statistics" do
      page.should have_content("Student Statistics")
    end
    
    it "should display the student's answers" do
      page.should have_content("Questions Answered")
      page.should have_content(user.answers.count)
    end
  end

  describe "edit/delete links" do
      before :each do
        sign_in_user(user)
        visit user_path(user)
      end

      it "should appear when user is logged in" do
        page.should have_content("Edit Profile")
      end

      describe "clicking edit" do
        it "should redirect to the edit page" do
          click_link("Edit Profile")
          current_path.should == edit_student_profile_path(student_profile)
        end
      end
    end
end

# comment
