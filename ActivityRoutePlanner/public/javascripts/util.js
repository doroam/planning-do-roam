var map;        //complex object of type OpenLayers.Map
var zoom = 12;  //zoom of the map
var markerHash = null; //hashmap for markers
var route = null; //kml layer
var layerMarkers = null; //marker layer

/**
 *  Loads the map and registers the listener
 *  for the onclick event to set points on the map
 *
 */
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

/**
 *  Shows the pop up to set a point by click on the map
 *  @param evt event to get coordinates of the mouse pointer
 *
 */
function handleMapClick(evt)
{
    //calculates the longitude and latitude from the position 
    //of the pointer
    var lonlat = map.getLonLatFromViewPortPx(evt.xy);

    //transform coordinates to srid
    var proj1 = new OpenLayers.Projection("EPSG:4326");
    var proj2 = new OpenLayers.Projection("EPSG:900913");
    var trans = lonlat.transform(proj2,proj1);

    //show popup. see yuiUtils.js
    showSetPointMenu(trans,evt);
       
}

/**
 * Shows the route on the map
 * @param fileName of the kml with the route
 *
 */
function loadRoute(fileName){

    //Delete old route
    removeRoute();

    /* Nice try to calculate zoom
     *var bounds = new OpenLayers.Bounds();
    bounds.extend(new OpenLayers.LonLat(end_lon,end_lat));
    bounds.extend(new OpenLayers.LonLat(start_lon,start_lat));
    bounds.toBBOX();
    alert(bounds);*/
    //creates new layer with the route
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

    //adds the route layer
    map.addLayer(route);

    //wait for the route to be displayed before
    //hiding the loading panel
    setTimeout ( "hideWall();", 1500 );

}

/**
 * Adds a start or end mark
 * @param name label of the point
 * @param lat latitude
 * @param lon longitude
 * @param type start or end
 *
 */
function addMark(name,lat,lon,type){
        //alert(name+"   "+lat+"  "+lon+"  "+type);
        //gets the icon of the marker
        var src ="javascripts/img/marker-gold.png";
        if(type == "start")
            src = "javascripts/img/marker.png";
        else if(type == "end")
            src = "javascripts/img/marker-blue.png";

        //gets the marker if one has been already created
        var marker = markerHash[type];

        //if there is no marker and there are no coordinates
        //the marker will be removed
        if(lat=="" && lon =="" && markerHash[type]!=null){

            layerMarkers.removeMarker(marker);
            //markerHash[type] = null;
            marker = null
        }

        //if there is no marker
        if(marker == null){
            //create a new one and set it to the layer
            marker           = createMarker(type+"-"+name,lon,lat,src);
            markerHash[type] =  marker;
            layerMarkers.addMarker(marker);
        }
        else{
            //update marker
            marker = markerHash[type];
            layerMarkers.removeMarker(marker);
            updateMarker(type+"-"+name,marker,lon,lat,src);
            layerMarkers.addMarker(marker);
        }    
}
/**
 * Removes a marker with the entered id
 *
 * @param id id of the marker
 */
function removeMarker(id){
    //alert(id);
    var marker = markerHash[id];
    if(marker!=null){
            layerMarkers.removeMarker(marker);
            marker = null;
    }
}
/**
 * Creates an activity marker
 * @param name label
 * @param lat latitude
 * @param lon longitude
 * @param imagePath path to the icon
 * @param id id of the marker: icon name
 *
 */
function addActivityMark(name,lat,lon,imagePath,id){
    //alert("addActivityMark  "+lat+"  "+lon+"  "+imagePath+"  "+id);

    var marker = markerHash[id];

    //if there is no marker
    if(marker == null){
        //create a marker
        marker           = createMarker(name,lon,lat,imagePath);
        markerHash[id]   =  marker;
        layerMarkers.addMarker(marker);        
    }
    else{
        //update the marker
        layerMarkers.removeMarker(marker);        
        updateMarker(name,marker,lon,lat,imagePath);
        layerMarkers.addMarker(marker);
    }    
}
/**
 * Creates a marker
 * @param tooltip tooltip
 * @param lon longitude
 * @param lat latitude
 * @param src icon file path
 *
 */
function createMarker(tooltip,lon,lat,src){
    //alert(tooltip+"  "+lon+"  "+lat+"  "+src)
    //get new position object
    var lonLat = new OpenLayers.LonLat(lon, lat).transform(new OpenLayers.Projection("EPSG:4326"), map.getProjectionObject());
    //map.setCenter (lonLat, zoom);

    //get new icon
    var size    = new OpenLayers.Size(21,25);
    var offset  = new OpenLayers.Pixel(-(size.w/2), -size.h+15);
    var icon    = new OpenLayers.Icon(src,size,offset);

    //set tooltip: workaround: no tooltips from openlayers supported
    icon.imageDiv.firstChild.title = decodeURIComponent(tooltip);
    //return maker
    return new OpenLayers.Marker(lonLat,icon);
}

/**
 * Updates a marker
 * @param name label
 * @param marker marker
 * @param lon longitude
 * @param lat latitude
 * @param src icon path
 *
 */
function updateMarker(name,marker,lon,lat,src){
    //new position
    var lonLat = new OpenLayers.LonLat(lon, lat).transform(new OpenLayers.Projection("EPSG:4326"), map.getProjectionObject());
    //map.setCenter (lonLat, zoom);
    //new icon
    var size    = new OpenLayers.Size(21,25);
    var offset  = new OpenLayers.Pixel(-(size.w/2), -size.h+15);
    var icon    = new OpenLayers.Icon(src,size,offset);
    //set tooltip
    icon.imageDiv.firstChild.title = name;
    //update position and icon
    marker.lonlat   = lonLat;
    marker.icon     = icon;    
}

/**
 * Initialize the map object and set the middle to the entered parameters
 * with the entered zoom
 * @param lat latitude
 * @param lon longitude
 * @param zoom zoom
 *
 */
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

        //sets center point of the map
	var lonLat = new OpenLayers.LonLat(lon, lat).transform(new OpenLayers.Projection("EPSG:4326"), map.getProjectionObject());
	map.setCenter (lonLat, zoom);

}
/**
 * remove all markers and the route excepting the start and end marker
 *
 */
function removeMarks(){
    layerMarkers.clearMarkers();
    if (markerHash["start"]!=null)
        layerMarkers.addMarker(markerHash["start"]);
    if(markerHash["end"]!=null)
        layerMarkers.addMarker(markerHash["end"]);
    removeRoute();
}
/**
 * Removes the route layer
 *
 */
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

    //remove the route layer if there is one
    if(route!=null){
        map.removeLayer(route);
        route = null;
    }
}