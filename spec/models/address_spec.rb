require 'spec_helper'

describe Address do
  before :each do
    @address = FactoryGirl.build(:address)
  end
  subject { @address }

  it { should respond_to(:country) }
  it { should respond_to(:city) }
  it { should respond_to(:center) }
  
end

#comments
