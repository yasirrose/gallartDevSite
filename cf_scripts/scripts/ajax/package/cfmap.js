/*ADOBE SYSTEMS INCORPORATED
Copyright 2012 Adobe Systems Incorporated
All Rights Reserved.

NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
terms of the Adobe license agreement accompanying it.  If you have received this file from a
source other than Adobe, then your use, modification, or distribution of it requires the prior
written permission of Adobe.*/
if(!ColdFusion.Map){
ColdFusion.Map={};
}
var coldFusion_markerObjCache=new Array();
var $MAP=ColdFusion.Map;
$MAP.statusCodeObject={code200:"A directions request could not be successfully parsed. For example, the request may have been rejected if it contained more than the maximum number of waypoints allowed.",code400:"A directions request could not be successfully parsed. For example, the request may have been rejected if it contained more than the maximum number of waypoints allowed.",code500:"A geocoding or directions request could not be successfully processed, yet the exact reason for the failure is not known",code601:"The HTTP query parameter was either missing or had no value. For geocoding requests, this means that an empty address was specified as input. For directions requests, this means that no query was specified in the input",code602:"No corresponding geographic location could be found for the specified address. This may be due to the fact that the address is relatively new, or it may be incorrect",code603:"The geocode for the given address or the route for the given directions query cannot be returned due to legal or contractual reasons",code604:"The GDirections object could not compute directions between the points mentioned in the query. This is usually because there is no route available between the two points, or because we do not have data for routing in that region",code610:"This request was invalid.",code620:"The webpage has gone over the requests limit in too short a period of time."};
ColdFusion.Map._init=function(_1a0,_1a1,_1a2,type,_1a4,_1a5,_1a6,_1a7,_1a8,_1a9,_1aa,_1ab,_1ac,_1ad,_1ae,_1af,_1b0,_1b1,_1b2,_1b3,_1b4,_1b5,_1b6,_1b7,_1b8,_1b9,_1ba,_1bb,_1bc,_1bd,_1be){
var _1bf=null;
if(navigator.geolocation){
navigator.geolocation.getCurrentPosition(function(_1c0){
if(_1be<1){
_1b3=_1c0.coords.latitude;
_1b4=_1c0.coords.longitude;
_1b2=null;
}
if(_1be!==0){
if(_1be<0){
_1be=_1be*-1;
}
_1b8[_1be-1].latitude=_1c0.coords.latitude;
_1b8[_1be-1].longitude=_1c0.coords.longitude;
}
_1bf=ColdFusion.Map.init(_1a0,_1a1,_1a2,type,_1a4,_1a5,_1a6,_1a7,_1a8,_1a9,_1aa,_1ab,_1ac,_1ad,_1ae,_1af,_1b0,_1b1,_1b2,_1b3,_1b4,_1b5,_1b6,_1b7,_1b8,_1b9,_1ba,_1bb,_1bc,_1bd);
},function(_1c1){
_1bf=ColdFusion.Map.init(_1a0,_1a1,_1a2,type,_1a4,_1a5,_1a6,_1a7,_1a8,_1a9,_1aa,_1ab,_1ac,_1ad,_1ae,_1af,_1b0,_1b1,_1b2,_1b3,_1b4,_1b5,_1b6,_1b7,_1b8,_1b9,_1ba,_1bb,_1bc,_1bd);
});
}else{
_1bf=ColdFusion.Map.init(_1a0,_1a1,_1a2,type,_1a4,_1a5,_1a6,_1a7,_1a8,_1a9,_1aa,_1ab,_1ac,_1ad,_1ae,_1af,_1b0,_1b1,_1b2,_1b3,_1b4,_1b5,_1b6,_1b7,_1b8,_1b9,_1ba,_1bb,_1bc,_1bd);
}
return _1bf;
};
ColdFusion.Map.init=function(_1c2,_1c3,_1c4,type,_1c6,_1c7,_1c8,_1c9,_1ca,_1cb,_1cc,_1cd,_1ce,_1cf,_1d0,_1d1,_1d2,_1d3,_1d4,_1d5,_1d6,_1d7,_1d8,_1d9,_1da,_1db,_1dc,_1dd,_1de,_1df){
var _1e0={divName:_1c2,type:type,layout:"fit",renderTo:_1c2,centerAddress:_1d4,centerLatitude:_1d5,centerLongitude:_1d6,markerItems:_1da,onLoad:_1db,onError:_1dc,showCenterMarker:_1cf,showAllMarker:_1d0,markerColor:_1d8,markerIcon:_1d9,markerBindListener:_1de,initShow:_1c9};
if(_1c4!=null&&typeof (_1c4)!="undefined"){
_1e0.width=_1c4;
}else{
_1e0.width=400;
}
if(_1c3!=null&&typeof (_1c3)!="undefined"){
_1e0.height=_1c3;
}else{
_1e0.height=400;
}
if(_1c6!=null&&typeof (_1c6)!="undefined"){
_1e0.zoomLevel=_1c6;
}else{
_1e0.zoomLevel=3;
}
_1e0.hideBorders=_1c8;
if(!_1c8){
if(_1c7==null||typeof _1c7==="undefined"||_1c7.length==0){
_1c7=" ";
}
_1e0.title=_1c7;
_1e0.collapsible=_1ca;
}
if(_1d8==null&&_1d9==null){
_1e0.markerColor="#00FF00";
}
var _1e1=new Ext.Panel(_1e0);
ColdFusion.objectCache[_1c2]=_1e0;
_1e0.mapPanel=_1e1;
var _1e2=["enableDragging"];
var swz=false;
if(_1cb){
swz=true;
}
if(_1cc){
_1e2.push("enableDoubleClickZoom");
}else{
_1e2.push("disableDoubleClickZoom");
}
if(_1cd){
_1e2.push("enableContinuousZoom");
}else{
_1e2.push("disableContinuousZoom");
}
var _1e4=["NonExistantControl"];
if(_1ce){
_1e4.push("scaleControl");
}
var mtc=false;
var mtco="";
if(_1d2&&_1d2.toUpperCase()=="BASIC"){
mtc=true;
mtco="google.maps.MapTypeControlStyle.HORIZONTAL_BAR";
}else{
if(_1d2&&_1d2.toUpperCase()=="ADVANCED"){
mtc="true";
mtco=google.maps.MapTypeControlStyle.DROPDOWN_MENU;
}
}
if(_1d1){
_1e4.push("overviewMapControl");
}
var zc=false;
var zco="";
if(_1d3!=null&&_1d3!="undefined"){
_1d3=_1d3.toUpperCase();
switch(_1d3){
case "SMALL":
zco=google.maps.ZoomControlStyle.SMALL;
zc=true;
break;
case "SMALL3D":
zco=google.maps.ZoomControlStyle.SMALL;
zc=true;
break;
case "LARGE":
zco=google.maps.ZoomControlStyle.LARGE;
zc=true;
break;
case "LARGE3D":
zco=google.maps.ZoomControlStyle.LARGE;
zc=true;
break;
}
}
var _1e9=[];
for(i=0;i<_1e0.markerItems.length;i++){
var _1ea=$MAP.parseMarker(_1e0.markerItems[i],_1c2);
_1e9.push(_1ea);
}
if(_1d7==null||typeof _1d7==="undefined"){
_1d7="";
}
var _1eb={marker:{title:_1d7,iscenter:true}};
if(_1e0.markerColor!=null&&typeof _1e0.markerColor!="undefined"){
_1eb.marker.markercolor=_1e0.markerColor;
}else{
if(_1e0.markerIcon!=null&&typeof _1e0.markerIcon!="undefined"){
_1eb.marker.markericon=_1e0.markerIcon;
}
}
if(_1dd===true){
_1eb.listeners={click:$MAP.markerOnClickHandler};
if(_1df!=null){
_1eb.marker.markerwindowcontent=_1df;
}else{
_1eb.marker.bindcallback=_1de;
}
_1eb.marker.name=_1c2;
}
if(_1e0.centerAddress!=null&&typeof _1e0.centerAddress==="string"){
_1eb.geoCodeAddr=_1e0.centerAddress;
_1eb.marker.address=_1e0.centerAddress;
}else{
_1eb.lat=_1e0.centerLatitude;
_1eb.lng=_1e0.centerLongitude;
_1eb.marker.address=_1e0.centerAddress;
}
var _1ec=false;
if(_1d2!=null&&typeof _1d2=="string"&&_1d2.toUpperCase()=="ADVANCED"){
_1ec=true;
}
var _1ed=new Ext.ux.GMapPanel({xtype:"gmappanel",region:"center",zoomLevel:_1e0.zoomLevel,gmapType:_1e0.type,mapConfOpts:_1e2,mapControls:_1e4,setCenter:_1eb,markers:_1e9,border:!_1e0.hideBorders,onLoadhandler:$MAP.onLoadCompleteHandler,onErrorhandler:_1dc,name:_1e0.divName,noCenterMarker:!_1cf,showAllMarker:_1d0,advanceMapTypeControl:_1ec,initShow:_1c9,zc:zc,zco:zco,mtc:mtc,mtco:mtco,swz:swz});
_1e1.add(_1ed);
_1e0.mapPanelObject=_1ed;
if(_1c9===false){
_1e1.hide();
}else{
_1e1.updateLayout();
}
ColdFusion.Log.info("map.initialized","widget",[_1c2]);
return _1e1;
};
$MAP.addMarker=function(name,_1ef){
var _1f0=$MAP.getMapPanelObject(name);
var _1f1=$MAP.parseMarker(_1ef,name);
var _1f2=[];
_1f2.push(_1f1);
_1f0.addMarkers(_1f2);
ColdFusion.Log.info("map.addmarker.markeradded","widget",[name,_1f2.length]);
};
$MAP.setCenter=function(name,_1f4){
var _1f5=$MAP.getMapPanelObject(name);
var lat;
var lng;
if(_1f4.latitude&&_1f4.longitude){
if(typeof _1f4.latitude!="number"||typeof _1f4.longitude!="number"){
ColdFusion.handleError(null,"map.setcenter.latlngnonnumeric","widget",[name,_1f4.latitude,_1f4.longitude],null,null,true);
}else{
lat=_1f4.latitude;
lng=_1f4.longitude;
}
var _1f8=new google.maps.LatLng(lat,lng);
_1f5.getMap().setCenter(_1f8,_1f5.zoomLevel);
var _1f9={};
_1f9.markercolor="#00FF00";
_1f5.addMarker(new google.maps.LatLng(_1f4.latitude,_1f4.longitude),_1f9,null,true);
}else{
if(_1f4.address){
if(typeof _1f4.address!="string"){
ColdFusion.handleError(null,"map.setcenter.addressnotstring","widget",[name,_1f4.address],null,null,true);
}else{
_1f5.geoCodeLookup(_1f4.address,null,null,true);
}
}else{
ColdFusion.handleError(null,"map.setcenter.invalidcenter","widget",[name],null,null,true);
}
}
ColdFusion.Log.info("map.setcenter.centerset","widget",[name]);
};
$MAP.getLatitudeLongitude=function(_1fa,_1fb){
geocoder=new google.maps.Geocoder();
if(_1fb==null||!typeof _1fb==="function"){
_1fb=$MAP.LatitudeLongitudeHandler;
}
geocoder.geocode({"address":_1fa},_1fb);
};
$MAP.addEvent=function(name,_1fd,_1fe,_1ff){
if(_1fd=="singlerightclick"){
_1fd="rightclick";
}
if(_1fd=="maptypechanged"){
_1fd="maptypeid_changed";
}
var _200=$MAP.getMapPanelObject(name);
_200.addEventToMap(_1fd,_1fe,_1ff);
};
$MAP.setZoomLevel=function(name,_202){
var _203=$MAP.getMapPanelObject(name);
_203.zoomLevel=_202;
_203.getMap().setZoom(_202);
};
$MAP.getMapObject=function(name){
var _205=$MAP.getMapPanelObject(name);
if(_205!=null){
return _205.getMap();
}
};
$MAP.parseMarker=function(_206,_207){
var _208={};
if(_206.latitude&&_206.longitude){
if(typeof _206.latitude!="number"||typeof _206.longitude!="number"){
ColdFusion.handleError(null,"map.marker.latlngnonnumeric","widget",[_206.latitude,_206.longitude],null,null,true);
}else{
_208.lat=_206.latitude;
_208.lng=_206.longitude;
}
}else{
if(_206.address!=null){
if(typeof _206.address!="string"){
ColdFusion.handleError(null,"map.marker.addressnotstring","widget",[_206.address],null,null,true);
}else{
_208.address=_206.address;
}
}
}
var _209={};
if(_206.tip==null){
_209.title="";
}else{
_209.title=_206.tip;
}
if(_206.markercolor!=null&&typeof _206.markercolor!="undefined"){
_209.markercolor=_206.markercolor;
}else{
if(_206.markericon!=null&&typeof _206.markericon!="undefined"){
_209.markericon=_206.markericon;
}
}
if(_206.showmarkerwindow===true||_206.markerwindowcontent!=null){
var _20a=ColdFusion.objectCache[_207];
var _20b;
if(_20a!=null||typeof (_20a)!="undefined"){
_20b=_20a.markerBindListener;
}
if(_20b!=null||_206.markerwindowcontent!=null){
_208.listeners={click:$MAP.markerOnClickHandler};
if(_206.markerwindowcontent!=null){
_209.markerwindowcontent=_206.markerwindowcontent;
}else{
_209.bindcallback=_20b;
}
_209.name=_206.name;
}
}
_208.marker=_209;
return _208;
};
$MAP.onErrorHandler=function(name,_20d){
var _20e=ColdFusion.objectCache[name];
var _20f=$MAP.statusCodeObject;
var _210=$MAP.retrieveStatueMessage(_20d);
var _211=_20e.onError;
if(_211!=null&&typeof _211==="function"){
_211.call(null,_20d,_210);
}else{
alert("Error: "+_210);
}
ColdFusion.handleError(null,"map.loadMap.error","map",[name,_20d,_210],null,null,true);
};
$MAP.onLoadCompleteHandler=function(name){
var _213=ColdFusion.objectCache[name];
var _214=_213.onLoad;
if(_214!=null&&typeof _214==="function"){
_214.call();
}
};
$MAP.retrieveStatueMessage=function(code){
var _216;
switch(code){
case "ZERO_RESULTS":
_216=$MAP.statusCodeObject.code602;
break;
case "OVER_QUERY_LIMIT":
_216=$MAP.statusCodeObject.code620;
break;
case "REQUEST_DENIED":
_216=$MAP.statusCodeObject.code610;
break;
case "INVALID_REQUEST":
_216=$MAP.statusCodeObject.code610;
break;
}
return _216;
};
var currentopenwindow="";
$MAP.markerOnClickHandler=function(_217){
coldFusion_markerObjCache[this.name]=this.scope.marker;
if(this.bindcallback!=null&&typeof this.bindcallback=="function"){
var _218=this.address;
if(_218==null||typeof _218=="undefined"){
_218="";
}
this.bindcallback.call(null,this.name,_217.latLng.lat(),_217.latLng.lng(),_218);
}else{
if(this.scope.statictext!=null&&typeof this.scope.statictext!="undefined"){
var me=this,infoWindow=new google.maps.InfoWindow({content:this.scope.statictext,position:this.scope.marker.position});
if(currentopenwindow!=""){
currentopenwindow.close();
}
infoWindow.open(this.scope.marker.map);
currentopenwindow=infoWindow;
}
}
};
ColdFusion.Map.loadMarkerWindowInfo=function(data,_21b){
var _21c=coldFusion_markerObjCache[_21b._cf_marker_name];
var me=this,infoWindow=new google.maps.InfoWindow({content:data,position:_21c.position});
if(currentopenwindow!=""){
currentopenwindow.close();
}
infoWindow.open(_21c.map);
currentopenwindow=infoWindow;
};
ColdFusion.Map.bindOnErrorHandler=function(data,_21f){
ColdFusion.handleError(null,"map.markerbind.binderror","widget",[data],null,null,true);
};
$MAP.getMapPanelObject=function(name){
var _221=ColdFusion.objectCache[name];
if(_221==null||typeof (_221)=="undefined"){
ColdFusion.handleError(null,"map.getmappanelobject.notfound","widget",[name],null,null,true);
}
return _221.mapPanelObject;
};
$MAP.refresh=function(name){
var _223=ColdFusion.objectCache[name];
if(_223==null||typeof (_223)=="undefined"){
ColdFusion.handleError(null,"map.refresh.notfound","widget",[name],null,null,true);
}
_223.mapPanel.updateLayout();
};
$MAP.hide=function(name){
var _225=ColdFusion.objectCache[name];
if(_225==null||typeof (_225)=="undefined"){
ColdFusion.handleError(null,"map.hide.notfound","widget",[name],null,null,true);
}
_225.mapPanel.hide();
};
$MAP.show=function(name){
var _227=ColdFusion.objectCache[name];
if(_227==null||typeof (_227)=="undefined"){
ColdFusion.handleError(null,"map.show.notfound","widget",[name],null,null,true);
}
_227.mapPanel.show();
_227.mapPanel.updateLayout();
};
