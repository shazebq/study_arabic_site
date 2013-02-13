require 'spec_helper'

describe Image do
  before :each do
    @image = FactoryGirl.build(:image)
  end

  subject { @image }

  it { should respond_to :imageable }
end

#comments
