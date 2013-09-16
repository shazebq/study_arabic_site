$(document).ready(function() {  


  function map_setup() {
    var mapOptions = {
      // center on the U.S. for now
      center: new google.maps.LatLng(39.50, -98.35),
      zoom: 4,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    var map = new google.maps.Map(document.getElementById("map-canvas"),
        mapOptions);


    set_markers(map)
  }

  function set_markers(map) {
    centers = ( $("#map-canvas").data("centers") );

    markers = new Array();
    //info_windows = new Array();

    // loop through each of the centers and create a marker for each one using the lat and long attributes
    info_window = new google.maps.InfoWindow({
                              content: "hello this is a very cool center don't you think?",
                        });

    count = 0;
    $.each(centers, function() {
       markers[count] = new google.maps.Marker({
                                    position: new google.maps.LatLng(this["address"]["latitude"],this["address"]["longitude"]),
                                    map: map,
                                    title:"Hello World!"
                                 });
       count += 1
    });

    for (var foo=0;foo< markers.length;foo++)
    {
      bind_info_window(markers[foo], map, info_window);
    }
  }


  // need this closure in order the the multiple info window thing to work
  function bind_info_window(marker, map, info_window) {
    google.maps.event.addListener(marker, 'click', function() {
      //info_window.setContent(strDescription);
      info_window.open(map, marker);
    });
  }

  google.maps.event.addDomListener(window, 'load', map_setup);

});
