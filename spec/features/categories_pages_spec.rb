require 'spec_helper'

describe "Category Pages" do

  subject { page }

  describe "index page" do
    create_categories

    before do
      visit categories_path
    end

    describe "page title" do
      it "has the title Forum Categories" do
        page.html.should have_selector("title", text: "Forum Categories")
      end
    end

    describe "parent category listing" do
      it { should have_content("Arabic Language")}
      it { should have_content("Study Abroad (General)")}
      it { should have_content("Study Abroad (Country)")}

      it { should have_selector(".categories_div", text: "Egypt")}
      it { should have_selector(".categories_div", text: "Books")}
      it { should have_selector(".categories_div", text: "Arabic Centers")}
    end

    describe "category links" do
      it { should have_selector("a", text: "Arabic Language") }
      it { should have_selector("a", text: "Arabic Centers") }

      describe "clicking on a category link" do
        it "should redirect to forum post page of the category" do
          click_link("Arabic Centers")
          current_path.should == category_forum_posts_path(child1)
        end

        #it "should redirect to forum post page of a parent category" do
        #  click_link("Arabic Language")
        #  current_path.should == category_forum_posts_path(parent)
        #end
      end
    end

  end



end


#comments
