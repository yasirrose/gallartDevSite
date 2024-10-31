/*ADOBE SYSTEMS INCORPORATED
Copyright 2012 Adobe Systems Incorporated
All Rights Reserved.

NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
terms of the Adobe license agreement accompanying it.  If you have received this file from a
source other than Adobe, then your use, modification, or distribution of it requires the prior
written permission of Adobe.*/
if(!ColdFusion.Autosuggest){
ColdFusion.Autosuggest={};
}
var staticgifpath=_cf_ajaxscriptsrc+"/resources/cf/images/static.gif";
var dynamicgifpath=_cf_ajaxscriptsrc+"/resources/cf/images/loading.gif";
ColdFusion.Autosuggest.loadAutoSuggest=function(_1,_2){
var _3=ColdFusion.objectCache[_2.autosuggestid];
if(typeof (_1)=="string"){
_1=_1.split(",");
}else{
var _4=false;
if(_1&&ColdFusion.Util.isArray(_1)){
_4=true;
if(_1.length>0&&(typeof (_1[0])!="string"&&typeof (_1[0])!="number")){
_4=false;
}
}
if(!_4){
ColdFusion.handleError(_3.onbinderror,"autosuggest.loadautosuggest.invalidvalue","widget",[_2.autosuggestid]);
return;
}
}
var _5=document.getElementById(_2.autosuggestid).value;
if(_5.length==1&&_1.length==0){
var _6=new Array();
_3.dataSource.flushCache();
_3.dataSource=new YAHOO.widget.DS_JSArray(_6);
_3.autosuggestitems=_6;
}
if(_1.length>0){
var i=0;
var _8=false;
var _6=new Array();
for(i=0;i<_1.length;i++){
if(_1[i]){
if(typeof (_1[i])=="string"){
_6[i]=_1[i];
}else{
if(typeof (_1[i])=="number"){
_6[i]=_1[i]+"";
}else{
_6[i]=new String(_1[i]);
}
}
if(_6[i].indexOf(_5)==0){
_8=true;
}
}
}
if(_8==false&&_3.showloadingicon==true){
document.getElementById(_2.autosuggestid+"_cf_button").src=staticgifpath;
}
_3.dataSource.flushCache();
_3.dataSource=new YAHOO.widget.DS_JSArray(_6);
_3.autosuggestitems=_6;
if(_3.queryMatchContains){
_3.dataSource.queryMatchContains=_3.queryMatchContains;
}
_3._sendQuery(_5);
}else{
if(_3.showloadingicon==true){
document.getElementById(_2.autosuggestid+"_cf_button").src=staticgifpath;
_3.showloadingicon==false;
}
}
};
ColdFusion.Autosuggest.checkToMakeBindCall=function(_9,_a,_b,_c,_d){
var _c=document.getElementById(_a).value;
if(!_b.isContainerOpen()&&_c.length>0&&_9.keyCode!=39&&(_9.keyCode>31||(_9.keyCode==8&&_b.valuePresent==true))){
_b.valuePresent=false;
if(_b.showloadingicon==true){
document.getElementById(_a+"_cf_button").src=dynamicgifpath;
}
ColdFusion.Log.info("autosuggest.checktomakebindcall.fetching","widget",[_a,_c]);
if(_b.cfqueryDelay>0){
var _e=setTimeout(_d,_b.cfqueryDelay*1000,this);
if(_b._nDelayID!=-1){
clearTimeout(_b._cf_nDelayID);
}
_b._cf_nDelayID=_e;
}else{
_d.call(this);
}
}
};
ColdFusion.Autosuggest.checkValueNotInAutosuggest=function(_f,_10){
if(_f.autosuggestitems){
for(var i=0;i<_f.autosuggestitems.length;i++){
if(_10==_f.autosuggestitems[i]){
return false;
}
}
}
return true;
};
ColdFusion.Autosuggest.triggerOnChange=function(_12,_13){
var _14=_13[0];
var _15=document.getElementById(_14.id);
ColdFusion.Event.callBindHandlers(_14.id,null,"change");
};
ColdFusion.Autosuggest.init=function(_16,_17,_18){
return new YAHOO.widget.AutoComplete(_16,_17,_18);
};
ColdFusion.Autosuggest.getAutosuggestObject=function(_19){
var _1a=ColdFusion.objectCache[_19];
if(_1a==null||typeof (_1a)=="undefined"){
ColdFusion.handleError(null,"autosuggest.getAutosuggestObject.notfound","widget",[_19],null,null,true);
}
return _1a;
};
ColdFusion.Autosuggest.initJS_ARRAY=function(_1b){
return new YAHOO.widget.DS_JSArray(_1b);
};
