/**
 * YUI object
 */
YAHOO.namespace("yuiObjectContainer");

/**
 * Initialize the loading panel
 */
function initLoadingPanel() {
    if (!YAHOO.yuiObjectContainer.loading) {
        //create a new loading panel
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
        //set gif animation
        YAHOO.yuiObjectContainer.loading.setBody("<img src=\"javascripts/img/loadingAnimation.gif\"/>");

        //render to html body
        YAHOO.yuiObjectContainer.loading.render(document.body);
    }
    //display
    YAHOO.yuiObjectContainer.loading.show();
}

/**
 * displays the wall
 */
function showWall(){
    if (!YAHOO.yuiObjectContainer.loading) {
		initLoadingPanel();
	}
    YAHOO.yuiObjectContainer.loading.show();
}
/**
 * hides the wall
 */
function hideWall(){
    if (YAHOO.yuiObjectContainer.loading) {
		YAHOO.yuiObjectContainer.loading.hide();
	}
}

/**
 * Displays the popup to set the points by click
 *
 * @param latlon position object
 * @param e event
 *
 */
function showSetPointMenu(latLon,e){
    //get mouse coordinates
    var mouseXY = YAHOO.util.Event.getXY(e);
    var mX = mouseXY[0];
    var mY = mouseXY[1];

    // Build overlay2 dynamically, at mouse position
    YAHOO.yuiObjectContainer.pointMenu = new YAHOO.widget.Dialog("setPoint", { xy:[mX,mY],
                                                                           visible:false,
                                                                           close:true,
                                                                           width:"200px",
                                                                            height:"85px"} );


    //coordinates of point
    var coordinates = escape(latLon.lat+";"+latLon.lon);
    //set start point link
    var linkStart   = "<a onclick=\"hideSetPoint();showWall();\" href=\"/updateRoute?start="+coordinates+"\" data-remote=\"true\">Set start point</a>";
    //set end point link
    var linkEnd     = "<a onclick=\"hideSetPoint();showWall();\" href=\"/updateRoute?end="+coordinates+"\" data-remote=\"true\">Set end point</a>";
    //set body
    YAHOO.yuiObjectContainer.pointMenu.setBody("<div class=\"setPoint\"><b>Coordinates:</b><br/> <b>Latitude:</b> "+latLon.lat+"<br /><b>Longitude:</b> "+latLon.lon+" <br/>"+linkStart+" &nbsp "+linkEnd+"</div>");
    //render popup
    YAHOO.yuiObjectContainer.pointMenu.render(document.body);
    YAHOO.yuiObjectContainer.pointMenu.show();
}
/**
 * hides the set point popup
 */
function hideSetPoint(){
    if(YAHOO.yuiObjectContainer.pointMenu){
        YAHOO.yuiObjectContainer.pointMenu.hide();
    }
}