require 'spec_helper'

describe StudentProfile do
  before :each do
    @student_profile = FactoryGirl.build(:student_profile)
  end

  subject { @student_profile }

  it { should(respond_to :user) }

  describe "validation" do
    before :each do
      @student_profile1 = StudentProfile.new()
    end
   
    describe "level validation" do
      describe "when level is not present" do
        it "should be valid" do
          @student_profile1.should_not be_valid
        end
      end

      describe "when level is not present" do
        before { @student_profile1.level_id = 5 }
        it "should not be valid" do
          @student_profile.should be_valid
        end
      end
    end
    
  end

end


