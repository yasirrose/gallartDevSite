/*ADOBE SYSTEMS INCORPORATED
Copyright 2012 Adobe Systems Incorporated
All Rights Reserved.

NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
terms of the Adobe license agreement accompanying it.  If you have received this file from a
source other than Adobe, then your use, modification, or distribution of it requires the prior
written permission of Adobe.*/
if(!ColdFusion.Window){
ColdFusion.Window={};
}
ColdFusion.Window.windowIdCounter=1;
ColdFusion.Window.TITLE_BGCOLOR_TEMPLATE="WINDOW_DIV_ID .x-window-tc , WINDOW_DIV_ID .x-window-tl, WINDOW_DIV_ID .x-window-tr, WINDOW_DIV_ID .x-window-bc, WINDOW_DIV_ID .x-window-br, WINDOW_DIV_ID"+" .x-window-bl, WINDOW_DIV_ID  .x-window-ml, WINDOW_DIV_ID .x-window-mr { background-image: none; background-color: COLOR_ID; }";
ColdFusion.Window.create=function(_8d1,_8d2,url,_8d4){
if(_8d1==null){
ColdFusion.handleError(null,"window.create.nullname","widget",null,null,null,true);
return;
}
if(_8d1==""){
ColdFusion.handleError(null,"window.create.emptyname","widget",null,null,null,true);
return;
}
var _8d5=ColdFusion.objectCache[_8d1];
var _8d6=false;
if(typeof (_8d5)!="undefined"&&_8d5!=null){
if(_8d5.callfromtag){
ColdFusion.handleError(null,"window.create.duplicatename","widget",[_8d1]);
}
if(typeof (_8d5.isConfObj)!="undefined"&&_8d5.isConfObj==true){
_8d6=true;
if(_8d4!=null&&typeof (_8d4.initshow)!="undefined"){
if(_8d4.initshow==false){
return;
}
}
}else{
if(!_8d4||(_8d4&&_8d4.initshow!==false)){
ColdFusion.Window.show(_8d1);
}
return;
}
}
if(!_8d5){
ColdFusion.Log.info("window.create.creating","widget",[_8d1]);
}
var _8d7=ColdFusion.Window.createHTML(_8d1,_8d2,url,_8d4,_8d6);
var _8d8=ColdFusion.objectCache[_8d1];
if(_8d8!=null&&typeof (_8d8.isConfObj)!="undefined"&&_8d8.isConfObj==true){
return;
}
return ColdFusion.Window.createJSObj(_8d1,url,_8d7);
};
ColdFusion.Window.createHTML=function(_8d9,_8da,url,_8dc,_8dd){
var _8de=null;
var _8df=null;
if(_8dc&&_8dc.divid){
_8de=document.getElementById(_8dc.divid);
}
if(_8de==null){
_8de=document.createElement("div");
_8df="cf_window"+ColdFusion.Window.windowIdCounter;
ColdFusion.Window.windowIdCounter++;
_8de.id=_8df;
_8de.className="x-hidden";
}
var _8e0=false;
var _8e1=null;
if(_8dc!=null&&typeof (_8dc.headerstyle)!="undefined"&&_8dc.headerstyle!=null){
var _8e2=new String(_8dc.headerstyle);
_8e2=_8e2.toLowerCase();
var _8e3=_8e2.indexOf("background-color");
if(_8e3>=0){
_8e0=true;
var _8e4=_8e2.indexOf(";",_8e3+17);
if(_8e4<0){
_8e4=_8e2.length;
}
_8e1=_8e2.substring(_8e3+17,_8e4);
}
}
var _8e5=document.getElementById(_8d9+"_title-html");
if(_8e0==true&&_8e1){
var _8e6="#"+_8dc.divid;
var _8e7="NAME_ID .x-window-tc , NAME_ID .x-window-tl, NAME_ID .x-window-tr, NAME_ID .x-window-bc, NAME_ID .x-window-br, NAME_ID .x-window-bl,NAME_ID .x-window-ml, NAME_ID .x-window-mr { background-image: none; background-color: COLOR_ID; }";
var _8e8=ColdFusion.Util.replaceAll(ColdFusion.Window.TITLE_BGCOLOR_TEMPLATE,"WINDOW_DIV_ID",_8e6);
var _8e8=ColdFusion.Util.replaceAll(_8e8,"COLOR_ID",_8e1);
Ext.util.CSS.createStyleSheet(_8e8);
}
if(_8e5==null){
_8e5=document.createElement("div");
_8e5.id=_8d9+"_title-html";
var _8e9="x-window-header";
_8e5.className=_8e9;
if(_8da){
_8e5.innerHTML=_8da;
}else{
_8e5.innerHTML="&nbsp;";
}
}
var _8ea=document.getElementById(_8d9+"-body");
if(_8ea==null){
_8ea=document.createElement("div");
_8ea.id=_8d9+"-body";
_8de.appendChild(_8ea);
}
var _8eb;
_8eb=ColdFusion.Window.getUpdatedConfigObj(_8dc,_8d9);
if(_8dc){
_8eb.header={style:_8dc.headerstyle};
}
if(typeof (_8eb)=="undefined"){
_8de.innerHTML="";
return;
}
if(_8df){
_8eb.divid=_8df;
}
_8eb.title=_8da;
if(typeof (_8eb.initshow)!="undefined"&&_8eb.initshow===false){
_8eb.url=url;
ColdFusion.objectCache[_8d9]=_8eb;
ColdFusion.objectCache[_8d9+"-body"]=_8eb;
}
_8eb.items=[{html:_8de.innerHTML}];
return _8eb;
};
ColdFusion.Window.createJSObj=function(_8ec,url,_8ee){
var _8ef;
var _8f0=false;
if(typeof (_8ee.childlayoutid)&&_8ee.childlayoutid!=null){
_8f0=true;
_8ee.layout="border";
_8ee.items=ColdFusion.objectCache[_8ee.childlayoutid];
}else{
var elem=document.getElementById(_8ec+"-body");
if(elem){
elem.parentNode.removeChild(elem);
}
_8ee.layout="fit";
}
if(typeof (_8ee.autoScroll)=="undefined"){
_8ee.autoScroll=true;
}
if(_8ee.onShow){
_8ee._cf_onShow=_8ee.onShow;
_8ee.onShow=null;
}
if(_8ee.onHide){
_8ee._cf_onHide=_8ee.onHide;
_8ee.onHide=null;
}
_8ef=new Ext.Window(_8ee);
_8ef.show();
_8ef.hide();
_8ef.cfwindowname=_8ec;
_8ef.tempx=_8ee.tempx;
_8ef.tempy=_8ee.tempy;
_8ef.divid=_8ee.divid;
if(typeof (_8ee.headerstyle)!="undefined"&&_8ee.headerstyle!=null){
var _8f2=document.getElementById(_8ec+"_title");
_8f2=_8f2||document.getElementById(_8ef.id+"_header_hd-textEl");
if(_8f2!=null){
_8f2.style.cssText="background:none;"+_8ee.headerstyle;
}
}
if(typeof (_8ee.bodystyle)!="undefined"&&_8ee.bodystyle!=null){
var _8f3=document.getElementById(_8ec+"-body");
if(_8f3){
var _8f4=_8f3.parentNode;
}
if(_8f4!=null){
_8f4.style.cssText=_8ee.bodystyle;
}
}
_8ef.isConfObj=false;
_8ef._cf_body=_8ec+"-body";
ColdFusion.objectCache[_8ec]=_8ef;
if(_8f0){
var _8f5=_8ef.getLayout();
var _8f6=ColdFusion.objectCache[_8ee.childlayoutid];
}
_8ef.addListener("beforeclose",ColdFusion.Window.beforeCloseHandler);
var _8f7=null;
if(typeof (url)!="undefined"&&url!=""){
_8f7=url;
}
if(_8f7==null){
if(typeof (_8ee.initshow)=="undefined"||_8ee.initshow==true){
_8ef.addListener("beforeshow",ColdFusion.Window.beforeShowHandler);
ColdFusion.Window.showandhide(_8ef,_8ee);
}
return;
}
ColdFusion.objectCache[_8ec+"-body"]=_8ef;
if(typeof (_8ee.callfromtag)=="undefined"){
var _8f8;
var _8f9;
_8ef._cf_visible=false;
_8ef._cf_dirtyview=true;
_8ef.addListener("show",ColdFusion.Window.showHandler);
_8ef.addListener("hide",ColdFusion.Window.hideHandler);
_8ef.url=_8f7;
if(_8ee){
if(typeof (_8ee.initshow)=="undefined"||_8ee.initshow==true){
ColdFusion.Window.showandhide(_8ef,_8ee);
}
_8f8=_8ee.callbackHandler;
_8f9=_8ee.errorHandler;
}
}else{
_8ef.callfromtag=true;
_8ef._cf_visible=false;
_8ef._cf_dirtyview=true;
_8ef.addListener("show",ColdFusion.Window.showHandler);
_8ef.addListener("beforeshow",ColdFusion.Window.beforeShowHandler);
_8ef.addListener("hide",ColdFusion.Window.hideHandler);
if(typeof (_8ee.initshow)=="undefined"||_8ee.initshow==true){
ColdFusion.Window.showandhide(_8ef,_8ee);
}
}
var body=document.getElementById(_8ec+"-body");
if(body){
body.style.width="100%";
body.style.height="100%";
}
var _8fb=body.parentNode.parentNode.parentNode;
if(_8fb){
_8fb.style.overflow="auto";
}
var _8fc=document.getElementsByClassName("x-window-bodywrap");
if(typeof (_8fc)!="undefined"){
for(var i=0;i<_8fc.length;i++){
var elem=_8fc[i].firstChild;
elem.style.overflow="hidden";
}
}
};
ColdFusion.Window.showandhide=function(_8fe,_8ff){
if(typeof (_8ff.tempinitshow)!="undefined"&&_8ff.tempinitshow==false){
var _900=Ext.Element.get(_8fe.divid);
if(typeof _900!="undefined"&&_900){
_900.show();
_900.hide();
}
}else{
if(_8fe){
_8fe.show();
}
}
};
ColdFusion.Window.destroy=function(_901,_902){
if(_901){
var _903=ColdFusion.Window.getWindowObject(_901);
if(_903){
if(_902===true){
_903.destroy(true);
}else{
_903.destroy();
}
ColdFusion.objectCache[_901]=null;
}
}
};
ColdFusion.Window.resizeHandler=function(_904,_905,_906){
if(typeof (_904.fixedcenter)!="undefined"&&_904.fixedcenter==true){
_904.center();
}
};
ColdFusion.Window.beforeShowHandler=function(_907){
if(typeof (_907.fixedcenter)!="undefined"&&_907.fixedcenter==true){
_907.center();
}
};
ColdFusion.Window.beforeCloseHandler=function(_908){
if(_908.destroyonclose!="undefined"&&_908.destroyonclose==true){
ColdFusion.objectCache[_908.cfwindowname]=null;
return true;
}else{
_908.hide();
return false;
}
};
ColdFusion.Window.showHandler=function(_909){
_909._cf_visible=true;
if(_909._cf_dirtyview){
if(typeof (_909.callfromtag)=="undefined"){
ColdFusion.Ajax.replaceHTML(_909._cf_body,_909.url,"GET",null,_909.callbackHandler,_909.errorHandler);
}else{
var _90a=ColdFusion.bindHandlerCache[_909._cf_body];
if(_90a){
_90a();
}
}
_909._cf_dirtyview=false;
}
};
ColdFusion.Window.hideHandler=function(_90b){
_90b._cf_visible=false;
if(_90b._cf_refreshOnShow){
_90b._cf_dirtyview=true;
}
};
ColdFusion.Window.xPosition=50;
ColdFusion.Window.yPosition=50;
ColdFusion.Window.resetHTML=function(_90c){
var _90d=document.getElementById(_90c);
if(_90d){
_90d.innerHTML="";
}
};
ColdFusion.Window.getUpdatedConfigObj=function(_90e,_90f){
var _910={};
if(_90e!=null){
if(typeof (_90e)!="object"){
ColdFusion.Window.resetHTML(_90f);
ColdFusion.handleError(null,"window.getupdatedconfigobject.invalidconfig","widget",[_90f],null,null,true);
return;
}
for(var key in _90e){
if(key=="center"&&ColdFusion.Util.isBoolean(_90e["center"])){
_910["fixedcenter"]=_90e["center"];
}else{
_910[key]=_90e[key];
}
}
}
if(typeof (_910.initshow)!="undefined"){
if(ColdFusion.Util.isBoolean(_910.initshow)==false){
ColdFusion.Window.resetHTML(_90f);
ColdFusion.handleError(null,"window.getupdatedconfigobject.invalidinitshow","widget",[_90f],null,null,true);
return;
}else{
_910.initshow=ColdFusion.Util.castBoolean(_910.initshow);
_910._cf_visible=_910.initshow;
}
}
_910.tempcenter=null;
if(typeof (_910.fixedcenter)!="undefined"){
if(ColdFusion.Util.isBoolean(_910.fixedcenter)==false){
ColdFusion.Window.resetHTML(_90f);
ColdFusion.handleError(null,"window.getupdatedconfigobject.invalidcenter","widget",[_90f],null,null,true);
return;
}else{
_910.fixedcenter=ColdFusion.Util.castBoolean(_910.fixedcenter);
}
}
if(typeof (_910.resizable)!="undefined"){
if(ColdFusion.Util.isBoolean(_910.resizable)==false){
ColdFusion.Window.resetHTML(_90f);
ColdFusion.handleError(null,"window.getupdatedconfigobject.invalidresizable","widget",[_90f],null,null,true);
return;
}else{
_910.resizable=ColdFusion.Util.castBoolean(_910.resizable);
}
}
if(typeof (_910.draggable)!="undefined"){
if(ColdFusion.Util.isBoolean(_910.draggable)==false){
ColdFusion.Window.resetHTML(_90f);
ColdFusion.handleError(null,"window.getupdatedconfigobject.invaliddraggable","widget",[_90f],null,null,true);
return;
}else{
_910.draggable=ColdFusion.Util.castBoolean(_910.draggable);
}
}
if(typeof (_910.closable)!="undefined"){
if(ColdFusion.Util.isBoolean(_910.closable)==false){
ColdFusion.Window.resetHTML(_90f);
ColdFusion.handleError(null,"window.getupdatedconfigobject.invalidclosable","widget",[_90f],null,null,true);
return;
}else{
_910.closable=ColdFusion.Util.castBoolean(_910.closable);
}
}
if(typeof (_910.modal)!="undefined"){
if(ColdFusion.Util.isBoolean(_910.modal)==false){
ColdFusion.Window.resetHTML(_90f);
ColdFusion.handleError(null,"window.getupdatedconfigobject.invalidmodal","widget",[_90f],null,null,true);
return;
}else{
_910.modal=ColdFusion.Util.castBoolean(_910.modal);
}
}
if(typeof (_910.refreshonshow)!="undefined"){
if(ColdFusion.Util.isBoolean(_910.refreshonshow)==false){
ColdFusion.Window.resetHTML(_90f);
ColdFusion.handleError(null,"window.getupdatedconfigobject.invalidrefreshonshow","widget",[_90f],null,null,true);
return;
}else{
_910._cf_refreshOnShow=ColdFusion.Util.castBoolean(_910.refreshonshow);
}
}
_910.shadow=true;
if(!_910.height){
_910.height=300;
}else{
if(ColdFusion.Util.isInteger(_910.height)==false){
ColdFusion.Window.resetHTML(_90f);
ColdFusion.handleError(null,"window.getupdatedconfigobject.invalidheight","widget",[_90f],null,null,true);
return;
}
}
if(!_910.width){
_910.width=500;
}else{
if(ColdFusion.Util.isInteger(_910.width)==false){
ColdFusion.Window.resetHTML(_90f);
ColdFusion.handleError(null,"window.getupdatedconfigobject.invalidwidth","widget",[_90f],null,null,true);
return;
}
}
var _912=false;
if(_910.minwidth){
if(ColdFusion.Util.isInteger(_910.minwidth)==false){
ColdFusion.Window.resetHTML(_90f);
ColdFusion.handleError(null,"window.getupdatedconfigobject.invalidminwidth","widget",[_90f],null,null,true);
return;
}
var _913=_910.minwidth;
var _914=_910.width;
if(typeof (_913)!="number"){
_913=parseInt(_913);
}
if(typeof (_914)!="number"){
_914=parseInt(_914);
}
if(_913>_914){
ColdFusion.Window.resetHTML(_90f);
ColdFusion.handleError(null,"window.getupdatedconfigobject.invalidminwidth","widget",[_90f],null,null,true);
return;
}
_910.minWidth=_910.minwidth;
_912=true;
}
if(_910.minheight){
if(ColdFusion.Util.isInteger(_910.minheight)==false){
ColdFusion.Window.resetHTML(_90f);
ColdFusion.handleError(null,"window.getupdatedconfigobject.invalidminheight","widget",[_90f],null,null,true);
return;
}
var _915=_910.minheight;
var _916=_910.height;
if(typeof (_915)!="number"){
_915=parseInt(_915);
}
if(typeof (_916)!="number"){
_916=parseInt(_916);
}
if(_915>_916){
ColdFusion.Window.resetHTML(_90f);
ColdFusion.handleError(null,"window.getupdatedconfigobject.invalidheightvalue","widget",[_90f],null,null,true);
return;
}
_910.minHeight=_910.minheight;
_912=true;
}
if(_910.x){
if(ColdFusion.Util.isInteger(_910.x)==false){
ColdFusion.Window.resetHTML(_90f);
ColdFusion.handleError(null,"window.getupdatedconfigobject.invalidx","widget",[_90f],null,null,true);
return;
}
}
if(_910.y){
if(ColdFusion.Util.isInteger(_910.y)==false){
ColdFusion.Window.resetHTML(_90f);
ColdFusion.handleError(null,"window.getupdatedconfigobject.invalidy","widget",[_90f],null,null,true);
return;
}
}
if(typeof (_910.x)=="undefined"&&(typeof (_910.fixedcenter)=="undefined"||_910.fixedcenter==false)){
_910.x=ColdFusion.Window.xPosition;
ColdFusion.Window.xPosition+=15;
}
if(typeof (_910.y)=="undefined"&&(typeof (_910.fixedcenter)=="undefined"||_910.fixedcenter==false)){
_910.y=ColdFusion.Window.yPosition;
ColdFusion.Window.yPosition+=15;
}
if(typeof (_910.initshow)!="undefined"&&_910.initshow===false){
_910.tempinitshow=false;
if(typeof (_910.fixedcenter)!="undefined"&&_910.fixedcenter===true){
_910.tempcenter=_910.fixedcenter;
_910.fixedcenter=null;
}else{
_910.tempx=_910.x;
_910.tempy=_910.y;
}
_910.x=-10000;
_910.y=-10000;
}
_910.constraintoviewport=true;
_910.initshow=true;
if(_910.resizable!=null&&_910.resizable==false&&_912==true){
ColdFusion.Window.resetHTML(_90f);
ColdFusion.handleError(null,"window.getupdatedconfigobject.minhwnotallowed","widget",[_90f],null,null,true);
return;
}
_910.collapsible=false;
_910.shadow=true;
_910.isConfObj=true;
return _910;
};
ColdFusion.Window.show=function(_917){
var _918=ColdFusion.objectCache[_917];
if(typeof (_918)!="undefined"&&_918!=null){
if(typeof (_918.isConfObj)!="undefined"&&_918.isConfObj==true){
_918.initshow=true;
var _919=ColdFusion.Window.createHTML(_917,null,_918.url,_918,true);
ColdFusion.Window.createJSObj(_917,_918.url,_919);
}else{
if(_918.isVisible()==false){
_918.show();
ColdFusion.Log.info("window.show.shown","widget",[_917]);
}
if(_918.tempcenter!=null){
_918.center();
_918.tempcenter=null;
}else{
if(_918.getEl()&&_918.getEl().getX()>0&&_918.getEl().getY()>0){
_918.tempx=null;
_918.tempy=null;
}else{
if(_918.tempx!=null&&_918.tempy!=null){
_918.setPosition(_918.tempx,_918.tempy);
_918.tempx=null;
_918.tempy=null;
}else{
var x=_918.getEl().getX();
var y=_918.getEl().getY();
_918.setPosition(x+1,y+1);
_918.setPosition(x,y);
}
}
}
}
}else{
ColdFusion.handleError(null,"window.show.notfound","widget",[_917],null,null,true);
}
};
ColdFusion.Window.hide=function(_91c){
var _91d=ColdFusion.objectCache[_91c];
if(_91d){
if(_91d.isVisible&&_91d.isVisible()==true){
_91d.hide();
ColdFusion.Log.info("window.hide.hidden","widget",[_91c]);
}
}else{
ColdFusion.handleError(null,"window.hide.notfound","widget",[_91c],null,null,true);
}
};
ColdFusion.Window.onShow=function(_91e,_91f){
var _920=ColdFusion.objectCache[_91e];
if(typeof (_920)!="undefined"&&_920!=null){
_920._cf_onShow=_91f;
if(_920.addListener){
_920.addListener("show",ColdFusion.Window.onShowWrapper);
}
}else{
ColdFusion.handleError(null,"window.onshow.notfound","widget",[_91e],null,null,true);
}
};
ColdFusion.Window.onShowWrapper=function(_921){
_921._cf_onShow.call(null,_921.cfwindowname);
};
ColdFusion.Window.onHide=function(_922,_923){
var _924=ColdFusion.objectCache[_922];
if(typeof (_924)!="undefined"&&_924!=null){
_924._cf_onHide=_923;
if(_924.addListener){
_924.addListener("hide",ColdFusion.Window.onHideWrapper);
}
}else{
ColdFusion.handleError(null,"window.onhide.notfound","widget",[_922],null,null,true);
}
};
ColdFusion.Window.onHideWrapper=function(_925){
_925._cf_onHide.call(null,_925.cfwindowname);
};
ColdFusion.Window.getWindowObject=function(_926){
if(!_926){
ColdFusion.handleError(null,"window.getwindowobject.emptyname","widget",null,null,null,true);
return;
}
var _927=ColdFusion.objectCache[_926];
if(_927==null||(typeof (_927.isConfObj)=="undefined"&&Ext.Window.prototype.isPrototypeOf(_927)==false)){
ColdFusion.handleError(null,"window.getwindowobject.notfound","widget",[_926],null,null,true);
return;
}
if(typeof (_927.isConfObj)!="undefined"&&_927.isConfObj==true){
_927.initshow=true;
var _928=ColdFusion.Window.createHTML(_926,null,_927.url,_927,true);
ColdFusion.Window.createJSObj(_926,_927.url,_928);
ColdFusion.Window.hide(_926);
_927=ColdFusion.objectCache[_926];
}
return _927;
};
