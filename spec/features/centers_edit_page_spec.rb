require "spec_helper"

describe "centers edit page" do
  let!(:center) { FactoryGirl.create(:center) }

  before :each do
    visit edit_center_path(center)
  end
  describe "title" do
    it "should be Edit Center/Program Information" do
      page.html.should have_selector("title", text: "Edit Center/Program Information")
    end
  end
end
