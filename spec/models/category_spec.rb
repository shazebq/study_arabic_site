require 'spec_helper'

describe Category do
  before :each do
    @category = FactoryGirl.build(:category)
  end

  subject { @category }

  it { should respond_to(:forum_posts) }

  it { should respond_to(:category_parent)}

  it { should respond_to(:category_parent)}
  
  describe "popular_forums" do
    let!(:category1) { FactoryGirl.create(:category, name: "Egypt") }
    let!(:category2) { FactoryGirl.create(:category, name: "Roommates") }
    let!(:join_record1) { FactoryGirl.create(:categories_categorizable, category_id: category1.id, categorizable_type: "ForumPost") }
    let!(:join_record2) { FactoryGirl.create(:categories_categorizable, category_id: category1.id, categorizable_type: "ForumPost") }

    it "should should return categories ordered by the number of forums associated with each category descending" do
      Category.popular_forums.size.count == 2
    end
  end
end
