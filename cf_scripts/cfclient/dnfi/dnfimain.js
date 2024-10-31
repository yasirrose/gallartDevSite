/*************************************************************************
*
* ADOBE CONFIDENTIAL

* ___________________
*
*  Copyright 2013 Adobe Systems Incorporated
*  All Rights Reserved.
*
* NOTICE:  All information contained herein is, and remains
* the property of Adobe Systems Incorporated and its suppliers,
* if any.  The intellectual and technical concepts contained
* herein are proprietary to Adobe Systems Incorporated and its
* suppliers and may be covered by U.S. and Foreign Patents,
* patents in process, and are protected by trade secret or copyright law.
* Dissemination of this information or reproduction of this material
* is strictly forbidden unless prior written permission is obtained
* from Adobe Systems Incorporated.
**************************************************************************/

dropBoxInterfaceTable = {
	"createDirectory" : "fill this later", 
};
dnfiProviderInterface = {};
__cfclient_os = cfclient.getUrlParam("os");
if(window.ispgbuild)
{
	__cfclient_cordovaJSPath = "cordova.js";
}
else
{
	__cfclient_cordovaJSPath = null;
	
	if (__cfclient_os == undefined || __cfclient_os == null)
	{
		//Check if OS is already determined using HTTP_USER_AGENT header
		if (typeof __cfclient_platform != 'undefined')
			__cfclient_os = __cfclient_platform;
			
	}
	
	if (__cfclient_os != undefined && __cfclient_os != null)
	{
		if (__cfclient_os == "ios")
			__cfclient_cordovaJSPath = window.cfclientPath + "cf_scripts/cfclient/dnfi/ios/cordova.js";
		else if (__cfclient_os == "android")
			__cfclient_cordovaJSPath = window.cfclientPath + "cf_scripts/cfclient/dnfi/android/cordova.js";
		else if (__cfclient_os == "pg_emulator") //PhoneGap emulator supports version 2.0.0
			__cfclient_cordovaJSPath = window.cfclientPath + "cf_scripts/cfclient/dnfi/cordova-2.0.0.js";
			
	}
	if (typeof __cfclient_cordovaJSPath == "undefined" || __cfclient_cordovaJSPath == null)
		__cfclient_cordovaJSPath = window.cfclientPath + "cf_scripts/cfclient/dnfi/cordova-2.0.0.js";
}
	
jsIncludes = [
    {name: __cfclient_cordovaJSPath, status: false}, 
	{name: window.cfclientPath + "cf_scripts/cfclient/dnfi/error.js", className:"DnfiStatus", status: false}, 
	{name: window.cfclientPath + "cf_scripts/cfclient/dnfi/cfcamera.js", className:"Wcamera", status: false}, 
	{name: window.cfclientPath + "cf_scripts/cfclient/dnfi/cffile.js", className:"WFileManager", status: false}, 
	/*{name: window.cfclientPath + "CFIDE/cfclient/dnfi/cloud.js", className:"WCloudManager", status: false},*/ 
	/*{name: window.cfclientPath + "CFIDE/cfclient/dnfi/device.js", className:"WDevice", status: false},*/ 
	{name: window.cfclientPath + "cf_scripts/cfclient/dnfi/geolocation.js", className:"WGeoLocation", status: false}, 
	{name: window.cfclientPath + "cf_scripts/cfclient/dnfi/notifications.js", className:"WNotification", status: false},
	{name: window.cfclientPath + "cf_scripts/cfclient/dnfi/contacts.js", className:"WContacts", status: false},
	{name: window.cfclientPath + "cf_scripts/cfclient/dnfi/localstorage.js", className:"WLocalStorage", status: false},
	{name: window.cfclientPath + "cf_scripts/cfclient/dnfi/connection.js", className:"WConnection", status: false},
	{name: window.cfclientPath + "cf_scripts/cfclient/dnfi/audio.js", className:"WAudio", status: false},
	{name: window.cfclientPath + "cf_scripts/cfclient/dnfi/video.js", className:"WVideo", status: false},
	{name: window.cfclientPath + "cf_scripts/cfclient/dnfi/accelerometer.js", className:"WAccelerometer", status: false},
	{name: window.cfclientPath + "cf_scripts/cfclient/dnfi/splashscreen.js", className:"WSplashScreen", status: false},
	{name: window.cfclientPath + "cf_scripts/cfclient/dnfi/events.js", className:"WEvents", status: false},
	/*{name: window.cfclientPath + "CFIDE/cfclient/dnfi/base64.js", status: false}*/]
