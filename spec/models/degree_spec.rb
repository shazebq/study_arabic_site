require 'spec_helper'

describe Degree do
  before :each do
    @degree = FactoryGirl.build(:degree)
  end

  subject { @degree }

  it { should(respond_to :teacher_profiles) }
end
