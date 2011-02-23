var map; //complex object of type OpenLayers.Map
function loadMap(){
	// Start position for the map (hardcoded here for simplicity,
	// but maybe you want to get from URL params)
	var lat=47.496792
	var lon=7.571726
	var zoom=12
	//47.547855" lon="7.589664
	init(lat,lon,zoom,map);
}
		
 
//Initialise the 'map' object
function init(lat,lon,zoom,map) {
	map = new OpenLayers.Map ("map", {
			controls:[
				new OpenLayers.Control.Navigation(),
				new OpenLayers.Control.PanZoomBar(),
				new OpenLayers.Control.LayerSwitcher(),
				new OpenLayers.Control.Attribution()],
			maxExtent: new OpenLayers.Bounds(-20037508.34,-20037508.34,20037508.34,20037508.34),
			maxResolution: 156543.0399,
			numZoomLevels: 19,
			units: 'm',
			projection: new OpenLayers.Projection("EPSG:900913"),
			displayProjection: new OpenLayers.Projection("EPSG:4326")
			} );
 
	// Define the map layer
	// Note that we use a predefined layer that will be
	// kept up to date with URL changes
	// Here we define just one layer, but providing a choice
	// of several layers is also quite simple
	// Other defined layers are OpenLayers.Layer.OSM.Mapnik, OpenLayers.Layer.OSM.Maplint and OpenLayers.Layer.OSM.CycleMap
	layerMapnik = new OpenLayers.Layer.OSM.Mapnik("Mapnik");
	map.addLayer(layerMapnik);
	layerTilesAtHome = new OpenLayers.Layer.OSM.Osmarender("Osmarender");
	map.addLayer(layerTilesAtHome);
	layerCycleMap = new OpenLayers.Layer.OSM.CycleMap("CycleMap");
	map.addLayer(layerCycleMap);
	layerMarkers = new OpenLayers.Layer.Markers("Markers");
	map.addLayer(layerMarkers);
 
	// Add the Layer with GPX Track choose the color of the Track (replace #00FF00 by the HTML code of the color you want)
	//var lgpx = new OpenLayers.Layer.GPX("MB Bruderholz", "mb_bruderholz.GPX", "blue");
	//map.addLayer(lgpx);
 
	var lonLat = new OpenLayers.LonLat(lon, lat).transform(new OpenLayers.Projection("EPSG:4326"), map.getProjectionObject());
	map.setCenter (lonLat, zoom);
 
	var size = new OpenLayers.Size(21,25);
	var offset = new OpenLayers.Pixel(-(size.w/2), -size.h+15);
	var icon = new OpenLayers.Icon('http://www.openstreetmap.org/openlayers/img/marker.png',size,offset);
	layerMarkers.addMarker(new OpenLayers.Marker(lonLat,icon));
}