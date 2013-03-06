require "spec_helper"

describe "centers show page" do
  let!(:country) { FactoryGirl.create(:country) }
  let!(:city) { FactoryGirl.create(:city, country_id: country.id) }
  let!(:address) { FactoryGirl.create(:address, country_id: country.id, city_id: city.id) }
  let!(:center) { FactoryGirl.create(:center, name: "Number 1 Arabic Center") }

  before :each do
    visit center_path(center) 
  end

  describe "title of page" do
    it "has the title Arabic Centers and Programs" do
      page.html.should have_selector("title", text: "Number 1 Arabic Center")
    end
  end

  describe "general contents" do
    it "should include the name of the center" do
      page.should have_content(center.name)
    end

    it "should include the description of the center" do
      page.should have_content(center.description)
    end
  end
  
  describe "edit link" do
    create_student_records
    before :each do
      sign_in_user(user)
    end
    it "should redirect to the edit page for the center when clicked" do
      click_link "Edit Center/Program Info"
      current_path.should == edit_center_path(center)
    end
  end

end
