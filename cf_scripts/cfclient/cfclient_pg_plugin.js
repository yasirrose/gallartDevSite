/**
 * @author Ram Kulkarni
 */

(function() {
	
	var FileManager = function()
	{
		var self = this;
		
		this.getFilesFromFullPath = function (folderStr, retVarName, callbackstack)
		{
			if (typeof window.resolveLocalFileSystemURI != 'undefined') {
				window.resolveLocalFileSystemURI(folderStr,function(fileEntry){
					//success
					if (fileEntry.isFile) {
						//alert ("Cannot get children of file " + folderStr);
						return;
					}
					self._getEntriesHelper(fileEntry,retVarName,callbackstack);
				},function(err){
					//error
					if (typeof err.message != 'undefined')
						err = err.message;
					//alert ("Error getting folder entries for " + folderStr + " : " + err);
				});
			}			
		}

		this.getFiles = function (folderStr, retVarName, callbackstack)
		{
			if (typeof window.requestFileSystem != 'undefined') {
				window.requestFileSystem(LocalFileSystem.PERSISTENT, 0, function(fileSystem){
					//success
					var rootDir = fileSystem.root;
					if (folderStr == "" || folderStr == '/')
					{
						self._getEntriesHelper(rootDir,retVarName,callbackstack);
						return;
					}
					
					rootDir.getDirectory(folderStr,{create:false,exclusive: false}, function(dirEntry){
						//success
						self._getEntriesHelper(dirEntry,retVarName,callbackstack);
					},
					function(err){
						//error
						if (typeof err.message != 'undefined')
							err = err.message;
						//alert ("Error getting folder entries for " + folderStr + " : " + err);
					});
					
				}, function(err){
					//error
					if (typeof err.message != 'undefined')
						err = err.message;
					//alert ("Error getting folder entries for " + folderStr + " : " + err);
				});
			}
			
			return null;
		}
		
		this._getEntriesHelper = function (dirEntry, retVarName, callbackstack)
		{
			var dirReader = dirEntry.createReader();
			dirReader.readEntries(function(entries){
				var result = self._dirEntriesToArray(entries);
				if (retVarName != undefined)
					eval("window." + retVarName + " = result");

				if (callbackstack != undefined && callbackstack.length > 0) {
					var nextFunc = callbackstack.pop();
					nextFunc.call(this, callbackstack, result);
				}
			}, function(err){
				if (typeof err.message != 'undefined')
					err = err.message;
				//alert("Error getting folder entries : " + err);	
			});
			
		}
		
		this._dirEntriesToArray = function (entries)
		{
			entries.sort(function(a,b){
				var str1 = a.name.toLowerCase();
				var str2 = b.name.toLowerCase();
				if (str1 < str2)
					return -1;
				if (str1 > str2)
					return 1;
				return 0;
			});
			
			var resultArray = new Array();
			
			for (var i = 0; i < entries.length; i++)
				resultArray.push(self._fileEntryToObj(entries[i]));
			
			return resultArray;
		}
		
		this._fileEntryToObj = function (entry)
		{
			var isFolder = entry.isDirectory;
			var name = entry.name;
			var fullPath = entry.fullPath;
			return {
				name: name,
				isFolder: isFolder,
				fullPath: fullPath
			};
		}
		
		this.getRoot = function(retVarName,callbackstack)
		{
			if (typeof window.requestFileSystem != 'undefined') {
				window.requestFileSystem(LocalFileSystem.PERSISTENT, 0, function(fileSystem){
					//success
					if (retVarName != undefined)
						eval("window." + retVarName + " = fileSystem ");

					if (callbackstack != undefined && callbackstack.length > 0) {
						var nextFunc = callbackstack.pop();
						nextFunc.call(this, callbackstack, fileSystem);
					}
				}, function(){
					throw ("Error accessing local file system");
				});
			}
		}

	}
	
	var _DNFiFileManager = function()
	{
		var self = this;
		this.dnfiFileAPIs = null;
		
		this.callDNFI = function (functionName, callbackStack, args)
		{			
			self.getFileAPIObj(function(){
				_callDNFIHelper(self.dnfiFileAPIs,functionName, callbackStack, args);
			});
		}

		this.getFileAPIObj = function (callback)
		{
			if (self.dnfiFileAPIs == null)
			{
				self.dnfiFileAPIs = new WFileManager({cb: [function(e, fm) {
					self.dnfiFileAPIs = fm;
					if (callback)
						callback();
				}], ret:"ret"});
				
			}
			else if (callback)
				callback();
		}
	}
	
	var _DNFICameraManager = function()
	{
		var self = this;
		this.dnfiCameraAPIs = new WCamera();
		
		this.callDNFI = function (functionName, callbackStack, args)
		{
			_callDNFIHelper(self.dnfiCameraAPIs,functionName, callbackStack, args);
		}
	}
	
	var _DNFIContactsManager = function()
	{
		var self = this;
		this.dnfiContactsAPIs = null;
		
		this.callDNFI = function (functionName, callbackStack, args)
		{			   		
		       self.getContactsAPIObj(function(){
		       _callDNFIHelper(self.dnfiContactsAPIs,functionName, callbackStack, args);
		});
		}
		this.getContactsAPIObj = function (callback)
		{			   		
		   if (self.dnfiContactsAPIs == null)
		   {
		        self.dnfiContactsAPIs = new WContacts();                               
		   }
		   if (callback)
		           callback();
		}
	}
	
	var _DNFIGeolocationManager = function()
	{
		var self = this;
		this.dnfiGeolocationAPIs = new WGeoLocation();
		
		this.callDNFI = function (functionName, callbackStack, args)
		{
			_callDNFIHelper(self.dnfiGeolocationAPIs,functionName, callbackStack, args);
		}
	}

	var _DNFINotificationManager = function()
	{
		var self = this;
		this.dnfiNotificationAPIs = new WNotification();
		
		this.callDNFI = function (functionName, callbackStack, args)
		{
			_callDNFIHelper(self.dnfiNotificationAPIs,functionName, callbackStack, args);
		}
	}

	/*var _DNFIDeviceManager = function()
	{
		var self = this;
		this.dnfiDeviceAPIs = new WDevice();
		
		this.callDNFI = function (functionName, callbackStack, args)
		{
			_callDNFIHelper(self.dnfiDeviceAPIs,functionName, callbackStack, args);
		}
	}*/
	
	var _DNFILocalStorageManager = function()
	{
		var self = this;
		this.dnfiLocalStorageAPIs = new WLocalStorage();
		
		this.callDNFI = function (functionName, callbackStack, args)
		{
			_callDNFIHelper(self.dnfiLocalStorageAPIs,functionName, callbackStack, args);
		}
	}
	
	var _DNFIConnectionManager = function()
	{
		var self = this;
		this.dnfiConnectionAPIs = new WConnection();
		
		this.callDNFI = function (functionName, callbackStack, args)
		{
			_callDNFIHelper(self.dnfiConnectionAPIs,functionName, callbackStack, args);
		}
	}
	
	var _DNFIAudioManager = function()
	{
		var self = this;
		this.dnfiAudioAPIs = new WAudio();
		
		this.callDNFI = function (functionName, callbackStack, args)
		{
			_callDNFIHelper(self.dnfiAudioAPIs,functionName, callbackStack, args);
		}
	}	
	
	var _DNFIVideoManager = function()
	{
		var self = this;
		this.dnfiVideoAPIs = new WVideo();
		
		this.callDNFI = function (functionName, callbackStack, args)
		{
			_callDNFIHelper(self.dnfiVideoAPIs,functionName, callbackStack, args);
		}
	}
	
	var _DNFIAccelerometerManager = function()
	{
		var self = this;
		this.dnfiAccelerometerAPIs = new WAccelerometer();
		
		this.callDNFI = function (functionName, callbackStack, args)
		{
			_callDNFIHelper(self.dnfiAccelerometerAPIs,functionName, callbackStack, args);
		}
	}
	
	var _DNFISplashScreenManager = function()
	{
		var self = this;
		this.dnfiSplashScreenAPIs = new WSplashScreen();
		
		this.callDNFI = function (functionName, callbackStack, args)
		{
			_callDNFIHelper(self.dnfiSplashScreenAPIs,functionName, callbackStack, args);
		}
	}
	
	var _DNFIEventsManager = function()
	{
		var self = this;
		this.dnfiEventsAPIs = new WEvents();
		
		this.callDNFI = function (functionName, callbackStack, args)
		{
			_callDNFIHelper(self.dnfiEventsAPIs,functionName, callbackStack, args);
		}
	}
	
	var _callDNFIHelper = function(dnfiObj,functionName, callbackStack, args){
		try
		{			
			var dnfiFunc = eval("dnfiObj." + functionName);
			if (!dnfiFunc)
				dnfiFunc = eval("dnfiObj." + functionName.toLowerCase());
			
		} catch (err)
		{
			var errMsg = "Function " + functionName + " not found";
			returnFromAsyncFunc(callbackStack,{code:1,message:errMsg},null);
			return;
		}
		
		if (!dnfiFunc)
		{
			var errMsg = "Function " + functionName + " not found";
			returnFromAsyncFunc(callbackStack,{code:1,message:errMsg},null);
			return;
		}
		
		var cbStack = {cb:[function(e,ret){
			if (e.code != 0)
			{
				//this is an error
				returnFromAsyncFunc(callbackStack,{code:1,message:e.message},null);
				return;
			}
			returnFromAsyncFunc(callbackStack,e,ret);
		}]};
		
		try
		{			
			if (!args)
			args = [];
		
			var argsArray = [cbStack].concat(args);		
			dnfiFunc.apply(dnfiFunc,argsArray);
			
		} catch (err)
		{
			returnFromAsyncFunc(callbackStack,{code:1,message:err.message},null);
			return;
		}
		
		
	}
	
	var _pgplugin = function ()
	{
		var self = this;
		this.initialized = false;
		this.fileManager = new FileManager();
		
		this.file = null; //Wrapper for WFileManager
		this.camera = null; //Wrapper for WCamera
		this.contacts = null; //Wrapper for WContacts
		this.geolocation = null; //Wrapper for WGeoLocation 
		this.notification = null; //Wrapper for WNotification 
		this.device = null; //Wrapper for WDevice
		
		//this.scriptPath = "/CFIDE/cfclient/cordova-1.8.0.js";
		this.scriptPath = window.cfclientPath + "cf_scripts/cfclient/dnfi/dnfimain.js";
		
		this.init = function(callbackFunction)
		{
			if (self.initialized)
				return;
			
			self.initialized = true;					
				
			cfclient.loadJSFile(self.scriptPath, function(){
				__dnfiReadyCallback = function (e)
				{
					if(__cfclient_os != "pg_emulator" && typeof navigator.splashscreen != "undefined")
						navigator.splashscreen.hide(); //hide splash screen once device is ready
					
					cfclient.file = new _DNFiFileManager(); 
					cfclient.camera = new _DNFICameraManager();
					cfclient.contacts = new _DNFIContactsManager();
					cfclient.geolocation = new _DNFIGeolocationManager(); 
					cfclient.notification = new _DNFINotificationManager(); 
					//self.device = new _DNFIDeviceManager();
					cfclient.localstorage = new _DNFILocalStorageManager();
					cfclient.connection = new _DNFIConnectionManager();
					cfclient.audio = new _DNFIAudioManager();
					cfclient.video = new _DNFIVideoManager();
					cfclient.accelerometer = new _DNFIAccelerometerManager();
					cfclient.splashscreen = new _DNFISplashScreenManager();
					cfclient.events = new _DNFIEventsManager();									
					
					if(typeof device != "undefined")
					{
						self.model = device.model;
						self.name = device.name;
						self.platform = device.platform;
						self.uuid = device.uuid;
						self.version = device.version;
						self.cordova = device.cordova;
						
						if(typeof __cfclient_os == "undefined")
						{
							__cfclient_os = device.platform;
						}
					}
					
					if (typeof callbackFunction == 'function')
						callbackFunction();
				}
				
				initDNFI({cb:[__dnfiReadyCallback]});
				
//				document.addEventListener("deviceready", function(){
//					if (typeof callbackFunction == 'function')
//						callbackFunction();
//				}, false);
			});
		}		
		
		this.isPhone = function ()
		{
			return typeof navigator.contacts != 'undefined';
		}			
				
		this.trim = function(str) {
			return str.replace(/^\s+|\s+$/g,"");
		}		
		
	}//of var _pgplugin = function ()
	
	window.cfclient_mobile_api_plugin = new _pgplugin();
}
)();
