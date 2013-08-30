$(document).ready(function() {  


  function map_setup() {
    var mapOptions = {
      center: new google.maps.LatLng(39.50, -98.35),
      zoom: 4,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    var map = new google.maps.Map(document.getElementById("map-canvas"),
        mapOptions);


    set_markers(map)
  }

  function set_markers(map) {
    centers = ( $("#map-canvas").data("centers") )
    // loop through each of the centers and create a marker for each one using the lat and long attributes
    $.each(centers, function() {
      new google.maps.Marker({
            position: new google.maps.LatLng(this["address"]["latitude"],this["address"]["longitude"]),
            map: map,
            title:"Hello World!"
        });
    });


      
  }

  google.maps.event.addDomListener(window, 'load', map_setup);

});
