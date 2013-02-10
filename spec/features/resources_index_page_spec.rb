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
  
  describe "filter links" do
    describe "most views link" do
      it "should redirect to the index page with posts sorted by views" do
        click_link "Most Views"
        uri = URI.parse(current_url)
        "#{uri.path}?#{uri.query}".should == resources_path(:order_by => 'most_views')
      end
    end

    describe "most votes link" do
      it "should redirect to the index page with posts sorted by most votes" do
        click_link "Most Votes"
        uri = URI.parse(current_url)
        "#{uri.path}?#{uri.query}".should == resources_path(:order_by => 'most_votes')
      end
    end

    describe "most downloads link" do
      it "should redirect to the index page with posts sorted by most downloads" do
        click_link "Most Downloads"
        uri = URI.parse(current_url)
        "#{uri.path}?#{uri.query}".should == resources_path(:order_by => 'most_downloads')
      end
    end
  end

  describe "category links" do
   it "should have links to each category" do
     page.should have_selector("a", text: "Vocabulary")
   end
  end

end
# comment
