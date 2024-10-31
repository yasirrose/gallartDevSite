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

/*
You must use to communicate between the Cordova JavaScript and native environments is the cordova.exec function as below:

cordova.exec(function(winParam) {}, function(error) {}, "service",
             "action", ["firstArgument", "secondArgument", 42,
             false]);
*/

dBoxAuthenticated = false; //on successful authentication this will be set to true - this is a global variable

WCloudManager = function()
{
	__$cf._log("in WCloudManager");
	var self = this;
	this.callBackStack = new Array();
	this.retVal = "";
	this.successObject = new DnfiStatus('WCloudManager', dnfi.SUCCESS.code, dnfi.SUCCESS.message);
		
	//this is a simple echo function to test the plugin model
	this.pEcho = function(str, callback) {
    	cordova.exec(callback, function(err) {
    		//alert(err.code);
        	callback('Nothing to echo.');
    	}, "CloudManager", "echo", [str]);
	};
	

	this.pDropBoxAuthenticate = function(callback, fail) {
		__$cf._log("in JS authenticate()");
    	cordova.exec(callback, fail, "CloudManager", "authenticate", []);
	};
	
	
	this.pUpload = function(callback, fail, dest, src) {
		__$cf._log("in JS upload()");
    	cordova.exec(callback, fail, "CloudManager", "upload", [dest, src]);
	};
	
	
	this.pDownload = function(callback, fail, dest, src) {
		__$cf._log("in JS download()");
    	cordova.exec(callback, fail, "CloudManager", "download", [dest, src]);
	};
	
	this.isDropBoxAuthenticated = function()
	{
		return dBoxAuthenticated;
	}
	
	this.dropBoxAuthenticate = function(context) {
		self.callBackStack = context.cb;
		self.retVal = context.ret;
		if (self.isDropBoxAuthenticated())
		{
			__$cf._log("dropBox already authenticated");
			runCallBacks(self.callBackStack, self.successObject, true);				
			return;				
		}
		
		self.pDropBoxAuthenticate(function() 
			{
				dBoxAuthenticated = true; 
				//alert("authenticated");
				__$cf._log("dropBox authenticated now");
				runCallBacks(self.callBackStack, self.successObject, true);				
				return;								
			}, function() {
					__$cf._log("DropBox Authentication Failed");
					runCallBacks(self.callBackStack, new DnfiStatus(wCloudManagerError.AUTHENTICATION_ERROR.code, wCloudManagerError.AUTHENTICATION_ERROR.message));				
				});
		return;
	}
	
	this.dropBoxUpload = function(context, dest, src)
	{
		var upload_f = function(context) {
			self.callBackStack = context.cb;
			self.retVal = context.ret;
			self.pUpload(function() {
					//alert("upload success");
					runCallBacks(self.callBackStack, self.successObject, true);								
				}, function(e) {
					//alert("upload fail" + e);
					runCallBacks(self.callBackStack, new DnfiStatus(wCloudManagerError.UPLOAD_ERROR.code, wCloudManagerError.UPLOAD_ERROR.message));				
				}, dest, src);
		};
		
		if (self.isDropBoxAuthenticated())
		{
			__$cf._log("Upload function - dropBox already authenticated");
			upload_f(context);
			return;				
		}
		else
		{
			self.dropBoxAuthenticate({cb: [function(e) {
				__$cf._log("calling dropBoxAuthenticate within cloud.js constructor");
				self.callBackStack = context.cb;
				self.retVal = context.ret;
				if (e.code == dnfi.SUCCESS.code)
				{
					//we can now perform other operations like load etc
					__$cf._log("Authentication Successful - cloud.js");
					upload_f(context);
					return;											
				}
				else
				{
					__$cf._log("Authentication Failed");
					runCallBacks(self.callBackStack, e);									
				}
			}], ret:"ret"});
		}
	}
	
	this.dropBoxDownload = function(context, dest, src)
	{
		var download_f = function(context) {
			self.callBackStack = context.cb;
			self.retVal = context.ret;
			self.pDownload(function() {
					//alert("download success");
					runCallBacks(self.callBackStack, self.successObject, true);								
				}, function(e) {
					//alert("download fail" + e);
					runCallBacks(self.callBackStack, new DnfiStatus(wCloudManagerError.DOWNLOAD_ERROR.code, wCloudManagerError.DOWNLOAD_ERROR.message));				
				}, dest, src);
		};
		
		if (self.isDropBoxAuthenticated())
		{
			__$cf._log("Download function - dropBox already authenticated");
			download_f(context);
			return;				
		}
		else
		{
			self.dropBoxAuthenticate({cb: [function(e) {
				__$cf._log("calling dropBoxAuthenticate within cloud.js constructor");
				self.callBackStack = context.cb;
				self.retVal = context.ret;
				if (e.code == dnfi.SUCCESS.code)
				{
					//we can now perform other operations like load etc
					__$cf._log("Authentication Successful - cloud.js");
					download_f(context);
					return;											
				}
				else
				{
					__$cf._log("Authentication Failed");
					runCallBacks(self.callBackStack, e);									
				}
			}], ret:"ret"});
		}
	}

	return self;	
}