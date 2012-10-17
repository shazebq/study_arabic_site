require "spec_helper"

describe "Authentication Pages" do

  describe "Authorization" do

    describe "for non signed in users" do

      describe "visiting new forum_post page" do
        create_categories  # need categories for this page to work
        before { visit new_forum_post_path }
        specify { current_path.should == new_user_session_path }
      end

    end

  end









end