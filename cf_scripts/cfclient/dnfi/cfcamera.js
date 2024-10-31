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
 * thus, WCamera would invoke Camera class from DNFI layer. It is the job of the code generator from CF server to convert Camera() from 
 * the code embedded in Cfclient to WCamera
 * 2 Aug 2012
 */

/*
 * Class: WCamera
 * Methods:
 * 		getPicture()
 * 		savePicture(imgObject)
 * 		getPictureAndSave()
 * 		cleanUp()
 */

	//loadedWCamera = true;
		
var WCamera = function()
{
	if(typeof Camera != "undefined" && typeof navigator.camera != "undefined")
	{
	__$cf._log("Initializing Camera...");
		var self = this;
		this.successObject = new DnfiStatus('camera', dnfi.SUCCESS.code, dnfi.SUCCESS.message);		
		this.callBackStack = new Array();
		//this.retVal = "";
		// the var statements below define the properties of the object
		
		this.source = {
			type: Camera.PictureSourceType.CAMERA,
			provider: 'camera',
			url: null,
			path: null,
			name: null,
			authKey: ''
		};
		this.destination = {
			type: 'local',
			provider: '',
			url: '',
			path: null,
			name: null,
			authKey: ''
		};
		this.options = {};
		this.options.allowEdit = false;
		this.options.encodingType = Camera.EncodingType.JPEG;
		this.options.correctOrientation = false;
		this.options.quality= 75; 
		this.options.saveToPhotoAlbum = false;
		this.options.popoverOptions = new CameraPopoverOptions(300,300,100,100,Camera.PopoverArrowDirection.ARROW_ANY);
		
		if(typeof Camera.Direction != "undefined")
		{
			this.FRONT = Camera.Direction.FRONT;
			this.BACK = Camera.Direction.BACK;
		}
		
		
var getPictureFromSource = function(context,source, params, base64)
		{
			var camOpts = self.options;
						
			
			if (typeof params != "undefined" && params != null) 
			{
				_updateProperties(camOpts,params);	
				if (typeof camOpts.encodingType == "string") 
				{
					if(camOpts.encodingType.toLowerCase() == "jpeg")
						camOpts.encodingType = Camera.EncodingType.JPEG;
					else if(camOpts.encodingType.toLowerCase() == "png")
						camOpts.encodingType = Camera.EncodingType.PNG;	
				}
			}
							
			if(base64)
					camOpts.destinationType = Camera.DestinationType.DATA_URL;
				else
					camOpts.destinationType = Camera.DestinationType.FILE_URI;
				
			if(source == "camera")
			{
				camOpts.sourceType = Camera.PictureSourceType.CAMERA;					
				__$cf._log("getting the image from device's camera");				
			}
			else if (source == "album")
			{
				camOpts.sourceType = Camera.PictureSourceType.SAVEDPHOTOALBUM;					
				__$cf._log("getting the image from album");
				
			}
			else if (source == "library")
			{
				camOpts.sourceType = Camera.PictureSourceType.PHOTOLIBRARY;					
				__$cf._log("getting the image from photo library");
				
			}
			
			navigator.camera.getPicture(function(imgData)
				{				
					runCallBacks(context.cb, self.successObject, imgData);
				}, function(mess)
				{
					__$cf._log("Camera Error - "+mess);
					self.returnError(context,new DnfiStatus('camera', wCameraError.GENERAL_ERROR, mess));
				}
				, camOpts);
		}
		
		this.setOptions = function(context, opts)
		{
			if(_validateDeviceAPI(context, this.arguments.length-1, 1, "setOptions"))
			{
				if(typeof opts != "undefined")
				{
					_updateProperties(self.options,opts);			
								
					if (typeof opts.encodingType == "string") 
					{				
						if(opts.encodingType.toLowerCase() == "jpeg")
							self.options.encodingType = Camera.EncodingType.JPEG;
						else if(opts.encodingType.toLowerCase() == "png")
							self.options.encodingType = Camera.EncodingType.PNG;
					}
				}
				runCallBacks(context.cb, self.successObject, null);
			}
		}
		
		this.getOptions = function(context)
		{
			p = {};
			
			_updateProperties(p,self.options);			
			
			if(self.options.encodingType == Camera.EncodingType.JPEG)
				p.encodingType = "jpeg";
			else if(self.options.encodingType == Camera.EncodingType.PNG)
				p.encodingType = "png";
			
			runCallBacks(context.cb, self.successObject, p);
		}
		
/* ----------------------------------------------------------------------------------------------------------------------
 * getPicture(context, src, params)
 ------------------------------------------------------------------------------------------------------------------------
 */		
		// context has the form: {ret:retVarName, cb:callbackstack}, we may add more fields later to the context
		// dest, src, params are objects that map in to the corresponding properties of the WCamera object 
		
		this.getPicture = function (context, params, base64) 
		{			
			getPictureFromSource(context,"camera", params,base64);
		}
		
		this.getPictureFromAlbum = function (context, params, base64) 
		{
			getPictureFromSource(context,"album", params,base64);
		}
		
		this.getPictureFromPhotoLibrary = function (context, params, base64) 
		{
			getPictureFromSource(context,"library", params,base64);
		}
		
		
		

/* -----------------------------------------------------------------------------------------------------------------------
 * cleanUp() - doesn't work on Android
 * --------------------------------------------------------------------------------------------------------------------*/
		this.cleanup = function(context)
		{
			if (typeof navigator.camera.cleanup != "undefined") 
			{
				navigator.camera.cleanup(function()
				{
					//self.callBackStack = context.cb;
					//					self.retVal = context.ret;
					runCallBacks(context.cb, successObject);
				}, function(mess)
				{
					self.returnError(context, new DnfiStatus('camera', wCameraError.GENERAL_ERROR, mess));
				});
			}
			else
				runCallBacks(context.cb, new DnfiStatus('camera', wCameraError.UNSUPPORTED_OPERATION_ERROR.code, 
								wCameraError.UNSUPPORTED_OPERATION_ERROR.message),null);
		}
	
	
		this.cameraError = function (mess)
		{
			//alert("error in getPicture(): " + mess);
			//need to find context here
			self.returnError(context,new DnfiStatus('camera', wCameraError.GENERAL_ERROR, mess));
		}
		
		this.returnError = function (context,e)
		{
			runCallBacks(context.cb, e, null);
		}

		this.toString = function() 
		{
			return("WCamera");
		}
	}
		//return null;
} //WCamera
	
