require "spec_helper"

describe "Authentication Pages" do

  describe "Authorization" do

    describe "for non signed in users" do
      create_categories

      describe "visiting new forum_post page" do
        before { visit new_forum_post_path }
        specify { current_path.should == new_user_session_path }
      end





    end

  end









end