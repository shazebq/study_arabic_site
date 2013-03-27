module CentersHelper
  def center_location(center)
    "#{center.address.city.name}, #{center.address.country.name}"
  end
end
