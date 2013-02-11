require 'spec_helper'

describe TeacherProfile do
  before :each do
    @teacher_profile = FactoryGirl.build(:teacher_profile)
  end

  subject { @teacher_profile}

  it { should(respond_to :user) }
end

#commentss
