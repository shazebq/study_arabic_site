require "spec_helper"

describe ReviewsHelper do
  describe "generate_stars" do
    it "returns an html snippet with the four filled in stars our of five" do
      generate_stars(4).should == "<i class='icon-star'></i><i class='icon-star'></i><i class='icon-star'></i><i class='icon-star'></i><i class='icon-star-empty'></i>"
    end

    it "returns an html snippet with the one filled in star our of five" do
      generate_stars(1).should == "<i class='icon-star'></i><i class='icon-star-empty'></i><i class='icon-star-empty'></i><i class='icon-star-empty'></i><i class='icon-star-empty'></i>"
    end

    it "returns an html snippet with the zero filled in star our of five" do
      generate_stars(0).should == "<i class='icon-star-empty'></i><i class='icon-star-empty'></i><i class='icon-star-empty'></i><i class='icon-star-empty'></i><i class='icon-star-empty'></i>"
    end

    context "when there is a half number as the argument" do
      it "returns an html snippet with a half a star" do
        generate_stars(1.5).should == "<i class='icon-star'></i><i class='icon-star-half'></i>"
      end
    end
  end
end

#comment



