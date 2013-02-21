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
end

# comments
