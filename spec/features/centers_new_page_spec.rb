require "spec_helper"

describe "new center page" do
  let(:user) { FactoryGirl.create(:user) } 

  before :each do
    FactoryGirl.create(:country, name: "Egypt")
    visit new_center_path
    sign_in_user(user)
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
      fill_in "center_description", with: "a great arabic center"
      fill_in "center_year_established", with: 1998
      fill_in "center_price_per_hour_private", with: 5.00
      fill_in "center_price_per_hour_group", with: 4.00
      fill_in "center_website", with: "http://www.studyarabic.com" 
      fill_in "center_email", with: "studyarabic@example.com" 
      fill_in "center_phone_number", with: "408-554-2343" 
      fill_in "center_total_price", with: 5000
      choose "center_housing_provided_true" 
      choose "center_short_term_true"
      choose "center_long_term_true"
      fill_in "center_address_attributes_address_line", with: "123 Najeeb Mahfouz Street"
      fill_in "center_address_attributes_city_name", with: "Cairo" 
      select "Egypt", from: "center_address_attributes_country_id" 
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
