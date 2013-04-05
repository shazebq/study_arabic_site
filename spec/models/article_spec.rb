require 'spec_helper'

describe Article do
  let(:article) { FactoryGirl.build(:article) } 
  let(:user) { FactoryGirl.create(:user, reputation: 0)}

  before :each do
    @article1 = Article.new(title: "new article", user_id: user.id)
    @article1.save(validate: false)
  end

  subject { article }

  it { should respond_to :views }
  it { should respond_to :votes }
  it { should respond_to :images }
  it { should respond_to :categories }
  it { should respond_to :comments }

  describe "validations" do
    before { @article1 = Article.new(title: "study advice", content: "some more info here", user_id: 5) }
  end

  describe "count_vote function" do
    it "should add a vote if up voted and return the number of up votes" do
      article.count_vote(@article1.id, "Article", user.id, "up").should == 1
    end

    it "should cause the reputation of the owner of the resource to increase by 2" do
      article.count_vote(@article1.id, "Article", user.id, "up")
      @article1.user.reputation.should == 4
    end
  end

  describe "when article is voted down after already having an up vote" do
    before :each do
      @article1.count_vote(@article1.id, "Article", user.id, "up")
    end

    #it "should decrease the number of vote counts and also decrease the reputation of the article owner" do
    #  @article1.count_vote(@article1.id, "Article", user.id, "down")
    #  @article1.user.reputation.should == 0
    #end
  end

end

# comments


#def count_vote(voteable_id, voteable_type, user_id, type)
