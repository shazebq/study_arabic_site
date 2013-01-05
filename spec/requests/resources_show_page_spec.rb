require 'spec_helper'
include Devise::TestHelpers

describe "show resource page" do
  let(:category) { FactoryGirl.create(:category) }
  let(:resource) { FactoryGirl.create(:resource, title: "A new resource", category_ids: [category.id])}

  before do
    visit resource_path(resource)
  end

  subject { page }

  describe "general contents" do
    it { should have_selector("title", text: resource.title) }
  end
end

#comment