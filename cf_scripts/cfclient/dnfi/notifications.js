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
 * @author P.N. Anantharaman (ananth@adobe.com)
 * this is a wrapper that invokes the underlying DNFI layer classes
 * in order to distinguish DNFI class names with the class names in the wrapper, we prepend the class name with W
 * 10 Nov 2012
 */

/*
 * Class: WNotification
 * Method: 
 		notify(action, parameters) 
 */		
	var WNotification = function() 
	{
		if(typeof navigator.notification != "undefined")
		{
		__$cf._log("Initializing Notification...");
		var self = this;
		this.successObject = new DnfiStatus('notification', dnfi.SUCCESS.code, dnfi.SUCCESS.message);		
		this.callBackStack = new Array();
		this.retVal = "";
		
		
		this.alert = function(context,message,title, buttonName)
		{
			if(_validateDeviceAPI(context, arguments.length-1, 1, "alert"))
			{
				function callback()
				{
					runCallBacks(context.cb,self.successObject,null);
				}			
			
				navigator.notification.alert(message, callback, title, buttonName);
			}
		}
		
		this.confirm = function(context,message,title, buttonName)
		{
			if(_validateDeviceAPI(context, arguments.length-1, 1, "confirm"))
			{
				function callback(btnIndex)
				{
					runCallBacks(context.cb,self.successObject,btnIndex);
				}			
			
				navigator.notification.confirm(message, callback, title, buttonName);
			}
		}
		
		/*
this.prompt = function(context,message,title, buttonName)
		{
			function callback(results)
			{
				results.buttonindex = results.buttonIndex;
				runCallBacks(context.cb,self.successObject,results);
			}			
		
			navigator.notification.prompt(message, callback, title, buttonName);
		}
*/
		
		this.beep = function(context,count)
		{
			if(_validateDeviceAPI(context, arguments.length-1, 1, "beep"))
			{
				var num = 1;
				if(typeof count != "undefined")
					num = count;
				navigator.notification.beep(num);
				runCallBacks(context.cb,self.successObject,null);
			}	
		}
		
		this.vibrate = function(context,milliseconds)
		{
			if(_validateDeviceAPI(context, arguments.length-1, 1, "vibrate"))
			{
				var num = 1;
				if(typeof milliseconds != "undefined")
					num = milliseconds;
				navigator.notification.vibrate(num);
				runCallBacks(context.cb,self.successObject,null);	
			}
		}
	}

} //WNotification
