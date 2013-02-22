require "spec_helper"

describe "centers index page" do
  let!(:center) { FactoryGirl.create(:center) }
  before :each do
    visit centers_path
  end

  describe "title of page" do
    it "has the title Arabic Centers and Programs" do
      page.html.should have_selector("title", text: "Arabic Centers and Programs")
    end
  end

  describe "general contents" do
    it "should include the names of the centers" do
      page.should have_content(center.name)
    end
  end

  
end
