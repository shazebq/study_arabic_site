require 'spec_helper'

describe TeacherProfilesController do
  create_teacher_records
  
  describe "Authorization" do
    
    describe "creating a new profile" do
      context "when a user is already signed in" do
        before :each do
          sign_in(user)
        end

        specify "user should not be able to access the create new profile page" do
          post(:create, specialities: "arabic, linguistics")   
          response.should redirect_to root_path
        end
      end
    end

  end
end
