require 'spec_helper'

describe Answer do
  let(:answer) { FactoryGirl.create(:answer)}
  subject { answer }

  it { should respond_to(:user) }
  it { should respond_to(:forum_post) }

end
