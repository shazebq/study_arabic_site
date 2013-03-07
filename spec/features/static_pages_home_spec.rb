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
    let(:user) { FactoryGirl.create(:user) }
    before :each do
      sign_in_user(user)
    end
    it "should have a link to the logged in user's profile" do
      page.should have_selector("a", text: "Profile")
    end
    
    describe "clicking on the profile link" do
      before :each do
        click_link "Profile"
      end
      it "should redirect to the user's profile page" do
        current_path.should == user_path(user)
      end
    end
  end
end

# comment
