require 'spec_helper'

describe Answer do
  let!(:answer) { FactoryGirl.create(:answer, content: "first question submitted")}
  let!(:answer1) { FactoryGirl.create(:answer, content: "great question")}
  let!(:answer2) { FactoryGirl.create(:answer, content: "nice question")}
  subject { answer }

  it { should respond_to(:user) }
  it { should respond_to(:forum_post) }

  describe "count_vote" do
    it "adds the vote to the forum if it is voted up and removes the vote if it is voted down" do
      expect { answer.count_vote(answer.id, "Answer", 1, "up") }.to change(answer.votes, :count).by(1)
    end
  end

  describe "by_votes scope" do
    before :each do
      answer2.votes.create()
      answer2.reload
    end

    it "should order answers by number of votes descending" do
      Answer.by_votes.first.should == answer2
    end

    it "should secondarily order answers by when created descending" do
      Answer.by_votes.last.should == answer
    end
  end
end
