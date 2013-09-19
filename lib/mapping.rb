module Mapping
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
