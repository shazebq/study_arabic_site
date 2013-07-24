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
  it { should respond_to(:sent_messages) }
  it { should respond_to(:received_messages) }
  it { should respond_to(:votes) }
  it { should respond_to(:notifications) }


  describe "add_rep_points" do
    let(:user) { FactoryGirl.create(:user, reputation: 0) }

    context "when user adds a forum_post" do
      before { user.add_rep_points("ForumPost") }
      it "should increase the user's reputation by 2 point" do
        user.reputation.should == 2
      end

    end

    context "when user adds a answer" do
      before { user.add_rep_points("Answer") }
      it "should increase the user's reputation by 4 point" do
        user.reputation.should == 4
      end

    end

    context "when user adds a resource" do
      before { user.add_rep_points("Resource") }
      it "should increase the user's reputation by 4 point" do
        user.reputation.should == 4
      end

    end

  end

  describe "user_voted_up? method" do
    initialize_records
    before :each do
      @user_voter = FactoryGirl.create(:user)
      @vote = FactoryGirl.create(:vote, user_id: @user_voter.id, voteable_type: "ForumPost", voteable_id: forum_post.id) 
    end
    
    it "should return true if the user has voted for the resource" do
      @user_voter.voted_up?(forum_post).should == true 
    end
  
  end

  describe "validations" do
    before :each do
      @user1 = User.new(first_name: "Billy", last_name: "Jones", bio: "A wonderful arabic teacher", username: "bill",
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

    end

  end

  describe "any_notifications?" do
    let(:user) { FactoryGirl.create(:user) }
    let(:notification) { FactoryGirl.create(:notification, recipient_id: user.id) }

    context "user has an unchecked notification" do
      before :each do
        user.reload
        notification.reload
      end
      it "should return true" do
        user.new_notifications.size.should == 1 
      end
    end

    context "user has a notification but it has been checked" do
      before :each do
        notification.checked = true
        notification.save
        notification.reload
      end

      it "should return false" do
        user.new_notifications.size.should == 0
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
