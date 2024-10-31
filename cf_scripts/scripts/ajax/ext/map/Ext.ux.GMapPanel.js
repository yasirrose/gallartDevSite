/*
 * Ext JS Library 2.2
 * Copyright(c) 2006-2008, Ext JS, LLC.
 * licensing@extjs.com
 * 
 * http://extjs.com/license
 */

/**
 * @author Shea Frederick
 */

Ext.namespace('Ext.ux');
 
/**
 *
 * @class GMapPanel
 * @extends Ext.Panel
 */
Ext.ux.GMapPanel = Ext.extend(Ext.Panel, {
    initComponent : function(){
        
       var defConfig = {
            plain: true,
            zoomLevel: 3,
            yaw: 180,
            pitch: 0,
            zoom: 0,
            gmapType: 'map',
            border: false
        }; 
        Ext.applyIf(this,defConfig); 
        
        Ext.ux.GMapPanel.superclass.initComponent.call(this);        

    },
    afterRender : function(){
        
        var wh = this.ownerCt.getSize();
        Ext.applyIf(this, wh);
        this.parsedMapType = this.parseMapType(this.gmapType); 
		Ext.ux.GMapPanel.superclass.afterRender.call(this);    
        this.gmap = new GMap2(this.body.dom);

        GEvent.bind(this.gmap, 'load', this, function(){
            this.onMapReady();
        });
         
        if (typeof this.setCenter === 'object') {
            if (typeof this.setCenter.geoCodeAddr === 'string'){
                this.geoCodeLookup(this.setCenter.geoCodeAddr);
            }else{
                if (this.setCenter.lat && this.setCenter.lng){
                    var point = new GLatLng(this.setCenter.lat,this.setCenter.lng);
					this.gmap.setCenter(point, this.zoomLevel, this.parsedMapType);    
                }
				if (typeof this.setCenter.marker === 'object' && typeof point === 'object' && this.noCenterMarker === false){

					this.addMarker(point,this.setCenter.marker,this.setCenter.marker.clear, false, this.setCenter.listeners);
                }
            }
        }

    },
    onMapReady : function(){
        if (this.advanceMapTypeControl == true) 
		{
			this.getMap().addMapType(G_PHYSICAL_MAP);
			this.getMap().addMapType(G_SATELLITE_3D_MAP);
		}
        this.addMarkers(this.markers);
        this.addMapControls();
        this.addOptions();
		if (typeof this.onLoadhandler === 'function') {
			this.onLoadhandler.call(null, this.name);
		}  
    },
    onResize : function(w, h){

        if (typeof this.getMap() == 'object') {
            this.gmap.checkResize();
        }
        
        Ext.ux.GMapPanel.superclass.onResize.call(this, w, h);

    },
    setSize : function(width, height, animate){
        
        if (typeof this.getMap() == 'object') {
            this.gmap.checkResize();
        }
        
        Ext.ux.GMapPanel.superclass.setSize.call(this, width, height, animate);
        
    },
    getMap : function(){
        
        return this.gmap;
        
    },
    getCenter : function(){
        
        return this.getMap().getCenter();
        
    },
    getCenterLatLng : function(){
        
        var ll = this.getCenter();
        return {lat: ll.lat(), lng: ll.lng()};
        
    },
    addMarkers : function(markers) {   
		this.addMarkerInProcess = false;
        this.markers = markers;
		if (Ext.isArray(markers)) {	
			for (var i = 0; i < markers.length; i++ ) {
				if (markers[i].lat && markers[i].lng) {
					var mkr_point = new GLatLng(markers[i].lat, markers[i].lng);
					this.addMarker(mkr_point, markers[i].marker, false, markers[i].setCenter, markers[i].listeners);
				}
				else 
					if (typeof markers[i].address === 'string') {							
						this.addMarkerInProcess = true;
						this.geoLatiLongiLookup(markers[i].address, i);
					}
			}
		}
        
    },
    addMarker : function(point, marker, clear, center, listeners){		

		//Ext.applyIf(marker,G_DEFAULT_ICON);  Old approach.. Now We are creating a Gicon class and adding title..	
		if(marker.markercolor != null && typeof marker.markercolor != 'undefined')
			marker.icon = MapIconMaker.createMarkerIcon({width: 32, height: 32, primaryColor: marker.markercolor });
		else		
			marker.icon = new GIcon(G_DEFAULT_ICON, marker.markericon);


		// Initially latLangitude bound will not be defined. While adding first marker 
		// this will be null. So we will initilize it. We need to keep count of marker added,
		// so that we can set the right zoom level once all marker are added.
		if(!this.latLongBound)
		{
			this.latLongBound = new GLatLngBounds();
			this.markerAddedCount = 0;		
		}
		this.latLongBound.extend(point);
		this.markerAddedCount++;

        if (clear === true){
            this.getMap().clearOverlays();
			this.latLongBound = null;
        }
        if (center === true) {
            this.getMap().setCenter(point, this.zoomLevel, this.parsedMapType);
        }
        if (!(center && this.noCenterMarker === true)) {
		   	var mark = new GMarker(point, marker);
			var scopeObj = {marker:mark, bindcallback:marker.bindcallback, name:marker.name, statictext: marker.markerwindowcontent, address:marker.address};
			if (typeof listeners === 'object') {
		   		for (evt in listeners) {
		   			GEvent.bind(mark, evt, scopeObj, listeners[evt]);
		   		}
		   	}
			this.getMap().addOverlay(mark);
	   }
	   
	   if(this.showAllMarker && this.markers.length > 0 && this.markerAddedCount > this.markers.length)
	   {
			//Bugid:78545, If zoomlevel is set to lower value then showallmarker should not optimize it 
			// to higher value. Ideally, showallmarker should only lower the zoomlevel if required to
			// accomodate all markers.			
			var optimalZoomLevel = this.getMap().getBoundsZoomLevel(this.latLongBound);
			if (optimalZoomLevel <= this.zoomLevel) {
				this.getMap().setZoom(optimalZoomLevel);
				this.getMap().setCenter(this.latLongBound.getCenter());
			}
	   	
	   }
    },
    addMapControls : function(){
        
	    if (Ext.isArray(this.mapControls)) {
	        for(i=0;i<this.mapControls.length;i++){
				this.addMapControl(this.mapControls[i]);
	        }
	    }else if(typeof this.mapControls === 'string'){
	        this.addMapControl(this.mapControls);
	    }else if(typeof this.mapControls === 'object'){
	        this.getMap().addControl(this.mapControls);
	    }
	}
        
    ,
	addEventToMap : function (event, listener,scope)
	{
		if(scope == null || typeof scope == 'undefined')
			scope = this.getMap();
		GEvent.bind(this.getMap(), event, scope, listener);
	},
    addMapControl : function(mc){      
        var mcf = window[mc];
        if (typeof mcf === 'function') {
			this.getMap().addControl(new mcf());
        }    
        
    },
    addOptions : function(){
        
        if (Ext.isArray(this.mapConfOpts)) {
            var mc;
            for(i=0;i<this.mapConfOpts.length;i++){
                this.addOption(this.mapConfOpts[i]);
            }
        }else if(typeof this.mapConfOpts === 'string'){
            this.addOption(this.mapConfOpts);
        }        
        
    },
    addOption : function(mc){
        
        var mcf = this.getMap()[mc];
        if (typeof mcf === 'function') {
            this.getMap()[mc]();
        }    
        
    },
	parseMapType : function(mapType){
		if (!mapType || typeof mapType != 'string') {
			// Log Error 
			return G_NORMAL_MAP;
		}
		mapType = mapType.toUpperCase();
		if(mapType === 'SATELLITE')
			return G_SATELLITE_MAP;
		if(mapType === 'MAP')
			return G_NORMAL_MAP;
		if(mapType === 'HYBRID')
			return G_HYBRID_MAP;						
		if(mapType === 'EARTH')
			return G_SATELLITE_3D_MAP;
		if(mapType === 'TERRAIN')
			return G_PHYSICAL_MAP;
	},
	
    geoLatiLongiLookup : function(addr, markerIndex) {
        
        this.geocoder = new GClientGeocoder();
        var markerObject = this.markers[markerIndex];
		markerObject.parent = this;
		this.geocoder.getLatLng(addr, this.addMarkerToMapCallBack.createDelegate(markerObject));
        
    },
	addMarkerToMapCallBack: function(latlngObject){
	
		if (latlngObject == null || typeof latlngObject != 'object') {
			ColdFusion.handleError(null, 'map.addmarker.addressnotfound', "map", [this.address], null, null, false);
			return null;
		}
		var point = new GLatLng(latlngObject.lat(), latlngObject.lng());
		var markerObj = this;

		var parent = this.parent;
        delete this.parent;
		parent.addMarker(point, markerObj.marker, false, false, markerObj.listeners);		
	},
	geoCodeLookup : function(addr) {
        
        this.geocoder = new GClientGeocoder();
        this.geocoder.getLocations(addr, this.addAddressToMap.createDelegate(this));
        
    },
	sleep : function (sleeptime)
	{
		var sleeping = true;
	    var now = new Date();
	    var alarm;
	    var startingMSeconds = now.getTime();
		while(sleeping){
	    	alarm = new Date();
	        alarmMSeconds = alarm.getTime();
	        if(alarmMSeconds - startingMSeconds > sleeptime){ sleeping = false; }
	    } 
	},
	
    addAddressToMap : function(response) {

        if (!response || response.Status.code != 200) {													
            this.onErrorhandler.call(null, this.name, response.Status.code);
        }else{
            place = response.Placemark[0];
            addressinfo = place.AddressDetails;
            accuracy = addressinfo.Accuracy;
            if (accuracy === 0) {
                this.onErrorHandler.call(null, this.name, 602);
            }else{
                point = new GLatLng(place.Point.coordinates[1], place.Point.coordinates[0]);
                if (typeof this.setCenter.marker === 'object' && typeof point === 'object'){
					this.addMarker(point,this.setCenter.marker,this.setCenter.marker.clear,true, this.setCenter.listeners);
                }
            }
        }        
    }
});

printObject = function(obj)
{
	var str = '';
	for(key in obj)
	{
		str  =  str + '  ' + key + '=';
		value = obj[key] ;
		if(typeof(value) == Object){
        	value = $G.printObject(value);		
		}
		str += value;
	}
	return str;
};

Ext.reg('gmappanel',Ext.ux.GMapPanel); 