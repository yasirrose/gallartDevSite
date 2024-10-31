/*ADOBE SYSTEMS INCORPORATED
Copyright 2012 Adobe Systems Incorporated
All Rights Reserved.

NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
terms of the Adobe license agreement accompanying it.  If you have received this file from a
source other than Adobe, then your use, modification, or distribution of it requires the prior
written permission of Adobe.*/
if(!ColdFusion.Calendar){
ColdFusion.Calendar={};
}
ColdFusion.Calendar.monthNamesShort=new Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");
ColdFusion.Calendar.monthNamesLong=new Array("January","February","March","April","May","June","July","August","September","October","November","December");
ColdFusion.Calendar.dayNamesShort=new Array("Sun","Mon","Tue","Wed","Thu","Fri","Sat");
ColdFusion.Calendar.dayNamesLong=new Array("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday");
ColdFusion.Calendar.calTableIdCounter=0;
if(navigator.userAgent.toLowerCase().indexOf("safari")>-1){
var set_month=Date.prototype.setMonth;
Date.prototype.setMonth=function(num){
if(num<=-1){
var n=Math.ceil(-num);
var _163=Math.ceil(n/12);
var _164=(n%12)?12-n%12:0;
this.setFullYear(this.getFullYear()-_163);
return set_month.call(this,_164);
}else{
return set_month.apply(this,arguments);
}
};
}
if(!String.escape){
String.escape=function(_165){
return _165.replace(/('|\\)/g,"\\$1");
};
}
ColdFusion.Calendar.setUpCalendar=function(_166,mask,_168,_169,_16a,_16b,_16c){
var _16d=ColdFusion.DOM.getElement(_166+_16b+"_cf_button",_16b);
var _16e=ColdFusion.DOM.getElement(_166,_16b);
var _16f=null;
var _170=null;
if(_16e.value!=""){
_16f=_16e.value;
_170=_16f.split("/");
}
var _171=_166+"_cf_calendar"+ColdFusion.Calendar.calTableIdCounter;
ColdFusion.Calendar.calTableIdCounter++;
var _172=ColdFusion.DOM.getElement(_166+_16b+"_cf_container",_16b);
var _173=_16e.offsetLeft;
ColdFusion.DOM.getElement(_166+_16b+"_cf_container",_16b).style.left=_173;
YAHOO.widget.Calendar.IMG_ROOT=_cf_ajaxscriptsrc+"/resources/yui/";
var _174;
if(_170&&_170[0]&&_170[2]){
_174=new YAHOO.widget.Calendar(_171,_166+_16b+"_cf_container",{close:true,pagedate:_170[0]+"/"+_170[2]});
}else{
_174=new YAHOO.widget.Calendar(_171,_166+_16b+"_cf_container",{close:true});
}
_174.calendarinputid=_166;
_174.calendarinput=_16e;
_174.mask=mask;
_174.formname=_16b;
_174.cfg.setProperty("MONTHS_LONG",_16a);
_174.cfg.setProperty("WEEKDAYS_SHORT",_169);
_174.cfg.setProperty("START_WEEKDAY",_168);
ColdFusion.objectCache[_171+_16b]=_174;
_174.select(_16f);
_174.render();
_174.hide();
_174.selectEvent.subscribe(ColdFusion.Calendar.handleDateSelect,_174,true);
YAHOO.util.Event.addListener(_166+_16b+"_cf_button","click",ColdFusion.Calendar.handleCalendarLinkClick,_174,true);
if(_16c!=null){
var year=_16c.year;
var _176=_16c.month;
var day=_16c.day;
var _178=new Date(year,_176.valueOf()-1,day);
_16e.value=ColdFusion.Calendar.createFormattedOutput(_166,mask,year,_176,day,_178);
}
};
ColdFusion.Calendar.openedCalendarInstance=null;
ColdFusion.Calendar.handleCalendarLinkClick=function(type,args){
var _17b=args;
if(ColdFusion.Calendar.openedCalendarInstance){
ColdFusion.Calendar.openedCalendarInstance.hide();
}
if(!_17b.extMask){
var _17c=ColdFusion.Calendar.convertToExtMask(_17b.mask);
_17b.extMask=_17c;
}
var _17d=ColdFusion.DOM.getElement(args.calendarinputid,_17b.formname).value;
var _17e=null;
if(typeof (_17d)!="undefined"&&ColdFusion.trim(_17d)!=""){
_17e=Ext.Date.parse(_17d,_17b.extMask);
}
if(_17e!=null){
_17b.setMonth(_17e.getMonth());
_17b.setYear(_17e.getFullYear());
_17b.select(_17e);
_17b.render();
}
ColdFusion.Calendar.openedCalendarInstance=_17b;
_17b.show();
};
ColdFusion.Calendar.handleDateSelect=function(type,args,_181){
var _182=args[0];
var date=_182[0];
var year=date[0],month=date[1],day=date[2];
var _185=new Date(year,month.valueOf()-1,day);
var _186=_181.calendarinput.value;
_181.calendarinput.value=ColdFusion.Calendar.createFormattedOutput(_181.calendarinputid,_181.mask,year,month,day,_185);
ColdFusion.Event.callBindHandlers(_181.calendarinputid,null,"change");
_181.hide();
var node=document.getElementById(_181.calendarinputid);
if(node){
if(node.onchange){
if(node.value!=_186){
node.onchange();
}
}
}
};
ColdFusion.Calendar.convertToExtMask=function(mask){
mask=mask.toUpperCase();
if(mask.indexOf("DD")!=-1){
mask=mask.replace(/DD/g,"d");
}
if(mask.indexOf("D")!=-1){
mask=mask.replace(/D/g,"d");
}
if(mask.indexOf("MMMM")!=-1){
mask=mask.replace(/MMMM/g,"F");
}else{
if(mask.indexOf("MMM")!=-1){
mask=mask.replace(/MMM/g,"M");
}else{
if(mask.indexOf("MM")!=-1){
mask=mask.replace(/MM/g,"m");
}else{
if(mask.indexOf("M")!=-1){
mask=mask.replace(/M/g,"m");
}
}
}
}
if(mask.indexOf("YYYY")!=-1){
mask=mask.replace(/YYYY/g,"Y");
}
if(mask.indexOf("YY")!=-1){
mask=mask.replace(/YY/g,"y");
}
if(mask.indexOf("EEEE")!=-1){
mask=mask.replace(/EEEE/g,"l");
}
if(mask.indexOf("EEE")!=-1){
mask=mask.replace(/EEE/g,"D");
}
if(mask.indexOf("E")!=-1){
mask=mask.replace(/E/g,"w");
}
return mask;
};
ColdFusion.Calendar.createFormattedOutput=function(_189,mask,year,_18c,day,date){
mask=mask.toUpperCase();
year=new String(year);
_18c=new String(_18c);
day=new String(day);
var _18f=date.getDay();
if(mask.indexOf("DD")!=-1){
if(day.length==1){
day="0"+day;
}
mask=mask.replace(/DD/g,day);
}
if(mask.indexOf("D"!=-1)){
if(day.length!=-1&&day.charAt(0)=="0"){
day=day.charAt(1);
}
mask=mask.replace(/D/g,day);
}
if(mask.indexOf("MMMM")!=-1){
_18c=ColdFusion.Calendar.monthNamesLong[_18c.valueOf()-1];
mask=mask.replace(/MMMM/g,_18c);
}else{
if(mask.indexOf("MMM")!=-1){
_18c=ColdFusion.Calendar.monthNamesShort[_18c.valueOf()-1];
mask=mask.replace(/MMM/g,_18c);
}else{
if(mask.indexOf("MM")!=-1){
if(_18c.length==1){
_18c="0"+_18c;
}
mask=mask.replace(/MM/g,_18c);
}else{
if(mask.indexOf("M")!=-1){
if(_18c.length!=-1&&_18c.charAt(0)=="0"){
_18c=_18c.charAt(1);
}
mask=mask.replace(/M/g,_18c);
}
}
}
}
if(mask.indexOf("YYYY")!=-1){
mask=mask.replace(/YYYY/g,year);
}
if(mask.indexOf("YY")!=-1){
year=year.substring(2);
mask=mask.replace(/YY/g,year);
}
if(mask.indexOf("EEEE")!=-1){
_18f=ColdFusion.Calendar.dayNamesLong[_18f.valueOf()];
mask=mask.replace(/EEEE/g,_18f);
}
if(mask.indexOf("EEE")!=-1){
_18f=ColdFusion.Calendar.dayNamesShort[_18f.valueOf()];
mask=mask.replace(/EEE/g,_18f);
}
if(mask.indexOf("E")!=-1){
_18f=_18f.valueOf();
_18f=new String(_18f);
if(_18f.length!=-1&&_18f.charAt(0)=="0"&&_18f.charAt(1)){
_18f=_18f.charAt(1);
}
mask=mask.replace(/E/g,_18f);
}
return mask;
};
