require 'spec_helper'
include Devise::TestHelpers

describe "show resource page" do
  let!(:user) { FactoryGirl.create(:user)}
  let!(:category) { FactoryGirl.create(:category, name: "Vocabulary") }
  let!(:resource) { FactoryGirl.create(:resource, title: "Colors",
                                      description: "colors vocabulary worksheet", category_ids: [category.id], user_id: user.id)}
  let!(:review) { FactoryGirl.create(:review, title: "excellent vocab sheet", content: "more details here", reviewable_id: resource.id, reviewable_type: "Resource", user_id: user.id) }

  before do
    visit resource_path(resource)
  end

  subject { page }

  describe "general contents" do
    describe "page title" do
      it "has the title Forum Categories" do
        page.html.should have_selector("title", text: resource.title)
      end
    end

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

    context "when the user is signed in" do
      before :each do
        sign_in_user(user)
        visit resource_path(resource)
      end

      it "should display delete and edit links" do
        page.should have_selector("#delete_review#{review.id}", text: "Delete")
        page.should have_selector("#edit_review#{review.id}", text: "Edit")
      end

      describe "clicking edit review link" do
        it "should redirect to the edit page of the review" do
          click_link("edit_review#{review.id}")
          current_path.should == edit_resource_review_path(resource, review)
        end
      end

      describe "clicking delete review link" do
        it "should delete the review" do
          expect { click_link("delete_review#{review.id}") }.to change(Review, :count).by(-1)
        end

        it "should redirect to the resource page" do
          click_link("delete_review#{review.id}")
          current_path.should == resource_path(resource)
        end
      end
    end
  end

  describe "clicking review button" do
    it "should redirect to new review page" do
      click_button("Review this resource")
      current_path.should == new_resource_review_path(resource)
    end
  end

  describe "reviews" do
    it "should display all of the resource's reviews" do
      page.should have_content(review.title)
    end
  end
end

#commentsss