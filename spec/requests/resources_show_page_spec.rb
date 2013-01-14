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
    it { should have_selector(".stats", text: resource.votes_count.to_s)}  # number of votes
    it { should have_selector(".stats", text: resource.downloads_count.to_s)}  # number of downloads
  end

  describe "visiting a resource page" do
    it "should increment the number of views" do
      resource.views.count.should == 1
    end
  end

  describe "edit and delete links" do
    before :each do
      sign_in_user(user)
      visit resource_path(resource)
    end

    it { should have_selector("a", text: "Edit")}
    it { should have_selector("a", text: "Delete")}

    describe "clicking resource links" do
      describe "clicking delete link of the resource" do
        it "should delete the resource" do
          expect { click_link("delete") }.to change(Resource, :count).by(-1)
        end
      end

      describe "clicking edit link of the post" do
        it "should redirect user to edit post page" do
          click_link("edit")
          current_path.should == edit_resource_path(resource)
        end
      end
    end
  end

  describe "resource links" do
    context "when the user is not signed in" do
      it "should not display delete or edit links" do
        page.should_not have_selector("a", text: "Edit")
        page.should_not have_selector("a", text: "Delete")
      end
    end
  end

end

#comment