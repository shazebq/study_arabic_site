require 'spec_helper'

describe Language do
  before :each do
    @language = FactoryGirl.build(:language)
  end
                                                          
  subject { @language }
                                                          
  it { should(respond_to :teacher_profiles) }
end
