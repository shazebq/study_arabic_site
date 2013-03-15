require "spec_helper"

describe ReviewsHelper do
  describe "generate_stars" do
    it "returns an html snippet with the four filled in stars our of five" do
      generate_stars(4).should == "<span class='star-rating'><i class='rating-40'></i></span>".html_safe
    end

    it "returns an html snippet with the zero filled in stars our of five" do
      generate_stars(0).should == "<span class='star-rating'><i class='rating-0'></i></span>".html_safe
    end
  end
end

#comment