var TIMERTICK = 100; // Duration for 1 tick in milli seconds
var TIMEOUTTICKS = 100; //number of ticks to elapse before timeout happens
var timerCounts = 0; //this is a counter that keeps track of counts 

addDnfiInterface = function(provider, cls)
{
	dnfiProviderInterface[provider] = cls;
	dnfiProviderInterface['dropbox'](); 
} 

getFileNameFromProvider = function(provider)   
{
	//TODO: we need to later support provider files that have different name than $provider.js
	return (provider + ".js");
}

findDnfiProviderInterface = function(context, provider)
{
	var iface = dnfiProviderInterface[provider];
	var success =  new DnfiStatus('DNFI', dnfi.SUCCESS.code, dnfi.SUCCESS.message);
	
	if (iface != null)
	{
 		eval(provider + "RegisterPlugin()"); //this would set up dnfiProviderInterface[provider] properly
		runCallBacks(context.cb, success, iface);
		return;
	}

  	var script = document.createElement("script");
  	script.setAttribute("type", "text/javascript");
  	var jsPath = getFileNameFromProvider(provider); //provider + ".js";
  	script.setAttribute("src", jsPath);   

 	script.onload = function() 
 	{
 		//we assume that the module is completely loaded and also the module executed registerPlugin 
 		//TODO: check the above assumptions
 		eval(provider + "RegisterPlugin()"); //this would set up dnfiProviderInterface[provider] properly
 		runCallBacks(context.cb, success, dnfiProviderInterface[provider]);
 		return;
 	};
  	document.getElementsByTagName("head")[0].appendChild(script);
}

var initDNFI = function(context)
{
	var self = this;	
	var mytimer = null;	
	this.callBackStack = new Array();
	this.retVal = "";
	this.successObject = null; //new DnfiStatus('WFileManager', dnfi.SUCCESS.code, dnfi.SUCCESS.message);

	this.includeJS = function(jsPath, handler) {
  		var script = document.createElement("script");
  		script.setAttribute("type", "text/javascript");
  		script.setAttribute("src", jsPath.name);
  		script.onload = handler(jsPath);
  		document.getElementsByTagName("head")[0].appendChild(script);
	}
	
	this.onDeviceReady = function(){
		//cordova has fired now - let me load the other dependent scripts
		__$cf._log("Executing on Device ready");
	
		//setupPrototypes(); //sets up prototypes for built in objects like String

		for (var i = 1; i < jsIncludes.length; i++) {
			__$cf._log("About to load - " + jsIncludes[i].name);
			self.includeJS(jsIncludes[i], function loadEventHandler(jsObj) {
				jsObj.status = true;
				});
		}	
		myTimer = setInterval(self.checkLoadCompletion, TIMERTICK); 
	}	 

	this.init2 = function() 
	{	
		//cameraObj = new WCamera(); //myCamera is now a global variable	
		//add methods and properties to Phonegap classes
		updateContacts();	
		
		runCallBacks(context.cb, {"module":"init","code":0,"message":""}, null);
	}
	

	//check whether all required files are loaded fully
	this.checkLoadCompletion = function()
	{

		timerCounts += 1;
		if (timerCounts > TIMEOUTTICKS)
		{
			//timeout has happened - fire an error event for the callback
			__$cf._log("Device API load timed out: some modules might not have been fully loaded/initialized yet");
			timerCounts = 0;
			clearInterval(myTimer);
		}
		if(!window.ispgbuild)
		{
			//check all modules are loaded in case of non pg build
			
			if ((typeof WCamera == 'undefined') || (typeof DnfiStatus == 'undefined') || 
					(typeof WFileManager == 'undefined') || (typeof WContacts == 'undefined') || 
					(typeof WNotification == 'undefined') || (typeof WGeoLocation == 'undefined') ) return;
			timerCounts = 0;
			clearInterval(myTimer);
			/*
				window.resolveLocalFileSystemURI("file:///android_asset/", 
										function(entry) {alert("success, " + entry.fullPath);},  
										function(e) {alert("fail, code: " + e.code);});
			*/
			self.init2();
		}
		else
		{
			for (var i = 1; i < jsIncludes.length; i++) 
			{
				if(!jsIncludes[i].status)
					return;
				
			};
			timerCounts = 0;
			clearInterval(myTimer);
			self.init2();
		}
	}
	
	//load Cordova first before other JS files
	//note: it may be necessary to order the loads properly because of any dependencies between different JS wrappers
	//particularly if there is any initializer code that is executed at the time of loading the file
	//if the file contains only Function objects i dont see this as an issue as they will not be executed till invoked
	
	if  ((typeof window.parent != 'undefined' && typeof window.parent.__cf_pg_device_ready != 'undefined') ||
		(typeof window.__cf_pg_device_ready != 'undefined' && window.__cf_pg_device_ready))
	{
		self.onDeviceReady();
	} 
	else
	{
		
			
		/*if(!window.ispgbuild)
		{
			//Hack for supporting PhoneGap 3.0 onwards. It looks
			//for script tag with src cordova.js to find path of 
			//cordova_plugins.js - Ram
	  		var pluginScript = document.createElement("script");
	  		pluginScript.setAttribute("type", "text/javascript");

	  		var cordovaPath;
	  		var platform_folder = "android/"; //default to android in case can't find platform'
	  		if (__cfclient_os == "ios")
				platform_folder = "ios/";
				
	  		if (window.cfclientPath)
	  			cordovaPath = window.cfclientPath + "cf_scripts/cfclient/dnfi/" + platform_folder +"cordova.js";
	  		else
	  			cordovaPath = "/cf_scripts/cfclient/dnfi/" + platform_folder +"cordova.js";
	  			
	  		pluginScript.setAttribute("src", cordovaPath);
	  		pluginScript.setAttribute("charset", "utf-8");
	  		document.getElementsByTagName("head")[0].appendChild(pluginScript);
		}		*/
		
  		var script = document.createElement("script");
  		script.setAttribute("type", "text/javascript");
  		script.setAttribute("src", __cfclient_cordovaJSPath);
  		script.setAttribute("charset", "utf-8");
  		
  		__$cf._log("cordova path "+__cfclient_cordovaJSPath);

  		script.onload = function() {
  			document.addEventListener("deviceready", function() 
  			{
  				__$cf._log("cordova js loaded");
  				self.onDeviceReady()
  			});
  		};
  		document.getElementsByTagName("head")[0].appendChild(script);
	}
}

