require 'spec_helper'
include Devise::TestHelpers

describe "show resource page" do
  let(:user) { FactoryGirl.create(:user)}
  let(:category) { FactoryGirl.create(:category, name: "Vocabulary") }
  let(:resource) { FactoryGirl.create(:resource, title: "Colors",
                                      description: "colors vocabulary worksheet", category_ids: [category.id], user_id: user.id)}

  before do
    visit resource_path(resource)
  end

  subject { page }

  describe "general contents" do
    it { should have_selector("title", text: resource.title) }
    it { should have_selector("h3", text: resource.title)}
    it { should have_content("colors vocabulary worksheet")}
  end

  describe "side bar" do
    it { should have_content("Vocabulary")}   # category name

    it { should have_selector(".stats", text: resource.votes_count.to_s)}  # number of views

  end

  describe "visiting a resource page" do
    it "should increment the number of views" do
      resource.views.count.should == 1
    end
  end

  describe "edit and delete links" do
    #it { should have_selector("a", text: "edit")}
    #
    #it { should have_selector("a", text: "delete")}
  end

end

#comments