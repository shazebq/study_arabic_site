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
          page.should have_selector("#in_person")
          page.should have_selector("#online")
        end
      end

      describe "price options" do
        it "should have filter options price" do
          page.should have_content("Price")
          page.should have_selector("#five")
          page.should have_selector("#ten")
        end
      end
    end

    describe "side bar" do
      let!(:country) { FactoryGirl.create(:country, name: "Mali") }
      let!(:teacher_profile1) { FactoryGirl.create(:teacher_profile, language_ids: [language.id], degree_id: degree.id, city_id: city.id) }
      let!(:user1) { FactoryGirl.create(:user, profile_type: "TeacherProfile", profile_id: teacher_profile1.id, country_id: country.id) }
      let!(:teacher_review1) { FactoryGirl.create(:review, reviewable_type: "TeacherProfile",
                                              reviewable_id: teacher_profile1.id, content: "wonderful teacher!!!") }
      before :each do
        visit teacher_profiles_path
      end

      it "should have a list of all the countries represented by teachers" do
        page.should have_content(user1.country.name)
      end
    end
  end

end
