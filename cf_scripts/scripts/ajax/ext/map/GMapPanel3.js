var x = document.createElement('script');
x.src = _cf_ajaxscriptsrc  + '/jquery/jquery.js';
document.getElementsByTagName("head")[0].appendChild(x);

Ext.ns('Ext.ux');

Ext.define('Ext.ux.GMapPanel', {

	extend: 'Ext.panel.Panel',

    alias: 'widget.gmappanel',
    
    requires: ['Ext.window.MessageBox'],
    /**
     * @cfg {Boolean} border
     * Defaults to <tt>false</tt>.  See {@link Ext.Panel}.<code>{@link Ext.Panel#border border}</code>.
     */
    border: false,

    /**
     * @cfg {Array} respErrors
     * An array of msg/code pairs.
     */
    respErrors: [{
            code: 'UNKNOWN_ERROR',
            msg: 'A geocoding or directions request could not be successfully processed, yet the exact reason for the failure is not known.' 
        },{
            code: 'ERROR',
            msg: 'There was a problem contacting the Google servers.'
        },{
            code: 'ZERO_RESULTS',
            msg: 'The request did not encounter any errors but returns zero results.'
        },{
            code: 'INVALID_REQUEST',
            msg: 'This request was invalid.' 
        },{
            code: 'REQUEST_DENIED',
            msg: 'The webpage is not allowed to use the geocoder for some reason.' 
        },{
            code: 'OVER_QUERY_LIMIT',
            msg: 'The webpage has gone over the requests limit in too short a period of time.' 
    }],
    /**
     * @cfg {Array} locationTypes
     * An array of msg/code/level pairs.
     */
    locationTypes: [{
            level: 4,
            code: 'ROOFTOP',
            msg: 'The returned result is a precise geocode for which we have location information accurate down to street address precision.' 
        },{
            level: 3,
            code: 'RANGE_INTERPOLATED',
            msg: 'The returned result reflects an approximation (usually on a road) interpolated between two precise points (such as intersections). Interpolated results are generally returned when rooftop geocodes are unavailable for a street address.'
        },{
            level: 2,
            code: 'GEOMETRIC_CENTER',
            msg: 'The returned result is the geometric center of a result such as a polyline (for example, a street) or polygon (region).'
        },{
            level: 1,
            code: 'APPROXIMATE',
            msg: 'The returned result is approximate.' 
    }],
    /**
     * @cfg {String} respErrorTitle
     * Defaults to <tt>'Error'</tt>.
     */
    respErrorTitle : 'Error',
    /**
     * @cfg {String} geoErrorMsgUnable
     * Defaults to <tt>'Unable to Locate the Address you provided'</tt>.
     */
    geoErrorMsgUnable : 'Unable to Locate the Address you provided',
    /**
     * @cfg {String} geoErrorTitle
     * Defaults to <tt>'Address Location Error'</tt>.
     */
    geoErrorTitle : 'Address Location Error',
    /**
     * @cfg {String} geoErrorMsgAccuracy
     * Defaults to <tt>'The address provided has a low accuracy.<br><br>{0} Accuracy.'</tt>.
     * <div class="mdetail-params"><ul>
     * <li><b><code>ROOFTOP</code></b> : <div class="sub-desc"><p>
     * The returned result is a precise geocode for which we have location information accurate down to street address precision.
     * </p></div></li>
     * <li><b><code>RANGE_INTERPOLATED</code></b> : <div class="sub-desc"><p>
     * The returned result reflects an approximation (usually on a road) interpolated between two precise points (such as intersections). Interpolated results are generally returned when rooftop geocodes are unavailable for a street address.
     * </p></div></li>
     * <li><b><code>GEOMETRIC_CENTER</code></b> : <div class="sub-desc"><p>
     * The returned result is the geometric center of a result such as a polyline (for example, a street) or polygon (region).
     * </p></div></li>
     * <li><b><code>APPROXIMATE</code></b> : <div class="sub-desc"><p>
     * The returned result is approximate.
     * </p></div></li>
     * </ul></div>
     */
    geoErrorMsgAccuracy : 'The address provided has a low accuracy.<br><br>"{0}" Accuracy.<br><br>{1}',
    /**
     * @cfg {String} gmapType
     * The type of map to display, generic options available are: 'map', 'panorama'.
     * Defaults to <tt>'map'</tt>. 
     * More specific maps can be used by specifying the google map type:
     * <div class="mdetail-params"><ul>
     * <li><b><code>G_NORMAL_MAP</code></b> : <div class="sub-desc"><p>
     * Displays the default road map view
     * </p></div></li>
     * <li><b><code>G_SATELLITE_MAP</code></b> : <div class="sub-desc"><p>
     * Displays Google Earth satellite images
     * </p></div></li>
     * <li><b><code>G_HYBRID_MAP</code></b> : <div class="sub-desc"><p>
     * Displays a mixture of normal and satellite views
     * </p></div></li>
     * <li><b><code>G_DEFAULT_MAP_TYPES</code></b> : <div class="sub-desc"><p>
     * Contains an array of the above three types, useful for iterative processing.
     * </p></div></li>
     * <li><b><code>G_PHYSICAL_MAP</code></b> : <div class="sub-desc"><p>
     * Displays a physical map based on terrain information. 
     * </p></div></li>
     * <li><b><code>G_MOON_ELEVATION_MAP</code></b> : <div class="sub-desc"><p>
     * Displays a shaded terrain map of the surface of the Moon, color-coded by altitude.
     * </p></div></li>
     * <li><b><code>G_MOON_VISIBLE_MAP</code></b> : <div class="sub-desc"><p>
     * Displays photographic imagery taken from orbit around the moon.
     * </p></div></li>
     * <li><b><code>G_MARS_ELEVATION_MAP</code></b> : <div class="sub-desc"><p>
     * Displays a shaded terrain map of the surface of Mars, color-coded by altitude.
     * </p></div></li>
     * <li><b><code>G_MARS_VISIBLE_MAP</code></b> : <div class="sub-desc"><p>
     * Displays photographs taken from orbit around Mars.
     * </p></div></li>
     * <li><b><code>G_MARS_INFRARED_MAP</code></b> : <div class="sub-desc"><p>
     * Displays a shaded infrared map of the surface of Mars, where warmer areas appear brighter and colder areas appear darker.
     * </p></div></li>
     * <li><b><code>G_SKY_VISIBLE_MAP</code></b> : <div class="sub-desc"><p>
     * Displays a mosaic of the sky, as seen from Earth, covering the full celestial sphere.
     * </p></div></li>
     * </ul></div>
     * Sample usage:
     * <pre><code>
     * gmapType: G_MOON_VISIBLE_MAP
     * </code></pre>
     */
    gmapType : 'map',
    /**
     * @cfg {Object} setCenter
     * The initial center location of the map. The map needs to be centered before it can be used.
     * A marker is not required to be specified. 
     * More markers can be added to the map using the <code>{@link #markers}</code> array.
     * For example:
     * <pre><code>
setCenter: {
    geoCodeAddr: '4 Yawkey Way, Boston, MA, 02215-3409, USA',
    marker: {title: 'Fenway Park'}
},

// or just specify lat/long
setCenter: {
    lat: 42.345573,
    lng: -71.098326
}
     * </code></pre>
     */
    /**
     * @cfg {Number} zoomLevel
     * The zoom level to initialize the map at, generally between 1 (whole planet) and 40 (street).
     * Also used as the zoom level for panoramas, zero specifies no zoom at all.
     * Defaults to <tt>3</tt>.
     */
    zoomLevel: 3,
    /**
     * @cfg {Number} yaw
     * The Yaw, or rotational direction of the users perspective in degrees. Only applies to panoramas.
     * Defaults to <tt>180</tt>.
     */
    yaw: 180,
    /**
     * @cfg {Number} pitch
     * The pitch, or vertical direction of the users perspective in degrees.
     * Defaults to <tt>0</tt> (straight ahead). Valid values are between +90 (straight up) and -90 (straight down). 
     */
    pitch: 0,
    /**
     * @cfg {Boolean} displayGeoErrors
     * True to display geocoding errors to the end user via a message box.
     * Defaults to <tt>false</tt>.
     */
    displayGeoErrors: false,
    /**
     * @cfg {Boolean} minGeoAccuracy
     * The level to display an accuracy error below. Defaults to <tt>ROOFTOP</tt>. For additional information
     * see <a href="http://code.google.com/apis/maps/documentation/reference.html#GGeoAddressAccuracy">here</a>.
     */
    minGeoAccuracy: 'ROOFTOP',
    /**
     * @cfg {Array} mapConfOpts
     * Array of strings representing configuration methods to call, a full list can be found
     * <a href="http://code.google.com/apis/maps/documentation/reference.html#GMap2">here</a>.
     * For example:
     * <pre><code>
     * mapConfOpts: ['enableScrollWheelZoom','enableDoubleClickZoom','enableDragging'],
     * </code></pre>
     */
    /**
     * @cfg {Array} mapControls
     * Array of strings representing map controls to initialize, a full list can be found
     * <a href="http://code.google.com/apis/maps/documentation/reference.html#GControlImpl">here</a>.
     * For example:
     * <pre><code>
     * mapControls: ['GSmallMapControl','GMapTypeControl','NonExistantControl']
     * </code></pre>
     */
    /**
     * @cfg {Array} markers
     * Markers may be added to the map. Instead of specifying <code>lat</code>/<code>lng</code>,
     * geocoding can be specified via a <code>geoCodeAddr</code> string.
     * For example:
     * <pre><code>
markers: [{
    //lat: 42.339641,
    //lng: -71.094224,
    // instead of lat/lng:
    geoCodeAddr: '465 Huntington Avenue, Boston, MA, 02215-5597, USA',
    marker: {title: 'Boston Museum of Fine Arts'},
    listeners: {
        click: function(e){
            Ext.Msg.alert('Its fine', 'and its art.');
        }
    }
},{
    lat: 42.339419,
    lng: -71.09077,
    marker: {title: 'Northeastern University'}
}]
     * </code></pre>
     */
    // private
    mapDefined: false,
    // private
    mapDefinedGMap: false,
    initComponent : function(){
        
       
        
        Ext.applyIf(this,{
          markers: [],
          cache: {
              marker: [],
              polyline: [],
              infowindow: []
          }
        });
        
        Ext.ux.GMapPanel.superclass.initComponent.call(this);        

        if (window.google && window.google.maps){
          this.on('afterrender', this.apiReady, this);
        }else{
           window.gmapapiready = Ext.Function.bind(this.apiReady,this);
          this.buildScriptTag('http://maps.google.com/maps/api/js?sensor=false&callback=gmapapiready');
        }

    },
   apiReady : function(){
        
        if (this.rendered){
          
          Ext.defer(function(){
          this.gmapType = this.gmapType.toLowerCase();
		  var mapType;
		  switch(this.gmapType){
            case 'map':
                 mapType = google.maps.MapTypeId.ROADMAP;
                 break;
            case 'satellite':
                 mapType = google.maps.MapTypeId.SATELLITE;
                 break;
            case 'hybrid':
                 mapType = google.maps.MapTypeId.HYBRID;
                 break; 
			case 'terrain':
                 mapType = google.maps.MapTypeId.TERRAIN;
                 break; 
			case 'earth':
                 mapType = google.maps.MapTypeId.ROADMAP;
                 break; 
              }
          if (this.gmapType.toLowerCase() === 'map'){
              this.gmap = new google.maps.Map(this.body.dom, 
				  {
				   zoom:this.zoomLevel,
				   mapTypeControl : this.mtc,
                   mapTypeControlOptions: {
                            style: this.mtco
                          },
				   scrollwheel:this.swz,	
				   zoomControl: this.zc,
                   zoomControlOptions: {
                            style: this.zco
                          },
				   mapTypeId: google.maps.MapTypeId.ROADMAP
				  });
              this.mapDefined = true;
              this.mapDefinedGMap = true;
          }
          
          if (this.gmapType === 'panorama'){
              this.gmap = new GStreetviewPanorama(this.body.dom);
              this.mapDefined = true;
          }
  
          if (!this.mapDefined && this.gmapType){
             this.gmap = new google.maps.Map(this.body.dom, 
				 { 
				   zoom:this.zoomLevel,
				   mapTypeControl : this.mtc,
                   mapTypeControlOptions: {
                            style: this.mtco
                          },
				   scrollwheel:this.swz,	
				   zoomControl: this.zc,
                   zoomControlOptions: {
                            style: this.zco
                          },
				   mapTypeId: google.maps.MapTypeId.ROADMAP
				  });
             this.gmap.setMapTypeId(mapType);
             this.mapDefined = true;
             this.mapDefinedGMap = true;
          }
          
          google.maps.event.addListenerOnce(this.getMap(), 'tilesloaded', Ext.Function.bind(this.onMapReady, this));
          google.maps.event.addListener(this.getMap(), 'dragend', Ext.Function.bind(this.dragEnd, this));
          
          if (typeof this.setCenter === 'object') {
              if (typeof this.setCenter.geoCodeAddr === 'string'){
                  this.geoCodeLookup(this.setCenter.geoCodeAddr, this.setCenter.marker, false, true, this.setCenter.listeners);
              }else{
                
                      var point = new google.maps.LatLng(this.setCenter.lat,this.setCenter.lng);
                      this.getMap().setCenter(point, this.zoomLevel);
                      this.lastCenter = point;  
                 
                  if (typeof this.setCenter.marker === 'object' && typeof point === 'object' && this.noCenterMarker === false) {
                      this.addMarker(point, this.setCenter.marker, this.setCenter.marker.clear,true, this.setCenter.listeners);
                  }
              }
              if (this.gmapType === 'panorama'){
                  this.getMap().setLocationAndPOV(new google.maps.LatLng(this.setCenter.lat,this.setCenter.lng), {yaw: this.yaw, pitch: this.pitch, zoom: this.zoomLevel});
              }
          }
          
          },200,this);
          
        }else{
          this.on('afterrender', this.apiReady, this);
        }
    },
    // private
    afterRender : function(){
        
        var wh = this.ownerCt.getSize();
        Ext.applyIf(this, wh);
        
        Ext.ux.GMapPanel.superclass.afterRender.call(this);

    },
    // private
    buildScriptTag: function(filename, callback) {
        var script  = document.createElement('script'),
        head        = document.getElementsByTagName("head")[0];
        script.type = "text/javascript";
        script.src  = filename;    
        
        return head.appendChild(script);
    },
    // private
    onMapReady : function(){
                
        this.addMapControls();
        this.addOptions();
        
        this.addMarkers(this.markers);
        this.addMapListeners();

        this.fireEvent('mapready', this, this.getMap());
		if (typeof this.onLoadhandler === 'function') {
			this.onLoadhandler.call(null, this.name);
		}  
       
    },

		// private
    addMapListeners : function () {
      	if (this.maplisteners){
      		Ext.iterate(this.maplisteners, function(key,val){
      			google.maps.event.addListener(this.getMap(), key, Ext.Function.bind(val,this));
      		},this);
      	}
    }, 
   
    // private
    onResize : function(w, h){
        
        Ext.ux.GMapPanel.superclass.onResize.call(this, w, h);

        // check for the existance of the google map in case the onResize fires too early
        if (typeof this.getMap() == 'object') {
            google.maps.event.trigger(this.getMap(), 'resize');
            if (this.lastCenter){
              this.getMap().setCenter(this.lastCenter, this.zoomLevel);
            }
        }

    },
    // private
    setSize : function(width, height, animate){
        
        Ext.ux.GMapPanel.superclass.setSize.call(this, width, height, animate);

        // check for the existance of the google map in case setSize is called too early
        if (Ext.isObject(this.getMap())) {
            google.maps.event.trigger(this.getMap(), 'resize');
            if (this.lastCenter){
              this.getMap().setCenter(this.lastCenter, this.zoomLevel);
            }
        }
        
    },
    // private
    dragEnd: function(){
      this.lastCenter = this.getMap().getCenter();
    },
    /**
     * Returns the current google map which can be used to call Google Maps API specific handlers.
     * @return {GMap} this
     */
    getMap : function(){
        
        return this.gmap;
        
    },
    /**
     * Returns the maps center as a GLatLng object
     * @return {GLatLng} this
     */
    getCenter : function(){
        
        return this.getMap().getCenter();
        
    },
    /**
     * Returns the maps center as a simple object
     * @return {Object} this has lat and lng properties only
     */
    getCenterLatLng : function(){
        
        var ll = this.getCenter();
        return {lat: ll.lat(), lng: ll.lng()};
        
    },
    /**
     * Creates markers from the array that is passed in. Each marker must consist of at least
     * <code>lat</code> and <code>lng</code> properties or a <code>geoCodeAddr</code>.
     * @param {Array} markers an array of marker objects
     */
    addMarkers : function(markers) {
        if (Ext.isArray(markers)){
            for (var i = 0; i < markers.length; i++) {
                if (markers[i]) {
                    if (typeof markers[i].geoCodeAddr == 'string') {
						this.addMarkerInProcess = true;
                        this.geoCodeLookup(markers[i].geoCodeAddr, markers[i].marker, false, markers[i].setCenter, markers[i].listeners);
                    } 
					else if (typeof markers[i].address === 'string') {							
						this.addMarkerInProcess = true;
						 this.geoCodeLookup(markers[i].address, markers[i].marker, false, markers[i].setCenter, markers[i].listeners);
						 if(i > 8)
						  this.sleep(1000);
					}else {
                        var mkr_point = new google.maps.LatLng(markers[i].lat, markers[i].lng);
                        this.addMarker(mkr_point, markers[i].marker, false, markers[i].setCenter, markers[i].listeners);
                    }
                }
            }
        }
        
    },

	sleep : function(ms){
      var unixtime_ms = new Date().getTime();
    while(new Date().getTime() < unixtime_ms + ms) {}
	},

	 geoLatiLongiLookup : function(addr, markerIndex) {
        
        this.geocoder = new google.maps.Geocoder();
        var markerObject = this.markers[markerIndex];
		markerObject.parent = this;
		//this.geocoder.geocode(addr, this.addMarkerToMapCallBack.createDelegate(markerObject));
		this.geocoder.geocode({
    			address: addr
    		}, Ext.Function.bind(this.addMarkerToMapCallBack,markerObject, true));

		 
    	
    },

	addMarkerToMapCallBack: function(latlngObject){
	
		if (latlngObject == null || typeof latlngObject != 'object') {
			ColdFusion.handleError(null, 'map.addmarker.addressnotfound', "map", [this.address], null, null, false);
			return null;
		}
		var point = new google.maps.LatLng(latlngObject.lat(), latlngObject.lng());
		var markerObj = this;

		var parent = this.parent;
        delete this.parent;
		parent.addMarker(point, markerObj.marker, false, false, markerObj.listeners);		
	},
    /**
     * Creates a single marker.
     * @param {Object} point a GLatLng point
     * @param {Object} marker a marker object consisting of at least lat and lng
     * @param {Boolean} clear clear other markers before creating this marker
     * @param {Boolean} center true to center the map on this marker
     * @param {Object} listeners a listeners config
     */
    addMarker : function(point, marker, clear, center, listeners){
        
        Ext.applyIf(marker,{});
        if(marker.markercolor != null && typeof marker.markercolor != 'undefined')
			marker.icon = MapIconMaker.createMarkerIcon({width: 32, height: 32, primaryColor: marker.markercolor });
		else		
		{
			if(marker.markericon == null)
			{
			    marker.icon = new google.maps.MarkerImage(_cf_ajaxscriptsrc + '/resources/cf/map/marker.png');
			}
			else
			{
			    marker.icon = new google.maps.MarkerImage(marker.markericon);
			}
		}
		// Initially latLangitude bound will not be defined. While adding first marker 
		// this will be null. So we will initilize it. We need to keep count of marker added,
		// so that we can set the right zoom level once all marker are added.
		if(!this.latLongBound)
		{
			this.latLongBound = new google.maps.LatLngBounds();
			this.markerAddedCount = 0;		
		}
		this.latLongBound.extend(point);
		this.markerAddedCount++;

        if (clear === true){
            this.clearMarkers();
			this.latLongBound = null;
        }
        if (center === true) {
			this.hideCenter();
            this.getMap().setCenter(point, this.zoomLevel)
            this.lastCenter = point;
        }

        if (marker.infoWindow){
            this.createInfoWindow(marker.infoWindow, point, mark);
        }
         var showcenter = true;
		if(this.noCenterMarker == true && marker.iscenter == true)
			showcenter = false;
        if (showcenter)
	   {
        var mark = new google.maps.Marker(Ext.apply(marker, {
            position: point
        }));
        
      
        this.cache.marker.push(mark);
        mark.setMap(this.getMap());

        if (typeof listeners === 'object'){
			var scopeObj = {marker:mark, bindcallback:marker.bindcallback, name:marker.name, statictext: marker.markerwindowcontent, address:marker.address};
			mark.scope = scopeObj;
            for (evt in listeners) {
                google.maps.event.addListener(mark, evt, listeners[evt]);
            }
			
        }
      }

	   if(this.showAllMarker && this.markers.length > 0 && this.markerAddedCount > this.markers.length)
	   {
			//Bugid:78545, If zoomlevel is set to lower value then showallmarker should not optimize it 
			// to higher value. Ideally, showallmarker should only lower the zoomlevel if required to
			// accomodate all markers.		
			//this.getMap().fitBounds(latLongBound);
			var optimalZoomLevel = getZoomByBounds(this.getMap(),this.latLongBound);//this.getMap().getBoundsZoomLevel(this.latLongBound);
			if (optimalZoomLevel <= this.zoomLevel) 
				{
				this.getMap().setZoom(optimalZoomLevel);
				this.getMap().setCenter(this.latLongBound.getCenter());
			}
	   	
	   }
        
        return mark;
        
    },
	addEventToMap : function (event, listener,scope)
	{
		if(scope == null || typeof scope == 'undefined')
			scope = this.getMap();
		google.maps.event.addListener(this.getMap(), event, bind(scope,  listener));
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
                point = new google.maps.LatLng(place.Point.coordinates[1], place.Point.coordinates[0]);
                if (typeof this.setCenter.marker === 'object' && typeof point === 'object' ){
					this.addMarker(point,this.setCenter.marker,this.setCenter.marker.clear,true, this.setCenter.listeners);
                }
            }
        }       } ,
    /**
     * Creates a single polyline.
     * @param {Array} points an array of polyline points
     * @param {Object} linestyle an object defining the line style to use
     */
    addPolyline : function(points, linestyle){
        
        var plinepnts = new google.maps.MVCArray, pline, linestyle = linestyle ? linestyle : {
            strokeColor: '#FF0000',
            strokeOpacity: 1.0,
            strokeWeight: 2
        };
        
        Ext.each(points, function(point){
            plinepnts.push(new google.maps.LatLng(point.lat, point.lng));
        }, this);
        
        var pline = new google.maps.Polyline(Ext.apply({
          path: plinepnts
        },linestyle));
        
        this.cache.polyline.push(pline);
        
        pline.setMap(this.getMap());

    },
    /**
     * Creates an Info Window.
     * @param {Object} inwin an Info Window configuration
     * @param {GLatLng} point the point to show the Info Window at
     * @param {GMarker} marker a marker to attach the Info Window to
     */
    createInfoWindow : function(inwin, point, marker){
        
        var me = this, infoWindow = new google.maps.InfoWindow({
            content: inwin.content,
            position: point
        });
        
        if (marker) {
            google.maps.event.addListener(marker, 'click', function(){
                me.hideAllInfoWindows();
                infoWindow.open(me.getMap());
            });
        }
        
        this.cache.infowindow.push(infoWindow);

        return infoWindow;

    },
    // private
    hideAllInfoWindows : function(){
        for (var i = 0; i < this.cache.infowindow.length; i++) {
            this.cache.infowindow[i].close();
        }
    },
    // private
    clearMarkers : function(){
        
        this.hideAllInfoWindows();
        this.hideMarkers();

    },
    // private
    hideMarkers : function(){
        Ext.each(this.cache.marker, function(mrk){
            mrk.setMap(null);
        });
    },
		// private
    hideCenter : function(){
        Ext.each(this.cache.marker, function(mrk){
			if(mrk.iscenter == true)
            mrk.setMap(null);
        });
    },
    // private
    showMarkers : function(){
        Ext.each(this.cache.marker, function(mrk){
            mrk.setMap(this.getMap());
        },this);
    },
    // private
    addMapControls : function(){
        
        if (this.gmapType === 'map') {
            if (Ext.isArray(this.mapControls)) {
                for(i=0;i<this.mapControls.length;i++){
                    this.addMapControl(this.mapControls[i]);
                }
            }else if(typeof this.mapControls === 'string'){
                this.addMapControl(this.mapControls);
            }else if(typeof this.mapControls === 'object'){
                this.getMap().add_control(this.mapControls);
            }
        }
        
    },
    /**
     * Adds a GMap control to the map.
     * @param {String} mc a string representation of the control to be instantiated.
     */
    addMapControl : function(mc){
        this.getMap().set(mc,true);
        
    },
    // private
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
    /**
     * Adds a GMap option to the map.
     * @param {String} mo a string representation of the option to be instantiated.
     */
    addOption : function(mo){
        this.getMap().set(mo,true);   
        
    },
    /**
     * Looks up and address and optionally add a marker, center the map to this location, or
     * clear other markers. Sample usage:
     * <pre><code>
buttons: [
    {
        text: 'Fenway Park',
        handler: function(){
            var addr = '4 Yawkey Way, Boston, MA, 02215-3409, USA';
            Ext.getCmp('my_map').geoCodeLookup(addr, undefined, false, true, undefined);
        }
    },{
        text: 'Zoom Fenway Park',
        handler: function(){
            Ext.getCmp('my_map').zoomLevel = 19;
            var addr = '4 Yawkey Way, Boston, MA, 02215-3409, USA';
            Ext.getCmp('my_map').geoCodeLookup(addr, undefined, false, true, undefined);
        }
    },{
        text: 'Low Accuracy',
        handler: function(){
            Ext.getCmp('my_map').geoCodeLookup('Paris, France', undefined, false, true, undefined);
        }
    },{

        text: 'Bogus Address',
        handler: function(){
            var addr = 'Some Fake, Address, For, Errors';
            Ext.getCmp('my_map').geoCodeLookup(addr, undefined, false, true, undefined);
        }
    }
]
     * </code></pre>
     * @param {String} addr the address to lookup.
     * @param {Object} marker the marker to add (optional).
     * @param {Boolean} clear clear other markers before creating this marker
     * @param {Boolean} center true to set this point as the center of the map.
     * @param {Object} listeners a listeners config
     */
    geoCodeLookup : function(addr, marker, clear, center, listeners) {
        
        if (!this.geocoder) {
            this.geocoder = new google.maps.Geocoder();
        }
         
        this.geocoder.geocode({
    			address: addr
    		}, Ext.Function.bind(this.addAddressToMap, this, [addr, marker, clear, center, listeners], true));
	},
  	// private 
  	centerOnClientLocation : function(){
  		this.getClientLocation(function(loc){
  			var point = new google.maps.LatLng(loc.latitude,loc.longitude);
        this.getMap().setCenter(point, this.zoomLevel);
        this.lastCenter = point;
  		});
  	},
  	// private
  	getClientLocation : function(fn, errorFn){
  		if (!errorFn) {
          errorFn = Ext.emptyFn;
      }
  		if (!this.clientGeo) {
  			this.clientGeo = google.gears.factory.create('beta.geolocation');
  		}
  		  		geo.getCurrentPosition(Ext.Function.bind(fn, this), errorFn);
  	},
    // private
    addAddressToMap : function(response, status, addr, marker, clear, center, listeners){
        if (!response || status !== 'OK') {
			Ext.each(this.respErrors, function(obj){
            if (status == obj.code){
                this.onErrorhandler.call(null, status,obj.msg);
            }
        }, this);
          
        }else{
            var place = response[0].geometry.location,
			          accuracy = this.getLocationTypeInfo(response[0].geometry.location_type,'level'),
			          reqAccuracy = this.getLocationTypeInfo(this.minGeoAccuracy,'level');
            if (accuracy === 0) {
                this.geoErrorMsg(this.geoErrorTitle, this.geoErrorMsgUnable);
            }else{
                if (accuracy <-1) {
                                        this.geoErrorMsg(this.geoErrorTitle, String.format(this.geoErrorMsgAccuracy, response[0].geometry.location_type, this.getLocationTypeInfo(response[0].geometry.location_type,'msg')));  }else{
                    point = new google.maps.LatLng(place.lat(),place.lng());
                    if (center){
                        this.getMap().setCenter(point, this.zoomLevel);
                        this.lastCenter = point;
                    }
                    if (typeof marker === 'object') {
                        if (!marker.title){
                            marker.title = response.formatted_address;
                        }
                        var mkr = this.addMarker(point, marker, clear, false, listeners);
                        if (marker.callback){
                          marker.callback.call(this, mkr, point);
                        }
                    }
                }
            }
        }
        
    },
    // private
    geoErrorMsg : function(title,msg){
        if (this.displayGeoErrors) {
            Ext.MessageBox.alert(title,msg);
        }
    },
    // private
    respErrorMsg : function(code){
        Ext.each(this.respErrors, function(obj){
            if (code == obj.code){
                Ext.MessageBox.alert(this.respErrorTitle, obj.msg);
            }
        }, this);
    },
    // private
    getLocationTypeInfo: function(location_type,property){
      var val = 0;
      Ext.each(this.locationTypes, function(itm){
        if (itm.code === location_type){
          val = itm[property];
        }
      });
      return val;
    }
});


 function bind(object, method) {
  return function() {
    return method.apply(object, arguments);
  }
}

