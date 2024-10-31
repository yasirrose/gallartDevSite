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


var WAudio = function() 
{
	//we need  to check if file class is available as our audio API requires File support
	if(typeof Media != "undefined" && typeof navigator.device != "undefined" && 
			typeof navigator.device.capture != "undefined" && typeof File != "undefined")
	{
	__$cf._log("Initializing Audio...");
	var self = this;
	this.successObject = new DnfiStatus('audio', dnfi.SUCCESS.code, dnfi.SUCCESS.message);		
	this.callBackStack = new Array();	
	
	
	
	this.MEDIA_NONE = Media.MEDIA_NONE;
	this.MEDIA_STARTING = Media.MEDIA_STARTING;
	this.MEDIA_RUNNING = Media.MEDIA_RUNNING;
	this.MEDIA_PAUSED = Media.MEDIA_PAUSED;
	this.MEDIA_STOPPED = Media.MEDIA_STOPPED;
	
	this.options = new Object();
	this.options.limit = 1;
	this.options.duration = 20;
	this._initFile = false;
	
	var _init = function()
	{
		self.fileManager = cfclient.file;
		self._initFile = true;
	}
	
	var handleError = function(context,e,retVal)
	{
		var dnfiError = null;
			
		if (e.code == CaptureError.CAPTURE_INTERNAL_ERR) 
			dnfiError = new DnfiStatus('wAudio', wAudioError.CAPTURE_INTERNAL_ERROR.code, wAudioError.CAPTURE_INTERNAL_ERROR.message);
		else if(e.code == CaptureError.CAPTURE_APPLICATION_BUSY) 
			dnfiError = new DnfiStatus('wAudio', wAudioError.CAPTURE_APPLICATION_BUSY_ERROR.code, wAudioError.CAPTURE_APPLICATION_BUSY_ERROR.message);
		else if(e.code == CaptureError.CAPTURE_INVALID_ARGUMENT) 
			dnfiError = new DnfiStatus('wAudio', wAudioError.CAPTURE_INVALID_ARGUMENT_ERROR.code, wAudioError.CAPTURE_INVALID_ARGUMENT_ERROR.message);
		else if(e.code == CaptureError.CAPTURE_NO_MEDIA_FILES) 
			dnfiError = new DnfiStatus('wAudio', wAudioError.CAPTURE_NO_MEDIA_FILES_ERROR.code, wAudioError.CAPTURE_NO_MEDIA_FILES_ERROR.message);
		else if(e.code == CaptureError.CAPTURE_NOT_SUPPORTED) 
			dnfiError = new DnfiStatus('wAudio', wAudioError.CAPTURE_NOT_SUPPORTED_ERROR.code, wAudioError.CAPTURE_NOT_SUPPORTED_ERROR.message);
				
		
		if(dnfiError == null)
			dnfiError = new DnfiStatus('wAudio', wAudioError.GENERAL_ERROR.code, 
							wAudioError.GENERAL_ERROR.message);
		runCallBacks(context.cb, dnfiError, retVal);
	}
	
	/*
var syncMediaFileProperties = function(mFile)
	{
		__$cf._log(mFile.fullPath + " " + mFile.lastModifiedDate);
		mFile.fullpath = mFile.fullPath;
		mFile.lastmodifieddate = mFile.lastModifiedDate;
		if(typeof mFile.type == "undefined")
			mFile.type = ""; //add property in case absent from object
	}
*/	
	
	var getFilePathFromURL = function(str)
	{
		var tempStr = str;
		var strA;
		if (str.indexOf("file://localhost") == 0) //for ios
			strA = str.split("file://localhost");
		else 
			strA = str.split("file://");
		if (strA.length > 1) 
			tempStr = strA[1];
		
		return tempStr;
	}	
	
	var getResolvedPath = function(path,rootPath)
	{
		
		var resolvedPath = path;
		if (path != null && typeof path == 'string')
		{
			resolvedPath = getFilePathFromURL(path);					
			if (resolvedPath[0] != '/') //relative path
				resolvedPath = rootPath + "/" + resolvedPath;	//resolved path w.r.t working directory
			
		}
		return resolvedPath;
		
	}
	
	
	
	/*  this.getsupportedmodes = function(context)
	{
		var audioModes = navigator.device.capture.supportedAudioModes;
		
		runCallBacks(context.cb, self.successObject, audioModes);
	} */
	
	this.getOptions = function(context)
	{	
		runCallBacks(context.cb, self.successObject, self.options);
	}
	
	this.setOptions = function(context, opts)
	{	
		if(_validateDeviceAPI(context, this.arguments.length-1, 1, "setOptions"))
		{
			if(typeof opts != "undefined" && opts != null)
			{
				_updateProperties(self.options,opts);			
			}
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
			runCallBacks(context.cb, new DnfiStatus('WAudio', wAudioError.CALLBACK_ERROR.code, wAudioError.CALLBACK_ERROR.message), null);
		else 
		{
		
			var captureCB = function(mediaFile)
			{
				__$cf._log("Audio capture successful");
				/* 
					for (var i=0; i< mediaFile.length;i++) 
					{
						syncMediaFileProperties(mediaFile[i]);
					}
				*/
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
			
			navigator.device.capture.captureAudio(captureCB, error,captureOptions);
		}
		
	}
	
	this.createMedia = function(context, src, cbFunction)
	{
		if(_validateDeviceAPI(context, this.arguments.length-1, 1, "createMedia"))
		{
			if(typeof src != "undefined" && src != null)
			{
				var callbackFunction = null;
				if(typeof cbFunction == "string")
					callbackFunction =_getFunctionForName(cbFunction);
				else
					callbackFunction = cbFunction;
					
				if (typeof cbFunction != "undefined" && typeof callbackFunction != "function" )  
						runCallBacks(context.cb, new DnfiStatus('WAudio', wAudioError.CALLBACK_ERROR.code, wAudioError.CALLBACK_ERROR.message), null);
						
				if(! self._initFile)
					_init();
					
				function _cb(callStack, dnfistatus, retVal)
				{
					var absPath = getResolvedPath(src,retVal.root.fullPath);				
					
					function success()
					{
						__$cf._log("media success ");
					}
					
					function error(e)
					{
						__$cf._log("media error " + e.code);
						handleError(context, e, null);
					}
					
					function status(statusObj)
					{
						__$cf._log("Media status changed to " + statusObj);
						
						var argsArray = [statusObj];
						
						if(typeof callbackFunction != "undefined")
							callbackFunction.apply(callbackFunction, argsArray);
						
					}				
	
					var media = new Media(absPath, success, error, status);
					
					runCallBacks(context.cb, self.successObject, media);
				}
				
				self.fileManager.callDNFI("getFileSystem",{cb:[_cb]});
			}
		}
	}
	
	this.getCurrentPosition = function(context, media)
	{
		if(_validateDeviceAPI(context, this.arguments.length-1, 1, "getCurrentPosition"))
		{
			if(typeof media != "undefined" && media != null)
			{			
				function success(pos)
				{
					if(pos < 0)
						pos = -1;
					runCallBacks(context.cb, self.successObject, pos);
				}
				
				function error(e)
				{
					handleError(context,e, null);
				}
					
				media.getCurrentPosition(success,error);
			}
			else
				runCallBacks(context.cb, new DnfiStatus('WAudio', wAudioError.INVALID_ARGUMENT_ERROR.code, wAudioError.INVALID_ARGUMENT_ERROR.message), null);
		}
	}
	
	this.getDuration = function(context, media)
	{
		if(_validateDeviceAPI(context, this.arguments.length-1, 1, "getDuration"))
		{
			if(typeof media != "undefined" && media != null)
			{		
				var duration = media.getDuration();
				runCallBacks(context.cb, self.successObject, duration);
			}
			else
				runCallBacks(context.cb, new DnfiStatus('WAudio', wAudioError.INVALID_ARGUMENT_ERROR.code, wAudioError.INVALID_ARGUMENT_ERROR.message), null);
		}
	}
	
	this.play = function(context, src)
	{
		if(_validateDeviceAPI(context, this.arguments.length-1, 1, "play"))
		{
			if(typeof src != "undefined" && src != null)
			{
				if(! self._initFile)
						_init();
						
				function _cb(callStack, dnfistatus, retVal)
				{	
					var absPath = getResolvedPath(src, retVal.root.fullPath);
					
					var media = new Media(absPath);
										
					media.play();
				
					runCallBacks(context.cb, self.successObject, media);
				}
				if (typeof src == "string") 
				{
					//get file system root
					self.fileManager.callDNFI("getFileSystem",{cb:[_cb]});				
				}
				else 
				{	
					//we already have media object as src
					src.play();				
					runCallBacks(context.cb, self.successObject, src);
				}
				
			}
			else
				runCallBacks(context.cb, new DnfiStatus('WAudio', wAudioError.INVALID_ARGUMENT_ERROR.code, wAudioError.INVALID_ARGUMENT_ERROR.message), null);
		}		
	}
	
	this.pause = function(context, media)
	{
		if(_validateDeviceAPI(context, this.arguments.length-1, 1, "pause"))
		{
			if(typeof media != "undefined" && media != null)
			{		
				media.pause();
				
				runCallBacks(context.cb, self.successObject, null);
			}
			else
				runCallBacks(context.cb, new DnfiStatus('WAudio', wAudioError.INVALID_ARGUMENT_ERROR.code, wAudioError.INVALID_ARGUMENT_ERROR.message), null);
		}
	}
	
	this.release = function(context, media)
	{
		if(_validateDeviceAPI(context, this.arguments.length-1, 1, "release"))
		{
			if(typeof media != "undefined" && media != null)
			{			
				media.release();
				
				runCallBacks(context.cb, self.successObject, null);
			}
			else
				runCallBacks(context.cb, new DnfiStatus('WAudio', wAudioError.INVALID_ARGUMENT_ERROR.code, wAudioError.INVALID_ARGUMENT_ERROR.message), null);
		}
	}
	
	this.seekTo = function(context, media, millisecs)
	{
		if(_validateDeviceAPI(context, this.arguments.length-1, 2, "seekTo"))
		{
			if(typeof media != "undefined" && media != null)
			{			
				media.seekTo(millisecs);
				
				runCallBacks(context.cb, self.successObject, null);
			}
			else
				runCallBacks(context.cb, new DnfiStatus('WAudio', wAudioError.INVALID_ARGUMENT_ERROR.code, wAudioError.INVALID_ARGUMENT_ERROR.message), null);
		}
		
	}
	
	this.stop = function(context, media)
	{
		if(_validateDeviceAPI(context, this.arguments.length-1, 1, "stop"))
		{
			if(typeof media != "undefined" && media != null)
			{			
				media.stop();
				
				runCallBacks(context.cb, self.successObject, null);
			}
			else
				runCallBacks(context.cb, new DnfiStatus('WAudio', wAudioError.INVALID_ARGUMENT_ERROR.code, wAudioError.INVALID_ARGUMENT_ERROR.message), null);
		}
	}
	
		
	this.record = function(context, src)
	{
		if(_validateDeviceAPI(context, this.arguments.length-1, 1, "record"))
		{
			if(typeof src != "undefined" && src != null)
			{
				if(! self._initFile)
					_init();
					
				function _cb(callStack, dnfistatus, retVal)
				{
					
					var absPath = getRelativePath(src, retVal.root.fullPath);
					
					function success(mediaFile)
					{
						__$cf._log("Record to file success");
						//runCallBacks(context.cb, self.successObject, mediaFile);
					}
					
					function error(e)
					{
						handleError(context,e, null);
					}
					
					var media = new Media(absPath, success, error);
										
					media.startRecord();
					
					runCallBacks(context.cb, self.successObject, media);
				}			
				
				if (typeof src == "string") 
				{
					//get file systemroot
					self.fileManager.callDNFI("getFileSystem",{cb:[_cb]});				
				}
				else 
				{	
					//we already have media object as src
					src.startRecord();				
					runCallBacks(context.cb, self.successObject, src);
				}
			}
			else
				runCallBacks(context.cb, new DnfiStatus('WAudio', wAudioError.INVALID_ARGUMENT_ERROR.code, wAudioError.INVALID_ARGUMENT_ERROR.message), null);
		}
	}
	
	this.stopRecording = function(context, media)
	{
		if(_validateDeviceAPI(context, this.arguments.length-1, 1, "stopRecording"))
		{
			if(typeof media != "undefined" && media != null)
			{				
				media.stopRecord();
				__$cf._log("stopped recording");
				runCallBacks(context.cb, self.successObject, null);
			}
			else
				runCallBacks(context.cb, new DnfiStatus('WAudio', wAudioError.INVALID_ARGUMENT_ERROR.code, wAudioError.INVALID_ARGUMENT_ERROR.message), null);
		}
		
	}
	
}
	

} //WAudio
