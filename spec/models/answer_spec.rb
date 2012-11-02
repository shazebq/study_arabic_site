require 'spec_helper'

describe Answer do
  let(:answer) { FactoryGirl.create(:answer)}
  subject { answer }

  it { should respond_to(:user) }
  it { should respond_to(:forum_post) }

  describe "count_vote" do
    it "adds the vote to the forum if it is voted up and removes the vote if it is voted down" do
      expect { answer.count_vote(answer.id, "Answer", 1, "up") }.should change(answer.votes, :count).by(1)
    end

  end



end
