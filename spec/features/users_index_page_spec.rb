require "spec_helper"

describe "users(teachers) index page" do
  create_teacher_records

  before :each do
    visit users_path
  end

  describe "page title" do
    it "has the title Arabic Teacher Directory" do
      page.html.should have_selector("title", text: "Arabic Teacher Directory")
    end
  end

  describe "display of one user profile (teacher)" do
    it "should contain the teacher's basic information" do
      page.should have_content(user.first_name)
      page.should have_content(user.last_name)
    end
  end
end
