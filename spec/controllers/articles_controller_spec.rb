require "spec_helper"

describe ArticlesController do

  describe "authorization" do
    let(:user) { FactoryGirl.create(:user) }

    describe "creating an article" do

      context "when user is not logged in" do
        #before { sign_in(user) }
        it "should not allow user to create an article" do
          post :create, article: FactoryGirl.attributes_for(:article) 
          response.should redirect_to(new_user_session_path)
        end

      end

      context "when user is logged in but not a staff writer" do
        before { sign_in(user) }
        it "should not allow user to create an article" do
          post :create, article: FactoryGirl.attributes_for(:article) 
          response.should redirect_to(root_path)
        end
      end

      context "when user is a staff writer" do
        before :each do
          user.staff_writer = true
          user.save
          sign_in(user)
        end
        it "should allow user to create an article" do
          post :create, article: FactoryGirl.attributes_for(:article) 
          response.code.should == "200"
        end
      end
    end
  end
end

