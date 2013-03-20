
describe "user show page" do
  create_teacher_records
  before do
    visit user_path(user)
  end

  subject { page }

  describe "general contents" do
    describe "page title" do
      it "has the user's name as the title" do
        page.html.should have_selector("title", text: "#{user.first_name} #{user.last_name}") 
      end
    end
    
    it "should display the user's name" do
      page.should have_content("#{user.first_name} #{user.last_name}")
    end

    it "should display a teacher badge" do
      page.should have_content("Teacher")
    end

    it "should display the user's bio" do
      page.should have_content(user.bio)
    end

    it "should display the user's bio" do
      page.should have_content(user.profile.specialties)
    end

    it "should display the teacher's statistics" do
      page.should have_content("Teacher Statistics")
    end
    
    it "should display the teacher's answers" do
      page.should have_content("Questions Answered")
      page.should have_content(user.answers.count)
    end    

    it "should display a button to review the teacher" do
      #page.should have_content("Write a Review")
    end

    describe "teacher reviews" do
      specify "all teacher reviews should be displayed" do
        page.should have_content(teacher_review.content)
      end
    end

    describe "clicking on the review button" do
      before :each do
        sign_in_user(user)
        visit user_path(user)
      end

      it "should redirect to the teacher_review_path" do
        click_button("Write a Review")
        current_path.should == new_teacher_profile_review_path(teacher_profile) 
      end
    end

    describe "edit/delete links" do
      before :each do
        sign_in_user(user)
        visit user_path(user)
      end

      it "should appear when user is logged in" do
        page.should have_content("Edit Profile")
      end

      describe "clicking edit" do
        it "should redirect to the edit page" do
          click_link("Edit Profile")
          current_path.should == edit_teacher_profile_path(teacher_profile)
        end
      end
    end

    describe "edit links when user is not signed in" do
      it "should not appear" do
        page.should_not have_content("Edit Profile")
      end
    end

    describe "edit links when the user who is signed in is different than the profile" do
      before :each do
        user_new = FactoryGirl.create(:user, email: "wallyjones@example.com")
        sign_in_user(user_new)
        visit user_path(user)
      end

      it "should not appear" do
        page.should_not have_content("Edit Profile")
      end
    end

    describe "send message button" do
      before :each do
        user_new = FactoryGirl.create(:user, email: "wallyjones@example.com")
        sign_in_user(user_new)
        visit user_path(user)
        click_link "Send Message"
      end

      it "should redirect to the new message page" do
        current_path.should == new_user_message_path(user)
      end
    end

    describe "send message button" do
      context "when user is not logged in" do
        before :each do
          visit user_path(user)
          click_link "Send Message"
        end

        it "should redirect to the the sign in page" do
          current_path.should == new_user_session_path
        end
      end
    end
  end
end

# comments
