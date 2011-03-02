/**
 * Yui Objekt Sammlung wird angeleft
 */
YAHOO.namespace("yuiObjectContainer");

/**
 * Funktion zum Initialisieren und Anzeigen des Lade Bildschirm
 */
function initLoadingPanel() {
    if (!YAHOO.yuiObjectContainer.loading) {
        YAHOO.yuiObjectContainer.loading = new YAHOO.widget.Panel("loadingPanel", {
            width: "134px",
            height: "134px",
            fixedcenter: true,
            underlay: "none",
            close: false,
            draggable: false,
            scrollable: false,
            zindex: 99,
            modal: true,
            visible: false
        });
        YAHOO.yuiObjectContainer.loading.setBody("<img src=\"javascripts/img/loadingAnimation.gif\"/>");

		YAHOO.yuiObjectContainer.loading.render(document.body);
    }
    YAHOO.yuiObjectContainer.loading.show();
}

function showWall(){
    if (!YAHOO.yuiObjectContainer.loading) {
		initLoadingPanel();
	}
    YAHOO.yuiObjectContainer.loading.show();
}
function hideWall(){
    if (YAHOO.yuiObjectContainer.loading) {
		YAHOO.yuiObjectContainer.loading.hide();
	}
}

function showSetPointMenu(latLon,e){
    var mouseXY = YAHOO.util.Event.getXY(e);
    var mX = mouseXY[0];
    var mY = mouseXY[1];

    // Build overlay2 dynamically, initially hidden, at position x:400,y:500, and 300px wide
    YAHOO.yuiObjectContainer.pointMenu = new YAHOO.widget.Dialog("setPoint", { xy:[mX,mY],
                                                                           visible:false,
                                                                           close:true,
                                                                           width:"200px",
                                                                            height:"60px"} );

    var coordinates = escape(latLon.lat+";"+latLon.lon);
    var linkStart = "<a onclick=\"hideSetPoint();showWall();\" href=\"/updateRoute?start="+coordinates+"\" data-remote=\"true\">Set start point</a>";
    var linkEnd = "<a onclick=\"hideSetPoint();showWall();\" href=\"/updateRoute?end="+coordinates+"\" data-remote=\"true\">Set end point</a>";
    YAHOO.yuiObjectContainer.pointMenu.setBody("<div class=\"setPoint\"><b>Coordinates:</b><br/> <b>Latitude:</b> "+latLon.lat+"<br /><b>Longitude:</b>"+latLon.lon+" <br/>"+linkStart+" &nbsp "+linkEnd+"</div>");
    YAHOO.yuiObjectContainer.pointMenu.render(document.body);
    YAHOO.yuiObjectContainer.pointMenu.show();
}

function hideSetPoint(){
    if(YAHOO.yuiObjectContainer.pointMenu){
        YAHOO.yuiObjectContainer.pointMenu.hide();
    }
}