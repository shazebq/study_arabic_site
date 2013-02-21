class CentersController < ApplicationController
  def new
    @center = Center.new
  end
end
