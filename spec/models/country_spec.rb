require 'spec_helper'

describe Country do
  before :each do
    @country = FactoryGirl.build(:country) 
  end

  subject { @country }

  it { should respond_to :users }
  it { should respond_to :cities }
  it { should respond_to :addresses }

  describe "getting the number of items that belong to a particular country" do
    let!(:language) { FactoryGirl.create(:language) }
    let!(:country) { FactoryGirl.create(:country, name: "Canada") }
    let!(:address) { FactoryGirl.create(:address, country_id: country.id) }
    let!(:center) { FactoryGirl.create(:center, address_id: address.id) }
    let!(:center1) { FactoryGirl.create(:center, address_id: address.id) }
    let!(:teacher_profile) { FactoryGirl.create(:teacher_profile, language_ids: [language.id]) }
    let!(:user) { FactoryGirl.create(:user, country_id: country.id, profile_id: teacher_profile.id, profile_type: "TeacherProfile") }

    describe "getting the number of teachers from a certain country" do
      it "should return 1" do
        country.teacher_profiles_in_country.should == 1
      end
    end

    describe "getting the number of centers in a certain country" do
      it "should return 1" do
        country.centers_in_country.should == 2
      end
    end
  end
end

#comments
