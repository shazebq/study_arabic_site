require 'spec_helper'

describe TeacherProfile do
  before :each do
    @teacher_profile = FactoryGirl.build(:teacher_profile)
  end

  subject { @teacher_profile}

  it { should(respond_to :user) }
  
  it "should create a user AND teacher profile" do
    @user_and_teacher_profile = { field_of_study: "bachelors in Arabic", university: "Cairo University",
                                  years_of_experience: 2, specialties: "Classical Arabic", online: true, in_person: false,
                                  user_attributes: { first_name: "John", last_name: "Khan", email: "jkhan@example.com",
                                                     password: "cool123", password_confirmation: "cool123" } }
    profile = TeacherProfile.create!(@user_and_teacher_profile)
    profile.id.should_not be_nil
    profile.user.should_not be_nil
  end
end

#comments
