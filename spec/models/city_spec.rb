require 'spec_helper'

describe City do
  before :each do
    @city = FactoryGirl.build(:city)
  end

  subject { @city }

  it { should respond_to(:country) }
  it { should respond_to(:addresses) }
end
