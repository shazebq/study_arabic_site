require "spec_helper"

describe "student profile new page" do
  
  describe "general content" do
    before :each do
      visit new_student_profile_path
    end

    it "should include fields specific for student profile" do
      page.should have_selector("#student_profile_level_id")
    end
  end
end

# comment
