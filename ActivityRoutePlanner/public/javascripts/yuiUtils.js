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