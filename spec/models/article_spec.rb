require 'spec_helper'

describe Article do
  let(:article) { FactoryGirl.build(:article) } 

  subject { article }

  it { should respond_to :views }
  it { should respond_to :votes }
  it { should respond_to :images }
  it { should respond_to :categories }
  it { should respond_to :comments }

  describe "validations" do
    before { @article1 = Article.new(title: "study advice", content: "some more info here", user_id: 5) }
  end

end

# comments
