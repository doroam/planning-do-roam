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

function showSetTempMenu(name,lat,lon,type,event){
    var mouseXY = YAHOO.util.Event.getXY(event);
    var mX = mouseXY[0];
    var mY = mouseXY[1];

    if(YAHOO.yuiObjectContainer.pointMenu){
        YAHOO.yuiObjectContainer.pointMenu.destroy();
    }
    // Build overlay2 dynamically, at mouse position
    YAHOO.yuiObjectContainer.pointMenu = new YAHOO.widget.Dialog("setPoint", {
        xy:[mX,mY],
        visible:false,
        close:true,
        width:"200px",
        height:"85px"
    } );


    //set body
    YAHOO.yuiObjectContainer.pointMenu.setBody("<div id=\"set_point_id\" class=\"setPoint\"></div>");

    //render popup
    YAHOO.yuiObjectContainer.pointMenu.render(document.body);
    YAHOO.yuiObjectContainer.pointMenu.show();
    var params = new Array();
    params[0]  = ["url","content_loader/tmp_marker_tooltip"];
    params[1]  = ["lat",lat+""];
    params[2]  = ['lon',lon+""];
    params[3]  = ['name',name];
    params[4]  = ['type',type];
    var url = buildUrl("/load_content", params);
    loadContent(url,"set_point_id");

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


    if(YAHOO.yuiObjectContainer.pointMenu){
        YAHOO.yuiObjectContainer.pointMenu.destroy();
    }
    // Build overlay2 dynamically, at mouse position
    YAHOO.yuiObjectContainer.pointMenu = new YAHOO.widget.Dialog("setPoint", {
        xy:[mX,mY],
        visible:false,
        close:true,
        width:"200px",
        height:"85px"
    } );


    //set body
    YAHOO.yuiObjectContainer.pointMenu.setBody("<div id=\"set_point_id\" class=\"setPoint\"></div>");

    //render popup
    YAHOO.yuiObjectContainer.pointMenu.render(document.body);
    YAHOO.yuiObjectContainer.pointMenu.show();
    var params = new Array();
    params[0]  = ["url","content_loader/point_tooltip"];
    params[1]  = ["lat",latLon.lat+""];
    params[2]  = ['lon',latLon.lon+""];
    var url = buildUrl("/load_content", params);
    loadContent(url,"set_point_id");
    
}
/**
 * hides the set point popup
 */
function hideSetPoint(){
    if(YAHOO.yuiObjectContainer.pointMenu){
        YAHOO.yuiObjectContainer.pointMenu.hide();
    }
}

function loadContent(url,div_id){
    new Ajax.Updater(div_id, url,{
        parameters : "authenticity_token="+_token,
        evalScripts:true
    });
}
function buildUrl(url,params){
    var result = url+"?";
    for (var i=0;i<params.length;i++)
    {
        var and = "&";
        if(i==params.length-1)
            and = "";

        result += params[i][0]+"="+encodeURIComponent(params[i][1])+and;
    }
    return result;
}

function makeDialog(id,beforeHide){

    if(YAHOO.yuiObjectContainer.standardDialog){
        YAHOO.yuiObjectContainer.standardDialog.destroy();
    }
    // Build overlay2 dynamically, at mouse position
    YAHOO.yuiObjectContainer.standardDialog = new YAHOO.widget.Dialog(id, {
        center : true,
        visible:false,
        close:true,
        scrollable: true,
        zindex:100,
        width:"260px"
    } );
        
    
    YAHOO.yuiObjectContainer.standardDialog.setBody("<div id=\""+id+"_div\" class=\"dialog\"></div>");

    if(beforeHide!=null)
        YAHOO.yuiObjectContainer.standardDialog.subscribe( "beforeHide", beforeHide);

    //render popup
    YAHOO.yuiObjectContainer.standardDialog.render(document.body);


    

    return YAHOO.yuiObjectContainer.standardDialog;
}

function hideDialog(){
    if(YAHOO.yuiObjectContainer.standardDialog)
        YAHOO.yuiObjectContainer.standardDialog.hide();
}

function showOntology(){
    var id = "ontology";
    if(YAHOO.yuiObjectContainer.ontology){
        YAHOO.yuiObjectContainer.ontology.destroy();
    }
    // Build overlay2 dynamically, at mouse position
    YAHOO.yuiObjectContainer.ontology = new YAHOO.widget.Dialog(id, {
        center : true,
        visible:false,
        fixedcenter:true,
        close:true,
        scrollable: true,
        zindex:100,
        modal: true,
        width:"500px",
        height:"600px"
    } );


    YAHOO.yuiObjectContainer.ontology.setBody("<div id=\""+id+"_div\" class=\"setPoint\"></div>");
    //render popup
    YAHOO.yuiObjectContainer.ontology.render(document.body);


    var params = new Array();
    params[0]  = ["url","ontology/content"];
    var url = buildUrl("/load_content", params);
    loadContent(url,"ontology_div");
    YAHOO.yuiObjectContainer.ontology.show();
}