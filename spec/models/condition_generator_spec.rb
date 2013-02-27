require "spec_helper"

describe "ConditionGenerator Class" do
  before :each do
    @generator = ConditionGenerator.new
  end

  describe "bool_generator" do
    it "should create a sql boolean condition based on the array provided" do
      @generator.bool_generator(["online", "in_person", "at_work"]).
        should == ["online = :value OR in_person = :value", { value: "true" } ]
    end
  end
end

# comment
