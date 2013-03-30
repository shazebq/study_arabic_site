require "spec_helper"

describe "users(teachers) index page" do
  create_teacher_records

  before :each do
    visit users_path
  end

  describe "page title" do
    it "has the title Arabic Teacher Directory" do
      page.html.should have_selector("title", text: "Arabic Teacher Directory")
    end
  end

  describe "display of one user profile (teacher)" do
    it "should contain the teacher's basic information" do
      page.should have_content(user.username)
      page.should have_content(user.last_name)
    end
  end

  describe "teacher's name" do
    it "should be a link to the the user's show page" do
      click_link("#{user.first_name} #{user.last_name}")
    end
  end

  describe "sorting options" do
    it "should have sorting by ratings options" do
      page.should have_content("Ratings")
      page.should have_content("Highest Rated")
      page.should have_content("Most Reviews")
    end

    describe "clicking on sorting options" do
      describe "clicking on 'Highest Rated' option" do
        it "should sort the results by highest rated teacher" do
          check('Highest Rated') 
        end
      end
    end
  end
end
