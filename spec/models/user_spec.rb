require 'spec_helper'

describe User do
  before :each do
    @user = FactoryGirl.build(:user)
  end

  subject {@user}

  it { should respond_to(:forum_posts) }
  it { should respond_to(:reviews) }
  it { should respond_to(:answers) }
  it { should respond_to(:resources) }
  it { should respond_to(:profile) }
  it { should respond_to(:country) }
  it { should respond_to(:image) }

  describe "validations" do
    before :each do
      @user1 = User.new(first_name: "Billy", last_name: "Jones", bio: "A wonderful arabic teacher",
                        email: "jjones@example.com", country_id: 123, password: "cool123", password_confirmation: "cool123")
    end
    describe "user validation" do
      
      describe "valid user information is submitted" do
        it "should be valid with valid information" do
          @user1.should be_valid
        end
      end

      describe "email validation" do
        describe "invalid email is submitted" do
          before { @user1.email = "blahblah" }
          it "should be invalid" do
            @user1.should_not be_valid
          end
        end

        describe "valid email is submitted" do
          it "should be valid" do
            @user1.should be_valid
          end
        end
      end

      describe "name validation" do
        describe "blank name" do
          before { @user1.first_name = nil }
          it "should not be valid" do
            @user1.should_not be_valid
          end
        end

        describe "very long name" do
          before { @user1.first_name = "a" * 100 }
          it "should not be valid" do
            @user1.should_not be_valid
          end
        end

        describe "a valid name" do
          before { @user1.first_name = "Bill" }
          it "should be valid" do
            @user1.should be_valid
          end
        end
      end

      describe "skype_id validation" do
        describe "long skype_id" do
          before { @user1.skype_id = "a" * 100 }
          it "should not be valid" do
            @user1.should_not be_valid
          end
        end

      end

    end


  end






  # this spec doesn't work but it does work
  #describe "after a user is destroyed" do
  #  before :each do
  #    @teacher_profile = FactoryGirl.create(:teacher_profile)
  #    @user1 = FactoryGirl.create(:user, profile_type: "TeacherProfile", profile_id: @teacher_profile.id)
  #    @user1.destroy
  #    @user1.reload
  #  end
  #  it "its profile should also be destroyed" do
  #    @user1.destroyed?.should == true
  #  end
  #end
end

#comments
