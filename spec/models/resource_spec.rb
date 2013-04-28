require 'spec_helper'

describe Resource do
  let(:resource) { FactoryGirl.build(:resource) }
  subject { resource }

  it { should respond_to(:categories) }
  it { should respond_to(:user) }
  it { should respond_to(:votes) }
  it { should respond_to(:reviews) }

  describe "scopes" do
    let!(:parent) { FactoryGirl.create(:category, name: "Grammar") }
    let!(:resource1) { FactoryGirl.create(:resource, category_ids: parent.id, views_count: 2, votes_count:4, downloads_count: 0) }
    let!(:resource2) { FactoryGirl.create(:resource, category_ids: parent.id, views_count: 9, votes_count:1, downloads_count: 4) }
    let!(:resource3) { FactoryGirl.create(:resource, category_ids: parent.id, views_count: 5, votes_count:3, downloads_count: 8) }

    describe "most views scope" do
      it "should order resources by number of views descending" do
       Resource.most_views.first.should == resource2
      end

      it "should order the resource with the fewest votes last" do
       Resource.most_views.last.should == resource1
      end
    end

    describe "most votes scope" do
      it "should order resources by number of votes descending" do
        Resource.most_votes.first.should == resource1
      end

      it "should order the resource with fewest votes last" do
        Resource.most_votes.last.should == resource2
      end
    end

    describe "most downloads scope" do
      it "should order resources by number of downloads descending" do
        Resource.most_downloads.first.should == resource3
      end

      it "should order the resource with fewest downloads last" do
        Resource.most_downloads.last.should == resource1
      end
    end
  end

  describe "validate_file_type function" do
    context "valid file type" do
      it "should return true" do
        file_name = "uploads/resources/something.jpg"  
        Resource.validate_file_type(file_name).should == true
      end
    end

    context "invalid file type" do
      it "should return false" do
        file_name1 = "uploads/resources/something.rb"
        Resource.validate_file_type(file_name1).should == false
      end
    end

    context "when there is no file extension" do
      it "should return false" do
        file_name1 = "uploads/resources/something"
        Resource.validate_file_type(file_name1).should == false
      end
    end
  end
end

# comments
