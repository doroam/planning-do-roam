var map;        //complex object of type OpenLayers.Map
var zoom = 4;  //zoom of the map
var markerHash = null; //hashmap for markers
var route = null; //kml layer
var layerMarkers = null; //marker layer
var tmpMarkerHash = null;
var tmpMarkerIds = null;
var center = null;


function initEvents(){
    resizeMap();

}
Event.observe(window, "load", resizeMap);
Event.observe(window, "resize", resizeMap);
/**
 *  Loads the map and registers the listener
 *  for the onclick event to set points on the map
 *
 */
function loadMap(){
    markerHash = new Array();
    tmpMarkerHash = new Array();
    tmpMarkerIds = new Array();
    // Start position for the map (hardcoded here for simplicity,
    // but maybe you want to get from URL params)
    var lat=48.1102751;
    var lon=11.5170473;
    //53.075878;8.807311
    //47.547855" lon="7.589664
    init(lat,lon,zoom);
    document.oncontextmenu = function noContextMenu(e) {
        return false;
    };
    map.events.register('mousedown', map, handleMapClick);

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
    //layerTilesAtHome = new OpenLayers.Layer.OSM.Osmarender("Osmarender"); //Server was shut down
    //map.addLayer(layerTilesAtHome);
    layerCycleMap = new OpenLayers.Layer.OSM.CycleMap("CycleMap");
    map.addLayer(layerCycleMap);
    layerMarkers = new OpenLayers.Layer.Markers("Markers");
    map.addLayer(layerMarkers);

    //sets center point of the map
    center = new OpenLayers.LonLat(lon, lat).transform(new OpenLayers.Projection("EPSG:4326"), map.getProjectionObject());
    map.setCenter (center, zoom);
    map.events.register("moveend", map, onmoveend);
//map.events.register("changelayer", map, updateLocation);
}
function resetCenter(){
    map.setCenter (center, zoom);
}
/**
 *  Shows the pop up to set a point by click on the map
 *  @param evt event to get coordinates of the mouse pointer
 *
 */
