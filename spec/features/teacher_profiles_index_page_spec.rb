require "spec_helper"

describe "user(teachers) index page" do
  describe "users(teachers) index page" do
    create_teacher_records

    before :each do
      visit teacher_profiles_path
    end

    describe "page title" do
      it "has the title Arabic Teacher Directory" do
        page.html.should have_selector("title", text: "Arabic Teacher Directory")
      end
    end

    describe "display of one user profile (teacher)" do
      it "should contain the teacher's basic information" do
        page.should have_content(user.first_name)
        page.should have_content(user.last_name)
      end
    end

    describe "teacher's name" do
      it "should be a link to the the user's show page" do
        click_link("#{user.first_name} #{user.last_name}")
      end
    end

    describe "sorting options" do
      describe "ratings options" do
        it "should have sorting by ratings options" do
          page.should have_content("Ratings")
          page.should have_selector("#order_by_average_rating")
          page.should have_selector("#order_by_reviews")
        end
      end

      describe "instruction type options" do
        it "should have filter options for instruction type" do
          page.should have_content("Instruction Type")
          page.should have_selector("#in_person_filter")
          page.should have_selector("#online_filter")
        end
      end

    end
  end

end
