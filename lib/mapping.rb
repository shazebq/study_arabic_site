module Mapping

  DEFAULT_LAT_LONG = { latitude: 35.0, longitude: -9.0, zoom: 2 }  

  def get_lat_long
    if self.latitude? && self.longitude?
      if self.is_a?(Country)
        zoom = 4
      else
        zoom = 8
      end
      { latitude: self.latitude, longitude: self.longitude, zoom: zoom }
    else
      DEFAULT_LAT_LONG
    end
  end
end
