/*ADOBE SYSTEMS INCORPORATED
Copyright 2012 Adobe Systems Incorporated
All Rights Reserved.

NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
terms of the Adobe license agreement accompanying it.  If you have received this file from a
source other than Adobe, then your use, modification, or distribution of it requires the prior
written permission of Adobe.*/
if(!ColdFusion.FileUpload){
ColdFusion.FileUpload={};
}
var $FS=ColdFusion.FileUpload;
$FS.defaultSWFLocation=_cf_ajaxscriptsrc+"/resources/cf/assets/MultiFileUpload.swf";
var isIE=(navigator.appVersion.indexOf("MSIE")!=-1)?true:false;
var isWin=(navigator.appVersion.toLowerCase().indexOf("win")!=-1)?true:false;
var isOpera=(navigator.userAgent.indexOf("Opera")!=-1)?true:false;
var defaultAddButtonLabel="Add Files";
var defaultUploadButtonLabel="Upload";
var defaultClearButtonLabel="Clear All";
var defaultDeleteButtonLabel="Delete";
var defaultAddIcon=_cf_ajaxscriptsrc+"/resources/cf/images/fileupload/addfile.png";
var defaultUploadIcon=_cf_ajaxscriptsrc+"/resources/cf/images/fileupload/upload.png";
var defaultClearIcon=_cf_ajaxscriptsrc+"/resources/cf/images/fileupload/clear.gif";
var defaultDeleteIcon=_cf_ajaxscriptsrc+"/resources/cf/images/fileupload/delete.png";
var defaultUploadSize=10*1024*1024;
var fileUploadPrefix="cf_fileUpload_";
ColdFusion.FileUpload.create=function(_4b,_4c,_4d,_4e,_4f,_50,_51,_52,_53,_54,_55,_56,_57,_58,_59,_5a,_5b,_5c,_5d,_5e,_5f,_60,_61,_62,_63,_64,_65,_66,_67,_68){
var _69={};
_69.uploadDivId=_4b;
_69.fileUploadName=fileUploadPrefix+_4b;
_69.url_withoutQuery=_4c;
_69.url_queryString=_4d;
_69.url_CF_cookie=_4e;
_69.url=$FS.constructUrl(_4c,_4d,_4e);
_69.onCompleteHandler=_56;
_69.onUploadCompleteHandler=_57;
_69.onErrorHandler=_58;
_69.progressbar=_63;
if(_5b==null){
_5b="";
}
_69.bgcolor=_5b;
if(_5c==null){
_5c="";
}
_69.selectcolor=_5c;
if(_5d==null){
_5d="";
}
_69.rollovercolor=_5d;
if(_5e==null){
_5e="";
}
_69.textcolor=_5e;
if(_61==null){
_61="left";
}
_69.titletextalign=_61;
if(_5f==null){
_5f="";
}
_69.titletextcolor=_5f;
if(_60==null){
_60="";
}
_69.headercolor=_60;
_69.bgcolor=_5b;
_69.bgcolor=_5b;
if(_62==null){
_62="";
}
_69.fileFilter=_62;
_69.disableUploadButton=_65;
if(_67==null||typeof _67=="undefined"){
_67="window";
}
_69.wmode=_67;
_69.stopOnError=_66;
if(_4f==null||typeof _4f==="undefined"){
_4f=defaultAddButtonLabel;
}
_69.addIcon=defaultAddIcon;
_69.addButtonLabel=_4f;
if(_51==null||typeof _51==="undefined"){
_51=defaultUploadButtonLabel;
}
_69.uploadButtonLabel=_51;
_69.uploadIcon=defaultUploadIcon;
if(_53==null||typeof _53==="undefined"){
_53="File Upload ";
}
_69.title=_53;
_69.swfLocation=$FS.defaultSWFLocation;
if(_50==null||typeof _50==="undefined"){
_50=defaultClearButtonLabel;
}
_69.clearButtonLabel=_50;
_69.clearIcon=defaultClearIcon;
if(_52==null||typeof _52==="undefined"){
_52=defaultDeleteButtonLabel;
}
_69.deleteButtonLabel=_52;
_69.deleteIcon=defaultDeleteIcon;
if(_54==null||!typeof _54==="Number"){
_54=-1;
}
_69.maxFileSelect=_54;
if(_55==null||!typeof _55==="number"){
_55=defaultUploadSize;
}
_69.maxUploadSize=_55;
if(_59==null||typeof _59==="undefined"){
_59=420;
}
_69.widthInPx=_59+"px";
_69.width=_59;
if(_5a==null||typeof _5a==="undefined"){
_5a=300;
}
_69.heightInPx=_5a+"px";
_69.height=_5a;
_69.align=_68;
ColdFusion.objectCache[_4b]=_69;
ColdFusion.objectCache[_69.fileUploadName]=_69;
var _6a=$FS.constructMarkup(_69);
var _6b=document.getElementById(_4b);
_6b.innerHTML=_6a;
ColdFusion.Log.info("fileupload.initialized","widget",[_4b]);
};
$FS.constructMarkup=function(_6c){
var str="";
if(isIE&&isWin&&!isOpera){
str+="<object width=\""+_6c.width+"\" height=\""+_6c.height+"\"";
str+=" id=\""+_6c.fileUploadName+"\" name=\""+_6c.playerName+"\" type=\"application/x-shockwave-flash\" classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\" ";
str+=" data=\""+_6c.swfLocation+"\">";
str+="<param name=\"movie\" value=\""+_6c.swfLocation+"\" />";
str+="<param name=\"quality\" value=\""+_6c.quality+"\" />";
str+="<param name=\"allowFullScreen\" value=\""+_6c.fullScreen+"\" />";
str+="<param name=\"allowScriptAccess\" value=\"sameDomain\" />";
str+="<param name=\"wmode\" value=\""+_6c.wmode+"\" />";
str+="<param name=\"flashvars\" value=\"uniqueid="+_6c.fileUploadName+"&url="+_6c.url+"&addLabel="+_6c.addButtonLabel+"&deleteLabel="+_6c.deleteButtonLabel;
str+="&clearLabel="+_6c.clearButtonLabel+"&uploadLabel="+_6c.uploadButtonLabel+"&maxUploadSize="+_6c.maxUploadSize+"&maxFileSelect="+_6c.maxFileSelect+"&progress="+_6c.progressbar;
str+="&stopOnError="+_6c.stopOnError+"&hideUpload="+_6c.disableUploadButton+"&bgcolor="+_6c.bgcolor+"&fileFilter="+_6c.fileFilter+"&deleteIcon="+_6c.deleteIcon+"&title="+_6c.title;
str+="&uploadIcon="+_6c.uploadIcon+"&textcolor="+_6c.textcolor+"&titletextcolor="+_6c.titletextcolor+"&headercolor="+_6c.headercolor+"&titletextalign="+_6c.titletextalign+"&rollovercolor="+_6c.rollovercolor+"&selectcolor="+_6c.selectcolor+"\" />";
str+="</object>";
}else{
str="<embed src=\""+_6c.swfLocation+"\" allowScriptAccess=\"samedomain\" pluginspage=\"http://www.adobe.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" wmode=\""+_6c.wmode+"\"";
str+=" name=\""+_6c.fileUploadName+"\" width=\""+_6c.width+"\" height=\""+_6c.height+"\" quality=\" "+_6c.quality+"\"";
str+=" flashvars=\"uniqueid="+_6c.fileUploadName+"&url="+_6c.url+"&addLabel="+_6c.addButtonLabel+"&deleteLabel="+_6c.deleteButtonLabel;
str+="&clearLabel="+_6c.clearButtonLabel+"&uploadLabel="+_6c.uploadButtonLabel+"&maxUploadSize="+_6c.maxUploadSize+"&maxFileSelect="+_6c.maxFileSelect+"&progress="+_6c.progressbar;
str+="&stopOnError="+_6c.stopOnError+"&hideUpload="+_6c.disableUploadButton+"&bgcolor="+_6c.bgcolor+"&fileFilter="+_6c.fileFilter+"&deleteIcon="+_6c.deleteIcon+"&title="+_6c.title;
str+="&uploadIcon="+_6c.uploadIcon+"&textcolor="+_6c.textcolor+"&titletextcolor="+_6c.titletextcolor+"&headercolor="+_6c.headercolor+"&titletextalign="+_6c.titletextalign+"&rollovercolor="+_6c.rollovercolor+"&selectcolor="+_6c.selectcolor+"\" />";
}
return str;
};
$FS.constructUrl=function(_6e,_6f,_70){
var url=_6e;
if(_6f!=null){
url+="?"+_6f;
if(_70!=null){
url+="%26"+_70;
}
}else{
if(_70!=null){
url+="?"+_70;
}
}
return url;
};
coldfusion_FileUploadSwf_complete=function(_72,_73){
var _74=$FS.getFileUploadComponent(_72);
var _75=ColdFusion.objectCache[_72];
var _76=_75.onCompleteHandler;
if(_76!=null&&typeof _76=="function"){
_76.call(this,_73);
}
$FS.addResultToArray(_73,_75);
};
coldfusion_FileUploadSwf_onError=function(_77,_78){
var _79=$FS.getFileUploadComponent(_77);
var _7a=ColdFusion.objectCache[_77];
var _7b=_7a.onErrorHandler;
if(_7b!=null&&typeof _7b=="function"){
_7b.call(this,_78);
}
$FS.addResultToArray(_78,_7a);
};
coldfusion_FileUploadSwf_UploadCompete=function(_7c){
var _7d=$FS.getFileUploadComponent(_7c);
var _7e=ColdFusion.objectCache[_7c];
var _7f=_7e.onUploadCompleteHandler;
var _80=_7e.resultArray;
if(_7f!=null&&typeof _7f=="function"){
_7f.call(this,_80);
}
_7e.resultArray=new Array();
};
$FS.addResultToArray=function(_81,_82){
var _83=_82.resultArray;
if(_83==null||typeof _83=="undefined"){
_83=_82.resultArray=new Array();
}
_83.push(_81);
};
$FS.cancelUpload=function(_84){
var _85=fileUploadPrefix+_84;
var _86=$FS.getFileUploadComponent(_85);
if(_86!=null){
_86.cancelFileUpload();
}else{
ColdFusion.handleError(null,"fileupload.cancelupload.notfound","widget",[_84],null,null,true);
}
ColdFusion.Log.info("fileupload.cancelupload.cancelled","widget",[_84]);
};
$FS.getSelectedFiles=function(_87){
var _88=fileUploadPrefix+_87;
var _89=$FS.getFileUploadComponent(_88);
if(_89!=null){
return _89.getSelectedFileArray();
}else{
ColdFusion.handleError(null,"fileupload.getSelectedFiles.notfound","widget",[_87],null,null,true);
}
ColdFusion.Log.info("fileupload.getSelectedFiles.selected","widget",[_87]);
};
$FS.clearAllFiles=function(_8a){
var _8b=fileUploadPrefix+_8a;
var _8c=$FS.getFileUploadComponent(_8b);
if(_8c!=null){
_8c.clearAllUpload();
}else{
ColdFusion.handleError(null,"fileupload.clearallfiles.notfound","widget",[_8a],null,null,true);
}
ColdFusion.Log.info("fileupload.clearallfiles.cleared","widget",[_8a]);
};
$FS.setURL=function(_8d,src){
var _8f=$FS.getFileUploadComponent(fileUploadPrefix+_8d);
var _90=ColdFusion.objectCache[_8d];
if(_90==null||typeof (_90)=="undefined"){
ColdFusion.handleError(null,"fileupload.setURL.notfound","widget",[_8d],null,null,true);
}
if(!src||src.length==0){
ColdFusion.handleError(null,"fileupload.setURL.invalidurl","widget",[_8d],null,null,true);
}
var _91=null;
if(src.indexOf("?")>0){
_91=src.substring(src.indexOf("?")+1);
_91=escape(_91);
src=src.substring(0,src.indexOf("?"));
}
if(src.charAt(0)!="/"&&src.indexOf("://")<0){
var _92=_90.url_withoutQuery;
_92=unescape(_92);
var _93="";
if(_92||_92.indexOf("/")>-1){
_93=_92.substring(0,_92.lastIndexOf("/")+1);
}
var _94=_93+src;
var _95=_94.split("/");
var _96=new Array();
var _97=0;
for(var i=0;i<_95.length;i++){
if(_95[i]==".."){
_96[--_97]="";
}else{
_96[_97++]=_95[i];
}
}
src=_96[0];
for(var i=1;i<_97;i++){
src=src+"/"+_96[i];
}
}
var _99=$FS.constructUrl(src,_91,_90.url_CF_cookie);
_90.url=_99;
_8f.setSrc(_99);
ColdFusion.Log.info("fileupload.setURL.urlset","widget",[_8d,_99]);
};
$FS.startUpload=function(_9a){
var _9b=fileUploadPrefix+_9a;
var _9c=$FS.getFileUploadComponent(_9b);
if(_9c!=null){
_9c.submitUploadForm();
}else{
ColdFusion.handleError(null,"fileupload.startupload.notfound","widget",[_9a],null,null,true);
}
ColdFusion.Log.info("fileupload.startupload.started","widget",[_9a]);
};
$FS.getFileUploadComponent=function(_9d){
if(navigator.appName.indexOf("Microsoft")!=-1){
if(window[_9d]!=null){
return window[_9d];
}else{
return document[_9d];
}
}else{
return document[_9d];
}
};
