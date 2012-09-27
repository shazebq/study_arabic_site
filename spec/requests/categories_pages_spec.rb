require 'spec_helper'

describe "Category Pages" do

  subject { page }

  describe "index page" do
    let!(:parent) { FactoryGirl.create(:category, name: "Arabic Language") }
    let!(:parent1) { FactoryGirl.create(:category, name: "Study Abroad") }
    let!(:parent2) { FactoryGirl.create(:category, name: "Countries") }
    let!(:child) { FactoryGirl.create(:category, name: "Books", category_parent_id: parent.id) }
    let!(:child1) { FactoryGirl.create(:category, name: "Arabic Centers", category_parent_id: parent1.id) }
    let!(:child2) { FactoryGirl.create(:category, name: "Egypt", category_parent_id: parent2.id) }

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