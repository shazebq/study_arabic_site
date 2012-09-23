require 'spec_helper'

describe "Category Pages" do

  subject { page }

  describe "index page" do
    before { visit categories_path }

    it { should(have_selector("title", text: "Forum Categories")) }


  end



end

#kjasd