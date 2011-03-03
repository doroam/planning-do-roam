describe("utils",function(){	
	var map;
	var zoom;
	var markerHash;
	var route;
	var layerMarkers;
	var imagePath;
	var lat;
	var lon;
	var name;
	var type;
	
	beforeEach(function(){
		zoom = 12;
		markerHash = new Array();
		route = null;
		imagePath = "/images/test.png";
		lat = 53.07484672;
		lon = 8.77778524;
		name = "Test";
		type = "start"
		
		
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
		});
		layerMarkers = new OpenLayers.Layer.Markers("Markers");
		map.addLayer(layerMarkers);		
	});
	
	it("Should add mark",function(){
		addMark(name,lat,lon,type);
		expect(sss);
	});
});