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

      it "should redirect to the forums index and display the relevant search results" do
        click_button "Search"  
        current_path.should == forum_posts_path
      end
    end
  end
end

# comments
