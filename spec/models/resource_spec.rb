require 'spec_helper'

describe Resource do
  let(:resource) { FactoryGirl.build(:resource) }
  subject { resource }

  it {should respond_to(:categories)}


end
