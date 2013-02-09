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
  
  describe "filter" do
    describe "most views link" do
      it "should redirect to the index page with posts sorted by views" do
        click_link "Most Views"
        #uri = URI.parse(current_url)
        #"#{uri.path}?#{uri.query}".should == forum_posts_path(:order_by => 'most_views')
      end
    end
  end
end
# comment
