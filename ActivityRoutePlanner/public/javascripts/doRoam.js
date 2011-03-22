/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var projection = new OpenLayers.Projection("EPSG:4326");
function resizeMap(){    
    var content = $("map");
    content.style.width = (document.documentElement.clientWidth - content.offsetLeft-5)+"px";
    content.style.height = (document.documentElement.clientHeight - content.offsetTop-5)+"px";
}

function setMapExtent(extent) {
   map.zoomToExtent(extent.clone().transform(projection, map.getProjectionObject()));
}
function setZoom(minlon,minlat,maxlon,maxlat){
    var bounds = new OpenLayers.Bounds(minlon,minlat,maxlon,maxlat);
    bounds.transform(projection,map.getProjectionObject());
    return map.zoomToExtent(bounds);
}

function getMapExtent(){
   return map.getExtent().clone().transform(map.getProjectionObject(), projection);
}
function setBBox(form_id){
    var form = document.getElementById(form_id);
    var extent = getMapExtent();
    form.minlon.value = extent.left;
    form.minlat.value = extent.bottom;
    form.maxlon.value = extent.right;
    form.maxlat.value = extent.top;
}
