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
 * @author sandeepp
 */

/*
 * Class: WSplashScreen
 */		
	var WSplashScreen = function() 
	{
		if(typeof navigator.splashscreen != "undefined")
		{
		__$cf._log("Initializing SplashScreen...");
		var self = this;
		var MAX_SHOW_TIME = 10000; //10seconds
		this.successObject = new DnfiStatus('splashscreen', dnfi.SUCCESS.code, dnfi.SUCCESS.message);		
		this.callBackStack = new Array();
		this.retVal = "";
		
		this.show = function(context,milliseconds)
		{			
			navigator.splashscreen.show();
			
			if(typeof milliseconds != "undefined" && milliseconds < MAX_SHOW_TIME)
			{
				setTimeout(function() {
				    navigator.splashscreen.hide();
				}, milliseconds);
			}
			runCallBacks(context.cb, self.successObject, null);
		}
		
		this.hide = function(context)
		{
			navigator.splashscreen.hide();
			runCallBacks(context.cb, self.successObject, null);
		}	
	}

} //WSplashScreen
