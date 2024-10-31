var strobeMediaPlayback = function () {
	/*var settings = {
		"tablet": {
			"startSize": {"width":480, "height":275}
		},
		"smartphone": {
			"startSize": {"width":120, "height":67}
		},
		"default": {
			"startSize": {"width":480, "height":275}
		}
	};*/
	
	//var flashvars = {};
	
	function getSettingByDeviceType(settings, setting, deviceType, defaultValue) {
		if (deviceType in settings) {
			return (settings[deviceType][setting] ? settings[deviceType][setting] : defaultValue);
		}
		else {
			return (settings["default"][setting] ? settings["default"][setting] : defaultValue);
		}
	}
	
	
	return { 
		/*settings: function(object) {
			settings = $.extend(true, settings, object);
		},
		flashvars: function(object) {
			flashvars = $.extend(true, flashvars, object);
		},*/
		draw: function(element, options, flashvars) {
			if (element && flashvars ) {
				var agent = window.location.hash.replace(/^#/, "");
				var settings = $.extend(true, settings, options);
				//function onDeviceDetection(device) {
					var startSize = getSettingByDeviceType(settings, "startSize", device.getProfile().type, "");
					var isDesktop = device.getProfile().type == "desktop"? true:false;
					var flashPlayerVersion = swfobject.getFlashPlayerVersion();
            				var hasFlashPlayerCapability = flashPlayerVersion.major >= 10;  
					if (device.profileDetected() && device.useFlash() && (hasFlashPlayerCapability && flashvars.favorFlashOverHtml5Video)) {
						if (device.getProfile().type == "tablet" || device.getProfile().type == "smartphone"){
							//flashvars.skin = "skins/"+device.getProfile().type+"-skin.xml";
							flashvars.skin = "/CFIDE/scripts/ajax/resources/cf/skins/"+device.getProfile().type+"-skin.xml" 
							flashvars.controlBarType = device.getProfile().type;
							flashvars.playButtonOverlay = false;
						}
						var params = settings[(device.getProfile().type in settings ? device.getProfile().type : "default")];
						params["movie"] = flashvars.swf;
						params["allowfullscreen"] = "true";
						params["allowscriptaccess"] = "always";
						params["wmode"] = flashvars.wmode;
						
						var attributes = {};
						$("#" + element).css("width",startSize["width"]);
						$("#" + element).css("height",startSize["height"]);
						var options = $.extend(true,options,  flashvars);
						swfobject.embedSWF(
							flashvars.swf, 
							element, 
							startSize["width"], 
							startSize["height"], 
							"10.1.0", 
							"", 
							options, 
							params, 
							attributes,
							onFlashEmbedComplete
						);
						
					}
					else {
						var html5divs;
						if (isDesktop)
						{
							html5divs = '<div class="html5player">' + 
								'<a class="playoverlay"></a>' +
								'<div class="errorwindow"></div>';
							if(flashvars["controlBarMode"] != "none")
							{
								html5divs += '<div class="controls">' +
									'<div class="icon playtoggle">Play/Pause</div>' +
									'<div class="timestamp current">0:00</div>' +
									'<div class="progress">' +
										'<a class="slider"></a>' +
										'<div class="tracks">' +
											'<div class="seeking"></div>' + 
											'<div class="played"></div>' +
											'<div class="buffered"></div>' +
										'</div>' +
									'</div>' +
									'<span class="timestamp separator">/</span>' +
									'<div class="timestamp duration">0:00</div>' +
									'<a class="icon volume high"></a>'+
									'<div class=volume-container>' +
									'<div class=volume-slider></div></div>'+
									'<div class="icon fullview">Full View</div>' +
								'</div>';
							}
							html5divs += '<video id="' + flashvars["id"] + '"  width="' + startSize["width"] + '" height="' + startSize["height"] + '" preload="none" poster="' + flashvars["poster"] + '"';
								if(flashvars["loop"])
									html5divs += " loop";
								if(flashvars["autoPlay"])
									html5divs += " autoplay=\"autoplay\"";
								html5divs +=">";
								if(flashvars["src"])
									html5divs += '<source src="' + flashvars["src"] + '" />'
								html5divs += '</video>'  + 
							'</div>';
						}else
						{
							html5divs = 
							'<div class="html5player">' + 
								'<div class="errorwindow"></div>';
								if(flashvars["controlBarMode"] != "none")
								{	
									html5divs += '<div class="controls">' +
										'<div class="icon playtoggle">Play/Pause</div>' +
										'<div class="timestamp current">0:00</div>' +
										'<div class="progress">' +
											'<a class="slider"></a>' +
											'<div class="tracks">' +
												'<div class="seeking"></div>' + 
												'<div class="played"></div>' +
												'<div class="buffered"></div>' +
											'</div>' +
										'</div>' +
										'<div class="timestamp duration">0:00</div>' +
										'<div class="icon fullview">Full View</div>' +
									'</div>' ;
								}
								html5divs += '<video id="' + flashvars["id"] + '"  width="' + startSize["width"] + '" height="' + startSize["height"] + '" poster="' + flashvars["poster"] + '"';
								if(flashvars["loop"])
									html5divs += " loop";
								html5divs +=">";
								if(flashvars["src"])
									html5divs += '<source src="' + flashvars["src"] + '" />'
								html5divs += '</video>'  + 
							'</div>';
						}
						$("#" + element).html(html5divs);
						//$("#" + element + " .html5player").strobemediaplaybackhtml5();
					}
				//}

				//new DeviceDetection(agent).addCallback(onDeviceDetection).addProfiles(profiles).detect();
			}
		}
	}
}();