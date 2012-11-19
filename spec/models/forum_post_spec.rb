require 'spec_helper'

describe ForumPost do
  before :each do
    @forum_post = FactoryGirl.build(:forum_post)
  end

  subject { @forum_post }

  it { should respond_to(:user) }
  it { should respond_to(:categories) }
  it { should respond_to(:votes) }
  it { should respond_to(:answers)}
  it { should respond_to(:views)}
  #comment

  describe "count_vote" do
    let(:parent) { FactoryGirl.create(:category, name: "Arabic Language") }
    let(:forum_post) { FactoryGirl.create(:forum_post, category_ids: parent.id) }

    it "adds the vote to the forum if it is voted up and removes the vote if it is voted down" do
      expect { forum_post.count_vote(forum_post.id, "ForumPost", 1, "up") }.should change(forum_post.votes, :count).by(1)
    end

    it "subtracts the vote only if it was already voted for by the same user" do
      forum_post.count_vote(forum_post.id, "ForumPost", 1, "up")
      expect { forum_post.count_vote(forum_post.id, "ForumPost", 1, "down") }.should change(forum_post.votes, :count).by(-1)
    end

    it "makes no change if the user has not voted the post up" do
      expect { forum_post.count_vote(forum_post.id, "ForumPost", 1, "down") }.to_not change(Vote, :count)
    end

    it "returns the number of votes of the post" do
      forum_post.count_vote(forum_post.id, "ForumPost", 1, "up")
      forum_post.votes.count.should == 1
    end
  end

end