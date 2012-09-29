require 'spec_helper'

describe User do

  subject { page }

  describe "new forum post page" do
    before do
      visit new_forum_post_path
    end

    it { should have_selector("title", text: "Post a Question") }

    it { should have_selector("form")}

    describe "creating a new post" do

      # try filling out the form and adding the category?

      it "should create a forum post" do
        expect { click_button "Submit" }.should change(ForumPost, :count)
        #puts ForumPost.first.categories.count
      end



    end






  end

end
