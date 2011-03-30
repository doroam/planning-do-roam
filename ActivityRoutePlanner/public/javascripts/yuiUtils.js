/**
 * YUI object
 */
YAHOO.namespace("yuiObjectContainer");
var loading = "<img src=\"javascripts/img/loadingAnimation.gif\"/>";
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
        YAHOO.yuiObjectContainer.loading.setBody(loading);

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

function showSetTempMenu(name,lat,lon,type,e,tag,value){
    showCursorPopUp("content_loader/tmp_marker_tooltip",lat,lon,name,e,type,tag,value);
}

/**
 * Displays the popup to set the points by click
 *
 * @param latLon position object
 * @param e event
 *
 */
function showSetPointMenu(latLon,e){
    showCursorPopUp("content_loader/point_tooltip",latLon.lat,latLon.lon,null,e,null,null,null);
}

function showCursorPopUp(url,lat,lon,name,e,type,tag,value){
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
        close:true
    } );


    //set body
    YAHOO.yuiObjectContainer.pointMenu.setBody("<div id=\"set_point_id\" class=\"setPoint\"></div>");

    //render popup
    YAHOO.yuiObjectContainer.pointMenu.render(document.body);
    //YAHOO.yuiObjectContainer.pointMenu.show();
    var params = new Array();
    params[0]  = ["url",url];
    params[1]  = ["lat",lat+""];
    params[2]  = ['lon',lon+""];
    var i = 3;
    if(name!=null){
        params[i]  = ['name',name];
        i++;
    }
    if(type!=null){
        params[i]  = ['type',type];
        i++;
    }
    if(tag!=null){
        params[i]  = ['tag',tag];
        i++
    }
    if(value!=null){
        params[i]  = ['value',value];
        i++;
    }
    //alert("params"+params);
    var url_ = buildUrl("/load_content", params);
    loadContent(url_,"set_point_id",YAHOO.yuiObjectContainer.pointMenu);
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
    loadContent(url,div_id,null);
}
function loadContent(url,div_id,dialog){
    new Ajax.Updater(div_id, url,{
        onSuccess: function(o){showDialog(dialog);},
        parameters : "authenticity_token="+encodeURIComponent(_token),
        evalScripts:true
    });
}
function showDialog(dialog){
    if(dialog!=null)
        dialog.show();
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
    //alert("result="+result);
    return result;
}

function makeDialog(id,beforeHide){
    if(YAHOO.yuiObjectContainer.standardDialog!=null){
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
            
    YAHOO.yuiObjectContainer.standardDialog.setBody("<div id=\""+id+"_div\" class=\"dialog\">"+loading+"</div>");

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
        width:"550px",
        height:"500px"
    } );

    

    YAHOO.yuiObjectContainer.ontology.setBody("<div id=\""+id+"_div\" class=\"setPoint\">"+loading+"</div>");
    //render popup
    YAHOO.yuiObjectContainer.ontology.render(document.body);

    var params = new Array();
    params[0]  = ["url","ontology/content"];
    var url = buildUrl("/load_content", params);
    loadContent(url,"ontology_div");
    YAHOO.yuiObjectContainer.ontology.show();
}
function hideOntology(){
    if(YAHOO.yuiObjectContainer.ontology)
        YAHOO.yuiObjectContainer.ontology.hide();
}

function reloadRouteFields(){
    showWall();
    removeTempMarkers();
    var params = new Array();
    params[0]  = ["url","init/menu"];
    var url = buildUrl("/load_content", params);
    loadContent(url,"route_id");
}