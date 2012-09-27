require 'spec_helper'

describe User do

  subject { page }

  describe "new forum post page" do
    before do
      visit new_forum_post_path
    end

    it { should have_selector("title", text: "Post a Question") }

    it { should have_selector("form")}






  end

end
