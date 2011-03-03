var map; //complex object of type OpenLayers.Map
var zoom = 12;
var markerHash = null;
var route = null;
var layerMarkers = null;
function loadMap(){
    markerHash = new Array();
	// Start position for the map (hardcoded here for simplicity,
	// but maybe you want to get from URL params)
	var lat=53.075878
	var lon=8.807311
	//53.075878;8.807311
	//47.547855" lon="7.589664
	init(lat,lon,zoom);
        map.events.register('click', map, handleMapClick);

}
function encode( s ){
    return unescape( encodeURIComponent( s ) )
    ;
}
function decode( s ){
    return decodeURIComponent( escape( s ) );
}


function handleMapClick(evt)
{
       var lonlat = map.getLonLatFromViewPortPx(evt.xy);
       
       var proj1 = new OpenLayers.Projection("EPSG:4326");
       var proj2 = new OpenLayers.Projection("EPSG:900913");
       var trans = lonlat.transform(proj2,proj1);
       showSetPointMenu(trans,evt);
       
}


function loadRoute(fileName){

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
    
    setTimeout ( "hideWall();", 1500 );

}
function addMark(name,lat,lon,type){
        //alert(name+"   "+lat+"  "+lon+"  "+type);
        var src ="javascripts/img/marker-gold.png";
        if(type == "start")
            src = "javascripts/img/marker.png";
        else if(type == "end")
            src = "javascripts/img/marker-blue.png";

        var marker = markerHash[type];
        
        if(lat=="" && lon =="" && markerHash[type]!=null){

            layerMarkers.removeMarker(marker);
            //markerHash[type] = null;
            marker = null
        }

        
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
    //alert(id);
    var marker = markerHash[id];
    if(marker!=null){
            layerMarkers.removeMarker(marker);
            marker = null;
    }
}
function addActivityMark(name,lat,lon,imagePath,id){
    //alert("addActivityMark  "+lat+"  "+lon+"  "+imagePath+"  "+id);

    var marker = markerHash[id];
    
    if(marker == null){
        marker           = createMarker(name,lon,lat,imagePath);
        markerHash[id]   =  marker;
        layerMarkers.addMarker(marker);
        
    }
    else{
        
        layerMarkers.removeMarker(marker);
        
        updateMarker(name,marker,lon,lat,imagePath);
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
    icon.imageDiv.firstChild.title = decodeURIComponent(tooltip);
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

	var lonLat = new OpenLayers.LonLat(lon, lat).transform(new OpenLayers.Projection("EPSG:4326"), map.getProjectionObject());
	map.setCenter (lonLat, zoom);

}
function removeMarks(){
    layerMarkers.clearMarkers();
    if (markerHash["start"]!=null)
        layerMarkers.addMarker(markerHash["start"]);
    if(markerHash["end"]!=null)
        layerMarkers.addMarker(markerHash["end"]);
    removeRoute();
}
function removeRoute(){
    
    //remove vertices
    var vertice = markerHash["nearest_src"]
    if(vertice!=null){
        layerMarkers.removeMarker(vertice);
        vertice = null
    }
    var vertice_t = markerHash["nearest_target"]
    if(vertice_t!=null){
        layerMarkers.removeMarker(vertice_t);
        vertice_t = null;
    }

    if(route!=null){
        map.removeLayer(route);
        route = null;
    }
}