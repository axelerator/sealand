// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .

function workshopPopup(workshop, lonLat, icon) {
  var id = "wor"+workshop.id
    , closeBox = true
    , closeBoxCallback = function() { this.destroy(); }
    , contentSize = new OpenLayers.Size(300,200)
    , contentHTML = "<a href=\""+workshop.workshop_url+"\"><h4>"+workshop.workshop.name+"</h4><img width=\"250\" src=\""+workshop.plan_image+"\" /></a>";

  return new OpenLayers.Popup.Anchored(
      id,
      lonLat,
      contentSize,
      contentHTML,
      icon,
      closeBox,
      closeBoxCallback
  );
}

initMap = function(map, workshops, materials) {
    OpenLayers.ProxyHost="/proxy/?url=";
    var layerMapQuest, layerAerial;

    layerMapQuest = new OpenLayers.Layer.OSM("MapQuest Open", [
                     "http://otile1.mqcdn.com/tiles/1.0.0/osm/${z}/${x}/${y}.jpg",
                     "http://otile2.mqcdn.com/tiles/1.0.0/osm/${z}/${x}/${y}.jpg",
                     "http://otile3.mqcdn.com/tiles/1.0.0/osm/${z}/${x}/${y}.jpg",
                     "http://otile4.mqcdn.com/tiles/1.0.0/osm/${z}/${x}/${y}.jpg"
                    ]);

    layerAerial = new OpenLayers.Layer.OSM("Aerial", [
                     "http://oatile1.mqcdn.com/tiles/1.0.0/sat/${z}/${x}/${y}.jpg",
                     "http://oatile2.mqcdn.com/tiles/1.0.0/sat/${z}/${x}/${y}.jpg",
                     "http://oatile3.mqcdn.com/tiles/1.0.0/sat/${z}/${x}/${y}.jpg",
                     "http://oatile4.mqcdn.com/tiles/1.0.0/sat/${z}/${x}/${y}.jpg"
                  ]);

    map.addLayer(layerMapQuest);
    map.addLayer(layerAerial);
    map.setCenter(new OpenLayers.LonLat(0, 0), 0);

    var workshopsMarker = new OpenLayers.Layer.Markers( "Workshops" );
    var materialsMarker = new OpenLayers.Layer.Markers( "Marerials" );
    map.addLayer(workshopsMarker);
    map.addLayer(materialsMarker);

    if (workshops != null) {
      var size = new OpenLayers.Size(21,25);
      var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
      workshops.forEach( function(workshop,i) {
        var icon = new OpenLayers.Icon('http://www.openlayers.org/dev/img/marker-blue.png',size,offset);
        var lonLat = new OpenLayers.LonLat(workshop.workshop.lng, workshop.workshop.lat).transform(
              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
              map.getProjectionObject() // to Spherical Mercator Projection
            );
        var marker = new OpenLayers.Marker( lonLat, icon );
        marker.events.register("mousedown", marker, function() {
          map.addPopup(workshopPopup(workshop, lonLat, marker.icon));
        });
        workshopsMarker.addMarker(marker);
      });
    }

    if (materials != null ) {

      var size = new OpenLayers.Size(16,20);
      var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
      materials.forEach( function(material,i) {
        material.locations.forEach( function(location,i) {
          var icon = new OpenLayers.Icon('http://www.openlayers.org/dev/img/marker-gold.png',size,offset);
          var lonLat = new OpenLayers.LonLat(location.longitude, location.latitude).transform(
              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
              map.getProjectionObject() // to Spherical Mercator Projection
            );
          var marker = new OpenLayers.Marker( lonLat, icon );
          marker.events.register("mousedown", marker, function() {
            map.addPopup(new OpenLayers.Popup.Anchored("mat"+material.id,lonLat,new OpenLayers.Size(90,50),material.name,icon,true,function() { this.destroy(); }));
          });
          materialsMarker.addMarker(marker);
        });
      });

    }

    map.addControl(new OpenLayers.Control.LayerSwitcher());
    map.addControl(new OpenLayers.Control.MousePosition({'prefix':'Longitude: ','separator':'<br/>Latitude: &nbsp; ','numDigits':3,"displayProjection":new OpenLayers.Projection("EPSG:4326")}));
    map.zoomToMaxExtent();
    map.zoomIn( map.getZoom() + 1 );
    //map.zoomIn(5);
}
