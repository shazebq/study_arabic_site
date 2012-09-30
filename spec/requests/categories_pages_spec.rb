require 'spec_helper'

describe "Category Pages" do

  subject { page }

  describe "index page" do
    create_categories

    before do
      visit categories_path
    end

    it { should have_selector("title", text: "Forum Categories") }

    it { should have_selector("h3", text: "Forum Categories")}

    describe "parent category listing" do
      it { should have_content("Arabic Language")}
      it { should have_content("Study Abroad (General)")}
      it { should have_content("Study Abroad (Country Specific)")}

      it { should have_selector(".categories_div", text: "Egypt")}
      it { should have_selector(".categories_div", text: "Books")}
      it { should have_selector(".categories_div", text: "Arabic Centers")}
    end
  end



end