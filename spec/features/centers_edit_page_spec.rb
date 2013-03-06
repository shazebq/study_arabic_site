require "spec_helper"

describe "centers edit page" do
  let!(:center) { FactoryGirl.create(:center) }
  let!(:student) { FactoryGirl.create(:student_profile)}
  let!(:user) { FactoryGirl.create(:user, profile_id: student.id, profile_type: "StudentProfile") }

  before :each do
    sign_in_user(user)
    visit edit_center_path(center)
  end
  describe "title" do
    it "should be Edit Center/Program Information" do
      page.html.should have_selector("title", text: "Edit Center/Program Information")
    end
  end

  describe "making an edit and hitting submit" do
    #before :each do
    #  fill_in "center_name", with: "Baba's Arabic House" 
    #  click_button "Submit"
    #end

    #it "should successfully change the record" do

    #  
    #end
  end
end

# comemnts
