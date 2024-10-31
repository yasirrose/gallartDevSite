/*ADOBE SYSTEMS INCORPORATED
Copyright 2012 Adobe Systems Incorporated
All Rights Reserved.

NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
terms of the Adobe license agreement accompanying it.  If you have received this file from a
source other than Adobe, then your use, modification, or distribution of it requires the prior
written permission of Adobe.*/
if(!ColdFusion.Slider){
ColdFusion.Slider={};
}
var $SL=ColdFusion.Slider;
ColdFusion.Slider.init=function(_1c,_1d,_1e,_1f,_20,_21,_22,_23,_24,_25,tip,_27,_28){
var _29={renderTo:_1c,id:_1d};
if(_24!=null&&typeof (_24)!="undefined"){
_29.ClicktoChange=_24;
}else{
_29.ClicktoChange=false;
}
if(_25!=null&&typeof (_25)!="undefined"){
_29.increment=_25;
}else{
_29.increment=1;
}
if(_22!=null&&typeof (_22)!=undefined){
_29.minValue=_22;
}else{
_29.minValue=0;
}
if(_21!=null&&typeof (_21)!=undefined){
_29.value=_21;
}else{
_29.value=_29.minValue;
}
if(_1f!=null&&typeof (_1f)!=undefined){
_29.width=_1f;
}else{
_29.width=200;
}
if(_20!=null&&typeof (_20)!="undefined"){
_29.height=_20;
}else{
_29.height=100;
}
if(_23!=null&&typeof (_23)!=undefined){
_29.maxValue=_23;
}else{
_29.maxValue=100;
}
if(_1e!=null&&typeof (_1e)!=undefined){
_29.vertical=_1e;
}else{
_29.vertical=false;
}
if(_27!=null&&typeof (_27)=="function"){
_29.onChange=_27;
}
if(_28!=null&&typeof (_28)!="undefined"){
_29.onDrg=_28;
}
Ext.define("Ext.ux.ST",{extend:"Ext.slider.Tip",minWidth:25,minHeight:25,offsets:[0,-10],init:function(_2a){
_2a.on("dragstart",this.onSlide,this);
_2a.on("drag",this.onSlide,this);
_2a.on("dragend",this.hide,this);
_2a.on("destroy",this.destroy,this);
},onSlide:function(_2b,e,_2d){
this.show();
this.body.update(this.getText(_2b));
this.el.alignTo(_2d.el,"b-t?",this.offsets);
this.doAutoRender();
},getText:function(_2e){
return _2e.getValue()==0?"0":_2e.getValue();
}});
if(tip!=null&&typeof (tip)!="undefined"){
if(tip){
_29.plugins=new Ext.ux.ST();
}else{
_29.useTips=false;
}
}
var _2f=Ext.create("Ext.slider.Single",_29);
_2f.on("drag",$SL.onDragHandler,_29);
_2f.on("changecomplete",$SL.onChangeHandler,_29);
_29.sliderComp=_2f;
ColdFusion.objectCache[_1d]=_29;
ColdFusion.Log.info("slider.initialized","widget",[_1d]);
};
$SL.onDragHandler=function(_30,_31){
var _32=this.onDrg;
if(_32!=null&&typeof (_32)=="function"){
_32.call(this,_30,_31);
}
};
$SL.onChangeHandler=function(_33,_34){
var _35=this.onChange;
if(_35!=null&&typeof (_35)=="function"){
_35.call(this,_33,_34);
}
};
$SL.getValue=function(_36){
var _37=ColdFusion.objectCache[_36];
if(_37!=null||typeof (_37)!="undefined"){
var _38=_37.sliderComp;
if(_38){
return _38.getValue();
}
}else{
ColdFusion.handleError(null,"slider.getvalue.notfound","widget",[_36],null,null,true);
}
};
$SL.getSliderObject=function(_39){
var _3a=ColdFusion.objectCache[_39];
if(_3a!=null||typeof (_3a)!="undefined"){
return _3a.sliderComp;
}else{
return null;
}
};
$SL.setValue=function(_3b,_3c){
var _3d=ColdFusion.objectCache[_3b];
if(_3d!=null||typeof (_3d)!="undefined"){
var _3e=_3d.sliderComp;
if(_3e){
return _3e.setValue(_3c,true);
}
}else{
ColdFusion.handleError(null,"slider.setvalue.notfound","widget",[_3b],null,null,true);
}
};
$SL.show=function(_3f){
var _40=ColdFusion.objectCache[_3f];
if(_40!=null||typeof (_40)!="undefined"){
var _41=_40.sliderComp;
if(_41){
return _41.show();
}
}else{
ColdFusion.handleError(null,"slider.show.notfound","widget",[_3f],null,null,true);
}
ColdFusion.Log.info("slider.show.shown","widget",[_3f]);
};
$SL.hide=function(_42){
var _43=ColdFusion.objectCache[_42];
if(_43!=null||typeof (_43)!="undefined"){
var _44=_43.sliderComp;
if(_44){
return _44.hide();
}
}else{
ColdFusion.handleError(null,"slider.hide.notfound","widget",[_42],null,null,true);
}
ColdFusion.Log.info("slider.hide.hidden","widget",[_42]);
};
$SL.enable=function(_45){
var _46=ColdFusion.objectCache[_45];
if(_46!=null||typeof (_46)!="undefined"){
var _47=_46.sliderComp;
if(_47){
return _47.enable();
}
}else{
ColdFusion.handleError(null,"slider.enable.notfound","widget",[_45],null,null,true);
}
ColdFusion.Log.info("slider.enable.enabled","widget",[_45]);
};
$SL.disable=function(_48){
var _49=ColdFusion.objectCache[_48];
if(_49!=null||typeof (_49)!="undefined"){
var _4a=_49.sliderComp;
if(_4a){
return _4a.disable();
}
}else{
ColdFusion.handleError(null,"slider.disable.notfound","widget",[_48],null,null,true);
}
ColdFusion.Log.info("slider.disable.disabled","widget",[_48]);
};
