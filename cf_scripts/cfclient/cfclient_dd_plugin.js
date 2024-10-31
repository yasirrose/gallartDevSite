/**
 * @author Ram Kulkarni 
 */

(function(){
    var _ddplugin = function(){
        var self = this;
		this.initialized = false;
		this.callbackFunction = null;
		this.modernizrFilePath = window.cfclientPath + "cf_scripts/cfclient/modernizr.custom.js";
		this.modernizrLoaded = false;
		this.matchmediaFilePath = window.cfclientPath + "cf_scripts/cfclient/matchMedia.js";
		this.mediaQueryFileLoaded = false;
		this.bmaputilFilePath = window.cfclientPath + "cf_scripts/cfclient/bmaputil.js";
		this.bmapFilePath = window.cfclientPath + "cf_scripts/cfclient/bmap.js";
		this.probesFilePath = window.cfclientPath + "cf_scripts/cfclient/probes.js";
		this.devicegroupsFilePath = window.cfclientPath + "cf_scripts/cfclient/devicegroups.js";
		this.browserMapLoaded = false;
		
		this.orientationCallBacks = new Array();
		this.resizeCallBacks = new Array();
                
        this.init = function(callback){
			
			if (self.initialized)
				return;
			
			self.initialized = true;
			self.callbackFunction = callback;
			cfclient.properties = {};
			
            cfclient.loadJSFile(self.modernizrFilePath, function(){
				// Loading device data using modernizr
				for (var i in Modernizr) {
					cfclient.properties[i] = Modernizr[i];
				}
				self.modernizrLoaded = true;
				self.libaryLoadedCallback();
            });
			
			cfclient.properties.width = window.innerWidth;
			cfclient.properties.height = window.innerHeight;
			cfclient.properties.deviceWidth = window.screen.width;
			cfclient.properties.deviceHeight = window.screen.height;
			
			
			// Handling orientation change
			function handleOrientationValue (mql) 
			{
				// Setting the correct orientation. The orientation listener is created with the media query "orientation: portrait". So if the media query matches, the orientation is set as portrait. If it false, then it is set landscape.
				if(mql.matches) 
				{
					cfclient.properties.orientation = "portrait";
				}
				else 
				{
					cfclient.properties.orientation = "landscape";
				}
				var is_ios = false;
				if((navigator.userAgent.match(/iPhone/i)) || (navigator.userAgent.match(/iPod/i)) || (navigator.userAgent.match(/iPad/i)))
				{
					is_ios = true;
				}
				if( !is_ios )
				{
					// When the orientation changes, the device width and device height also needs to be updated.
					cfclient.properties.deviceWidth = window.screen.width;
					cfclient.properties.deviceHeight = window.screen.height;
				}
				else
				{
					// When the orientation changes, the device width and device height were not getting updated in iOS. So swapping the device width and device height in case of iOS.
					if(mql.matches)
					{
						cfclient.properties.deviceWidth = window.screen.width;
						cfclient.properties.deviceHeight = window.screen.height;
					}
					else
					{
						cfclient.properties.deviceWidth = window.screen.height;
						cfclient.properties.deviceHeight = window.screen.width;
					}
				}

				// Again setting the onresize event handler. If this is not set, the resize handler is not invoked, after an orientation is changed.
				window.onresize = cfresize;
				for(var i in self.orientationCallBacks)
				{
					if(self.orientationCallBacks.hasOwnProperty(i))
					{
						var orientCallBack = eval(i);
						var divStruct = self.orientationCallBacks[i];
						if( null != divStruct )
						{
							globalDivStruct = divStruct;
							orientCallBack(cfclient.properties.orientation);
							//globalDivStruct = null;	
						}	
					}					
				}
			}

			// Handling the resize events to update the width and height in cfclient.
			var resizeTimeout = 100;
			
			function cfresize()
			{
				
				var onResize = function()
				{
					var is_ios = false;
					if((navigator.userAgent.match(/iPhone/i)) || (navigator.userAgent.match(/iPod/i)) || (navigator.userAgent.match(/iPad/i)))
					{
						is_ios = true;
					}
					// Updating the width and height properties when browser is resized
					cfclient.properties.width = window.innerWidth;
					cfclient.properties.height = window.innerHeight;
					if(!is_ios)
					{
						var tempOrientation = "portrait";
						if(cfclient.properties.width > cfclient.properties.height)
						{
							tempOrientation = "landscape";
						}
						if(tempOrientation !== cfclient.properties.orientation)
						{
							cfclient.properties.orientation = tempOrientation;
							for(var i in self.orientationCallBacks)
							{
								if(self.orientationCallBacks.hasOwnProperty(i))
								{
									var orientCallBack = eval(i);
									var divStruct = self.orientationCallBacks[i];
									if( null != divStruct )
									{
										globalDivStruct = divStruct;
										orientCallBack(cfclient.properties.orientation);
									}	
								}					
							}
						}
					}
					// Invoking all the registered resize callbacks.
					for(var i in self.resizeCallBacks)
					{
						if(self.resizeCallBacks.hasOwnProperty(i))
						{
							var resizeCallBack = eval(i);
							var divStruct = self.resizeCallBacks[i];
							if( null != divStruct )
							{
								globalDivStruct = divStruct;
								resizeCallBack(cfclient.properties.width, cfclient.properties.height);
								// globalDivStruct = null;	
							}	
						}					
					}
					// Again setting the onresize event handler. If this is not set, the resize callbakcs are invoked only the first time. 
					window.onresize = cfresize;
				}
				
				// Calling the resize function using a timer. So that after the resizing is done the values will be updated. Otherwise for every small change while resizing, the callbacks will be invoked.
				window.clearTimeout(resizeTimeout);
				resizeTimeout = window.setTimeout(onResize, 100);
			}
			
			window.onresize = cfresize;
 
			function createOrientationListener()
			{
				var is_ios = false;
				if((navigator.userAgent.match(/iPhone/i)) || (navigator.userAgent.match(/iPod/i)) || (navigator.userAgent.match(/iPad/i)))
				{
					is_ios = true;
				}
				if(is_ios)
				{
					self.mediaQueryFileLoaded = true;
					// window.matchmedia API is not working android 2.3. So if matchmedia API is not available, using mql from matchmedia.js
					if( typeof window.matchMedia != 'undefined' )
					{
						var portraitOrientationCheck = window.matchMedia("(orientation: portrait)");
						portraitOrientationCheck.addListener(handleOrientationValue);
						// Setting the orientation value for the first time by explicitly invoking the handleOrientationValue(). Next time onwards the function will be called when the orientation changes.
						handleOrientationValue(portraitOrientationCheck);
						self.libaryLoadedCallback();
					}
					else
					{
						cfclient.loadJSFile(self.matchmediaFilePath, function(){
							var portraitOrientationCheck = mql("(orientation: portrait)", handleOrientationValue);
							// Setting the orientation value for the first time by explicitly invoking the handleOrientationValue(). Next time onwards the function will be called when the orientation changes.
							handleOrientationValue(portraitOrientationCheck);
							self.libaryLoadedCallback();
						});
					}					
				}
				else
				{
					self.mediaQueryFileLoaded = true;
					window.onresize();
				}
			}
			createOrientationListener();
			
			
			
			// Getting the devicegroup using browsermap js.
			// BrowserMap.forwardRequest();
			// var matchedGroups = BrowserMap.getMatchedDeviceGroups();
			// for (var g in matchedGroups) 
			// {
			//	this.devicegroupdescription.push(matchedGroups[g].description);
			//	this.devicegroupname.push(matchedGroups[g].name);
			// }
			// Loading device data using modernizr
				
			cfclient.loadJSFile(self.bmaputilFilePath, function(){
				cfclient.loadJSFile(self.bmapFilePath, function(){
					cfclient.loadJSFile(self.probesFilePath, function(){
						cfclient.loadJSFile(self.devicegroupsFilePath, function(){
							BrowserMap.forwardRequest();
							var matchedGroups = BrowserMap.getMatchedDeviceGroups();
							cfclient.properties.deviceGroupDescription = [];
							cfclient.properties.deviceGroupName = [];
							for (var g in matchedGroups) 
							{
								cfclient.properties.deviceGroupDescription.push(matchedGroups[g].description);
								cfclient.properties.deviceGroupName.push(matchedGroups[g].name);
							}
							self.browserMapLoaded = true;
							self.libaryLoadedCallback();
						});
					});
				});
            });
			
        }
		
		// Adding orientation listener
		this.libaryLoadedCallback = function()
		{
			if(self.callbackFunction != null)
			{
				if(self.mediaQueryFileLoaded && self.modernizrLoaded && self.browserMapLoaded)
				{
					self.callbackFunction();
					self.callbackFunction = null;
				}
			}
        }
		
		// Adding orientation listener
		this.addOrientationListener = function(listener)
		{
            self.orientationCallBacks[listener.name] = globalDivStruct;
        }
		
		// Removing orientation listener
		this.removeOrientationListener = function(listener)
		{
			for(var i in self.orientationCallBacks)
			{
				if(i==listener.name)
				{
					self.orientationCallBacks[i] = null;
					break;
				}
			}
        }
		
		// Adding resize listener
		this.addResizeListener = function(listener)
		{
			self.resizeCallBacks[listener.name] = globalDivStruct;
        }
		
		// Removing resize listener
		this.removeResizeListener = function(listener)
		{
			for(var i in self.resizeCallBacks)
			{
				if(i==listener.name)
				{
					self.resizeCallBacks[i] = null;
					break;
				}
			}
        }
        
                
    }
    window.cfclient_device_detection_plugin = new _ddplugin();
})();