var map; //complex object of type OpenLayers.Map
var zoom = 12;
var markerHash = new Array();
var route = null;
function loadMap(){
	// Start position for the map (hardcoded here for simplicity,
	// but maybe you want to get from URL params)
	var lat=53.075878
	var lon=8.807311
	//53.075878;8.807311
	//47.547855" lon="7.589664
	init(lat,lon,zoom);
        map.events.register('click', map, handleMapClick);

}


function handleMapClick(evt)
{
       var lonlat = map.getLonLatFromViewPortPx(evt.xy);
       
       var proj1 = new OpenLayers.Projection("EPSG:4326");
       var proj2 = new OpenLayers.Projection("EPSG:900913");
       var trans = lonlat.transform(proj2,proj1);
       showSetPointMenu(trans,evt);
       
}


function loadRoute(fileName,start_lat,start_lon,end_lat,end_lon){
    //Delete old route
    removeRoute();

    /* Nice try to calculate zoom
     *var bounds = new OpenLayers.Bounds();
    bounds.extend(new OpenLayers.LonLat(end_lon,end_lat));
    bounds.extend(new OpenLayers.LonLat(start_lon,start_lat));
    bounds.toBBOX();
    alert(bounds);*/
    route = new OpenLayers.Layer.Vector("KML", {
                projection: map.displayProjection,
                strategies: [new OpenLayers.Strategy.Fixed()],
                protocol: new OpenLayers.Protocol.HTTP({
                    url: fileName,
                    format: new OpenLayers.Format.KML({
                        extractStyles: true,
                        extractAttributes: true
                    })
                })
            });
    //var lonLat = new OpenLayers.LonLat(-112.169, 36.099).transform(new OpenLayers.Projection("EPSG:4326"), map.getProjectionObject());
    //map.setCenter(lonLat);
    //map.zoomTo(map.getZoomForExtent(bounds)-2);
    map.addLayer(route);
    
    hideWall();
}
function addMark(name,lat,lon,type){
        var src ="javascripts/img/marker-gold.png";
        if(type == "start")
            src = "javascripts/img/marker.png";
        else if(type == "end")
            src = "javascripts/img/marker-blue.png";

        var layerMarkers = map.getLayer("OpenLayers.Layer.Markers_85");

        // Add the Layer with GPX Track choose the color of the Track (replace #00FF00 by the HTML code of the color you want)
        //var lgpx = new OpenLayers.Layer.GPX("MB Bruderholz", "mb_bruderholz.GPX", "blue");
        //map.addLayer(lgpx);
        var marker = markerHash[type];
        
        if(lat=="" && lon =="" && markerHash[type]!=null)
            layerMarkers.removeMarker(marker);

        
        if(marker == null){
            marker           = createMarker(type+"-"+name,lon,lat,src);
            markerHash[type] =  marker;
            layerMarkers.addMarker(marker);
        }
        else{
            marker = markerHash[type];
            layerMarkers.removeMarker(marker);
            updateMarker(type+"-"+name,marker,lon,lat,src);
            layerMarkers.addMarker(marker);
        }    
}
function removeMarker(id){
    var marks = markerHash[id];
    if(marks!=null){
        for(var i =0;i<marks.length;i++){
            var mark = marks[i];
            mark.erase();
        }
    }
}
function addActivityMark(name,lat,lon,imagePath,index,id){
    //alert("addActivityMark  "+lat+"  "+lon+"  "+type+"  "+index);
    var layerMarkers = map.getLayer("OpenLayers.Layer.Markers_85");


    if(markerHash[id]==null)
        markerHash[id] = new Array();


    var marker = markerHash[id][index];
    if(marker == null){
        marker           = createMarker(name,lon,lat,imagePath);
        markerHash[id][index] =  marker;
        
        layerMarkers.addMarker(marker);
        
    }
    else{
        marker = markerHash[id][index];
        //layerMarkers.removeMarker(marker);
        updateMarker(name,marker,lon,lat,imagePath);
        //layerMarkers.addMarker(marker);
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
    marker.lonlat   = lonLat;
    marker.icon     = icon;
    marker.draw();
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

function removeMarks(){
    //remove activity markers
    for(var i=0;i<markerHash.length;i++){
        var marker = markerHash[i];
        if(marker instanceof Array){
            for(var j=0;j<marker.length;j++){
                var subMarker = marker[j];
                subMarker.erase();
            }
        }
    }
    //remove vertices
    var vertice = markerHash["nearest_src"]
    if(vertice!=null)
        vertice.erase();

    vertice = markerHash["nearest_target"]
    if(vertice!=null)
        vertice.erase();

    removeRoute();
}
function removeRoute(){
    if(route!=null)
        map.removeLayer(route);
}