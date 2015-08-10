function OnOpenButtonPressed() {
	var MainGristUI=$("#MainGristUI")
	$.Msg('Clicked')
	MainGristUI.visible=!MainGristUI.visible
}

function UpdateGristGutter( gristGutterStuff ) {
	var gristGutterArray=Object.keys(gristGutterStuff)
	var gristToDisplay=gristGutterStuff[gristGutterArray[gristGutterArray.length-1]] //until Valve gets around to canvas
	if (gristToDisplay) {
		var gristString="Currently holding onto " + gristToDisplay.amount + " " + gristToDisplay.name + " grist"
		$("#GristGutterDisplay").text=gristString
	} else {
		$("#GristGutterDisplay").text="GristGutter is empty!"
	}
}

function UpdateGristCache( gristCacheStuff ) {
	var MainGristUI=$("#MainGristUI")
	for (grist_name in gristCacheStuff) {
		if (grist_name!="maximum") {
			var grist_panel=$('#'+grist_name+'_panel') ? $('#'+grist_name+'_panel') : $.CreatePanel('Label',MainGristUI,grist_name+'_panel')
			grist_panel.text=grist_name+": "+gristCacheStuff[grist_name]+"/"+gristCacheStuff['maximum']
			grist_panel.AddClass('GristInfo')
		}
	}
}

(function () {
  GameEvents.Subscribe( "grist_gutter_changed", UpdateGristGutter );
  GameEvents.Subscribe( "grist_cache_changed", UpdateGristCache );
})();