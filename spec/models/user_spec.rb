require 'spec_helper'

describe User do
  before :each do
    @user = FactoryGirl.build(:user)
  end

  subject {@user}

  it { should respond_to(:forum_posts) }
  it { should respond_to(:answers) }
  it { should respond_to(:resources) }
  it { should respond_to(:profile) }
  it { should respond_to(:country) }
end

#comments