function updateContacts()
{
	if(typeof Contact != "undefined")
	{
	//ContactName
	/*ContactName.prototype.familyname = null;
	ContactName.prototype.givenname = null;
	ContactName.prototype.middlename = null;
	ContactName.prototype.honorificprefix = null;
	ContactName.prototype.honorificsuffix = null;*/
	
	//ContactAddress
	/*ContactAddress.prototype.streetaddress = null;
	ContactAddress.prototype.postalcode = null;
	
	Contact.prototype.displayname = null;
	Contact.prototype.phonenumbers = null;*/
	
	
	Contact.prototype.__getNumberWithType = function(type)
	{
		if(this.phoneNumbers != null)
		{
			var entry = null;
			for(var i =0 ; i < this.phoneNumbers.length; i++)
			{
				entry = this.phoneNumbers[i];
				if(type == "pref")
				{
					if(entry.pref)
						return entry;
				}
				else if(entry.type == type)
					return entry.value;
			}
		}
		
		return null;
	}
	Contact.prototype.getMobileNumber = function()
	{
		return this.__getNumberWithType("mobile");
	}
	Contact.prototype.getHomeNumber = function()
	{
		return this.__getNumberWithType("home");
	}
	Contact.prototype.getWorkNumber = function()
	{
		return this.__getNumberWithType("work");
	}
	Contact.prototype.getPreferredNumber = function()
	{
		return this.__getNumberWithType("pref");
	}
	
	Contact.prototype.addPhoneNumber = function(value, type, pref)
	{
		if(typeof type == "undefined" || type == null)
			type = "mobile";
		
		if(typeof pref == "undefined" || pref == null)
			pref = false;
			
		var pNumbers = new ContactField(type, value, pref);		
		
		arrayAppend(this.phoneNumbers, pNumbers);		
		
	}
	
	Contact.prototype.addEmail = function(value, type, pref)
	{
		
		if(typeof pref == "undefined" || pref == null)
			pref = false;
			
		var email = new ContactField(type, value, pref);
		if (this.emails == null) 
			this.emails = [];
		
		arrayAppend(this.emails, email);
				
	}
	
	Contact.prototype.addAddress = function(address)
	{
		
		if (this.addresses == null) 
			this.addresses = [];
		
		arrayAppend(this.addresses, address);				
	}
	
	Contact.prototype.addOrganization = function(organization)
	{
		
		if (this.organizations == null) 
			this.organizations = [];
		
		arrayAppend(this.organizations, organization);
	
	}
	
	Contact.prototype.addIm = function(value, type, pref)
	{		
		
		if(typeof pref == "undefined" || pref == null)
			pref = false;
			
		var im = new ContactField(type, value, pref);
		if (this.ims == null) 
			this.ims = [];
		
		arrayAppend(this.ims, im);	
	}
	
	Contact.prototype.addPhoto = function(value, type, pref)
	{		
		
		if(typeof pref == "undefined" || pref == null)
			pref = false;
			
		var photo = new ContactField(type, value, pref);
		if (this.photos == null) 
			this.photos = [];
		
		arrayAppend(this.photos, photo);		
	}
	
	Contact.prototype.addCategory = function(value, type, pref)
	{
		
		if(typeof pref == "undefined" || pref == null)
			pref = false;
			
		var category = new ContactField(type, value, pref);
		if (this.categories == null) 
			this.categories = [];
		
		arrayAppend(this.categories, category);	
	}
	
	Contact.prototype.addURL = function(value, type, pref)
	{
		
		if(typeof pref == "undefined" || pref == null)
			pref = false;
			
		var url = new ContactField(type, value, pref);
		if (this.urls == null) 
			this.urls = [];
		
		arrayAppend(this.categories, url);	
	}
	}
	
}


