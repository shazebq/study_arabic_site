require 'spec_helper'
include Devise::TestHelpers

describe "resources index page" do
  initialize_records
  create_categories
  let!(:resource) { FactoryGirl.create(:resource, category_ids: [Category.first.id] ) }
  subject { page }

  before :each do
    visit resources_path
  end

  describe "page title" do
    it "has the title Resources" do
      page.html.should have_selector("title", text: "Arabic Learning Resources")
    end
  end

  describe "resources information" do
    it { should(have_content(resource.title)) }
    it { should(have_content(resource.views_count)) }
    it { should(have_content(resource.votes_count)) }
    it { should(have_content(resource.downloads_count)) }
  end
end
  # commentsss
