var map; //complex object of type OpenLayers.Map
var zoom = 11;
var markerHash = new Array();

function loadMap(){
	// Start position for the map (hardcoded here for simplicity,
	// but maybe you want to get from URL params)
	var lat=53.075878
	var lon=8.807311
	//53.075878;8.807311
	//47.547855" lon="7.589664
	init(lat,lon,zoom);
}
function loadRoute(){
   var layer = new OpenLayers.Layer.Vector("KML", {
                projection: map.displayProjection,
                strategies: [new OpenLayers.Strategy.Fixed()],
                protocol: new OpenLayers.Protocol.HTTP({
                    url: "kmlRoute.kml",
                    format: new OpenLayers.Format.KML({
                        extractStyles: true,
                        extractAttributes: true
                    })
                })
            });
    //var lonLat = new OpenLayers.LonLat(-112.169, 36.099).transform(new OpenLayers.Projection("EPSG:4326"), map.getProjectionObject());
    //map.setCenter(lonLat);
    map.addLayer(layer);


}
function addMark(name,lat,lon,type){
        var src = type!=null && type == "start" ? "javascripts/img/marker.png":"javascripts/img/marker-blue.png";
        var layerMarkers = map.getLayer("OpenLayers.Layer.Markers_85");

        // Add the Layer with GPX Track choose the color of the Track (replace #00FF00 by the HTML code of the color you want)
        //var lgpx = new OpenLayers.Layer.GPX("MB Bruderholz", "mb_bruderholz.GPX", "blue");
        //map.addLayer(lgpx);
        var marker = markerHash[type];
        
        if(lat=="" && lon =="" && markerHash[type]!=null)
            layerMarkers.removeMarker(marker);

        
        if(marker == null){
            marker           = createMarker(name,lon,lat,src);
            markerHash[type] =  marker;
            layerMarkers.addMarker(marker);
        }
        else{
            marker = markerHash[type];
            layerMarkers.removeMarker(marker);
            updateMarker(name,marker,lon,lat,src);
            layerMarkers.addMarker(marker);
        }    
}
function removeMark(id){
    var marks = markerHash[id];
    if(marks!=null){
        for(var i =0;i<marks.length;i++){
            var mark = marks[i];
            var layerMarkers = map.getLayer("OpenLayers.Layer.Markers_85");
            layerMarkers.removeMarker(mark);
        }
    }
}
function addActivityMark(name,lat,lon,type,index,id){
    //alert("addActivityMark  "+lat+"  "+lon+"  "+type+"  "+index);
    var src = "images/icons/"+type+".png";
    var layerMarkers = map.getLayer("OpenLayers.Layer.Markers_85");


    if(markerHash[id]==null)
        markerHash[id] = new Array();


    var marker = markerHash[id][index];
    if(marker == null){
        marker           = createMarker(name,lon,lat,src);
        markerHash[id][index] =  marker;
        
        layerMarkers.addMarker(marker);
        
    }
    else{

        marker = markerHash[id][index];
        layerMarkers.removeMarker(marker);
        updateMarker(name,marker,lon,lat,src);
        layerMarkers.addMarker(marker);
    }
}
function createMarker(tooltip,lon,lat,src){
    //alert(tooltip+"  "+lon+"  "+lat+"  "+src)
    var lonLat = new OpenLayers.LonLat(lon, lat).transform(new OpenLayers.Projection("EPSG:4326"), map.getProjectionObject());
    //map.setCenter (lonLat, zoom);

    var size    = new OpenLayers.Size(21,25);
    var offset  = new OpenLayers.Pixel(-(size.w/2), -size.h+15);
    var icon    = new OpenLayers.Icon(src,size,offset);
    icon.imageDiv.firstChild.title = tooltip;
    return new OpenLayers.Marker(lonLat,icon);
}

function updateMarker(name,marker,lon,lat,src){
    var lonLat = new OpenLayers.LonLat(lon, lat).transform(new OpenLayers.Projection("EPSG:4326"), map.getProjectionObject());
    //map.setCenter (lonLat, zoom);

    var size    = new OpenLayers.Size(21,25);
    var offset  = new OpenLayers.Pixel(-(size.w/2), -size.h+15);
    var icon    = new OpenLayers.Icon(src,size,offset);
    icon.imageDiv.firstChild.title = name;
    marker.lonlat = lonLat;
    marker.icon = icon;
}

//Initialise the 'map' object
function init(lat,lon,zoom) {
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
 
	/*var size = new OpenLayers.Size(21,25);
	var offset = new OpenLayers.Pixel(-(size.w/2), -size.h+15);
	var icon = new OpenLayers.Icon('http://www.openstreetmap.org/openlayers/img/marker.png',size,offset);
	layerMarkers.addMarker(new OpenLayers.Marker(lonLat,icon));*/
}