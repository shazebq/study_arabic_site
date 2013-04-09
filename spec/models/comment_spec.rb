require 'spec_helper'

describe Comment do
  before { @comment = FactoryGirl.build(:comment) }

  subject { @comment }

  it { should respond_to :commentable }
  it { should respond_to :comments }
end


# comment
