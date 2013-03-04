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
end
