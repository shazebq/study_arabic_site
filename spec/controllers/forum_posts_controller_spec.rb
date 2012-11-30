require 'spec_helper'

describe ForumPostsController do
  let!(:parent) { FactoryGirl.create(:category, name: "Study Abroad") }
  let(:forum_post) { FactoryGirl.create(:forum_post, category_ids: [parent.id]) }

  describe "GET #show" do
    it "assigns the requested forum_post to @forum_post" do
      get :show, id: forum_post
      assigns(:forum_post).should == forum_post
    end
  end
end



