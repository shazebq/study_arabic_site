require "spec_helper"

describe ProfilesHelper do
  
  describe "get_user_type" do
    it "should return the string teacher if in the teachers controller" do
      get_other_user_type("teacher_profiles_controller").should == "student"
    end
  end
end

#comments
