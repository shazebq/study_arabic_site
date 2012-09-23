require 'spec_helper'

describe ForumPost do
  before :each do
    @forum_post = FactoryGirl.build(:forum_post)
  end

  subject { @forum_post }

  it { should respond_to(:user) }
  it { should respond_to(:categories) }

  # comment


end
