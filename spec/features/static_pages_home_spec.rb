require "spec_helper"

describe "home page" do
  before :each do
    visit home_path
  end

  describe "general content" do
    it "has the title Resources" do
      page.html.should have_selector("title", text: "StudyArabic.com")
    end
  end

  describe "searching" do
    describe "searching forums from home page" do
      before :each do
        fill_in "query", with: "roommates"  
        select "Forums", from: "item_type"  
      end
    end
  end

  describe "layout content" do
    before :each do
    end
    it "should have a link to the logged in user's profile" do

    end
  end
end

# comment
