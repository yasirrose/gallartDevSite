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


var WVideo = function() 
{
	if(typeof navigator.device != "undefined" && typeof navigator.device.capture != "undefined")
	{
	__$cf._log("Initializing Video...");
	var self = this;
	this.successObject = new DnfiStatus('video', dnfi.SUCCESS.code, dnfi.SUCCESS.message);		
	this.callBackStack = new Array();
	
	this.options = new Object();
	this.options.limit = 1;
	this.options.duration = 20;
	
	var handleError = function(context,e,retVal)
	{
		var dnfiError = null;
			
		if (e.code == CaptureError.CAPTURE_INTERNAL_ERR) 
			dnfiError = new DnfiStatus('wVideo', wVideoError.CAPTURE_INTERNAL_ERROR.code, wVideoError.CAPTURE_INTERNAL_ERROR.message);
		else if(e.code == CAPTURE_APPLICATION_BUSY) 
			dnfiError = new DnfiStatus('wVideo', wVideoError.CAPTURE_APPLICATION_BUSY_ERROR.code, wVideoError.CAPTURE_APPLICATION_BUSY_ERROR.message);
		else if(e.code == CAPTURE_INVALID_ARGUMENT) 
			dnfiError = new DnfiStatus('wVideo', wVideoError.CAPTURE_INVALID_ARGUMENT_ERROR.code, wVideoError.CAPTURE_INVALID_ARGUMENT_ERROR.message);
		else if(e.code == CAPTURE_NO_MEDIA_FILES) 
			dnfiError = new DnfiStatus('wVideo', wVideoError.CAPTURE_NO_MEDIA_FILES_ERROR.code, wVideoError.CAPTURE_NO_MEDIA_FILES_ERROR.message);
		else if(e.code == CAPTURE_NOT_SUPPORTED) 
			dnfiError = new DnfiStatus('wVideo', wVideoError.CAPTURE_NOT_SUPPORTED_ERROR.code, wVideoError.CAPTURE_NOT_SUPPORTED_ERROR.message);
				
		
		if(dnfiError == null)
			dnfiError = new DnfiStatus('wVideo', wVideoError.GENERAL_ERROR.code, 
							wVideoError.GENERAL_ERROR.message);
		runCallBacks(context.cb, dnfiError, retVal);
	}
	
	/*var syncMediaFileProperties = function(mFile)
	{
		mFile.fullpath = mFile.fullPath;
		mFile.lastmodifieddate = mFile.lastModifiedDate;
		if(typeof mFile.type == "undefined")
			mFile.type = ""; //add property in case absent from object
	}*/	
	
	/* this.getsupportedmodes = function(context)
	{
		var videoModes = navigator.device.capture.supportedVideoModes;
		
		runCallBacks(context.cb, self.successObject, videoModes);
	}*/
	
	this.getOptions = function(context)
	{			
		runCallBacks(context.cb, self.successObject, self.options);
	}
	
	this.setOptions = function(context, opts)
	{	
		if(_validateDeviceAPI(context, arguments.length-1, 1, "setOptions"))
		{
			if(typeof opts != "undefined" && opts != null)
				_updateProperties(self.options,opts);
				
			runCallBacks(context.cb, self.successObject, null);
		}
	}
	
	this.capture = function(context, opts, cbFunction)
	{
		var captureOptions = self.options;
		
		if(typeof opts != "undefined" && opts != null)
			_updateProperties(captureOptions,opts);
		
		var callbackFunction = null;
		if(typeof cbFunction == "string")
			callbackFunction =_getFunctionForName(cbFunction);
		else
			callbackFunction = cbFunction;
		
		if (typeof cbFunction != "undefined" && typeof callbackFunction != "function" ) 
			runCallBacks(context.cb, new DnfiStatus('WVideo', wVideoError.CALLBACK_ERROR.code, wVideoError.CALLBACK_ERROR.message), null);
		else 
		{
		
			var captureCB = function(mediaFile)
			{
				__$cf._log("Video capture successful");
				console.log(typeof callbackFunction);
				/*for (var i=0; i< mediaFile.length;i++) 
				{
					syncMediaFileProperties(mediaFile[i]);
				}*/
				if (typeof callbackFunction == "function") 
				{
					var argsArray = [mediaFile];		
					callbackFunction.apply(callbackFunction,argsArray);
				}
				else 
					runCallBacks(context.cb, self.successObject, mediaFile);
			}
			
			function error(e)
			{
				handleError(context, e, null);
			}
			
			navigator.device.capture.captureVideo(captureCB, error,captureOptions);
		}
		
	}
	}

} //WVideo