//debug this later
function areAllModulesLoaded()
{
	for (var i = 0; i < jsIncludes.length; i++)
	{
		if (typeof jsIncludes[i].className != 'undefined')
		{
			var temp = jsIncludes[i].className;
			eval("if (typeof " + temp + "== 'undefined') return false");
		}
		else
		{
			setTimeout(function() { alert("module " + jsIncludes[i].className + " is undefined");}, 0);
		}
	}
	
	return true;
}

function setupPrototypes()
{
	//Note: we are now setting up prototype functions for standard builtin objects
	//It is likely that some of these might have been defined by third party frameworks like jquery - verify later for clashes
	//setup prototypes for String object
	/*
	String.prototype.isString = function ()
		{
			if (typeof this == 'string') return true; else return false;
		};
	*/
}
/*function getCamera()
{
	if (typeof cameraObj == 'undefined') {
		__$cf._log("cameraObj undefined");
		return null;
	}
	else
	{
		return cameraObj;
	} 
}*/

	
	invokeProviderAction = function(context, provider, action)
	{
		//NOTE: params should be in a form that can be converted to string directly
		// objects or arrays need to be flattened as a param list before sending
		 var args = arguments;
		 
			findDnfiProviderInterface({cb:[function(e, iface) {
				self.callBackStack = context.cb;
				self.retVal = context.ret;
				if (e.code == dnfi.SUCCESS.code)
				{ //we are able to get the interface for the provider
					var cm = new iface();					
					
					var ctxString = "{cb:[function(e, value) {\
						self.callBackStack = context.cb;\
						self.retVal = context.ret;\
						if (e.code == dnfi.SUCCESS.code)\
						{\
							runCallBacks(context.cb, self.successObject, value);\
						}\
						else\
						{\
							runCallBacks(context.cb, e);\
						} }]}";
					
					var paramsString = "";
									
					for (var i = 3; i < args.length; i++)
					{
						if ((i + 1) == args.length) paramsString += "'" + args[i] + "'";
						else paramsString += "'" + args[i] + "', ";
					}
					
					var evalStr = "cm." + action + "(" + ctxString + "," + paramsString + ")";
					
					eval(evalStr);
					
					return;				
				}
				else // interface couldn't be obtained
				{
					runCallBacks(self.callBackStack, new DnfiStatus('wFileManager', wFileManagerError.PROVIDER_NOT_FOUND_ERROR.code, wFileManagerError.PROVIDER_NOT_FOUND_ERROR.message), null);																					
				}
			}]}, provider);					
	}


