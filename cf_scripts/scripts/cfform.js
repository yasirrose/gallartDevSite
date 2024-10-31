/*ADOBE SYSTEMS INCORPORATED
Copyright 2012 Adobe Systems Incorporated
All Rights Reserved.

NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
terms of the Adobe license agreement accompanying it.  If you have received this file from a
source other than Adobe, then your use, modification, or distribution of it requires the prior
written permission of Adobe.*/
var _CF_error_messages=new Array();
var _CF_error_fields=new Object();
var _CF_FirstErrorField=null;
var _CF_submit_status=new Array();
_CF_signalLoad=function(){
_CF_loaded=1;
};
_CF_onError=function(_929,_92a,_92b,_92c){
if(_CF_error_fields[_92a]==null){
if(_CF_FirstErrorField==null){
_CF_FirstErrorField=_92a;
}
_CF_error_exists=true;
_CF_error_fields[_92a]=_92c;
_CF_error_messages[_CF_error_messages.length]=_92c;
}
};
_CF_onErrorAlert=function(_92d){
var _92e="";
for(var i=0;i<_92d.length;i++){
_92e+=_92d[i]+"\n";
}
alert(_92e);
return false;
};
updateHiddenValue=function(val,form,name){
if(form==null||form==""){
form=0;
}
if(document.forms[form]==null||document.forms[form][name]==null){
return;
}
document.forms[form][name].value=val;
};
_CF_hasValue=function(obj,_934,_935){
if(_934=="TEXT"||_934=="FILE"||_934=="PASSWORD"||_934=="CFTEXTAREA"||_934=="TEXTAREA"||_934=="CFTEXTINPUT"||_934=="DATEFIELD"){
if(obj.value.length==0){
return false;
}else{
if(_935){
str=obj.value.replace(/^\s+/,"").replace(/\s+$/,"");
if(str.length==0){
return false;
}
}
}
return true;
}else{
if(_934=="SELECT"){
for(i=0;i<obj.length;i++){
if(obj.options[i].selected&&obj.options[i].value.length>0){
return true;
}
}
return false;
}else{
if(_934=="SINGLE_VALUE_RADIO"||_934=="SINGLE_VALUE_CHECKBOX"){
if(obj.checked){
return true;
}else{
return false;
}
}else{
if(_934=="RADIO"||_934=="CHECKBOX"){
if(obj.length==undefined&&obj.checked){
return true;
}else{
for(i=0;i<obj.length;i++){
if(obj[i].checked){
return true;
}
}
}
return false;
}else{
if(_934=="CFTREE"){
if(obj["value"].length>0){
return true;
}else{
return false;
}
}else{
if(_934=="RICHTEXT"){
var _936=FCKeditorAPI.GetInstance(obj.id);
var val=_936.GetXHTML();
if(val.length==0){
return false;
}else{
if(_935){
str=val.replace(/^\s+/,"").replace(/\s+$/,"");
if(str.length==0){
return false;
}
}
return true;
}
}else{
return true;
}
}
}
}
}
}
};
_CF_checkdate=function(_938,_939){
_938=_938.replace(/^\s+/,"").replace(/\s+$/,"");
_938=_938=_938.replace(/{d \'/,"").replace(/'}/,"");
if(_939){
if(_938.length==0){
return false;
}
}else{
if(_938.length==0){
return true;
}
}
if(_938.length==0){
return true;
}
isplit=_938.indexOf("/");
splitchr="/";
if(isplit==-1){
isplit=_938.indexOf(".");
splitchr=".";
}
if(isplit==-1){
isplit=_938.indexOf("-");
splitchr="-";
}
if(isplit==-1||isplit==_938.length){
return false;
}
var _93a=_938.substring(0,isplit);
if(_93a.length==4){
sYear=_938.substring(0,isplit);
isplit=_938.indexOf(splitchr,isplit+1);
if(isplit==-1||(isplit+1)==_938.length){
return false;
}
sMonth=_938.substring((sYear.length+1),isplit);
sDay=_938.substring(isplit+1);
}else{
sMonth=_938.substring(0,isplit);
isplit=_938.indexOf(splitchr,isplit+1);
if(isplit==-1||(isplit+1)==_938.length){
return false;
}
sDay=_938.substring((sMonth.length+1),isplit);
sYear=_938.substring(isplit+1);
}
if((sDay.length==0)||(sMonth.length==0)||(sYear.length==0)){
return false;
}
if(!_CF_checkinteger(sMonth)){
return false;
}else{
if(!_CF_checkrange(sMonth,1,12)){
return false;
}else{
if(!_CF_checkinteger(sYear)){
return false;
}else{
if(sYear.length!=1&&sYear.length!=2&&sYear.length!=4){
return false;
}else{
if(!_CF_checkrange(sYear,0,9999)){
return false;
}else{
if(!_CF_checkinteger(sDay)){
return false;
}else{
if(!_CF_checkday(sYear,sMonth,sDay)){
return false;
}else{
return true;
}
}
}
}
}
}
}
};
_CF_checkeurodate=function(_93b,_93c){
_93b=_93b.replace(/^\s+/,"").replace(/\s+$/,"");
_93b=_93b=_93b.replace(/{d \'/,"").replace(/'}/,"");
if(_93c){
if(_93b.length==0){
return false;
}
}else{
if(_93b.length==0){
return true;
}
}
isplit=_93b.indexOf("/");
splitchr="/";
if(isplit==-1){
isplit=_93b.indexOf(".");
splitchr=".";
}
if(isplit==-1){
isplit=_93b.indexOf("-");
splitchr="-";
}
if(isplit==-1||isplit==_93b.length){
return false;
}
var _93d=_93b.substring(0,isplit);
if(_93d.length==4){
sYear=_93b.substring(0,isplit);
isplit=_93b.indexOf(splitchr,isplit+1);
if(isplit==-1||(isplit+1)==_93b.length){
return false;
}
sMonth=_93b.substring((sYear.length+1),isplit);
sDay=_93b.substring(isplit+1);
}else{
sDay=_93b.substring(0,isplit);
isplit=_93b.indexOf(splitchr,isplit+1);
if(isplit==-1||(isplit+1)==_93b.length){
return false;
}
sMonth=_93b.substring((sDay.length+1),isplit);
sYear=_93b.substring(isplit+1);
}
if(!_CF_checkinteger(sMonth)){
return false;
}else{
if(!_CF_checkrange(sMonth,1,12)){
return false;
}else{
if(!_CF_checkinteger(sYear)){
return false;
}else{
if(!_CF_checkrange(sYear,0,null)){
return false;
}else{
if(!_CF_checkinteger(sDay)){
return false;
}else{
if(!_CF_checkday(sYear,sMonth,sDay)){
return false;
}else{
return true;
}
}
}
}
}
}
};
_CF_checkday=function(_93e,_93f,_940){
maxDay=31;
if(_93f==4||_93f==6||_93f==9||_93f==11){
maxDay=30;
}else{
if(_93f==2){
if(_93e%4>0){
maxDay=28;
}else{
if(_93e%100==0&&_93e%400>0){
maxDay=28;
}else{
maxDay=29;
}
}
}
}
return _CF_checkrange(_940,1,maxDay);
};
_CF_checkinteger=function(_941,_942){
_941=_941.replace(/^\s+/,"").replace(/\s+$/,"");
_941=_941.replace(/[$Â£Â¥â‚¬,~+]?/g,"");
if(_942){
if(_941.length==0){
return false;
}
}else{
if(_941.length==0){
return true;
}
}
var _943=".";
var _944=_941.indexOf(_943);
if(_944==-1){
return _CF_checknumber(_941);
}else{
return false;
}
};
_CF_numberrange=function(_945,_946,_947,_948){
if(_948){
if(_945.length==0){
return false;
}
}else{
if(_945.length==0){
return true;
}
}
if(_946!=null){
if(_945<_946){
return false;
}
}
if(_947!=null){
if(_945>_947){
return false;
}
}
return true;
};
_CF_checknumber=function(_949,_94a){
var _94b=" .+-0123456789";
var _94c=" .0123456789";
var _94d;
var _94e=false;
var _94f=false;
var _950=false;
_949=_949.replace(/^\s+/,"").replace(/\s+$/,"");
_949=_949.replace(/[$Â£Â¥â‚¬,~+]?/g,"");
if(_94a){
if(_949.length==0){
return false;
}
}else{
if(_949.length==0){
return true;
}
}
_94d=_94b.indexOf(_949.charAt(0));
if(_94d==1){
_94e=true;
}else{
if(_94d<1){
return false;
}
}
for(var i=1;i<_949.length;i++){
_94d=_94c.indexOf(_949.charAt(i));
if(_94d<0){
return false;
}else{
if(_94d==1){
if(_94e){
return false;
}else{
_94e=true;
}
}else{
if(_94d==0){
if(_94e||_950){
_94f=true;
}
}else{
if(_94f){
return false;
}else{
_950=true;
}
}
}
}
}
return true;
};
_CF_checkrange=function(_952,_953,_954,_955){
_952=_952.replace(/^\s+/,"").replace(/\s+$/,"");
if(_955){
if(_952.length==0){
return false;
}
}else{
if(_952.length==0){
return true;
}
}
if(!_CF_checknumber(_952)){
return false;
}else{
return (_CF_numberrange((eval(_952)),_953,_954));
}
return true;
};
_CF_checktime=function(_956,_957){
_956=_956.replace(/^\s+/,"").replace(/\s+$/,"");
_956=_956.replace(/\s+:\s+/,":");
_956=_956=_956.replace(/{t \'/,"").replace(/'}/,"");
if(_957){
if(_956.length==0){
return false;
}
}else{
if(_956.length==0){
return true;
}
}
var _958=_CF_checkregex(_956,/^((([0-1]?\d)|(2[0-3])):[0-5]?\d)?(:[0-5]?\d)? ?([AP]M|[AP]m|[ap]m|[ap]M)?$/,_957);
return _958;
};
_CF_checkphone=function(_959,_95a){
_959=_959.replace(/^\s+/,"").replace(/\s+$/,"");
if(_95a){
if(_959.length==0){
return false;
}
}else{
if(_959.length==0){
return true;
}
}
if(_959.length==0){
return true;
}
return _CF_checkregex(_959,/^(((1))?[ ,\-,\.]?([\\(]?([1-9][0-9]{2})[\\)]?))?[ ,\-,\.]?([^0-1]){1}([0-9]){2}[ ,\-,\.]?([0-9]){4}(( )((x){0,1}([0-9]){1,5}){0,1})?$/,_95a);
};
_CF_checkzip=function(_95b,_95c){
_95b=_95b.replace(/^\s+/,"").replace(/\s+$/,"");
if(_95c){
if(_95b.length==0){
return false;
}
}else{
if(_95b.length==0){
return true;
}
}
return _CF_checkregex(_95b,/^([0-9]){5,5}$|(([0-9]){5,5}(-| ){1}([0-9]){4,4}$)/,_95c);
};
_CF_checkcreditcard=function(_95d,_95e){
_95d=_95d.replace(/^\s+/,"").replace(/\s+$/,"");
if(_95e){
if(_95d.length==0){
return false;
}
}else{
if(_95d.length==0){
return true;
}
}
if(_95d.length==0){
return true;
}
var _95f=" -";
var _960="";
var _961;
for(var i=0;i<_95d.length;i++){
_961=_95f.indexOf(_95d.charAt(i));
if(_961<0){
_960+=_95d.substring(i,(i+1));
}
}
if(_960.length<13||_960.length>19){
return false;
}
if(_960.charAt(0)=="+"){
return false;
}
if(!_CF_checkinteger(_960)){
return false;
}
var _963=_960.length%2==1?false:true;
var _964=0;
var _965;
for(var i=0;i<_960.length;i++){
_965=eval(_960.charAt(i));
if(_963){
_965*=2;
_964+=(_965%10);
if((_965/10)>=1){
_964++;
}
_963=false;
}else{
_964+=_965;
_963=true;
}
}
return (_964%10)==0?true:false;
};
_CF_checkssn=function(_966,_967){
_966=_966.replace(/^\s+/,"").replace(/\s+$/,"");
if(_967){
if(_966.length==0){
return false;
}
}else{
if(_966.length==0){
return true;
}
}
return _CF_checkregex(_966,/^[0-9]{3}(-| )[0-9]{2}(-| )[0-9]{4}$/,_967);
};
_CF_checkEmail=function(_968,_969){
_968=_968.replace(/^\s+/,"").replace(/\s+$/,"");
if(_969){
if(_968.length==0){
return false;
}
}else{
if(_968.length==0){
return true;
}
}
return _CF_checkregex(_968,/^[a-zA-Z_0-9-'\+~]+(\.[a-zA-Z_0-9-'\+~]+)*@([a-zA-Z_0-9-]+\.)+[a-zA-Z]*$/,_969);
};
_CF_checkURL=function(_96a,_96b){
_96a=_96a.replace(/^\s+/,"").replace(/\s+$/,"");
if(_96b){
if(_96a.length==0){
return false;
}
}else{
if(_96a.length==0){
return true;
}
}
return _CF_checkregex(_96a.toLowerCase(),/^((http|https|ftp|file)\:\/\/([a-zA-Z0-0]*:[a-zA-Z0-0]*(@))?[a-zA-Z0-9-\.]+(\.[a-zA-Z]{2,3})?(:[a-zA-Z0-9]*)?\/?([a-zA-Z0-9-\._\?\,\'\/\+&amp;%\$#\=~])*)|((mailto)\:[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z0-9]*)|((news)\:[a-zA-Z0-9\.]*)$/,_96b);
};
_CF_checkUUID=function(_96c,_96d){
_96c=_96c.replace(/^\s+/,"").replace(/\s+$/,"");
if(_96d){
if(_96c.length==0){
return false;
}
}else{
if(_96c.length==0){
return true;
}
}
return _CF_checkregex(_96c,/[A-Fa-f0-9]{8,8}-[A-Fa-f0-9]{4,4}-[A-Fa-f0-9]{4,4}-[A-Fa-f0-9]{16,16}/,_96d);
};
_CF_checkGUID=function(_96e,_96f){
_96e=_96e.replace(/^\s+/,"").replace(/\s+$/,"");
if(_96f){
if(_96e.length==0){
return false;
}
}else{
if(_96e.length==0){
return true;
}
}
return _CF_checkregex(_96e,/[A-Fa-f0-9]{8,8}-[A-Fa-f0-9]{4,4}-[A-Fa-f0-9]{4,4}-[A-Fa-f0-9]{4,4}-[A-Fa-f0-9]{12,12}/,_96f);
};
_CF_checkBoolean=function(_970,_971){
_970=_970.replace(/^\s+/,"").replace(/\s+$/,"");
if(_971){
if(_970.length==0){
return false;
}
}else{
if(_970.length==0){
return true;
}
}
if(_970.toUpperCase()=="TRUE"||_970.toUpperCase()=="YES"||(_CF_checknumber(_970)&&_970!="0")){
return true;
}else{
if(_970.toUpperCase()=="FALSE"||_970.toUpperCase()=="NO"||_970=="0"){
return true;
}else{
return false;
}
}
};
_CF_setFormParam=function(_972,_973,_974){
var _975="document['"+_972+"']['"+_973+"']";
var obj=eval(_975);
if(obj==undefined){
return false;
}else{
obj.value=_974;
return true;
}
};
_CF_checkregex=function(_977,_978,_979){
if(_979){
if(_977.length==0){
return false;
}
}else{
if(_977.length==0){
return true;
}
}
return _978.test(_977);
};
