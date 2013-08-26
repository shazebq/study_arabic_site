require 'spec_helper'

describe Address do
  before :each do
    @address = FactoryGirl.build(:address)
  end
  subject { @address }

  it { should respond_to(:country) }
  it { should respond_to(:city) }
  it { should respond_to(:center) }

  let!(:country) { FactoryGirl.create(:country, name: "United States") } 
  let!(:city) { FactoryGirl.create(:city, name: "Morgan Hill", country_id: country.id) } 
  let!(:address_new) { FactoryGirl.create(:address, address_line: "150 Fennel Court", country_id: country.id, city_id: city.id) } 

  describe "full_address" do
    it "should return a string with the full address line including city and country" do
      address_new.full_address.should == "150 Fennel Court, Morgan Hill, United States"
    end
  end
end

#comments
