require "spec_helper"

describe "new center page" do
  
  before :each do
    visit new_center_path
  end

  describe "page title" do
    it "has the title Forum Categories" do
      page.html.should have_selector("title", text: "Add an Arabic Center or Program")
    end
  end

  describe "general content" do
    it "should display all of the appropriate fields" do
      page.should have_selector("#center_name")
      page.should have_selector("#center_description")
    end
  end

  describe "submitting a new center/program" do
    before :each do
      fill_in "center_name", with: "Diwan Arabic Center"
      fill_in "center_description", with: "A wonderful arabic center where you can learn a whole lot!"
      fill_in "center_address_attributes_address_line", with: "123 Najeeb Mahfouz Street"
      fill_in "center_address_attributes_city_id", with: 2 
      fill_in "center_address_attributes_country_id", with: 5
    end

    specify "clicking the submit button should create a new center record" do
      expect { click_button "Submit" }.to change(Center, :count)
    end
    
    specify "clicking the submit button should create a new address record as well" do
      expect { click_button "Submit" }.to change(Address, :count)
    end
  end
end

# comments
