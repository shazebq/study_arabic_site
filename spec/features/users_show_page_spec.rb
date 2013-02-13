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

  end
end

# commentss
