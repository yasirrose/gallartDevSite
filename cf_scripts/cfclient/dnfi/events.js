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


var WEvents = function() 
{
	__$cf._log("Initializing Events...");
	var self = this;
	this.successObject = new DnfiStatus('events', dnfi.SUCCESS.code, dnfi.SUCCESS.message);		
	this.callBackStack = new Array();
	this.retVal = "";
	
	var addlistener = function(context,eventType, cbObj)
	{		
			
		var callbackFunction = null;
		if(typeof cbObj == "string")
			callbackFunction =_getFunctionForName(cbObj);
		else
			callbackFunction = cbObj;
				
		var _cb = function(obj)
		{
			
			if(typeof obj != "undefined")
			{
				if(typeof obj.isPlugged != "undefined")
					obj.isplugged = obj.isPlugged;
					
				var argsArray = [obj];
				
				callbackFunction.apply(cbObj,argsArray);	
			}
			else
				callbackFunction.apply(cbObj);
			
		}
		
		
		if (typeof callbackFunction == "function") 
		{
			document.addEventListener(eventType, _cb, false);
		}
		else if(typeof cbObj != "undefined")
		{
			runCallBacks(context.cb, new DnfiStatus('WEvents', wEventsError.CALLBACK_ERROR.code, 
													wEventsError.CALLBACK_ERROR.message),null);
													
			return;
		}
		
		runCallBacks(context.cb,self.successObject,null);
	}
	
	this.onPause = function(context, callbackFunction)
	{
		if(_validateDeviceAPI(context, arguments.length-1, 1, "onPause"))			
			addlistener(context, "pause",callbackFunction);
	}
	
	this.onResume = function(context, callbackFunction)
	{
		if(_validateDeviceAPI(context, arguments.length-1, 1, "onResume"))
			addlistener(context, "resume",callbackFunction);
	}
	
	this.onBackButton = function(context, callbackFunction)
	{
		if(_validateDeviceAPI(context, arguments.length-1, 1, "onBackButton"))
			addlistener(context, "backbutton",callbackFunction);
	}
	
	this.onBatteryCritical = function(context, callbackFunction)
	{
		if(_validateDeviceAPI(context, arguments.length-1, 1, "onBatteryCritical"))
			addlistener(context, "batterycritical",callbackFunction);
	}
	
	this.onBatteryLow = function(context, callbackFunction)
	{
		if(_validateDeviceAPI(context, arguments.length-1, 1, "onBatteryLow"))
			addlistener(context, "batterylow",callbackFunction);
	}
	
	this.onBatteryStatusChange = function(context, callbackFunction)
	{
		if(_validateDeviceAPI(context, arguments.length-1, 1, "onBatteryStatusChange"))
			addlistener(context, "batterystatus",callbackFunction);
	}
	
	this.onMenuButton = function(context, callbackFunction)
	{
		if(_validateDeviceAPI(context, arguments.length-1, 1, "onMenuButton"))
			addlistener(context, "menubutton",callbackFunction);
	}
	
	this.onSearchButton = function(context, callbackFunction)
	{
		if(_validateDeviceAPI(context, arguments.length-1, 1, "onSearchButton"))
			addlistener(context, "searchbutton",callbackFunction);
	}	
		

} //WEvents
