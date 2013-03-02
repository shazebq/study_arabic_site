require 'spec_helper'

describe Review do
  let(:review) { FactoryGirl.build(:review) }
  subject { review }

  it { should respond_to(:user) }
  it { should respond_to(:reviewable) }
end

# comments
