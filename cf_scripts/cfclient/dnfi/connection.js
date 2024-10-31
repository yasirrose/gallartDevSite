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

/**
 * @author Sandeepp
 */


var WConnection = function() 
{
	if(typeof Connection != "undefined")
	{
	__$cf._log("Initializing Connection...");
	var self = this;
	this.successObject = new DnfiStatus('connection', dnfi.SUCCESS.code, dnfi.SUCCESS.message);		
	this.callBackStack = new Array();
	this.retVal = "";
	
	
	
	this.UNKNOWN = Connection.UNKNOWN;
	this.ETHERNET = Connection.ETHERNET;
	this.WIFI = Connection.WIFI;
	this.CELL_2G = Connection.CELL_2G;
	this.CELL_3G = Connection.CELL_3G;
	this.CELL_4G = Connection.CELL_4G;
	this.NONE = Connection.NONE;
		
		
	this.getType = function(context)
	{
		var type = navigator.connection.type;
		runCallBacks(context.cb,self.successObject,type);
	}
	
	var addlistener = function(context,eventType, cbObj)
	{		
			
		var callbackFunction = null;
		if(typeof cbObj == "string")
			callbackFunction =_getFunctionForName(cbObj);
		else
			callbackFunction = cbObj;
		
		
		if (typeof callbackFunction == "function") 
		{
			document.addEventListener(eventType, callbackFunction, false);
		}
		else if(typeof cbObj != "undefined")
		{
			runCallBacks(context.cb, new DnfiStatus('WConnection', wConnectionError.CALLBACK_ERROR.code, 
													wConnectionError.CALLBACK_ERROR.message),null);
													
			return;
		}
		
		runCallBacks(context.cb,self.successObject,null);
	}
	
	this.onOnline = function(context, callbackFunction)
	{
		if(_validateDeviceAPI(context, arguments.length-1, 1, "onOnline"))
			addlistener(context, "online",callbackFunction);
	}
	
	this.onOffline = function(context, callbackFunction)
	{
		if(_validateDeviceAPI(context, arguments.length-1, 1, "onOffline"))
			addlistener(context, "offline",callbackFunction);
	}
	
	}
		

} //WConnection
