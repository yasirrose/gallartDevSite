/*ADOBE SYSTEMS INCORPORATED
Copyright 2012 Adobe Systems Incorporated
All Rights Reserved.

NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
terms of the Adobe license agreement accompanying it.  If you have received this file from a
source other than Adobe, then your use, modification, or distribution of it requires the prior
written permission of Adobe.*/
if(!ColdFusion.Layout){
ColdFusion.Layout={};
}
var ACCORDION_TITLE_ICON_CSS_TEMPLATE=".{0} { background-image:url({1}); }";
if(!ColdFusion.MapVsAccordion){
ColdFusion.MapVsAccordion={};
}
ColdFusion.Layout.initializeTabLayout=function(id,_9f,_a0,_a1,_a2){
Ext.QuickTips.init();
var _a3;
if(_a0){
_a3={renderTo:id,height:_a0};
}else{
_a3={renderTo:id,autoHeight:true};
}
if(_a1&&_a1!="undefined"){
_a3.width=_a1;
}else{
_a3.autoWidth=true;
}
if(_9f){
_a3.tabPosition="bottom";
}else{
_a3.enableTabScroll=true;
}
_a3.plain=!_a2;
var _a4=new Ext.tab.Panel(_a3);
ColdFusion.objectCache[id]=_a4;
return _a4;
};
ColdFusion.Layout.getTabLayout=function(_a5){
var _a6=ColdFusion.objectCache[_a5];
if(!_a6||!(_a6 instanceof Ext.TabPanel)){
ColdFusion.handleError(null,"layout.gettablayout.notfound","widget",[_a5],null,null,true);
}
return _a6;
};
ColdFusion.Layout.onTabActivate=function(tab){
tab._cf_visible=true;
if(tab._cf_dirtyview){
var _a8=ColdFusion.bindHandlerCache[tab._cf_body];
if(_a8){
_a8();
}
tab._cf_dirtyview=false;
}
};
ColdFusion.Layout.onTabDeactivate=function(tab){
tab._cf_visible=false;
if(tab._cf_refreshOnActivate){
tab._cf_dirtyview=true;
}
};
ColdFusion.Layout.onTabClose=function(tab){
tab._cf_visible=false;
};
ColdFusion.Layout.addTab=function(_ab,_ac,_ad,_ae,_af,_b0,_b1,_b2,_b3){
if(_af!=null&&_af.length==0){
_af=null;
}
var _b4=_ab.initialConfig.autoHeight;
if(typeof _b4=="undefined"){
_b4=false;
}
var _b5=Ext.getCmp(_ad);
if(_b5){
alert("Component with the name "+_ad+" already exists. Please use unique names for all the components. Layout will not be rendered");
return;
}
_b5=new Ext.Panel({title:_ae,contentEl:_ac,_cf_body:_ac,id:_ad,closable:_b0,tabTip:_af,autoScroll:_b3,autoShow:true,autoHeight:_b4});
var tab=_ab.add(_b5);
if(_b2){
_b5.setDisabled(true);
}
tab._cf_visible=false;
tab._cf_dirtyview=true;
tab._cf_refreshOnActivate=_b1;
tab.addListener("activate",ColdFusion.Layout.onTabActivate);
tab.addListener("deactivate",ColdFusion.Layout.onTabDeactivate);
tab.addListener("close",ColdFusion.Layout.onTabClose);
ColdFusion.objectCache[_ad]=tab;
var _b7=tab.height;
if(_b7&&_b7>1){
var _b8=document.getElementById(_ac);
_b8.style.height=_b7;
}
};
ColdFusion.Layout.enableTab=function(_b9,_ba){
var _bb=ColdFusion.objectCache[_b9];
var _bc=ColdFusion.objectCache[_ba];
if(_bb&&(_bb instanceof Ext.TabPanel)&&_bc){
_bc.setDisabled(false);
ColdFusion.Log.info("layout.enabletab.enabled","widget",[_ba,_b9]);
}else{
ColdFusion.handleError(null,"layout.enabletab.notfound","widget",[_b9],null,null,true);
}
};
ColdFusion.Layout.disableTab=function(_bd,_be){
var _bf=ColdFusion.objectCache[_bd];
var _c0=ColdFusion.objectCache[_be];
if(_bf&&(_bf instanceof Ext.TabPanel)&&_c0){
_c0.setDisabled(true);
ColdFusion.Log.info("layout.disabletab.disabled","widget",[_be,_bd]);
}else{
ColdFusion.handleError(null,"layout.disabletab.notfound","widget",[_bd],null,null,true);
}
};
ColdFusion.Layout.selectTab=function(_c1,_c2){
var _c3=ColdFusion.objectCache[_c1];
var tab=ColdFusion.objectCache[_c2];
if(_c3&&(_c3 instanceof Ext.TabPanel)&&tab){
_c3.setActiveTab(tab);
ColdFusion.Log.info("layout.selecttab.selected","widget",[_c2,_c1]);
}else{
ColdFusion.handleError(null,"layout.selecttab.notfound","widget",[_c1],null,null,true);
}
};
ColdFusion.Layout.hideTab=function(_c5,_c6){
var _c7=ColdFusion.objectCache[_c5];
if(_c7&&(_c7 instanceof Ext.TabPanel)){
var _c8=ColdFusion.objectCache[_c6];
var _c9=false;
if(_c8){
if(_c7.getActiveTab()&&_c7.getActiveTab().getId()==_c6){
var i;
for(i=0;i<_c7.items.length;i++){
var _cb=_c7.getComponent(i);
if(_cb.hidden==false){
_c9=true;
_cb.show();
break;
}
}
if(_c9==false){
document.getElementById(_c6).style.display="none";
}
}
_c8.tab.hide();
ColdFusion.Log.info("layout.hidetab.hide","widget",[_c6,_c5]);
}
}else{
ColdFusion.handleError(null,"layout.hidetab.notfound","widget",[_c5],null,null,true);
}
};
ColdFusion.Layout.showTab=function(_cc,_cd){
var _ce=ColdFusion.objectCache[_cc];
var _cf=ColdFusion.objectCache[_cd];
if(_ce&&(_ce instanceof Ext.TabPanel)&&_cf){
_cf.tab.show();
ColdFusion.Log.info("layout.showtab.show","widget",[_cd,_cc]);
}else{
ColdFusion.handleError(null,"layout.showtab.notfound","widget",[_cc],null,null,true);
}
};
ColdFusion.Layout.disableSourceBind=function(_d0){
var _d1=ColdFusion.objectCache[_d0];
if(_d1==null||_d1=="undefined"){
ColdFusion.handleError(null,"layout.disableSourceBind.notfound","widget",[_d0],null,null,true);
}
_d1._cf_dirtyview=false;
};
ColdFusion.Layout.enableSourceBind=function(_d2){
var _d3=ColdFusion.objectCache[_d2];
if(_d3==null||_d3=="undefined"){
ColdFusion.handleError(null,"layout.enableSourceBind.notfound","widget",[_d2],null,null,true);
}
_d3._cf_dirtyview=true;
};
ColdFusion.Layout.createTab=function(_d4,_d5,_d6,_d7,_d8){
var _d9=ColdFusion.objectCache[_d4];
var _da=_d5;
if(_d4&&typeof (_d4)!="string"){
ColdFusion.handleError(null,"layout.createtab.invalidname","widget",null,null,null,true);
return;
}
if(!_d4||ColdFusion.trim(_d4)==""){
ColdFusion.handleError(null,"layout.createtab.emptyname","widget",null,null,null,true);
return;
}
if(_d5&&typeof (_d5)!="string"){
ColdFusion.handleError(null,"layout.createtab.invalidareaname","widget",null,null,null,true);
return;
}
if(!_d5||ColdFusion.trim(_d5)==""){
ColdFusion.handleError(null,"layout.createtab.emptyareaname","widget",null,null,null,true);
return;
}
if(_d6&&typeof (_d6)!="string"){
ColdFusion.handleError(null,"layout.createtab.invalidtitle","widget",null,null,null,true);
return;
}
if(!_d6||ColdFusion.trim(_d6)==""){
ColdFusion.handleError(null,"layout.createtab.emptytitle","widget",null,null,null,true);
return;
}
if(_d7&&typeof (_d7)!="string"){
ColdFusion.handleError(null,"layout.createtab.invalidurl","widget",null,null,null,true);
return;
}
if(!_d7||ColdFusion.trim(_d7)==""){
ColdFusion.handleError(null,"layout.createtab.emptyurl","widget",null,null,null,true);
return;
}
_d5="cf_layoutarea"+_d5;
if(_d9&&(_d9 instanceof Ext.TabPanel)){
var _db=null;
var ele=document.getElementById(_d5);
if(ele!=null){
ColdFusion.handleError(null,"layout.createtab.duplicateel","widget",[_d5],null,null,true);
return;
}
var _dd=false;
var _de=false;
var _df=false;
var _e0=false;
var _e1=false;
var _e2=null;
if((_d9.items.length<=0)){
_df=true;
}
if(_d8!=null){
if(typeof (_d8)!="object"){
ColdFusion.handleError(null,"layout.createtab.invalidconfig","widget",null,null,null,true);
return;
}
if(typeof (_d8.closable)!="undefined"&&_d8.closable==true){
_dd=true;
}
if(typeof (_d8.disabled)!="undefined"&&_d8.disabled==true){
_de=true;
}
if(typeof (_d8.selected)!="undefined"&&_d8.selected==true){
_df=true;
}
if(typeof (_d8.inithide)!="undefined"&&_d8.inithide==true){
_e0=true;
}
if(typeof (_d8.tabtip)!="undefined"&&_d8.tabtip!=null){
_e2=_d8.tabtip;
}
}
var _e3=document.getElementById(_d4);
if(_e3){
var _e4=document.getElementById(_d4);
var _e5=document.createElement("div");
_e5.id=_d5;
_e5.className="ytab";
if(_d8!=null&&typeof (_d8.align)!="undefined"){
_e5.align=_d8.align;
}
var _e6="display:none";
if(_d9.tabheight){
_e6="height:"+_d9.tabheight+";";
}
if(_d8!=null&&typeof (_d8.style)!="undefined"){
var _e7=new String(_d8.style);
_e7=_e7.toLowerCase();
_e6=_e6+_e7;
}
if(_d8!=null&&typeof (_d8.overflow)!="undefined"){
var _e8=new String(_d8.overflow);
_e8=_e8.toLowerCase();
if(_e8!="visible"&&_e8!="auto"&&_e8!="scroll"&&_e8!="hidden"){
ColdFusion.handleError(null,"layout.createtab.invalidoverflow","widget",null,null,null,true);
return;
}
if(_e8.toLocaleLowerCase()==="hidden"){
_e1=false;
}
_e6=_e6+"overflow:"+_e8+";";
}else{
_e6=_e6+"; overflow:auto;";
}
_e5.style.cssText=_e6;
_e4.appendChild(_e5);
}
ColdFusion.Layout.addTab(_d9,_d5,_da,_d6,_e2,_dd,false,_de,_e1);
ColdFusion.Log.info("layout.createtab.success","http",[_d5,_d4]);
if(_df==true){
ColdFusion.Layout.selectTab(_d4,_da);
}
if(_e0==true){
ColdFusion.Layout.hideTab(_d4,_da);
}
if(_d7!=null&&typeof (_d7)!="undefined"&&_d7!=""){
if(_d7.indexOf("?")!=-1){
_d7=_d7+"&";
}else{
_d7=_d7+"?";
}
var _e9;
var _ea;
if(_d8){
_e9=_d8.callbackHandler;
_ea=_d8.errorHandler;
}
ColdFusion.Ajax.replaceHTML(_d5,_d7,"GET",null,_e9,_ea);
}
}else{
ColdFusion.handleError(null,"layout.createtab.notfound","widget",[_d4],null,null,true);
}
};
ColdFusion.Layout.getBorderLayout=function(_eb){
var _ec=ColdFusion.objectCache[_eb];
if(!_ec){
ColdFusion.handleError(null,"layout.getborderlayout.notfound","widget",[_eb],null,null,true);
}
return _ec;
};
ColdFusion.Layout.showArea=function(_ed,_ee){
var _ef=ColdFusion.Layout.convertPositionToDirection(_ee);
var _f0=ColdFusion.objectCache[_ed];
var _f1;
if(_f0){
var _f2=_f0.items;
for(var i=0;i<_f2.getCount();i++){
var _f4=_f2.items[i];
if(_f4 instanceof Ext.Panel&&_f4.region==_ef){
_f1=_f4;
break;
}
}
if(_f1){
_f1.show();
_f1.expand();
ColdFusion.Log.info("layout.showarea.shown","widget",[_ee,_ed]);
}else{
ColdFusion.handleError(null,"layout.showarea.areanotfound","widget",[_ee],null,null,true);
}
}else{
ColdFusion.handleError(null,"layout.showarea.notfound","widget",[_ed],null,null,true);
}
};
ColdFusion.Layout.hideArea=function(_f5,_f6){
var _f7=ColdFusion.Layout.convertPositionToDirection(_f6);
var _f8=ColdFusion.objectCache[_f5];
var _f9;
if(_f8){
var _fa=_f8.items;
for(var i=0;i<_fa.getCount();i++){
var _fc=_fa.items[i];
if(_fc instanceof Ext.Panel&&_fc.region==_f7){
_f9=_fc;
break;
}
}
if(_f9){
_f9.hide();
ColdFusion.Log.info("layout.hidearea.hidden","widget",[_f6,_f5]);
}else{
ColdFusion.handleError(null,"layout.hidearea.areanotfound","widget",[_f6],null,null,true);
}
}else{
ColdFusion.handleError(null,"layout.hidearea.notfound","widget",[_f5],null,null,true);
}
};
ColdFusion.Layout.collapseArea=function(_fd,_fe){
var _ff=ColdFusion.Layout.convertPositionToDirection(_fe);
var _100=ColdFusion.objectCache[_fd];
var _101;
if(_100){
var _102=_100.items;
for(var i=0;i<_102.getCount();i++){
var _104=_102.items[i];
if(_104 instanceof Ext.Panel&&_104.region==_ff){
_101=_104;
break;
}
}
if(_101){
_101.collapse();
ColdFusion.Log.info("layout.collpasearea.collapsed","widget",[_fe,_fd]);
}else{
ColdFusion.handleError(null,"layout.collpasearea.areanotfound","widget",[_fe],null,null,true);
}
}else{
ColdFusion.handleError(null,"layout.collpasearea.notfound","widget",[_fe],null,null,true);
}
};
ColdFusion.Layout.expandArea=function(_105,_106){
var _107=ColdFusion.Layout.convertPositionToDirection(_106);
var _108=ColdFusion.objectCache[_105];
var _109;
if(_108){
var _10a=_108.items;
for(var i=0;i<_10a.getCount();i++){
var _10c=_10a.items[i];
if(_10c instanceof Ext.Panel&&_10c.region==_107){
_109=_10c;
break;
}
}
if(_109){
_109.expand();
ColdFusion.Log.info("layout.expandarea.expanded","widget",[_106,_105]);
}else{
ColdFusion.handleError(null,"layout.expandarea.areanotfound","widget",[_106],null,null,true);
}
}else{
ColdFusion.handleError(null,"layout.expandarea.notfound","widget",[_106],null,null,true);
}
};
ColdFusion.Layout.printObject=function(obj){
var str="";
for(key in obj){
str=str+"  "+key+"=";
value=obj[key];
if(typeof (value)==Object){
value=$G.printObject(value);
}
str+=value;
}
return str;
};
ColdFusion.Layout.InitAccordion=function(_10f,_110,_111,_112,_113,_114,_115,_116){
var _117=false;
if(_111.toUpperCase()=="LEFT"){
_117=true;
}
if(_114==null||typeof (_114)=="undefined"){
_113=false;
}
var _118={activeOnTop:_110,collapseFirst:_117,titleCollapse:_112,fill:_113};
var _119={renderTo:_10f,layoutConfig:_118,items:_116,layout:"accordion"};
if(_114==null||typeof (_114)=="undefined"){
_119.autoHeight=true;
_119.height=600;
}else{
_119.height=_114;
}
_119.flex=1;
if(_115==null||typeof (_115)=="undefined"){
_119.autoWidth=true;
}else{
_119.width=_115;
}
_119.align="stretch";
_119.preventRegister=true;
var _11a=new Ext.Panel(_119);
ColdFusion.objectCache[_10f]=_11a;
ColdFusion.Log.info("layout.accordion.initialized","widget",[_10f]);
return _11a;
};
ColdFusion.Layout.InitAccordionChildPanel=function(_11b,_11c,_11d,_11e,_11f,_120,_121,_122){
if(_11d==null||typeof (_11d)==undefined||_11d.length==0){
_11d="  ";
}
var _123={contentEl:_11b,id:_11c,title:_11d,collapsible:_11e,closable:_11f,autoScroll:_120,_cf_body:_11b};
if(_121&&typeof _121=="string"){
_123.iconCls=_121;
}
_123.preventRegister=true;
var _124=new Ext.Panel(_123);
_124._cf_visible=false;
_124._cf_dirtyview=true;
_124._cf_refreshOnActivate=_122;
_124.on("expand",ColdFusion.Layout.onAccordionPanelExpand,this);
_124.on("collapse",ColdFusion.Layout.onAccordionPanelCollapse,this);
_124.on("hide",ColdFusion.Layout.onAccordionPanelHide,this);
_124.on("show",ColdFusion.Layout.onAccordionPanelExpand,this);
ColdFusion.objectCache[_11c]=_124;
ColdFusion.Log.info("layout.accordion.childinitialized","widget",[_11c]);
return _124;
};
ColdFusion.Layout.getAccordionLayout=function(_125){
var _126=ColdFusion.objectCache[_125];
if(!_126||!(_126 instanceof Ext.Panel)){
ColdFusion.handleError(null,"layout.getaccordionlayout.notfound","widget",[_125],null,null,true);
}
return _126;
};
ColdFusion.Layout.onAccordionPanelExpand=function(_127){
_127._cf_visible=true;
if(_127._cf_dirtyview){
var _128=ColdFusion.bindHandlerCache[_127._cf_body];
if(_128){
_128();
}
_127._cf_dirtyview=false;
}
var el=Ext.get(_127.contentEl);
el.move("left",1);
el.move("right",1);
var _12a=ColdFusion.MapVsAccordion[_127._cf_body];
if(_12a!=undefined){
var _12b=$MAP.getMapPanelObject(_12a);
if(_12b!=undefined){
if(_12b.initShow===true){
$MAP.show(_12a);
}
}
}
};
ColdFusion.Layout.onAccordionPanelCollapse=function(_12c){
_12c._cf_visible=false;
if(_12c._cf_refreshOnActivate){
_12c._cf_dirtyview=true;
}
};
ColdFusion.Layout.onAccordionPanelHide=function(_12d){
_12d._cf_visible=false;
};
ColdFusion.Layout.hideAccordion=function(_12e,_12f){
var _130=ColdFusion.objectCache[_12e];
var _131=ColdFusion.objectCache[_12f];
if(!_130||!_130 instanceof Ext.Panel){
ColdFusion.handleError(null,"layout.hideaccordion.layoutnotfound","widget",[_12e],null,null,true);
}
if(!_131||!_131 instanceof Ext.Panel){
ColdFusion.handleError(null,"layout.hideaccordion.panelnotfound","widget",[_12f],null,null,true);
}
_131.hide();
ColdFusion.Log.info("layout.hideaccordion.hidden","widget",[_12f,_12e]);
};
ColdFusion.Layout.showAccordion=function(_132,_133){
var _134=ColdFusion.objectCache[_132];
var _135=ColdFusion.objectCache[_133];
if(!_134||!_134 instanceof Ext.Panel){
ColdFusion.handleError(null,"layout.showaccordion.layoutnotfound","widget",[_132],null,null,true);
}
if(!_135||!_135 instanceof Ext.Panel){
ColdFusion.handleError(null,"layout.showaccordion.panelnotfound","widget",[_133],null,null,true);
}
_135.show();
ColdFusion.Log.info("layout.showaccordion.shown","widget",[_133,_132]);
};
ColdFusion.Layout.expandAccordion=function(_136,_137){
var _138=ColdFusion.objectCache[_136];
var _139=ColdFusion.objectCache[_137];
if(!_138||!_138 instanceof Ext.Panel){
ColdFusion.handleError(null,"layout.expandaccordion.layoutnotfound","widget",[_136],null,null,true);
}
if(!_139||!_139 instanceof Ext.Panel){
ColdFusion.handleError(null,"layout.expandaccordion.panelnotfound","widget",[_137],null,null,true);
}
_139.expand();
ColdFusion.Log.info("layout.expandaccordion.expanded","widget",[_137,_136]);
};
ColdFusion.Layout.selectAccordion=function(_13a,_13b){
return ColdFusion.Layout.expandAccordion(_13a,_13b);
};
ColdFusion.Layout.collapseAccordion=function(_13c,_13d){
var _13e=ColdFusion.objectCache[_13c];
var _13f=ColdFusion.objectCache[_13d];
if(!_13e||!_13e instanceof Ext.Panel){
ColdFusion.handleError(null,"layout.collapseaccordion.layoutnotfound","widget",[_13c],null,null,true);
}
if(!_13f||!_13f instanceof Ext.Panel){
ColdFusion.handleError(null,"layout.collapseaccordion.panelnotfound","widget",[_13d],null,null,true);
}
_13f.collapse();
ColdFusion.Log.info("layout.collapseaccordion.collapsed","widget",[_13d,_13c]);
};
ColdFusion.Layout.createAccordionPanel=function(_140,_141,_142,url,_144){
var _145=ColdFusion.objectCache[_140];
var _146=_141;
if(_140&&typeof (_140)!="string"){
ColdFusion.handleError(null,"layout.createaccordionpanel.invalidname","widget",[_140],null,null,true);
return;
}
if(!_140||ColdFusion.trim(_140)==""){
ColdFusion.handleError(null,"layout.createaccordionpanel.emptyname","widget",[_140],null,null,true);
return;
}
if(_141&&typeof (_141)!="string"){
ColdFusion.handleError(null,"layout.createaccordionpanel.invalidaccordionpanelname","widget",[_141],null,null,true);
return;
}
if(!_141||ColdFusion.trim(_141)==""){
ColdFusion.handleError(null,"layout.createaccordionpanel.emptyaccordionpanelname","widget",[_141],null,null,true);
return;
}
if(_142&&typeof (_142)!="string"){
ColdFusion.handleError(null,"layout.createaccordionpanel.invalidtitle","widget",[_141],null,null,true);
return;
}
if(!_142||ColdFusion.trim(_142)==""){
ColdFusion.handleError(null,"layout.createaccordionpanel.invalidtitle","widget",[_141],null,null,true);
return;
}
if(url&&typeof (url)!="string"){
ColdFusion.handleError(null,"layout.createaccordionpanel.invalidurl","widget",[_141],null,null,true);
return;
}
if(!url||ColdFusion.trim(url)==""){
ColdFusion.handleError(null,"layout.createaccordionpanel.invalidurl","widget",[_141],null,null,true);
return;
}
_141="cf_layoutarea"+_146;
if(_145&&(_145 instanceof Ext.Panel)){
var _147=null;
var ele=document.getElementById(_141);
if(ele!=null){
ColdFusion.handleError(null,"layout.createaccordionpanel.duplicateel","widget",[_141],null,null,true);
return;
}
var _149=true;
var _14a;
var _14b=false;
var _14c=null;
if(_144!=null){
if(typeof (_144)!="object"){
ColdFusion.handleError(null,"layout.createaccordionpanel.invalidconfig","widget",[_141],null,null,true);
return;
}
}
if(_144&&typeof (_144.selected)!="undefined"&&_144.selected==true){
_14b=true;
}
if(_144&&_144.titleicon){
if(typeof _144.titleicon!="string"){
ColdFusion.handleError(null,"layout.createaccordionpanel.invalidtitleicon","widget",[_141],null,null,true);
return;
}
var _14d=Ext.String.format(ACCORDION_TITLE_ICON_CSS_TEMPLATE,_141,_144.titleicon);
Ext.util.CSS.createStyleSheet(_14d,_141+"_cf_icon");
_14c=_141;
}
var _14e=_145.layoutConfig;
var _14f=true;
if(_14e&&typeof _14e.fill!="undefined"){
_14f=_14e.fill;
}
if(_144!=null&&typeof (_144.overflow)!="undefined"){
var _14a=new String(_144.overflow);
_14a=_14a.toLowerCase();
if(_14a!="visible"&&_14a!="auto"&&_14a!="scroll"&&_14a!="hidden"){
ColdFusion.handleError(null,"layout.createaccordionpanel.invalidoverflow","widget",[_141],null,null,true);
return;
}
if(!_14f&&(_14a=="auto"||_14a=="scroll")){
ColdFusion.handleError(null,"layout.createaccordionpanel.invalidoverflowforfillheight","widget",[_141],null,null,true);
return;
}
if(_14a=="hidden"){
_149=false;
}
}else{
_14a="auto";
_149=true;
}
var _150=document.getElementById(_140);
if(_150){
var _151=document.getElementById(_140);
var _152=document.createElement("div");
_152.id=_141;
if(_144!=null&&typeof (_144.align)!="undefined"){
_152.align=_144.align;
}
var _153="";
if(_145.height){
_153="height:"+_145.height+";";
}
if(_144!=null&&typeof (_144.style)!="undefined"){
var _154=new String(_144.style);
_154=_154.toLowerCase();
_153=_153+_154;
}
_153=_153+"overflow:"+_14a+";";
_152.style.cssText=_153;
_151.appendChild(_152);
}
var _155=true;
var _156=true;
itemobj=ColdFusion.Layout.InitAccordionChildPanel(_141,_146,_142,_156,_155,_149,_14c,false);
_145.add(itemobj);
if(url!=null&&typeof (url)!="undefined"&&url!=""){
if(url.indexOf("?")!=-1){
url=url+"&";
}else{
url=url+"?";
}
var _157;
var _158;
if(_144){
_157=_144.callbackHandler;
_158=_144.errorHandler;
}
ColdFusion.Ajax.replaceHTML(_141,url,"GET",null,_157,_158);
}
_145.updateLayout();
if(_14b){
ColdFusion.Layout.expandAccordion(_140,_146);
}
ColdFusion.Log.info("layout.createaccordionpanel.created","widget",[_141]);
}else{
ColdFusion.handleError(null,"layout.createaccordionpanel.layoutnotfound","widget",[_140],null,null,true);
}
};
ColdFusion.Layout.initViewport=function(_159,item){
var _15b=new Array();
_15b[0]=item;
var _15c={items:_15b,layout:"fit",name:_159};
var _15d=new Ext.Viewport(_15c);
return _15d;
};
ColdFusion.Layout.convertPositionToDirection=function(_15e){
if(_15e.toUpperCase()=="LEFT"){
return "west";
}else{
if(_15e.toUpperCase()=="RIGHT"){
return "east";
}else{
if(_15e.toUpperCase()=="CENTER"){
return "center";
}else{
if(_15e.toUpperCase()=="BOTTOM"){
return "south";
}else{
if(_15e.toUpperCase()=="TOP"){
return "north";
}
}
}
}
}
};
ColdFusion.Layout.addMapInAccordionMapping=function(_15f,map){
ColdFusion.MapVsAccordion[_15f]=map;
};
