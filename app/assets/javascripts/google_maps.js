$(document).ready(function() {  

  console.log( $("#map-canvas").data("centers") )

  function map_setup() {
    var mapOptions = {
      center: new google.maps.LatLng(39.50, -98.35),
      zoom: 4,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    var map = new google.maps.Map(document.getElementById("map-canvas"),
        mapOptions);

    var latLng = new google.maps.LatLng(38.632892,-117.312012);


      new google.maps.Marker({
          position: latLng,
          map: map,
          title:"Hello World!"
      });
  }
  google.maps.event.addDomListener(window, 'load', map_setup);

});
