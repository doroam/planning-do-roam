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

function getMapExtent(){

   return map.getExtent().clone().transform(map.getProjectionObject(), projection);
}
function setBBox(){
    var extent = getMapExtent();

    $("minlon").value = extent.left;
    $("minlat").value = extent.bottom;
    $("maxlon").value = extent.right;
    $("maxlat").value = extent.top;
}