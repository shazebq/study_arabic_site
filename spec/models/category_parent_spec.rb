require 'spec_helper'

describe CategoryParent do

  describe "collect_all_posts" do
    before do
      @category_parent = CategoryParent.create(name: "Study Abroad")
      @child_category1 = Category.create(name: "Egypt", category_parent_id: @category_parent.id)
      @child_category2 = Category.create(name: "Jordan", category_parent_id: @category_parent.id)
      @forum_post1 = FactoryGirl.create(:forum_post, category_ids: [@child_category1.id])
      @forum_post2 = FactoryGirl.create(:forum_post, category_ids: [@child_category2.id])
      @child_category1.forum_posts << @forum_post1
      @child_category2.forum_posts << @forum_post2
    end

    it "returns all the posts of all the child categories" do
      @category_parent.collect_all_posts.should == [@forum_post1, @forum_post2]
    end
  end
end