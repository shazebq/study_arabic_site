require 'spec_helper'
include Devise::TestHelpers

describe "new resource page" do
  create_categories
  let!(:level) { FactoryGirl.create(:level, title: "advanced") }

  before do
    @user = FactoryGirl.create(:user, email: "shazebq@gmail.com")
    sign_in_user(@user)
    visit new_resource_path
  end

  subject { page }
  describe "page title" do
    it "has the title Forum Categories" do
      page.html.should have_selector("title", text: "Enter Resource Information")
    end
  end
  it { should have_selector("#resource_title")}
  it { should have_selector("#resource_description")}

  describe "validations" do
    context "when no title is give" do
      before do
        fill_in "resource_description", with: "a grammar worksheet"
      end

      it "should display an error" do
        click_button("Next")
        page.should(have_content("Your submission could not be accepted"))
      end
    end
  end

  describe "filling out form and clicking submit" do
    context "when the user is logged in" do
      before do
        fill_in "resource_title", with: "fruit vocabulary"
        fill_in "resource_description", with: "a simple vocab sheet that has common fruit names with Arabic translations"
        select "Books", from: "resource_category_ids"
        select "advanced", from: "resource_level_id"
      end

      specify "clicking submit button should create a resource" do

      end
    end
  end

  describe "user trying to access new resource page without being logged in" do
    before do
      click_link("Sign Out")
      visit new_resource_path
    end

    it "should cause user to be redirected to the sign in page" do
      current_path.should == new_user_session_path
    end
  end
end
