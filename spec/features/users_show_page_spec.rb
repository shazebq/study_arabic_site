require 'spec_helper'
include Devise::TestHelpers

describe "user show page" do
  let!(:teacher_profile) { FactoryGirl.create(:teacher_profile) }
  let!(:user) { FactoryGirl.create(:user, profile_type: "TeacherProfile", profile_id: teacher_profile.id) }
  before do
    visit user_path(user)
  end

  subject { page }

  describe "general contents" do
    describe "page title" do
      it "has the user's name as the title" do
        page.html.should have_selector("title", text: "#{user.first_name} #{user.last_name}") 
      end
    end
    
    it "should display the user's name" do
      page.should have_content("#{user.first_name} #{user.last_name}")
    end

    it "should display a teacher badge" do
      page.should have_content("Teacher")
    end

    it "should display the user's bio" do
      page.should have_content(user.bio)
    end

    it "should display the user's bio" do
      page.should have_content(user.profile.specialties)
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
          current_path.should == edit_teacher_profile_path(teacher_profile)
        end
      end
    end
  end
end

# comments
