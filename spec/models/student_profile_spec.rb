require 'spec_helper'

describe StudentProfile do
  before :each do
    @student_profile = FactoryGirl.build(:student_profile)
  end

  subject { @student_profile }

  it { should(respond_to :user) }
end