function handleMapClick(evt)
{
    var rightclick;
    if (!evt)
        evt = window.event;

    if (evt.which)
        rightclick = (evt.which == 3);
    else if (evt.button)
        rightclick = (evt.button == 2);

    if(rightclick){

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
       
}

/**
 * Shows the route on the map
 * @param fileName of the kml with the route
 * @param format STRING (GPX|KML|JSON)
 */
function loadRoute(fileName, format, range){
    //Delete old route
    removeRoute();
    //creates new layer with the route
    if(format == 'GPX' ){
    	route = new OpenLayers.Layer.Vector("Route", {
	    	style: {
	                strokeColor: "#0000ff",
	                strokeWidth: 3,
	                fillOpacity: 0,
	                cursor: "pointer"
	            },
	        projection: map.displayProjection,
	        strategies: [new OpenLayers.Strategy.Fixed()],
	        protocol: new OpenLayers.Protocol.HTTP({
	            url: fileName,
	            format: new OpenLayers.Format.GPX({
	                extractStyles: false,
	                extractAttributes: false
	            })
	        })
	    });
	//adds the route layer
    map.addLayer(route);
    map.setLayerIndex(route,0);
 	}else if(format == 'JSON' ){
 		var objects = $j.getJSON(fileName, function(data){
 			var route = new OpenLayers.Layer.Vector("Route",
			     {isBaseLayer: false,
			       extractAttributes: true 
			     });
 			for (x in data.route_geometry) {
 				var mggeom = new OpenLayers.Geometry.Point(data.route_geometry[x][0],data.route_geometry[x][1]);
 				var mgfeat = new OpenLayers.Feature.Vector(mggeom);
 				route.addFeatures(mgfeat);
 			}
 			map.addLayer(route);
   			 map.setLayerIndex(route,0);
 		});
 			

 		/*
 		prot = new OpenLayers.Protocol.HTTP({
	            url: fileName,
	            format: new OpenLayers.Format.GeoJSON({
	                extractStyles: false,
	                extractAttributes: false
	            })
	       });
 		
    	route = new OpenLayers.Layer.Vector("Route", {
	    	style: {
	                strokeColor: "#0000ff",
	                strokeWidth: 3,
	                fillOpacity: 0,
	                cursor: "pointer"
	            },
	        projection: map.displayProjection,
	        strategies: [new OpenLayers.Strategy.Fixed()],
	        protocol: prot
	    });
	//adds the route layer*/
 } else if(format == 'KML'){
 	for(i=0; i<=range;i++){
 		temp = fileName.split('?');
 		file = temp[0]+i+'?'+temp[1];
 		route = new OpenLayers.Layer.Vector("Route"+i, {
	    	style: {
	                strokeColor: "#0000ff",
	                strokeWidth: 3,
	                fillOpacity: 0,
	                cursor: "pointer"
	            },
	        projection: map.displayProjection,
	        strategies: [new OpenLayers.Strategy.Fixed()],
	        protocol: new OpenLayers.Protocol.HTTP({
	            url: file,
	            format: new OpenLayers.Format.KML({
	                extractStyles: false,
	                extractAttributes: false
	            })
	        })
	    });
	    //adds the route layer
   	 	map.addLayer(route);
    	map.setLayerIndex(route,0);
	 }
 }
    //wait for the route to be displayed before
    //hiding the loading panel
    setTimeout ( "hideWall();", 1500 );

    //set route zoom
    route.events.register("loadend", route, function() {
        map.zoomToExtent(route.getDataExtent());
    });
}


function closeActivityResults(){
    removeTempMarkers();
    YAHOO.yuiObjectContainer.standardDialog.setBody("");
    YAHOO.yuiObjectContainer.standardDialog.render(document.body);
}

function onmoveend(){
    //alert('moving');
    hideSetPoint();
    reloadMarkers();
    //alert('end moving');
}

function reloadMarkers(){
    
    var elem = document.getElementById('activity_results_div');
    if(elem!=null
        && YAHOO.yuiObjectContainer.standardDialog
        && YAHOO.yuiObjectContainer.standardDialog.cfg.getProperty('visible')){
        elem.innerHTML = loading;
        var url = "/activity/search";
        var extent = getMapExtent();
        new Ajax.Request(url,{
            //onSuccess: function(o){showDialog(dialog);},
            parameters : {
                authenticity_token:_token,
                minlon:extent.left,
                minlat:extent.bottom,
                maxlon:extent.right,
                maxlat:extent.top,
                zoom:map.getZoom(),
                reload:true
            },

            evalScripts:true
        });
    }
}
function addTempMarker(id,name,lat,lon,type){
    addTempMarker(id,name,lat,lon,type,null,null,null);
}
function zoomToMarkers(){
    if(layerMarkers != null && layerMarkers.markers.length>0){
        map.zoomToExtent(layerMarkers.getDataExtent());
    }
}
function addTempMarker(id,name,lat,lon,type,icon){
    var src = "javascripts/img/marker-green.png";
    if(icon!=null && icon!=""){
        src = icon;
    }

    var marker = createMarker(name,lon,lat,src);
    marker.events.register("mousedown", marker, function(e){
        showSetTempMenu(name,lat,lon,type,e,icon);
    });    
    tmpMarkerHash[id] = marker;
    tmpMarkerIds.push(id);
    layerMarkers.addMarker(marker);
    
}
function highMarker(id){
    var marker = tmpMarkerHash[id];
    if(marker!=null){
        marker.icon.size.w += 13;
        marker.icon.size.h += 13;
        marker.draw();
    }
}
function downMarker(id){
    var marker = tmpMarkerHash[id];
    if(marker!=null){
        marker.icon.size.w -= 13;
        marker.icon.size.h -= 13;
        marker.draw();
    }
}

function removeTempMarkers(){
    var id = tmpMarkerIds.pop();        
    if(id!=null){
        var elem = tmpMarkerHash[id];
        layerMarkers.removeMarker(elem);
        tmpMarkerHash[id] = null;
        removeTempMarkers();
    }
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
        marker.events.register("mousedown", marker, function(e){
            showActivityInfo(id,e);
        });
        markerHash[id]   =  marker;
        layerMarkers.addMarker(marker);        
    }
    else{
        //update the marker
        layerMarkers.removeMarker(marker);        
        updateMarker(name,marker,lon,lat,imagePath);
        marker.events.register("mousedown", marker, function(e){
            showActivityInfo(id,e);
        });
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
    icon.imageDiv.firstChild.title = tooltip;
    var marker = new OpenLayers.Marker(lonLat,icon);
    

    return marker;
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
 * remove all markers and the route excepting the start and end marker
 *
 */
function removeMarks(){
    layerMarkers.clearMarkers();
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
/**
 * Initializes the objects for the tests
 */
function testInit(){
    markerHash = new Array();
	
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
    layerMarkers = new OpenLayers.Layer.Markers("Markers");
    map.addLayer(layerMarkers);
}

function readyToCreateRoute(){
	//if start and endpoint are set
	if((document.getElementById("start_query").value != "") && (document.getElementById("end_query").value != "")){
		document.getElementById("calculate_route").disabled = false;
	} else {
		document.getElementById("calculate_route").disabled = true;
	}
}

function algoContent(){
	if($j("#setAlgorithmus").val() == "energy") {
		$j("#energy_form").slideDown();
	} else {
		$j("#energy_form").slideUp();
	}
}
		
function toggleStructured(){
	$j(".structured").slideToggle();
}
