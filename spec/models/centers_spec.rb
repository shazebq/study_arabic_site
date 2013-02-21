require 'spec_helper'

describe Center do
  before :each do
    @center = FactoryGirl.build(:center)
  end

  subject { @center }

  it { should respond_to :address }
  it { should respond_to :images }
end

#comment
