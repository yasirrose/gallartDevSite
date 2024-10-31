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


var WLocalStorage = function() 
{
	if(typeof window.localStorage != "undefined")
	{
	__$cf._log("Initializing LocalStorage...");
	var self = this;
	this.successObject = new DnfiStatus('localstorage', dnfi.SUCCESS.code, dnfi.SUCCESS.message);		
	this.callBackStack = new Array();
	this.retVal = "";
		
		
	/*
this.getkey = function(context,index)
	{
		var keyname = window.localStorage.key(index);
		runCallBacks(context.cb,self.successObject,keyname);
	}
*/
	
	this.getItem = function(context,key)
	{
		if(_validateDeviceAPI(context, arguments.length-1, 1, "getItem"))
		{
			var tempKey = key;
			if(typeof key == "string")
				tempKey = tempKey.toLowerCase();
			
			var item = window.localStorage.getItem(tempKey);
			runCallBacks(context.cb,self.successObject,item);
		}
	}
	
	this.setItem = function(context,key,value)
	{
		if(_validateDeviceAPI(context, arguments.length-1, 2, "setItem"))
		{
			var tempKey = key;
			if(typeof key == "string")
				tempKey = tempKey.toLowerCase();
			window.localStorage.setItem(tempKey, value);
			runCallBacks(context.cb,self.successObject,null);
		}
	}
	
	this.removeItem = function(context,key)
	{
		if(_validateDeviceAPI(context, arguments.length-1, 1, "removeItem"))
		{
			var tempKey = key;
			if(typeof key == "string")
				tempKey = tempKey.toLowerCase();
			window.localStorage.removeItem(tempKey);
			runCallBacks(context.cb,self.successObject,null);
		}
	}
	
	this.clear = function(context)
	{
		window.localStorage.clear();
		runCallBacks(context.cb,self.successObject,null);
	}
		
		
	}
} //WLocalStorage
