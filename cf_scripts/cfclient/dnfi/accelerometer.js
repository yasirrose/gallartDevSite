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
 * Class: WAccelerometer
 */		
	var WAccelerometer = function() 
	{
		if(typeof navigator.accelerometer != "undefined")
		{
		__$cf._log("Initializing Accelerometer...");
		var self = this;
		this.successObject = new DnfiStatus('accelerometer', dnfi.SUCCESS.code, dnfi.SUCCESS.message);		
		this.callBackStack = new Array();
		this.retVal = "";
		
		this.options = new Object();
		this.options.frequency = 10000;
		
		this.clearWatch = function(context, wId) 
		{
			if(_validateDeviceAPI(context, this.arguments.length-1, 1, "clearWatch"))
			{
				navigator.accelerometer.clearWatch(wId)
				runCallBacks(context.cb, self.successObject,null);
				return;
			}
			
		}
		
		this.getOptions = function(context)
		{			
			runCallBacks(context.cb, self.successObject, self.options);
		}
		
		this.setOptions = function(context, opt)
		{
			if(_validateDeviceAPI(context, this.arguments.length-1, 1, "setOptions"))
			{
				if (opt != null) 
				{
					_updateProperties(self.options,opt);
						
					runCallBacks(context.cb, self.successObject, null);
					
				}
				else 
				{
					runCallBacks(context.cb, new DnfiStatus('wAccelerometerError', wAccelerometerError.INVALID_ARGUMENT_ERROR.code, 
								wAccelerometerError.INVALID_ARGUMENT_ERROR.message), null);
				}	
			}
		}	
		
		this.watch = function(context, cbFunction, opts) 
		{
			if(_validateDeviceAPI(context, this.arguments.length-1, 1, "watch"))
			{
				var callbackFunction = null;
				if(typeof cbFunction == "string")
					callbackFunction =_getFunctionForName(cbFunction);
				else
					callbackFunction = cbFunction;
					
				if (typeof cbFunction != "undefined" && typeof callbackFunction != "function" )  
						runCallBacks(context.cb, new DnfiStatus('wAccelerometer', wAccelerometerError.CALLBACK_ERROR.code, wAccelerometerError.CALLBACK_ERROR.message), null);
						
				var accelerometerOptions = self.options;
						
				if(typeof opts != "undefined" && opts != null)
				{
					_updateProperties(accelerometerOptions,opts);
				}
				
				var failcb = function(e) 
				{
					__$cf._log("watch acceleration error, code = " + e.code + ", message = " + e.message)
					handleError(context,e,null);
					return;
				};			
				
				var _cb = function(acceleration)
				{
					var argsArray = [acceleration];		
					
					if(typeof callbackFunction != "undefined")
							callbackFunction.apply(callbackFunction, argsArray);
				}
				
				var watchId = navigator.accelerometer.watchAcceleration(_cb, failcb, accelerometerOptions);
				runCallBacks(context.cb, self.successObject, watchId);
			}			
		}
	}

} //WAccelerometer
