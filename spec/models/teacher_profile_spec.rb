require 'spec_helper'

describe TeacherProfile do
  before :each do
    @teacher_profile = FactoryGirl.build(:teacher_profile)
  end

  subject { @teacher_profile }

  it { should(respond_to :user) }
  
  it "should create a user AND teacher profile" do
    @teacher_profile_with_user = { field_of_study: "bachelors in Arabic", university: "Cairo University",
                                  years_of_experience: 2, specialties: "Classical Arabic", online: true, in_person: false,
                                  user_attributes: { first_name: "John", last_name: "Khan", email: "jkhan@example.com",
                                                     password: "cool123", password_confirmation: "cool123" } }
    profile = TeacherProfile.create!(@teacher_profile_with_user)
    profile.id.should_not be_nil
    profile.user.should_not be_nil
  end

  describe "scopes" do
    let!(:teacher_profile1) { FactoryGirl.create(:teacher_profile, reviews_count: 1) }
    let!(:user1) { FactoryGirl.create(:user, profile_type: "TeacherProfile", profile_id: teacher_profile1.id) }
    
    let!(:teacher_profile2) { FactoryGirl.create(:teacher_profile, reviews_count: 2) }
    let!(:user2) { FactoryGirl.create(:user, profile_type: "TeacherProfile", profile_id: teacher_profile2.id) }

    describe "most reviews descending" do
      it "should sort teachers by number of reviews descending" do
        User.order_by_reviews.first.should == user2
      end
    end
  end
end

#commentss