runCallBacks = function(cb, e, d) 
// run all the functions in the call back stack
{
		if (typeof cb == 'function')
		{
			cb(e, d);
			return;
		}
	
	var f; 
	
	if ((cb != undefined) && (cb != null) && cb.length > 0)
	{
		f = cb.pop();
		var retStatus = {status:e,retVal:d};
		//f({cb:cb},e,d);
		f(e,d);
	} 
}



_getFunctionForName = function(fName)
{
	var func = eval(fName);
	if(!func)
		func = eval(fName.toLowerCase());
		
	return func;
}

/*
* update properties of obj1 from obj2 and
* add missing properties
*/
_updateProperties = function(obj1, obj2)
{
	for(var key in obj2)
	{
		if(obj2.hasOwnProperty(key))
			obj1[key] = obj2[key];
	}
}
function _validateDeviceAPI(context, argumentCount, requiredCount, functionName)
{
	if(argumentCount < requiredCount)
	{
		var msg = "Required parameters missing for function "+functionName+". The function takes "+requiredCount+" required parameter";
		var dnfiError = new DnfiStatus('API Validation Error', 1, msg);
			runCallBacks(context.cb, dnfiError, null);
		return false;
	}		
	return true;	
}
/* ******************************************************************************************************************************
	dnfiExecuteSequence - This is a framework that will accept a list of instructions/functions and sequence them
	for execution and execute them in order
	
	1. Need to define basic primitives
	2. Mechanism for combination
	3. Mechansim for abstraction and manipulating abstract entities
******************************************************************************************************************************* */
dnfiExecuteSequence = function (context, caller)
{
  //this will be called like: dnfiExecuteSequence(context, referenceToCaller, [obj, f1, p1, p2], [obj, f2, p1], [obj, f3])
  var currentIndexOfSequence = 2; //point to the first function to be executed, which is index 2 as the context and caller are in index 0, 1
  var args = arguments;
  var instructionExecuted = false;
  this.returnValue = null;
  var sequencer = this;
  //var caller;

	this. getSequencerReturnValue = function(ret)
	{
		eval("caller." + ret +  "= sequencer.returnValue");
		return;
	}
   
  var cbFunction = function(e, value) {
	
  	if (e.code == dnfi.SUCCESS.code)
  	{
		sequencer.returnValue = value;
		if (args.length == currentIndexOfSequence) //nothing more available in argument array, all functions executed and so return
  		{
  			runCallBacks(context.cb, new DnfiStatus('dnfi', dnfi.SUCCESS.code, dnfi.SUCCESS.message), value);
			return;  
  		}  		
  		instructionExecuted = false;
  		var funcArray;

  		while(currentIndexOfSequence < args.length)  //this loop will keep executing instruction blocks till it encounters a function
  		{
  			funcArray = args[currentIndexOfSequence++]; //this will be of the form [function, arg1, arg2...]
  			if (typeof funcArray == 'string') //if this is an instruction block just evaluate it
  			{
  				eval(funcArray);
  				instructionExecuted = true;
  				continue; 
  			}
  			instructionExecuted = false;
  			break;
  		} 
		if ((instructionExecuted) && (currentIndexOfSequence == args.length))
		{
 			runCallBacks(context.cb, new DnfiStatus('dnfi', dnfi.SUCCESS.code, dnfi.SUCCESS.message), value);
			return;  
		}

	  	var a1 = Array.prototype.slice.call(funcArray, 2);
		a1.unshift({cb:[cbFunction]});  	
  		funcArray[0][funcArray[1]].apply(funcArray[0], a1);  //execute the  function	
  		return;  	
  	}
  	else
  	{
  		sequencer.returnValue = null;
		runCallBacks(context.cb, e, null);
  	}
  };
  cbFunction(new DnfiStatus('DNFI', dnfi.SUCCESS.code, dnfi.SUCCESS.message));
}
/*************************************************************************************************************
 * Utility Functions
 * //TODO: Refactor these as a separate utils file later
 *************************************************************************************************************/
function trim(str)
{
	return str.replace(/^\s+|\s+$/g,"");	
}				

//return true is the given string str is empty
function isEmptyString(str)
{
	var s = str;
	if (trim(s) == "") return true;
	else return false;
}

function getType(val)
{
	if( Object.prototype.toString.call( val ) === '[object Array]' ) return "array"; 
	else return (typeof val);
}

