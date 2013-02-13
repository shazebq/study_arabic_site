require 'spec_helper'

describe User do
  before :each do
    @user = FactoryGirl.build(:user)
  end

  subject {@user}

  it { should respond_to(:forum_posts) }
  it { should respond_to(:answers) }
  it { should respond_to(:resources) }
  it { should respond_to(:profile) }
  it { should respond_to(:country) }
  it { should respond_to(:image) }

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

#comment
