require 'spec_helper'

describe Country do
  before :each do
    @country = FactoryGirl.build(:country) 
  end

  subject { @country }

  it { should respond_to :users }
  it { should respond_to :cities }
  it { should respond_to :addresses }
end

#comments
