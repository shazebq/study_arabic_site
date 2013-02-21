require "spec_helper"

describe "centers show page" do
  let!(:center) { FactoryGirl.create(:center, name: "Number 1 Arabic Center") }

  before :each do
    visit center_path(center) 
  end

  describe "title of page" do
    it "has the title Arabic Centers and Programs" do
      page.html.should have_selector("title", text: "Number 1 Arabic Center")
    end
  end
end