/**
* Returns the zoom level at which the given rectangular region fits in the map view. 
* The zoom level is computed for the currently selected map type. 
* @param {google.maps.Map} map
* @param {google.maps.LatLngBounds} bounds 
* @return {Number} zoom level
**/
function getZoomByBounds( map, bounds ){
  var MAX_ZOOM = map.mapTypes.get( map.getMapTypeId() ).maxZoom || 21 ;
  var MIN_ZOOM = map.mapTypes.get( map.getMapTypeId() ).minZoom || 0 ;

  var ne= map.getProjection().fromLatLngToPoint( bounds.getNorthEast() );
  var sw= map.getProjection().fromLatLngToPoint( bounds.getSouthWest() ); 

  var worldCoordWidth = Math.abs(ne.x-sw.x);
  var worldCoordHeight = Math.abs(ne.y-sw.y);

  //Fit padding in pixels 
  var FIT_PAD = 40;

  for( var zoom = MAX_ZOOM; zoom >= MIN_ZOOM; --zoom ){ 
      if( worldCoordWidth*(1<<zoom)+2*FIT_PAD < $(map.getDiv()).width() && 
          worldCoordHeight*(1<<zoom)+2*FIT_PAD < $(map.getDiv()).height() )
          return zoom;
  }
  return 0;
}