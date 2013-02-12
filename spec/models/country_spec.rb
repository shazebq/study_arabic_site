require 'spec_helper'

describe Country do
  before :each do
    @country = FactoryGirl.build(:country) 
  end

  subject { @country }

  it { should respond_to :users }
end

#comments
