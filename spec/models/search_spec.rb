require "spec_helper"

describe "site wide search" do
  it "should do a site wide search on all of the models included" do
    PgSearch.multisearch("Homer").should be_instance_of(ActiveRecord::Relation)
  end
end

# comments
