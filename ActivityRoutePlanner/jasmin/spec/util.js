describe("utils",function(){	
	
	beforeEach(function(){
		testInit();
	});
	
	it("Should create marker",function(){
		var mark = createMarker("tooltip",8.807311,53.075878,"/test/path");
		expect(mark).not.toBeNull();
	});
	
	it("Should add activity mark",function(){
		addActivityMark("test",53.075878,8.807311,"/test/path","testIcon");
		var marker = layerMarkers["testIcon"];
		expect(marker).not.toBeNull();
	});
	
	it("Should remove activity mark",function(){
		addActivityMark("test",53.075878,8.807311,"/test/path","testIcon");
		var marker = layerMarkers["testIcon"];
		expect(marker).not.toBeNull();
		
		removeMarker("testIcon");
		marker = layerMarkers["testIcon"];
		expect(marker).toBeUndefined();
	});
	
	it("Should add mark",function(){
		addMark("test",53.075878,8.807311,"start");
		var mark = layerMarkers["start"];
		expect(mark).not.toBeNull();
	});	
	
	it("Should update marker",function(){
		addActivityMark("test",53.075878,8.807311,"/test/path","testIcon");
		var marker = layerMarkers["testIcon"];
		expect(marker).not.toBeNull();
		
		updateMarker("test",marker,8.807000,53.075000,"testIcon");
		marker = layerMarkers["testIcon"];
		expect(marker).not.toBeNull();
		expect(marker.lonlat).toEqual("8.807000;53.075000");
	});	
	
	it("Should remove marks",function(){
		addActivityMark("test",53.075878,8.807311,"/test/path","testIcon");
		var marker = layerMarkers["testIcon"];
		expect(marker).not.toBeNull();

		removeMarks();
		
		marker = layerMarkers["testIcon"];
		expect(marker).toBeUndefined();
	});
});