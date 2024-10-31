/*ADOBE SYSTEMS INCORPORATED
Copyright 2012 Adobe Systems Incorporated
All Rights Reserved.

NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
terms of the Adobe license agreement accompanying it.  If you have received this file from a
source other than Adobe, then your use, modification, or distribution of it requires the prior
written permission of Adobe.*/
if(!ColdFusion.MessageBox){
ColdFusion.MessageBox={};
}
var $MB=ColdFusion.MessageBox;
var DEFAULT_OK="Ok";
var DEFAULT_NO="No";
var DEFAULT_CANCEL="Cancel";
var DEFAULT_YES="Yes";
var DEFAULT_ALERT_BUTTON_TYPE=1;
var DEFAULT_CONFIRM_BUTTON_TYPE=6;
var DEFAULT_PROMPT_BUTTON_TYPE=9;
var CF_BEFORE_SHOW_HANDLER_ADDED=false;
var CURRENT_MESSAGEBOX_ID;
var $XB={};
Ext.onReady(function(){
$XB=Ext.MessageBox;
DEFAULT_OK=$XB.buttonText.ok;
DEFAULT_NO=$XB.buttonText.no;
DEFAULT_CANCEL=$XB.buttonText.cancel;
DEFAULT_YES=$XB.buttonText.yes;
DEFAULT_ALERT_BUTTON_TYPE=$XB.OK;
DEFAULT_CONFIRM_BUTTON_TYPE=$XB.YESNO;
DEFAULT_PROMPT_BUTTON_TYPE=$XB.OKCANCEL;
});
ColdFusion.MessageBox.init=function(_517,type,_519,_51a,_51b,_51c,_51d,_51e,_51f,_520,_521,icon,_523,x,y,_526,_527){
var _528={messageBoxId:_517,type:type,callBack_Fn:_521,multiline:_51f,modal:_520,width:_523,bodyStyle:_527};
if(_519==null||typeof (_519)=="undefined"){
_519="";
}
_519=ColdFusion.Util.replaceAll(_519,"\n","<br>");
_528.messageText=_519;
if(_51b!=null&&typeof (_51b)!="undefined"){
_528.label_OK=_51b;
}
if(_51c!=null&&typeof (_51c)!="undefined"){
_528.label_NO=_51c;
}
if(_51e!=null&&typeof (_51e)!="undefined"){
_528.label_YES=_51e;
}
if(_51d!=null&&typeof (_51d)!="undefined"){
_528.label_CANCEL=_51d;
}
if(_51a==null||typeof (_51a)=="undefined"){
type=type.toLowerCase();
if(type=="alert"){
_51a="Alert";
}else{
if(type=="confirm"){
_51a="Confirm";
}else{
if(type=="prompt"){
_51a="Prompt";
}
}
}
}
_528.title=_51a;
if(_526&&typeof (_526)=="string"){
_528.buttonType=_526;
}
if(icon&&typeof (icon)=="string"){
_528.icon=icon;
}
if(typeof x=="number"&&x>=0){
_528.x=x;
}
if(typeof y=="number"&&y>=0){
_528.y=y;
}
ColdFusion.objectCache[_517]=_528;
};
$MB.show=function(_529){
var _52a=$MB.getMessageBoxObject(_529);
var type=_52a.type;
type=(new String(type)).toLowerCase();
if(!CF_BEFORE_SHOW_HANDLER_ADDED){
var _52c=Ext.MessageBox;
_52c.addListener("show",$MB.beforeShowHandler,_52a);
CF_BEFORE_SHOW_HANDLER_ADDED=true;
}
CURRENT_MESSAGEBOX_ID=_529;
var _52d=_52a.buttonType;
var _52e={ok:DEFAULT_OK,no:DEFAULT_NO,cancel:DEFAULT_CANCEL,yes:DEFAULT_YES};
if(_52a.label_OK){
_52e.ok=_52a.label_OK;
}
if(_52a.label_YES){
_52e.yes=_52a.label_YES;
}
if(_52a.label_NO){
_52e.no=_52a.label_NO;
}
if(_52a.label_CANCEL){
_52e.cancel=_52a.label_CANCEL;
}
Ext.MessageBox.buttonText=_52e;
if(typeof _52d!="undefined"){
_52d=_52d.toUpperCase();
if(_52d&&_52d!=="OKCANCEL"&&_52d!=="OK"&&_52d!=="YESNOCANCEL"&&_52d!=="YESNO"){
ColdFusion.handleError(null,"messagebox.show.invalidbuttontype","widget",[messagebox,_52d],null,null,true);
}
switch(_52d){
case "OK":
_52d=$XB.OK;
break;
case "OKCANCEL":
_52d=$XB.OKCANCEL;
break;
case "YESNOCANCEL":
_52d=$XB.YESNOCANCEL;
break;
case "YESNO":
_52d=$XB.YESNO;
break;
}
}
var icon=_52a.icon;
var _530="";
if(icon&&typeof (icon)==="string"){
icon=icon.toUpperCase();
switch(icon){
case "ERROR":
_530=$XB.ERROR;
break;
case "INFO":
_530=$XB.INFO;
break;
case "QUESTION":
_530=$XB.QUESTION;
break;
case "WARNING":
_530=$XB.WARNING;
break;
}
}
var _531={title:_52a.title,msg:_52a.messageText,fn:_52a.callBack_Fn,modal:_52a.modal,icon:_530,scope:null};
if(_52a.width){
_531.width=_52a.width;
if(_531.width>600){
_531.maxWidth=_531.width;
}
if(_531.width<100){
_531.minWidth=_531.width;
}
}
if(type==="alert"){
if(!_52d){
_52d=DEFAULT_ALERT_BUTTON_TYPE;
}
_531.buttons=_52d;
$XB.show(_531);
}
if(type==="confirm"){
if(!_52d){
_52d=DEFAULT_CONFIRM_BUTTON_TYPE;
}
_531.buttons=_52d;
$XB.show(_531);
}
if(type==="prompt"){
if(!_52d){
_52d=DEFAULT_PROMPT_BUTTON_TYPE;
}
_531.buttons=_52d;
_531.prompt=true;
_531.multiline=_52a.multiline;
_531.value="",$XB.show(_531);
}
ColdFusion.Log.info("messagebox.show.shown","widget",[_529]);
};
$MB.create=function(_532,type,_534,_535,_536,_537){
if(_532&&typeof _532!="string"){
ColdFusion.handleError(null,"messagebox.create.invalidname","widget",null,null,null,true);
return;
}
if(!_532||ColdFusion.trim(_532)==""){
ColdFusion.handleError(null,"messagebox.create.invalidname","widget",null,null,null,true);
return;
}
var _538=ColdFusion.objectCache[_532];
if(_538!=null||typeof _538!="undefined"){
ColdFusion.handleError(null,"messagebox.create.duplicatename","widget",[_532],null,null,true);
return;
}
if(_535&&typeof _535!="string"){
ColdFusion.handleError(null,"messagebox.create.invalidmessage","widget",[_532],null,null,true);
return;
}
if(!_535||ColdFusion.trim(_535)==""){
ColdFusion.handleError(null,"messagebox.create.invalidmessage","widget",[_532],null,null,true);
return;
}
if(_534&&typeof _534!="string"){
ColdFusion.handleError(null,"messagebox.create.invalidtitle","widget",[_532],null,null,true);
return;
}
if(type&&typeof type!="string"){
ColdFusion.handleError(null,"messagebox.create.invalidtype","widget",[_532],null,null,true);
return;
}
if(!type||ColdFusion.trim(type)==""){
ColdFusion.handleError(null,"messagebox.create.emptytype","widget",[_532],null,null,true);
return;
}
if(_536&&typeof _536!=="function"){
ColdFusion.handleError(null,"messagebox.create.invalidcallback","widget",[_532],null,null,true);
return;
}
var _539=DEFAULT_CANCEL;
var _53a=DEFAULT_NO;
var _53b=DEFAULT_OK;
var _53c=DEFAULT_YES;
var _53d=true;
var _53e=null;
var _53f=false;
var icon;
var _541;
var x;
var y;
var _544;
if(_537&&_537.labelok){
_53b=_537.labelok;
}
if(_537&&_537.labelno){
_53a=_537.labelno;
}
if(_537&&_537.labelyes){
_53c=_537.labelyes;
}
if(_537&&_537.labelcancel){
_539=_537.labelcancel;
}
if(_537&&typeof _537.multiline==="boolean"){
_53f=_537.multiline;
}
if(_537&&typeof _537.modal==="boolean"){
_53d=_537.modal;
}
if(_537&&_537.buttontype){
_53e=_537.buttontype;
if(type.toUpperCase()!=="CONFIRM"){
ColdFusion.handleError(null,"messagebox.create.invalidtypeandbuttontypecombination","widget",[_532],null,null,true);
}else{
if(_53e.toUpperCase()!="YESNO"&&_53e.toUpperCase()!="YESNOCANCEL"){
ColdFusion.handleError(null,"messagebox.create.invalidbuttontype","widget",[_532,_53e],null,null,true);
}
}
}
if(_537&&_537.width){
_541=_537.width;
if(_541&&typeof _541!="number"){
ColdFusion.handleError(null,"messagebox.create.widthnotnumeric","widget",[_532,_541],null,null,true);
}
}
if(_537&&typeof _537.x!="undefined "){
if(_537.x&&typeof _537.x!="number"){
ColdFusion.handleError(null,"messagebox.create.xnotnumeric","widget",[_532,_537.x],null,null,true);
return;
}
x=_537.x;
}
if(_537&&typeof _537.y!="undefined"){
if(_537.y&&typeof _537.y!="number"){
ColdFusion.handleError(null,"messagebox.create.ynotnumeric","widget",[_532,_537.y],null,null,true);
return;
}
y=_537.y;
}
if(_537&&_537.icon){
icon=_537.icon;
if(icon){
icon=icon.toUpperCase();
if(icon!="ERROR"&&icon!="INFO"&&icon!="QUESTION"&&icon!="WARNING"){
ColdFusion.handleError(null,"messagebox.create.invalidicon","widget",[_532,icon],null,null,true);
}
}
}
if(_537&&_537.bodystyle){
_544=_537.bodystyle;
}
$MB.init(_532,type,_535,_534,_53b,_53a,_539,_53c,_53f,_53d,_536,icon,_541,x,y,_53e,_544);
ColdFusion.Log.info("messagebox.create.created","widget",[_532,type]);
};
$MB.updateMessage=function(_545,_546){
var _547=$MB.getMessageBoxObject(_545);
_547.messageText=_546;
ColdFusion.Log.info("messagebox.updatemessage.updated","widget",[_545]);
};
$MB.updateTitle=function(_548,_549){
var _54a=$MB.getMessageBoxObject(_548);
_54a.title=_549;
ColdFusion.Log.info("messagebox.updatetitle.updated","widget",[_548]);
};
$MB.update=function(_54b,_54c){
var _54d=$MB.getMessageBoxObject(_54b);
var _54e={};
if(!_54c||typeof _54c!="object"){
ColdFusion.handleError(null,"messagebox.update.invalidconfigobject","widget",[_54b],null,null,true);
return;
}
if(_54c.name&&typeof _54c.name=="string"){
ColdFusion.handleError(null,"messagebox.update.nameupdatenotallowed","widget",[_54b],null,null,true);
return;
}
if(_54c.type&&typeof _54c.type=="string"){
ColdFusion.handleError(null,"messagebox.update.typeupdatenotallowed","widget",[_54b],null,null,true);
return;
}
if(_54c.message){
if(typeof _54c.message==="string"||typeof _54c.message=="object"){
_54e.messageText=_54c.message;
}else{
ColdFusion.handleError(null,"messagebox.update.invalidmessage","widget",[_54b],null,null,true);
return;
}
}
if(_54c.title){
if(typeof _54c.title==="string"||typeof _54c.title=="object"){
_54e.title=_54c.title;
}else{
ColdFusion.handleError(null,"messagebox.update.invalidtitle","widget",[_54b],null,null,true);
return;
}
}
if(_54c.labelok!=null||typeof _54c.labelok!="undefined"){
if(typeof _54c.labelok==="string"||typeof _54c.labelok=="object"){
_54e.label_OK=_54c.labelok;
}else{
ColdFusion.handleError(null,"messagebox.update.invalidlabelok","widget",[_54b],null,null,true);
return;
}
}
if(_54c.labelno!=null||typeof _54c.labelno!="undefined"){
if(typeof _54c.labelno==="string"||typeof _54c.labelno=="object"){
_54e.label_NO=_54c.labelno;
}else{
ColdFusion.handleError(null,"messagebox.update.invalidlabelno","widget",[_54b],null,null,true);
return;
}
}
if(_54c.labelyes!=null||typeof _54c.labelyes!="undefined"){
if(typeof _54c.labelyes==="string"||typeof _54c.labelyes=="object"){
_54e.label_YES=_54c.labelyes;
}else{
ColdFusion.handleError(null,"messagebox.update.invalidlabelyes","widget",[_54b],null,null,true);
return;
}
}
if(_54c.labelcancel!=null||typeof _54c.labelcancel!="undefined"){
if(typeof _54c.labelcancel==="string"||typeof _54c.labelcancel=="object"){
_54e.label_CANCEL=_54c.labelcancel;
}else{
ColdFusion.handleError(null,"messagebox.update.invalidlabelcancel","widget",[_54b],null,null,true);
return;
}
}
if(typeof _54c.modal=="boolean"){
_54e.modal=_54c.modal;
}
if(typeof _54c.multiline==="boolean"){
if(_54d.type.toLowerCase()!="prompt"){
ColdFusion.handleError(null,"messagebox.update.invalidtypeformultiline","widget",[_54b],null,null,true);
return;
}
_54e.multiline=_54c.multiline;
}
if(_54c&&_54c.width){
if(typeof _54c.width==="number"||typeof _54c.width=="object"){
_54e.width=_54c.width;
}else{
ColdFusion.handleError(null,"messagebox.update.invalidwidth","widget",[_54b],null,null,true);
return;
}
}
if(_54c.icon!=null||typeof _54c.icon!="undefined"){
if(typeof _54c.icon==="string"){
icon=_54c.icon.toUpperCase();
if(icon!="ERROR"&&icon!="INFO"&&icon!="QUESTION"&&icon!="WARNING"){
ColdFusion.handleError(null,"messagebox.update.invalidicon","widget",[_54b],null,null,true);
return;
}
_54e.icon=_54c.icon;
}else{
if(typeof _54c.icon=="object"&&_54c.icon==null){
_54e.icon=null;
}else{
ColdFusion.handleError(null,"messagebox.update.invalidicon","widget",[_54b],null,null,true);
return;
}
}
}
if(_54c.callbackhandler!=null||typeof _54c.callbackhandler!="undefined"){
if(typeof _54c.callbackhandler==="function"||typeof _54c.callbackhandler==="object"){
_54e.callBack_Fn=_54c.callbackhandler;
}else{
ColdFusion.handleError(null,"messagebox.update.invalidcallbackhandler","widget",[_54b],null,null,true);
return;
}
}
if(_54c.x!=null||typeof _54c.x!="undefined"){
if(typeof _54c.x==="number"||typeof _54c.x=="object"){
_54e.x=_54c.x;
}else{
ColdFusion.handleError(null,"messagebox.update.xnotnumeric","widget",[_54b,_54c.x],null,null,true);
return;
}
}
if(_54c.y!=null||typeof _54c.y!="undefined"){
if(typeof _54c.y==="number"||typeof _54c.y=="object"){
_54e.y=_54c.y;
}else{
ColdFusion.handleError(null,"messagebox.update.ynotnumeric","widget",[_54b,_54c.y],null,null,true);
return;
}
}
if(_54c.bodystyle!=null||typeof _54c.bodystyle!="undefined"){
if(typeof _54c.bodystyle==="string"||typeof _54c.bodystyle=="object"){
_54e.bodyStyle=_54c.bodystyle;
}else{
ColdFusion.handleError(null,"messagebox.update.invalidbodystyle","widget",[_54b],null,null,true);
return;
}
}
if(_54c.buttontype!=null||typeof _54c.buttontype!="undefined"){
if(typeof _54c.buttontype==="string"||typeof _54c.buttontype==="object"){
buttonType=_54c.buttontype;
if(_54d.type.toUpperCase()!=="CONFIRM"){
ColdFusion.handleError(null,"messagebox.update.invalidtypeandbuttontypecombination","widget",[_54b],null,null,true);
return;
}else{
if(buttonType.toUpperCase()!="YESNO"&&buttonType.toUpperCase()!="YESNOCANCEL"){
ColdFusion.handleError(null,"messagebox.update.invalidbuttontype","widget",[_54b],null,null,true);
return;
}
}
_54e.buttonType=_54c.buttontype;
}else{
ColdFusion.handleError(null,"messagebox.update.invalidbuttontype","widget",[_54b],null,null,true);
return;
}
}
for(key in _54e){
_54d[key]=_54e[key];
}
ColdFusion.Log.info("messagebox.update.updated","messagebox",[_54b]);
};
$MB.getMessageBoxObject=function(_54f){
var _550=ColdFusion.objectCache[_54f];
if(_550==null||typeof (_550)=="undefined"){
ColdFusion.handleError(null,"messagebox.getmessageboxobject.missingmessageboxid","widget",[_54f],null,null,true);
}
return _550;
};
$MB.isMessageBoxDefined=function(_551){
var _552=ColdFusion.objectCache[_551];
if(_552==null||typeof (_552)=="undefined"){
return false;
}else{
return true;
}
};
$MB.beforeShowHandler=function(_553){
var _554=$MB.getMessageBoxObject(CURRENT_MESSAGEBOX_ID);
var _555=_554.x;
var _556=_554.y;
var _557=_554.bodyStyle;
var _558=_553.body.parent();
var id=_558.id;
var ele=document.getElementById(id);
if(null!=_557){
ele.style.cssText=_557;
}
if(_555&&_556&&typeof _555=="number"&&typeof _556=="number"&&_555>=0&&_556>=0){
_553.setPosition(_555,_556);
}else{
_553.center();
}
};
