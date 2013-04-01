require "spec_helper"

describe "new images page" do
  before :each do
    # an imageable object should already exist
    @center = FactoryGirl.create(:center)
    visit new_center_image_path(@center)
  end

  it "is a test" do
    
  end
end
