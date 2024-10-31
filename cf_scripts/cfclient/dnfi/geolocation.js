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
 * 13 Nov 2012
 */

/**************************************************************************************************************************************
 * Class: WGeoLocation
 		
	Note:
		This class currently returns the position object that has latitude, longitude etc.
		It may make more sense in some situations to return the name, address of the location.
		if we need that functionality, we need to use some web service to get the location name - B feature for now!
 **************************************************************************************************************************************/		
	var WGeoLocation = function()
	{
		if(typeof navigator.geolocation != "undefined")
		{
		
		__$cf._log("Initializing GeoLocation...");		
		var self = this;
		this.successObject = new DnfiStatus('geolocation', dnfi.SUCCESS.code, dnfi.SUCCESS.message);		
		this.options = {"enableHighAccuracy": false,"maximumAge":3000,"timeout":10000}; //set this as the default to take care of Android quirk
		
		
	var handleError = function(context,e,retVal)
	{
		var dnfiError = null;
			
		if (e.code == PositionError.PERMISSION_DENIED) 
			dnfiError = new DnfiStatus('WGeoLocation', wGeoLocationError.PERMISSION_DENIED_ERROR.code, wGeoLocationError.PERMISSION_DENIED_ERROR.message);
		else if(e.code == PositionError.POSITION_UNAVAILABLE) 
			dnfiError = new DnfiStatus('WGeoLocation', wGeoLocationError.POSITION_UNAVAILABLE_ERROR.code, wGeoLocationError.POSITION_UNAVAILABLE_ERROR.message);
		else if(e.code == PositionError.TIMEOUT) 
			dnfiError = new DnfiStatus('WGeoLocation', wGeoLocationError.TIMEOUT_ERROR.code, wGeoLocationError.TIMEOUT_ERROR.message);
				
		
		if(dnfiError == null)
			dnfiError = new DnfiStatus('WGeoLocation', wGeoLocationError.GENERAL_ERROR.code, 
								wGeoLocationError.GENERAL_ERROR.message);
		runCallBacks(context.cb, dnfiError, retVal);
	}
	
	/*
	var adjustcase = function(position)
	{
		position.coords.altitudeaccuracy = position.coords.altitudeAccuracy;
	}
	*/
		
	/* **********************************************************************************************************
  		* setting geoLocationOptions
	*************************************************************************************************************/
		this.setOptions = function(context, opts)
		{
			if(_validateDeviceAPI(context, arguments.length-1, 1, "setOptions"))
			{
				if (typeof opts != "undefined" && opts != null) 
				{
					_updateProperties(self.options,opts);					
					runCallBacks(context.cb, self.successObject, null);
					
				}
				else 
				{
					runCallBacks(context.cb, new DnfiStatus('WGeoLocation', wGeoLocationError.INVALID_ARGUMENT_ERROR.code, 
								wGeoLocationError.INVALID_ARGUMENT_ERROR.message), null);
				}	
			}
		}		
		
		this.getOptions = function(context)
		{
			/*
			self.options.maximumage = self.options.maximumAge;
			self.options.enablehighaccuracy = self.options.enableHighAccuracy;
			*/ 
			runCallBacks(context.cb, self.successObject, self.options);
		}
	/* ----------------------------------------------------------------------------------------------------------------------
 	* getCurrentPosition(context, opts)
 	------------------------------------------------------------------------------------------------------------------------*/		
		this.getCurrentPosition = function(context, opts) {
			var successcb = function(pos) {
				__$cf._log("got current position");
				//adjustcase(pos);
				runCallBacks(context.cb, self.successObject, pos);
				return;
			};
			var failcb = function(e) {
				__$cf._log("get current position error, code = " + e.code + ", message = " + e.message)
				handleError(context,e,null);
				
				return;
			};
			var tempOptions = self.options;
			if(typeof opts != "undefined" && opts != null)
				_updateProperties(tempOptions,opts);
				
			navigator.geolocation.getCurrentPosition(successcb, failcb, tempOptions);
		}
	/* ----------------------------------------------------------------------------------------------------------------------
 	* watchCurrentPosition(context, cb, opts)
 	Note: We need to pass a separate callback function cb that can handle the change in geolocation
 	------------------------------------------------------------------------------------------------------------------------*/		
		this.watchPosition = function(context, cbObj, opts) 
		{
			if(_validateDeviceAPI(context, arguments.length-1, 1, "watchPosition"))
			{
				var failcb = function(e) 
				{
					__$cf._log("watch position error, code = " + e.code + ", message = " + e.message)
					handleError(context,e,null);
					return;
				};
				var tempOptions = self.options;
				if(typeof opts != "undefined" && opts != null)
					_updateProperties(tempOptions,opts);
				
				var callbackFunction = null;
				if(typeof cbObj == "string")
					callbackFunction =_getFunctionForName(cbObj);
				else
					callbackFunction = cbObj;
					
				var _cb = function(pos)
				{
					if(typeof pos.coords.altitudeAccuracy != "undefined")
						pos.coords.altitudeaccuracy = pos.coords.altitudeAccuracy;
	
					var argsArray = [pos];		
					callbackFunction.apply(cbObj,argsArray);
				}
				if (typeof callbackFunction == "function") 
				{
					var watchId = navigator.geolocation.watchPosition(_cb, failcb, tempOptions)
					runCallBacks(context.cb, self.successObject, watchId);
				}
				else
				{
					runCallBacks(context.cb, new DnfiStatus('WGeoLocation', wGeoLocationError.CALLBACK_ERROR.code, 
														wGeoLocationError.CALLBACK_ERROR.message),null);
				}
				return;
			}
		}
	/* ----------------------------------------------------------------------------------------------------------------------
 	* clearWatch(context, wId)
 	------------------------------------------------------------------------------------------------------------------------*/		
		this.clearWatch = function(context, wId) 
		{
			if(_validateDeviceAPI(context, arguments.length-1, 1, "clearWatch"))
			{
				navigator.geolocation.clearWatch(wId)
				runCallBacks(context.cb, self.successObject,null);
				return;
			}
		}
	}	
} //WGeoLocation
	
