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

/*
 * Class: WDevice
 * Methods: (to be modeled along CRUD)
 	getProperty(propertyName)
 	propertyName can be:
 		connection | name | cordova | platform | uuid | version 
 */		
	var WDevice = function(){

		var self = this;
		this.successObject = new DnfiStatus('device', dnfi.SUCCESS.code, dnfi.SUCCESS.message);		
	/* ----------------------------------getProperty---------------------------------------------------------------------------
				getProperty(propertyName)
	-------------------------------------------------------------------------------------------------------------------- */
		this.getProperty = function(context, prop)
		{
			var property;
			if (prop == "connection") property = navigator.network.connection.type;
			else property = eval("device." + prop);
			runCallBacks(context.cb, self.successObject, property);			
		}		
	} //WDevice
	
