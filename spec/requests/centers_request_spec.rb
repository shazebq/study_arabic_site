require "spec_helper"

describe "Authorization" do
  let(:center) { FactoryGirl.create(:center) }

  context "when user is not signed in" do

    describe "creating a center" do
      before { post(centers_path) }
      it "should not create a center" do
        response.should(redirect_to(new_user_session_path))
      end
    end 

    describe "updating a center" do
      before { put(center_path(center)) }
      it "should not update the center" do
        response.should(redirect_to(new_user_session_path))
      end
    end

    describe "attempting to access page to create a new center" do
      before { get(new_center_path) }
      it "should redirect to the new user page" do
        response.should(redirect_to(new_user_session_path))
      end
    end
  
  end

end
