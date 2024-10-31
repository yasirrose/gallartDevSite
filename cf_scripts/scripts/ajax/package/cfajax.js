/*ADOBE SYSTEMS INCORPORATED
Copyright 2012 Adobe Systems Incorporated
All Rights Reserved.

NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
terms of the Adobe license agreement accompanying it.  If you have received this file from a
source other than Adobe, then your use, modification, or distribution of it requires the prior
written permission of Adobe.*/
if(!String.prototype.startsWith){
Object.defineProperty(String.prototype,"startsWith",{value:function(_228,pos){
pos=!pos||pos<0?0:+pos;
return this.substring(pos,pos+_228.length)===_228;
}});
}
function cfinit(){
if(!window.ColdFusion){
ColdFusion={};
var $C=ColdFusion;
if(!$C.Ajax){
$C.Ajax={};
}
var $A=$C.Ajax;
if(!$C.AjaxProxy){
$C.AjaxProxy={};
}
var $X=$C.AjaxProxy;
if(!$C.Bind){
$C.Bind={};
}
var $B=$C.Bind;
if(!$C.Event){
$C.Event={};
}
var $E=$C.Event;
if(!$C.Log){
$C.Log={};
}
var $L=$C.Log;
if(!$C.Util){
$C.Util={};
}
var $U=$C.Util;
if(!$C.DOM){
$C.DOM={};
}
var $D=$C.DOM;
if(!$C.Spry){
$C.Spry={};
}
var $S=$C.Spry;
if(!$C.Pod){
$C.Pod={};
}
var $P=$C.Pod;
if(!$C.objectCache){
$C.objectCache={};
}
if(!$C.required){
$C.required={};
}
if(!$C.importedTags){
$C.importedTags=[];
}
if(!$C.requestCounter){
$C.requestCounter=0;
}
if(!$C.bindHandlerCache){
$C.bindHandlerCache={};
}
window._cf_loadingtexthtml="<div style=\"text-align: center;\">"+window._cf_loadingtexthtml+"&nbsp;"+CFMessage["loading"]+"</div>";
$C.globalErrorHandler=function(_234,_235){
if($L.isAvailable){
$L.error(_234,_235);
}
if($C.userGlobalErrorHandler){
$C.userGlobalErrorHandler(_234);
}
if(!$L.isAvailable&&!$C.userGlobalErrorHandler){
alert(_234+CFMessage["globalErrorHandler.alert"]);
}
};
$C.handleError=function(_236,_237,_238,_239,_23a,_23b,_23c,_23d){
var msg=$L.format(_237,_239);
if(_236){
$L.error(msg,"http");
if(!_23a){
_23a=-1;
}
if(!_23b){
_23b=msg;
}
_236(_23a,_23b,_23d);
}else{
if(_23c){
$L.error(msg,"http");
throw msg;
}else{
$C.globalErrorHandler(msg,_238);
}
}
};
$C.setGlobalErrorHandler=function(_23f){
$C.userGlobalErrorHandler=_23f;
};
$A.createXMLHttpRequest=function(){
try{
return new XMLHttpRequest();
}
catch(e){
}
var _240=["Microsoft.XMLHTTP","MSXML2.XMLHTTP.5.0","MSXML2.XMLHTTP.4.0","MSXML2.XMLHTTP.3.0","MSXML2.XMLHTTP"];
for(var i=0;i<_240.length;i++){
try{
return new ActiveXObject(_240[i]);
}
catch(e){
}
}
return false;
};
$A.isRequestError=function(req){
return ((req.status!=0&&req.status!=200)||req.getResponseHeader("server-error"));
};
$A.sendMessage=function(url,_244,_245,_246,_247,_248,_249){
var req=$A.createXMLHttpRequest();
if(!_244){
_244="GET";
}
if(_246&&_247){
req.onreadystatechange=function(){
$A.callback(req,_247,_248);
};
}
if(_245){
_245+="&_cf_nodebug=true&_cf_nocache=true";
}else{
_245="_cf_nodebug=true&_cf_nocache=true";
}
if(window._cf_clientid){
_245+="&_cf_clientid="+_cf_clientid;
}
if(_244=="GET"){
if(_245){
_245+="&_cf_rc="+($C.requestCounter++);
if(url.indexOf("?")==-1){
url+="?"+_245;
}else{
url+="&"+_245;
}
}
$L.info("ajax.sendmessage.get","http",[url]);
req.open(_244,url,_246);
req.send(null);
}else{
$L.info("ajax.sendmessage.post","http",[url,_245]);
req.open(_244,url,_246);
req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
if(_245){
req.send(_245);
}else{
req.send(null);
}
}
if(!_246){
while(req.readyState!=4){
}
if($A.isRequestError(req)){
$C.handleError(null,"ajax.sendmessage.error","http",[req.status,req.statusText],req.status,req.statusText,_249);
}else{
return req;
}
}
};
$A.callback=function(req,_24c,_24d){
if(req.readyState!=4){
return;
}
req.onreadystatechange=new Function;
_24c(req,_24d);
};
$A.submitForm=function(_24e,url,_250,_251,_252,_253){
var _254=$C.getFormQueryString(_24e);
if(_254==-1){
$C.handleError(_251,"ajax.submitform.formnotfound","http",[_24e],-1,null,true);
return;
}
if(!_252){
_252="POST";
}
_253=!(_253===false);
var _255=function(req){
$A.submitForm.callback(req,_24e,_250,_251);
};
$L.info("ajax.submitform.submitting","http",[_24e]);
var _257=$A.sendMessage(url,_252,_254,_253,_255);
if(!_253){
$L.info("ajax.submitform.success","http",[_24e]);
return _257.responseText;
}
};
$A.submitForm.callback=function(req,_259,_25a,_25b){
if($A.isRequestError(req)){
$C.handleError(_25b,"ajax.submitform.error","http",[req.status,_259,req.statusText],req.status,req.statusText);
}else{
$L.info("ajax.submitform.success","http",[_259]);
if(_25a){
_25a(req.responseText);
}
}
};
$C.empty=function(){
};
$C.setSubmitClicked=function(_25c,_25d){
var el=$D.getElement(_25d,_25c);
el.cfinputbutton=true;
$C.setClickedProperty=function(){
el.clicked=true;
};
$E.addListener(el,"click",$C.setClickedProperty);
};
$C.getFormQueryString=function(_25f,_260){
var _261;
if(typeof _25f=="string"){
_261=(document.getElementById(_25f)||document.forms[_25f]);
}else{
if(typeof _25f=="object"){
_261=_25f;
}
}
if(!_261||null==_261.elements){
return -1;
}
var _262,elementName,elementValue,elementDisabled;
var _263=false;
var _264=(_260)?{}:"";
for(var i=0;i<_261.elements.length;i++){
_262=_261.elements[i];
elementDisabled=_262.disabled;
elementName=_262.name;
elementValue=_262.value;
if(_262.id&&_262.id.startsWith("cf_textarea")){
var _266=CKEDITOR.instances;
if(_266){
for(ta in _266){
if(_266[ta].getData){
elementValue=_266[ta].getData();
break;
}
}
}
}
if(!elementDisabled&&elementName){
switch(_262.type){
case "select-one":
case "select-multiple":
for(var j=0;j<_262.options.length;j++){
if(_262.options[j].selected){
if(window.ActiveXObject){
_264=$C.getFormQueryString.processFormData(_264,_260,elementName,_262.options[j].attributes["value"].specified?_262.options[j].value:_262.options[j].text);
}else{
_264=$C.getFormQueryString.processFormData(_264,_260,elementName,_262.options[j].hasAttribute("value")?_262.options[j].value:_262.options[j].text);
}
}
}
break;
case "radio":
case "checkbox":
if(_262.checked){
_264=$C.getFormQueryString.processFormData(_264,_260,elementName,elementValue);
}
break;
case "file":
case undefined:
case "reset":
break;
case "button":
_264=$C.getFormQueryString.processFormData(_264,_260,elementName,elementValue);
break;
case "submit":
if(_262.cfinputbutton){
if(_263==false&&_262.clicked){
_264=$C.getFormQueryString.processFormData(_264,_260,elementName,elementValue);
_263=true;
}
}else{
_264=$C.getFormQueryString.processFormData(_264,_260,elementName,elementValue);
}
break;
case "textarea":
var _268;
if(window.FCKeditorAPI&&(_268=$C.objectCache[elementName])&&_268.richtextid){
var _269=FCKeditorAPI.GetInstance(_268.richtextid);
if(_269){
elementValue=_269.GetXHTML();
}
}
_264=$C.getFormQueryString.processFormData(_264,_260,elementName,elementValue);
break;
default:
_264=$C.getFormQueryString.processFormData(_264,_260,elementName,elementValue);
break;
}
}
}
if(!_260){
_264=_264.substr(0,_264.length-1);
}
return _264;
};
$C.getFormQueryString.processFormData=function(_26a,_26b,_26c,_26d){
if(_26b){
if(_26a[_26c]){
_26a[_26c]+=","+_26d;
}else{
_26a[_26c]=_26d;
}
}else{
_26a+=encodeURIComponent(_26c)+"="+encodeURIComponent(_26d)+"&";
}
return _26a;
};
$A.importTag=function(_26e){
$C.importedTags.push(_26e);
};
$A.checkImportedTag=function(_26f){
var _270=false;
for(var i=0;i<$C.importedTags.length;i++){
if($C.importedTags[i]==_26f){
_270=true;
break;
}
}
if(!_270){
$C.handleError(null,"ajax.checkimportedtag.error","widget",[_26f]);
}
};
$C.getElementValue=function(_272,_273,_274){
if(!_272){
$C.handleError(null,"getelementvalue.noelementname","bind",null,null,null,true);
return;
}
if(!_274){
_274="value";
}
var _275=$B.getBindElementValue(_272,_273,_274);
if(typeof (_275)=="undefined"){
_275=null;
}
if(_275==null){
$C.handleError(null,"getelementvalue.elnotfound","bind",[_272,_274],null,null,true);
return;
}
return _275;
};
$B.getBindElementValue=function(_276,_277,_278,_279,_27a){
var _27b="";
if(window[_276]){
var _27c=eval(_276);
if(_27c&&_27c._cf_getAttribute){
_27b=_27c._cf_getAttribute(_278);
return _27b;
}
}
var _27d=$C.objectCache[_276];
if(_27d&&_27d._cf_getAttribute){
_27b=_27d._cf_getAttribute(_278);
return _27b;
}
var el=$D.getElement(_276,_277);
var _27f=(el&&((!el.length&&el.length!=0)||(el.length&&el.length>0)||el.tagName=="SELECT"));
if(!_27f&&!_27a){
$C.handleError(null,"bind.getbindelementvalue.elnotfound","bind",[_276]);
return null;
}
if(el.tagName!="SELECT"){
if(el.length>1){
var _280=true;
for(var i=0;i<el.length;i++){
var _282=(el[i].getAttribute("type")=="radio"||el[i].getAttribute("type")=="checkbox");
if(!_282||(_282&&el[i].checked)){
if(!_280){
_27b+=",";
}
_27b+=$B.getBindElementValue.extract(el[i],_278);
_280=false;
}
}
}else{
_27b=$B.getBindElementValue.extract(el,_278);
}
}else{
var _280=true;
for(var i=0;i<el.options.length;i++){
if(el.options[i].selected){
if(!_280){
_27b+=",";
}
_27b+=$B.getBindElementValue.extract(el.options[i],_278);
_280=false;
}
}
}
if(typeof (_27b)=="object"){
$C.handleError(null,"bind.getbindelementvalue.simplevalrequired","bind",[_276,_278]);
return null;
}
if(_279&&$C.required[_276]&&_27b.length==0){
return null;
}
return _27b;
};
$B.getBindElementValue.extract=function(el,_284){
var _285=el[_284];
if((_285==null||typeof (_285)=="undefined")&&el.getAttribute){
_285=el.getAttribute(_284);
}
return _285;
};
$L.init=function(){
if(window.YAHOO&&YAHOO.widget&&YAHOO.widget.Logger){
YAHOO.widget.Logger.categories=[CFMessage["debug"],CFMessage["info"],CFMessage["error"],CFMessage["window"]];
YAHOO.widget.LogReader.prototype.formatMsg=function(_286){
var _287=_286.category;
return "<p>"+"<span class='"+_287+"'>"+_287+"</span>:<i>"+_286.source+"</i>: "+_286.msg+"</p>";
};
var _288=new YAHOO.widget.LogReader(null,{width:"30em",fontSize:"100%"});
_288.setTitle(CFMessage["log.title"]||"ColdFusion AJAX Logger");
_288._btnCollapse.value=CFMessage["log.collapse"]||"Collapse";
_288._btnPause.value=CFMessage["log.pause"]||"Pause";
_288._btnClear.value=CFMessage["log.clear"]||"Clear";
$L.isAvailable=true;
}
};
$L.log=function(_289,_28a,_28b,_28c){
if(!$L.isAvailable){
return;
}
if(!_28b){
_28b="global";
}
_28b=CFMessage[_28b]||_28b;
_28a=CFMessage[_28a]||_28a;
_289=$L.format(_289,_28c);
YAHOO.log(_289,_28a,_28b);
};
$L.format=function(code,_28e){
var msg=CFMessage[code]||code;
if(_28e){
for(i=0;i<_28e.length;i++){
if(!_28e[i].length){
_28e[i]="";
}
var _290="{"+i+"}";
msg=msg.replace(_290,_28e[i]);
}
}
return msg;
};
$L.debug=function(_291,_292,_293){
$L.log(_291,"debug",_292,_293);
};
$L.info=function(_294,_295,_296){
$L.log(_294,"info",_295,_296);
};
$L.error=function(_297,_298,_299){
$L.log(_297,"error",_298,_299);
};
$L.dump=function(_29a,_29b){
if($L.isAvailable){
var dump=(/string|number|undefined|boolean/.test(typeof (_29a))||_29a==null)?_29a:recurse(_29a,typeof _29a,true);
$L.debug(dump,_29b);
}
};
$X.invoke=function(_29d,_29e,_29f,_2a0,_2a1){
return $X.invokeInternal(_29d,_29e,_29f,_2a0,_2a1,false,null,null);
};
$X.invokeInternal=function(_2a2,_2a3,_2a4,_2a5,_2a6,_2a7,_2a8,_2a9){
var _2aa="method="+_2a3+"&_cf_ajaxproxytoken="+_2a4;
if(_2a7){
_2aa+="&_cfclient="+"true";
var _2ab=$X.JSON.encodeInternal(_2a2._variables,_2a7);
_2aa+="&_variables="+encodeURIComponent(_2ab);
var _2ac=$X.JSON.encodeInternal(_2a2._metadata,_2a7);
_2aa+="&_metadata="+encodeURIComponent(_2ac);
}
var _2ad=_2a2.returnFormat||"json";
_2aa+="&returnFormat="+_2ad;
if(_2a2.queryFormat){
_2aa+="&queryFormat="+_2a2.queryFormat;
}
if(_2a2.formId){
var _2ae=$C.getFormQueryString(_2a2.formId,true);
if(_2a5!=null){
for(prop in _2ae){
_2a5[prop]=_2ae[prop];
}
}else{
_2a5=_2ae;
}
_2a2.formId=null;
}
var _2af="";
if(_2a5!=null){
_2af=$X.JSON.encodeInternal(_2a5,_2a7);
_2aa+="&argumentCollection="+encodeURIComponent(_2af);
}
$L.info("ajaxproxy.invoke.invoking","http",[_2a2.cfcPath,_2a3,_2af]);
if(_2a2.callHandler){
_2a2.callHandler.call(null,_2a2.callHandlerParams,_2a2.cfcPath,_2aa);
return;
}
var _2b0;
var _2b1=_2a2.async;
if(_2a8!=null){
_2b1=true;
_2b0=function(req){
$X.callbackOp(req,_2a2,_2a6,_2a8,_2a9);
};
}else{
if(_2a2.async){
_2b0=function(req){
$X.callback(req,_2a2,_2a6);
};
}
}
var req=$A.sendMessage(_2a2.cfcPath,_2a2.httpMethod,_2aa,_2b1,_2b0,null,true);
if(!_2b1){
return $X.processResponse(req,_2a2);
}
};
$X.callback=function(req,_2b6,_2b7){
if($A.isRequestError(req)){
$C.handleError(_2b6.errorHandler,"ajaxproxy.invoke.error","http",[req.status,_2b6.cfcPath,req.statusText],req.status,req.statusText,false,_2b7);
}else{
if(_2b6.callbackHandler){
var _2b8=$X.processResponse(req,_2b6);
_2b6.callbackHandler(_2b8,_2b7);
}
}
};
$X.callbackOp=function(req,_2ba,_2bb,_2bc,_2bd){
if($A.isRequestError(req)){
var _2be=_2ba.errorHandler;
if(_2bd!=null){
_2be=_2bd;
}
$C.handleError(_2be,"ajaxproxy.invoke.error","http",[req.status,_2ba.cfcPath,req.statusText],req.status,req.statusText,false,_2bb);
}else{
if(_2bc){
var _2bf=$X.processResponse(req,_2ba);
_2bc(_2bf,_2bb);
}
}
};
$X.processResponse=function(req,_2c1){
var _2c2=true;
for(var i=0;i<req.responseText.length;i++){
var c=req.responseText.charAt(i);
_2c2=(c==" "||c=="\n"||c=="\t"||c=="\r");
if(!_2c2){
break;
}
}
var _2c5=(req.responseXML&&req.responseXML.childNodes.length>0);
var _2c6=_2c5?"[XML Document]":req.responseText;
$L.info("ajaxproxy.invoke.response","http",[_2c6]);
var _2c7;
var _2c8=_2c1.returnFormat||"json";
if(_2c8=="json"){
try{
_2c7=_2c2?null:$X.JSON.decode(req.responseText);
}
catch(e){
if(typeof _2c1._metadata!=="undefined"&&_2c1._metadata.servercfc&&typeof req.responseText==="string"){
_2c7=req.responseText;
}else{
throw e;
}
}
}else{
_2c7=_2c5?req.responseXML:(_2c2?null:req.responseText);
}
return _2c7;
};
$X.init=function(_2c9,_2ca,_2cb){
if(typeof _2cb==="undefined"){
_2cb=false;
}
var _2cc=_2ca;
if(!_2cb){
var _2cd=_2ca.split(".");
var ns=self;
for(i=0;i<_2cd.length-1;i++){
if(_2cd[i].length){
ns[_2cd[i]]=ns[_2cd[i]]||{};
ns=ns[_2cd[i]];
}
}
var _2cf=_2cd[_2cd.length-1];
if(ns[_2cf]){
return ns[_2cf];
}
ns[_2cf]=function(){
this.httpMethod="GET";
this.async=false;
this.callbackHandler=null;
this.errorHandler=null;
this.formId=null;
};
_2cc=ns[_2cf].prototype;
}else{
_2cc.httpMethod="GET";
_2cc.async=false;
_2cc.callbackHandler=null;
_2cc.errorHandler=null;
_2cc.formId=null;
}
_2cc.cfcPath=_2c9;
_2cc.setHTTPMethod=function(_2d0){
if(_2d0){
_2d0=_2d0.toUpperCase();
}
if(_2d0!="GET"&&_2d0!="POST"){
$C.handleError(null,"ajaxproxy.sethttpmethod.invalidmethod","http",[_2d0],null,null,true);
}
this.httpMethod=_2d0;
};
_2cc.setSyncMode=function(){
this.async=false;
};
_2cc.setAsyncMode=function(){
this.async=true;
};
_2cc.setCallbackHandler=function(fn){
this.callbackHandler=fn;
this.setAsyncMode();
};
_2cc.setErrorHandler=function(fn){
this.errorHandler=fn;
this.setAsyncMode();
};
_2cc.setForm=function(fn){
this.formId=fn;
};
_2cc.setQueryFormat=function(_2d4){
if(_2d4){
_2d4=_2d4.toLowerCase();
}
if(!_2d4||(_2d4!="column"&&_2d4!="row"&&_2d4!="struct")){
$C.handleError(null,"ajaxproxy.setqueryformat.invalidformat","http",[_2d4],null,null,true);
}
this.queryFormat=_2d4;
};
_2cc.setReturnFormat=function(_2d5){
if(_2d5){
_2d5=_2d5.toLowerCase();
}
if(!_2d5||(_2d5!="plain"&&_2d5!="json"&&_2d5!="wddx")){
$C.handleError(null,"ajaxproxy.setreturnformat.invalidformat","http",[_2d5],null,null,true);
}
this.returnFormat=_2d5;
};
$L.info("ajaxproxy.init.created","http",[_2c9]);
if(_2cb){
return _2cc;
}else{
return ns[_2cf];
}
};
$U.isWhitespace=function(s){
var _2d7=true;
for(var i=0;i<s.length;i++){
var c=s.charAt(i);
_2d7=(c==" "||c=="\n"||c=="\t"||c=="\r");
if(!_2d7){
break;
}
}
return _2d7;
};
$U.getFirstNonWhitespaceIndex=function(s){
var _2db=true;
for(var i=0;i<s.length;i++){
var c=s.charAt(i);
_2db=(c==" "||c=="\n"||c=="\t"||c=="\r");
if(!_2db){
break;
}
}
return i;
};
$C.trim=function(_2de){
return _2de.replace(/^\s+|\s+$/g,"");
};
$U.isInteger=function(n){
var _2e0=true;
if(typeof (n)=="number"){
_2e0=(n>=0);
}else{
for(i=0;i<n.length;i++){
if($U.isInteger.numberChars.indexOf(n.charAt(i))==-1){
_2e0=false;
break;
}
}
}
return _2e0;
};
$U.isInteger.numberChars="0123456789";
$U.isArray=function(a){
return (typeof (a.length)=="number"&&!a.toUpperCase);
};
$U.isBoolean=function(b){
if(b===true||b===false){
return true;
}else{
if(b.toLowerCase){
b=b.toLowerCase();
return (b==$U.isBoolean.trueChars||b==$U.isBoolean.falseChars);
}else{
return false;
}
}
};
$U.isBoolean.trueChars="true";
$U.isBoolean.falseChars="false";
$U.castBoolean=function(b){
if(b===true){
return true;
}else{
if(b===false){
return false;
}else{
if(b.toLowerCase){
b=b.toLowerCase();
if(b==$U.isBoolean.trueChars){
return true;
}else{
if(b==$U.isBoolean.falseChars){
return false;
}else{
return false;
}
}
}else{
return false;
}
}
}
};
$U.checkQuery=function(o){
var _2e5=null;
if(o&&o.COLUMNS&&$U.isArray(o.COLUMNS)&&o.DATA&&$U.isArray(o.DATA)&&(o.DATA.length==0||(o.DATA.length>0&&$U.isArray(o.DATA[0])))){
_2e5="row";
}else{
if(o&&o.COLUMNS&&$U.isArray(o.COLUMNS)&&o.ROWCOUNT&&$U.isInteger(o.ROWCOUNT)&&o.DATA){
_2e5="col";
for(var i=0;i<o.COLUMNS.length;i++){
var _2e7=o.DATA[o.COLUMNS[i]];
if(!_2e7||!$U.isArray(_2e7)){
_2e5=null;
break;
}
}
}
}
return _2e5;
};
$X.JSON=new function(){
var _2e8={}.hasOwnProperty?true:false;
var _2e9=/^("(\\.|[^"\\\n\r])*?"|[,:{}\[\]0-9.\-+Eaeflnr-u \n\r\t])+?$/;
var pad=function(n){
return n<10?"0"+n:n;
};
var m={"\b":"\\b","\t":"\\t","\n":"\\n","\f":"\\f","\r":"\\r","\"":"\\\"","\\":"\\\\"};
var _2ed=function(s){
if(/["\\\x00-\x1f]/.test(s)){
return "\""+s.replace(/([\x00-\x1f\\"])/g,function(a,b){
var c=m[b];
if(c){
return c;
}
c=b.charCodeAt();
return "\\u00"+Math.floor(c/16).toString(16)+(c%16).toString(16);
})+"\"";
}
return "\""+s+"\"";
};
var _2f2=function(o){
var a=["["],b,i,l=o.length,v;
for(i=0;i<l;i+=1){
v=o[i];
switch(typeof v){
case "undefined":
case "function":
case "unknown":
break;
default:
if(b){
a.push(",");
}
a.push(v===null?"null":$X.JSON.encode(v));
b=true;
}
}
a.push("]");
return a.join("");
};
var _2f5=function(o){
return "\""+o.getFullYear()+"-"+pad(o.getMonth()+1)+"-"+pad(o.getDate())+"T"+pad(o.getHours())+":"+pad(o.getMinutes())+":"+pad(o.getSeconds())+"\"";
};
this.encode=function(o){
return this.encodeInternal(o,false);
};
this.encodeInternal=function(o,cfc){
if(typeof o=="undefined"||o===null){
return "null";
}else{
if(o instanceof Array){
return _2f2(o);
}else{
if(o instanceof Date){
if(cfc){
return this.encodeInternal({_date_:o.getTime()},cfc);
}
return _2f5(o);
}else{
if(typeof o=="string"){
return _2ed(o);
}else{
if(typeof o=="number"){
return isFinite(o)?String(o):"null";
}else{
if(typeof o=="boolean"){
return String(o);
}else{
if(cfc&&typeof o=="object"&&typeof o._metadata!=="undefined"){
return "{\"_metadata\":"+this.encodeInternal(o._metadata,false)+",\"_variables\":"+this.encodeInternal(o._variables,cfc)+"}";
}else{
var a=["{"],b,i,v;
for(var i in o){
if(!_2e8||o.hasOwnProperty(i)){
v=o[i];
switch(typeof v){
case "undefined":
case "function":
case "unknown":
break;
default:
if(b){
a.push(",");
}
a.push(this.encodeInternal(i,cfc),":",v===null?"null":this.encodeInternal(v,cfc));
b=true;
}
}
}
a.push("}");
return a.join("");
}
}
}
}
}
}
}
};
this.decode=function(json){
if(typeof json=="object"){
return json;
}
if($U.isWhitespace(json)){
return null;
}
var _2fd=$U.getFirstNonWhitespaceIndex(json);
if(_2fd>0){
json=json.slice(_2fd);
}
if(window._cf_jsonprefix&&json.indexOf(_cf_jsonprefix)==0){
json=json.slice(_cf_jsonprefix.length);
}
try{
if(_2e9.test(json)){
return JSON.parse(json);
}
}
catch(e){
}
throw new SyntaxError("parseJSON");
};
}();
if(!$C.JSON){
$C.JSON={};
}
$C.JSON.encode=$X.JSON.encode;
$C.JSON.encodeInternal=$X.JSON.encodeInternal;
$C.JSON.decode=$X.JSON.decode;
$C.navigate=function(url,_2ff,_300,_301,_302,_303){
if(url==null){
$C.handleError(_301,"navigate.urlrequired","widget");
return;
}
if(_302){
_302=_302.toUpperCase();
if(_302!="GET"&&_302!="POST"){
$C.handleError(null,"navigate.invalidhttpmethod","http",[_302],null,null,true);
}
}else{
_302="GET";
}
var _304;
if(_303){
_304=$C.getFormQueryString(_303);
if(_304==-1){
$C.handleError(null,"navigate.formnotfound","http",[_303],null,null,true);
}
}
if(_2ff==null){
if(_304){
if(url.indexOf("?")==-1){
url+="?"+_304;
}else{
url+="&"+_304;
}
}
$L.info("navigate.towindow","widget",[url]);
window.location.replace(url);
return;
}
$L.info("navigate.tocontainer","widget",[url,_2ff]);
var obj=$C.objectCache[_2ff];
if(obj!=null){
if(typeof (obj._cf_body)!="undefined"&&obj._cf_body!=null){
_2ff=obj._cf_body;
}
}
$A.replaceHTML(_2ff,url,_302,_304,_300,_301);
};
$A.checkForm=function(_306,_307,_308,_309,_30a){
var _30b=_307.call(null,_306);
if(_30b==false){
return false;
}
var _30c=$C.getFormQueryString(_306);
$L.info("ajax.submitform.submitting","http",[_306.name]);
$A.replaceHTML(_308,_306.action,_306.method,_30c,_309,_30a);
return false;
};
$A.replaceHTML=function(_30d,url,_30f,_310,_311,_312){
var _313=document.getElementById(_30d);
if(!_313){
$C.handleError(_312,"ajax.replacehtml.elnotfound","http",[_30d]);
return;
}
var _314="_cf_containerId="+encodeURIComponent(_30d);
_310=(_310)?_310+"&"+_314:_314;
$L.info("ajax.replacehtml.replacing","http",[_30d,url,_310]);
if(_cf_loadingtexthtml){
try{
_313.innerHTML=_cf_loadingtexthtml;
}
catch(e){
}
}
var _315=function(req,_317){
var _318=false;
if($A.isRequestError(req)){
$C.handleError(_312,"ajax.replacehtml.error","http",[req.status,_317.id,req.statusText],req.status,req.statusText);
_318=true;
}
var _319=new $E.CustomEvent("onReplaceHTML",_317);
var _31a=new $E.CustomEvent("onReplaceHTMLUser",_317);
$E.loadEvents[_317.id]={system:_319,user:_31a};
if(req.responseText.search(/<script/i)!=-1){
try{
_317.innerHTML="";
}
catch(e){
}
$A.replaceHTML.processResponseText(req.responseText,_317,_312);
}else{
try{
_317.innerHTML=req.responseText;
$A.updateLayouttab(_317);
if(_310.indexOf("window-id")>-1){
var q=_310.substring(_310.indexOf("window-id")+10,_310.indexOf("&"));
var cmp=Ext.getCmp(q);
if(cmp){
cmp.update(_317.innerHTML);
}
}
}
catch(e){
}
}
$E.loadEvents[_317.id]=null;
_319.fire();
_319.unsubscribe();
_31a.fire();
_31a.unsubscribe();
$L.info("ajax.replacehtml.success","http",[_317.id]);
if(_311&&!_318){
_311();
}
};
try{
$A.sendMessage(url,_30f,_310,true,_315,_313);
}
catch(e){
try{
_313.innerHTML=$L.format(CFMessage["ajax.replacehtml.connectionerrordisplay"],[url,e]);
}
catch(e){
}
$C.handleError(_312,"ajax.replacehtml.connectionerror","http",[_30d,url,e]);
}
};
$A.replaceHTML.processResponseText=function(text,_31e,_31f){
var pos=0;
var _321=0;
var _322=0;
_31e._cf_innerHTML="";
while(pos<text.length){
var _323=text.indexOf("<s",pos);
if(_323==-1){
_323=text.indexOf("<S",pos);
}
if(_323==-1){
break;
}
pos=_323;
var _324=true;
var _325=$A.replaceHTML.processResponseText.scriptTagChars;
for(var i=1;i<_325.length;i++){
var _327=pos+i+1;
if(_327>text.length){
break;
}
var _328=text.charAt(_327);
if(_325[i][0]!=_328&&_325[i][1]!=_328){
pos+=i+1;
_324=false;
break;
}
}
if(!_324){
continue;
}
var _329=text.substring(_321,pos);
if(_329){
_31e._cf_innerHTML+=_329;
}
var _32a=text.indexOf(">",pos)+1;
if(_32a==0){
pos++;
continue;
}else{
pos+=7;
}
var _32b=_32a;
while(_32b<text.length&&_32b!=-1){
_32b=text.indexOf("</s",_32b);
if(_32b==-1){
_32b=text.indexOf("</S",_32b);
}
if(_32b!=-1){
_324=true;
for(var i=1;i<_325.length;i++){
var _327=_32b+2+i;
if(_327>text.length){
break;
}
var _328=text.charAt(_327);
if(_325[i][0]!=_328&&_325[i][1]!=_328){
_32b=_327;
_324=false;
break;
}
}
if(_324){
break;
}
}
}
if(_32b!=-1){
var _32c=text.substring(_32a,_32b);
var _32d=_32c.indexOf("<!--");
if(_32d!=-1){
_32c=_32c.substring(_32d+4);
}
var _32e=_32c.lastIndexOf("//-->");
if(_32e!=-1){
_32c=_32c.substring(0,_32e-1);
}
if(_32c.indexOf("document.write")!=-1||_32c.indexOf("CF_RunContent")!=-1){
if(_32c.indexOf("CF_RunContent")!=-1){
_32c=_32c.replace("CF_RunContent","document.write");
}
_32c="var _cfDomNode = document.getElementById('"+_31e.id+"'); var _cfBuffer='';"+"if (!document._cf_write)"+"{document._cf_write = document.write;"+"document.write = function(str){if (_cfBuffer!=null){_cfBuffer+=str;}else{document._cf_write(str);}};};"+_32c+";_cfDomNode._cf_innerHTML += _cfBuffer; _cfBuffer=null;";
}
try{
eval(_32c);
}
catch(ex){
$C.handleError(_31f,"ajax.replacehtml.jserror","http",[_31e.id,ex]);
}
}
_323=text.indexOf(">",_32b)+1;
if(_323==0){
_322=_32b+1;
break;
}
_322=_323;
pos=_323;
_321=_323;
}
if(_322<text.length-1){
var _329=text.substring(_322,text.length);
if(_329){
_31e._cf_innerHTML+=_329;
}
}
try{
_31e.innerHTML=_31e._cf_innerHTML;
$A.updateLayouttab(_31e);
}
catch(e){
}
_31e._cf_innerHTML="";
};
$A.updateLayouttab=function(_32f){
var _330=_32f.id;
var s=_330.substr(13,_330.length);
var cmp=Ext.getCmp(s);
var _333=_32f.innerHTML;
var _334=document.getElementById(_330);
var html=_334.innerHTML;
if(cmp){
cmp.update("<div id="+_32f.id+">"+html+"</div>");
}
var _334=document.getElementById(_330);
if(_334){
}
};
$A.replaceHTML.processResponseText.scriptTagChars=[["s","S"],["c","C"],["r","R"],["i","I"],["p","P"],["t","T"]];
$D.getElement=function(_336,_337){
var _338=function(_339){
return (_339.name==_336||_339.id==_336);
};
var _33a=$D.getElementsBy(_338,null,_337);
if(_33a.length==1){
return _33a[0];
}else{
return _33a;
}
};
$D.getElementsBy=function(_33b,tag,root){
tag=tag||"*";
var _33e=[];
if(root){
root=$D.get(root);
if(!root){
return _33e;
}
}else{
root=document;
}
var _33f=root.getElementsByTagName(tag);
if(!_33f.length&&(tag=="*"&&root.all)){
_33f=root.all;
}
for(var i=0,len=_33f.length;i<len;++i){
if(_33b(_33f[i])){
_33e[_33e.length]=_33f[i];
}
}
return _33e;
};
$D.get=function(el){
if(!el){
return null;
}
if(typeof el!="string"&&!(el instanceof Array)){
return el;
}
if(typeof el=="string"){
return document.getElementById(el);
}else{
var _342=[];
for(var i=0,len=el.length;i<len;++i){
_342[_342.length]=$D.get(el[i]);
}
return _342;
}
return null;
};
$E.loadEvents={};
$E.CustomEvent=function(_344,_345){
return {name:_344,domNode:_345,subs:[],subscribe:function(func,_347){
var dup=false;
for(var i=0;i<this.subs.length;i++){
var sub=this.subs[i];
if(sub.f==func&&sub.p==_347){
dup=true;
break;
}
}
if(!dup){
this.subs.push({f:func,p:_347});
}
},fire:function(){
for(var i=0;i<this.subs.length;i++){
var sub=this.subs[i];
sub.f.call(null,this,sub.p);
}
},unsubscribe:function(){
this.subscribers=[];
}};
};
$E.windowLoadImpEvent=new $E.CustomEvent("cfWindowLoadImp");
$E.windowLoadEvent=new $E.CustomEvent("cfWindowLoad");
$E.windowLoadUserEvent=new $E.CustomEvent("cfWindowLoadUser");
$E.listeners=[];
$E.addListener=function(el,ev,fn,_350){
var l={el:el,ev:ev,fn:fn,params:_350};
$E.listeners.push(l);
var _352=function(e){
if(!e){
var e=window.event;
}
fn.call(null,e,_350);
};
if(el.addEventListener){
window.addEventListener("load",function(){
el.addEventListener(ev,_352,false);
});
el.addEventListener(ev,_352,false);
return true;
}else{
if(el.attachEvent){
el.attachEvent("on"+ev,_352);
return true;
}else{
return false;
}
}
};
$E.isListener=function(el,ev,fn,_357){
var _358=false;
var ls=$E.listeners;
for(var i=0;i<ls.length;i++){
if(ls[i].el==el&&ls[i].ev==ev&&ls[i].fn==fn&&ls[i].params==_357){
_358=true;
break;
}
}
return _358;
};
$E.callBindHandlers=function(id,_35c,ev){
var el=document.getElementById(id);
if(!el){
return;
}
var ls=$E.listeners;
for(var i=0;i<ls.length;i++){
if(ls[i].el==el&&ls[i].ev==ev&&ls[i].fn._cf_bindhandler){
ls[i].fn.call(null,null,ls[i].params);
}
}
};
$E.registerOnLoad=function(func,_362,_363,user){
if($E.registerOnLoad.windowLoaded){
if(_362&&_362._cf_containerId&&$E.loadEvents[_362._cf_containerId]){
if(user){
$E.loadEvents[_362._cf_containerId].user.subscribe(func,_362);
}else{
$E.loadEvents[_362._cf_containerId].system.subscribe(func,_362);
}
}else{
func.call(null,null,_362);
}
}else{
if(user){
$E.windowLoadUserEvent.subscribe(func,_362);
}else{
if(_363){
$E.windowLoadImpEvent.subscribe(func,_362);
}else{
$E.windowLoadEvent.subscribe(func,_362);
}
}
}
};
$E.registerOnLoad.windowLoaded=false;
$E.onWindowLoad=function(fn){
if(window.addEventListener){
window.addEventListener("load",fn,false);
}else{
if(window.attachEvent){
window.attachEvent("onload",fn);
}else{
if(document.getElementById){
window.onload=fn;
}
}
}
};
$C.addSpanToDom=function(){
var _366=document.createElement("span");
document.body.insertBefore(_366,document.body.firstChild);
};
$E.windowLoadHandler=function(e){
if(window.Ext){
Ext.BLANK_IMAGE_URL=_cf_ajaxscriptsrc+"/resources/ext/images/default/s.gif";
}
$C.addSpanToDom();
$L.init();
$E.registerOnLoad.windowLoaded=true;
$E.windowLoadImpEvent.fire();
$E.windowLoadImpEvent.unsubscribe();
$E.windowLoadEvent.fire();
$E.windowLoadEvent.unsubscribe();
if(window.Ext){
Ext.onReady(function(){
$E.windowLoadUserEvent.fire();
});
}else{
$E.windowLoadUserEvent.fire();
}
$E.windowLoadUserEvent.unsubscribe();
};
$E.onWindowLoad($E.windowLoadHandler);
$B.register=function(_368,_369,_36a,_36b){
for(var i=0;i<_368.length;i++){
var _36d=_368[i][0];
var _36e=_368[i][1];
var _36f=_368[i][2];
if(window[_36d]){
var _370=eval(_36d);
if(_370&&_370._cf_register){
_370._cf_register(_36f,_36a,_369);
continue;
}
}
var _371=$C.objectCache[_36d];
if(_371&&_371._cf_register){
_371._cf_register(_36f,_36a,_369);
continue;
}
var _372=$D.getElement(_36d,_36e);
var _373=(_372&&((!_372.length&&_372.length!=0)||(_372.length&&_372.length>0)||_372.tagName=="SELECT"));
if(!_373){
$C.handleError(null,"bind.register.elnotfound","bind",[_36d]);
}
if(_372.length>1&&!_372.options){
for(var j=0;j<_372.length;j++){
$B.register.addListener(_372[j],_36f,_36a,_369);
}
}else{
$B.register.addListener(_372,_36f,_36a,_369);
}
}
if(!$C.bindHandlerCache[_369.bindTo]&&typeof (_369.bindTo)=="string"){
$C.bindHandlerCache[_369.bindTo]=function(){
_36a.call(null,null,_369);
};
}
if(_36b){
_36a.call(null,null,_369);
}
};
$B.register.addListener=function(_375,_376,_377,_378){
if(!$E.isListener(_375,_376,_377,_378)){
$E.addListener(_375,_376,_377,_378);
}
};
$B.assignValue=function(_379,_37a,_37b,_37c){
if(!_379){
return;
}
if(_379.call){
_379.call(null,_37b,_37c);
return;
}
var _37d=$C.objectCache[_379];
if(_37d&&_37d._cf_setValue){
_37d._cf_setValue(_37b);
return;
}
var _37e=document.getElementById(_379);
if(!_37e){
$C.handleError(null,"bind.assignvalue.elnotfound","bind",[_379]);
}
if(_37e.tagName=="SELECT"){
var _37f=$U.checkQuery(_37b);
var _380=$C.objectCache[_379];
if(_37f){
if(!_380||(_380&&(!_380.valueCol||!_380.displayCol))){
$C.handleError(null,"bind.assignvalue.selboxmissingvaldisplay","bind",[_379]);
return;
}
}else{
if(typeof (_37b.length)=="number"&&!_37b.toUpperCase){
if(_37b.length>0&&(typeof (_37b[0].length)!="number"||_37b[0].toUpperCase)){
$C.handleError(null,"bind.assignvalue.selboxerror","bind",[_379]);
return;
}
}else{
$C.handleError(null,"bind.assignvalue.selboxerror","bind",[_379]);
return;
}
}
_37e.options.length=0;
var _381;
var _382=false;
if(_380){
_381=_380.selected;
if(_381&&_381.length>0){
_382=true;
}
}
if(!_37f){
for(var i=0;i<_37b.length;i++){
var opt=new Option(_37b[i][1],_37b[i][0]);
_37e.options[i]=opt;
if(_382){
for(var j=0;j<_381.length;j++){
if(_381[j]==opt.value){
opt.selected=true;
}
}
}
}
}else{
if(_37f=="col"){
var _386=_37b.DATA[_380.valueCol];
var _387=_37b.DATA[_380.displayCol];
if(!_386||!_387){
$C.handleError(null,"bind.assignvalue.selboxinvalidvaldisplay","bind",[_379]);
return;
}
for(var i=0;i<_386.length;i++){
var opt=new Option(_387[i],_386[i]);
_37e.options[i]=opt;
if(_382){
for(var j=0;j<_381.length;j++){
if(_381[j]==opt.value){
opt.selected=true;
}
}
}
}
}else{
if(_37f=="row"){
var _388=-1;
var _389=-1;
for(var i=0;i<_37b.COLUMNS.length;i++){
var col=_37b.COLUMNS[i];
if(col==_380.valueCol){
_388=i;
}
if(col==_380.displayCol){
_389=i;
}
if(_388!=-1&&_389!=-1){
break;
}
}
if(_388==-1||_389==-1){
$C.handleError(null,"bind.assignvalue.selboxinvalidvaldisplay","bind",[_379]);
return;
}
for(var i=0;i<_37b.DATA.length;i++){
var opt=new Option(_37b.DATA[i][_389],_37b.DATA[i][_388]);
_37e.options[i]=opt;
if(_382){
for(var j=0;j<_381.length;j++){
if(_381[j]==opt.value){
opt.selected=true;
}
}
}
}
}
}
}
}else{
_37e[_37a]=_37b;
}
$E.callBindHandlers(_379,null,"change");
$L.info("bind.assignvalue.success","bind",[_37b,_379,_37a]);
};
$B.localBindHandler=function(e,_38c){
var _38d=document.getElementById(_38c.bindTo);
var _38e=$B.evaluateBindTemplate(_38c,true);
$B.assignValue(_38c.bindTo,_38c.bindToAttr,_38e);
};
$B.localBindHandler._cf_bindhandler=true;
$B.evaluateBindTemplate=function(_38f,_390,_391,_392,_393){
var _394=_38f.bindExpr;
var _395="";
if(typeof _393=="undefined"){
_393=false;
}
for(var i=0;i<_394.length;i++){
if(typeof (_394[i])=="object"){
var _397=null;
if(!_394[i].length||typeof _394[i][0]=="object"){
_397=$X.JSON.encode(_394[i]);
}else{
var _397=$B.getBindElementValue(_394[i][0],_394[i][1],_394[i][2],_390,_392);
if(_397==null){
if(_390){
_395="";
break;
}else{
_397="";
}
}
}
if(_391){
_397=encodeURIComponent(_397);
}
_395+=_397;
}else{
var _398=_394[i];
if(_393==true&&i>0){
if(typeof (_398)=="string"&&_398.indexOf("&")!=0){
_398=encodeURIComponent(_398);
}
}
_395+=_398;
}
}
return _395;
};
$B.jsBindHandler=function(e,_39a){
var _39b=_39a.bindExpr;
var _39c=new Array();
var _39d=_39a.callFunction+"(";
for(var i=0;i<_39b.length;i++){
var _39f;
if(typeof (_39b[i])=="object"){
if(_39b[i].length){
if(typeof _39b[i][0]=="object"){
_39f=_39b[i];
}else{
_39f=$B.getBindElementValue(_39b[i][0],_39b[i][1],_39b[i][2],false);
}
}else{
_39f=_39b[i];
}
}else{
_39f=_39b[i];
}
if(i!=0){
_39d+=",";
}
_39c[i]=_39f;
_39d+="'"+_39f+"'";
}
_39d+=")";
var _3a0=_39a.callFunction.apply(null,_39c);
$B.assignValue(_39a.bindTo,_39a.bindToAttr,_3a0,_39a.bindToParams);
};
$B.jsBindHandler._cf_bindhandler=true;
$B.urlBindHandler=function(e,_3a2){
var _3a3=_3a2.bindTo;
if($C.objectCache[_3a3]&&$C.objectCache[_3a3]._cf_visible===false){
$C.objectCache[_3a3]._cf_dirtyview=true;
return;
}
var url=$B.evaluateBindTemplate(_3a2,false,true,false,true);
var _3a5=$U.extractReturnFormat(url);
if(_3a5==null||typeof _3a5=="undefined"){
_3a5="JSON";
}
if(_3a2.bindToAttr||typeof _3a2.bindTo=="undefined"||typeof _3a2.bindTo=="function"){
var _3a2={"bindTo":_3a2.bindTo,"bindToAttr":_3a2.bindToAttr,"bindToParams":_3a2.bindToParams,"errorHandler":_3a2.errorHandler,"url":url,returnFormat:_3a5};
try{
$A.sendMessage(url,"GET",null,true,$B.urlBindHandler.callback,_3a2);
}
catch(e){
$C.handleError(_3a2.errorHandler,"ajax.urlbindhandler.connectionerror","http",[url,e]);
}
}else{
$A.replaceHTML(_3a3,url,null,null,_3a2.callback,_3a2.errorHandler);
}
};
$B.urlBindHandler._cf_bindhandler=true;
$B.urlBindHandler.callback=function(req,_3a7){
if($A.isRequestError(req)){
$C.handleError(_3a7.errorHandler,"bind.urlbindhandler.httperror","http",[req.status,_3a7.url,req.statusText],req.status,req.statusText);
}else{
$L.info("bind.urlbindhandler.response","http",[req.responseText]);
var _3a8;
try{
if(_3a7.returnFormat==null||_3a7.returnFormat==="JSON"){
_3a8=$X.JSON.decode(req.responseText);
}else{
_3a8=req.responseText;
}
}
catch(e){
if(req.responseText!=null&&typeof req.responseText=="string"){
_3a8=req.responseText;
}else{
$C.handleError(_3a7.errorHandler,"bind.urlbindhandler.jsonerror","http",[req.responseText]);
}
}
$B.assignValue(_3a7.bindTo,_3a7.bindToAttr,_3a8,_3a7.bindToParams);
}
};
$A.initSelect=function(_3a9,_3aa,_3ab,_3ac){
$C.objectCache[_3a9]={"valueCol":_3aa,"displayCol":_3ab,selected:_3ac};
};
$S.setupSpry=function(){
if(typeof (Spry)!="undefined"&&Spry.Data){
Spry.Data.DataSet.prototype._cf_getAttribute=function(_3ad){
var val;
var row=this.getCurrentRow();
if(row){
val=row[_3ad];
}
return val;
};
Spry.Data.DataSet.prototype._cf_register=function(_3b0,_3b1,_3b2){
var obs={bindParams:_3b2};
obs.onCurrentRowChanged=function(){
_3b1.call(null,null,this.bindParams);
};
obs.onDataChanged=function(){
_3b1.call(null,null,this.bindParams);
};
this.addObserver(obs);
};
if(Spry.Debug.trace){
var _3b4=Spry.Debug.trace;
Spry.Debug.trace=function(str){
$L.info(str,"spry");
_3b4(str);
};
}
if(Spry.Debug.reportError){
var _3b6=Spry.Debug.reportError;
Spry.Debug.reportError=function(str){
$L.error(str,"spry");
_3b6(str);
};
}
$L.info("spry.setupcomplete","bind");
}
};
$E.registerOnLoad($S.setupSpry,null,true);
$S.bindHandler=function(_3b8,_3b9){
var url;
var _3bb="_cf_nodebug=true&_cf_nocache=true";
if(window._cf_clientid){
_3bb+="&_cf_clientid="+_cf_clientid;
}
var _3bc=window[_3b9.bindTo];
var _3bd=(typeof (_3bc)=="undefined");
if(_3b9.cfc){
var _3be={};
var _3bf=_3b9.bindExpr;
for(var i=0;i<_3bf.length;i++){
var _3c1;
if(_3bf[i].length==2){
_3c1=_3bf[i][1];
}else{
_3c1=$B.getBindElementValue(_3bf[i][1],_3bf[i][2],_3bf[i][3],false,_3bd);
}
_3be[_3bf[i][0]]=_3c1;
}
_3be=$X.JSON.encode(_3be);
_3bb+="&method="+_3b9.cfcFunction;
_3bb+="&argumentCollection="+encodeURIComponent(_3be);
$L.info("spry.bindhandler.loadingcfc","http",[_3b9.bindTo,_3b9.cfc,_3b9.cfcFunction,_3be]);
url=_3b9.cfc;
}else{
url=$B.evaluateBindTemplate(_3b9,false,true,_3bd);
$L.info("spry.bindhandler.loadingurl","http",[_3b9.bindTo,url]);
}
var _3c2=_3b9.options||{};
if((_3bc&&_3bc._cf_type=="json")||_3b9.dsType=="json"){
_3bb+="&returnformat=json";
}
if(_3bc){
if(_3bc.requestInfo.method=="GET"){
_3c2.method="GET";
if(url.indexOf("?")==-1){
url+="?"+_3bb;
}else{
url+="&"+_3bb;
}
}else{
_3c2.postData=_3bb;
_3c2.method="POST";
_3bc.setURL("");
}
_3bc.setURL(url,_3c2);
_3bc.loadData();
}else{
if(!_3c2.method||_3c2.method=="GET"){
if(url.indexOf("?")==-1){
url+="?"+_3bb;
}else{
url+="&"+_3bb;
}
}else{
_3c2.postData=_3bb;
_3c2.useCache=false;
}
var ds;
if(_3b9.dsType=="xml"){
ds=new Spry.Data.XMLDataSet(url,_3b9.xpath,_3c2);
}else{
ds=new Spry.Data.JSONDataSet(url,_3c2);
ds.preparseFunc=$S.preparseData;
}
ds._cf_type=_3b9.dsType;
var _3c4={onLoadError:function(req){
$C.handleError(_3b9.errorHandler,"spry.bindhandler.error","http",[_3b9.bindTo,req.url,req.requestInfo.postData]);
}};
ds.addObserver(_3c4);
window[_3b9.bindTo]=ds;
}
};
$S.bindHandler._cf_bindhandler=true;
$S.preparseData=function(ds,_3c7){
var _3c8=$U.getFirstNonWhitespaceIndex(_3c7);
if(_3c8>0){
_3c7=_3c7.slice(_3c8);
}
if(window._cf_jsonprefix&&_3c7.indexOf(_cf_jsonprefix)==0){
_3c7=_3c7.slice(_cf_jsonprefix.length);
}
return _3c7;
};
$P.init=function(_3c9){
$L.info("pod.init.creating","widget",[_3c9]);
var _3ca={};
_3ca._cf_body=_3c9+"_body";
$C.objectCache[_3c9]=_3ca;
};
$B.cfcBindHandler=function(e,_3cc){
var _3cd=(_3cc.httpMethod)?_3cc.httpMethod:"GET";
var _3ce={};
var _3cf=_3cc.bindExpr;
for(var i=0;i<_3cf.length;i++){
var _3d1;
if(_3cf[i].length==2){
_3d1=_3cf[i][1];
}else{
_3d1=$B.getBindElementValue(_3cf[i][1],_3cf[i][2],_3cf[i][3],false);
}
_3ce[_3cf[i][0]]=_3d1;
}
var _3d2=function(_3d3,_3d4){
$B.assignValue(_3d4.bindTo,_3d4.bindToAttr,_3d3,_3d4.bindToParams);
};
var _3d5={"bindTo":_3cc.bindTo,"bindToAttr":_3cc.bindToAttr,"bindToParams":_3cc.bindToParams};
var _3d6={"async":true,"cfcPath":_3cc.cfc,"httpMethod":_3cd,"callbackHandler":_3d2,"errorHandler":_3cc.errorHandler};
if(_3cc.proxyCallHandler){
_3d6.callHandler=_3cc.proxyCallHandler;
_3d6.callHandlerParams=_3cc;
}
$X.invoke(_3d6,_3cc.cfcFunction,_3cc._cf_ajaxproxytoken,_3ce,_3d5);
};
$B.cfcBindHandler._cf_bindhandler=true;
$U.extractReturnFormat=function(url){
var _3d8;
var _3d9=url.toUpperCase();
var _3da=_3d9.indexOf("RETURNFORMAT");
if(_3da>0){
var _3db=_3d9.indexOf("&",_3da+13);
if(_3db<0){
_3db=_3d9.length;
}
_3d8=_3d9.substring(_3da+13,_3db);
}
return _3d8;
};
$U.replaceAll=function(_3dc,_3dd,_3de){
var _3df=_3dc.indexOf(_3dd);
while(_3df>-1){
_3dc=_3dc.replace(_3dd,_3de);
_3df=_3dc.indexOf(_3dd);
}
return _3dc;
};
$U.cloneObject=function(obj){
var _3e1={};
for(key in obj){
var _3e2=obj[key];
if(typeof _3e2=="object"){
_3e2=$U.cloneObject(_3e2);
}
_3e1.key=_3e2;
}
return _3e1;
};
$C.clone=function(obj,_3e4){
if(typeof (obj)!="object"){
return obj;
}
if(obj==null){
return obj;
}
var _3e5=new Object();
for(var i in obj){
if(_3e4===true){
_3e5[i]=$C.clone(obj[i]);
}else{
_3e5[i]=obj[i];
}
}
return _3e5;
};
$C.printObject=function(obj){
var str="";
for(key in obj){
str=str+"  "+key+"=";
value=obj[key];
if(typeof (value)=="object"){
value=$C.printObject(value);
}
str+=value;
}
return str;
};
}
}
cfinit();
