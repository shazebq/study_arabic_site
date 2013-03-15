require 'spec_helper'

describe Article do
  let(:article) { FactoryGirl.build(:article) } 

  subject { article }

  it { should respond_to :views }
  it { should respond_to :votes }
  it { should respond_to :images }
  it { should respond_to :categories }


end
