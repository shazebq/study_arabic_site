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
      expect { forum_post.count_vote(forum_post.id, "ForumPost", 1, "up") }.to change(forum_post.votes, :count).by(1)
    end

    it "subtracts the vote only if it was already voted for by the same user" do
      forum_post.count_vote(forum_post.id, "ForumPost", 1, "up")
      expect { forum_post.count_vote(forum_post.id, "ForumPost", 1, "down") }.to change(forum_post.votes, :count).by(-1)
    end

    it "makes no change if the user has not voted the post up" do
      expect { forum_post.count_vote(forum_post.id, "ForumPost", 1, "down") }.to_not change(Vote, :count)
    end

    it "returns the number of votes of the post" do
      forum_post.count_vote(forum_post.id, "ForumPost", 1, "up")
      forum_post.votes.count.should == 1
    end
  end

  describe "scopes" do
    let!(:parent) { FactoryGirl.create(:category, name: "Arabic Language") }
    let!(:forum_post1) { FactoryGirl.create(:forum_post, category_ids: parent.id, views_count: 2, votes_count:3, answers_count: 0) }
    let!(:forum_post2) { FactoryGirl.create(:forum_post, category_ids: parent.id, views_count: 5, votes_count:2, answers_count: 8) }
    let!(:forum_post3) { FactoryGirl.create(:forum_post, category_ids: parent.id, views_count: 9, votes_count: 3, answers_count: 4) }

    describe "most_views scope" do
      it "should order posts by number of views descending" do
        ForumPost.most_views.first.should == forum_post3
      end

      it "should order the post with the fewest views last" do
        ForumPost.most_views.last.should == forum_post1
      end
    end

    describe "most_votes scope" do
      it "should order posts by number of votes descending" do
        ForumPost.most_votes.first.should == forum_post1
      end

      it "should order the post with the fewest votes last" do
        ForumPost.most_votes.last.should == forum_post2
      end
    end

    describe "most_answers scope" do
      it "should order posts by number of answers descending" do
        ForumPost.most_answers.first.should == forum_post2
      end

      it "should order the post with the fewest answers last" do
        ForumPost.most_answers.last.should == forum_post1
      end
    end

    describe "unanswered scope" do
      it "should only display posts with no answers" do
        ForumPost.unanswered.first.should == forum_post1
      end

      it "should not display posts with answers" do
        ForumPost.unanswered.should_not(include(forum_post2))
      end
    end

  end

end

#comments