/*ADOBE SYSTEMS INCORPORATED
Copyright 2012 Adobe Systems Incorporated
All Rights Reserved.

NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
terms of the Adobe license agreement accompanying it.  If you have received this file from a
source other than Adobe, then your use, modification, or distribution of it requires the prior
written permission of Adobe.*/
if(!ColdFusion.Button){
ColdFusion.Button={};
}
var $BT=ColdFusion.Button;
ColdFusion.Button.init=function(_619,_61a,icon,tips,_61d,_61e,_61f,_620,_621){
var _622={renderTo:_619,enableToggle:_621,text:_61a,onClick:_61d,onToggle:_61e,onMouseOver:_61f,onMouseout:_620,tooltip:tips,icon:icon};
var _623={renderTo:_619,enableToggle:_621,text:_61a};
if(tips!=null&&typeof tips!="undefined"){
_623.tooltip=tips;
Ext.QuickTips.init();
}
if(icon!=null&&typeof icon!="undefined"){
_623.icon=icon;
}
if(icon&&_61a){
_623.iconCls="x-btn-text-icon";
}else{
if(icon&&!_61a){
_623.iconCls="x-btn-icon";
}
}
var _624=new Ext.Button(_623);
if(_61d!=null&&typeof _61d=="function"){
_624.on("click",_61d,_622);
}
if(_61e!=null&&typeof _61e=="function"){
_624.on("toggle",_61e,_622);
}
if(_61f!=null&&typeof _61f=="function"){
_624.on("mouseover",_61f,_622);
}
if(_620!=null&&typeof _620=="function"){
_624.on("mouseout",_620,_622);
}
_622.buttonComp=_624;
ColdFusion.objectCache[_619]=_622;
ColdFusion.Log.info("button.initialized","widget",[_619]);
};
$BT.show=function(_625){
var _626=$BT.getButtonObject(_625);
if(_626!=null){
_626.show();
}
ColdFusion.Log.info("button.show.shown","widget",[_625]);
};
$BT.hide=function(_627){
var _628=$BT.getButtonObject(_627);
if(_628!=null){
_628.hide();
}
ColdFusion.Log.info("button.hide.hidden","widget",[_627]);
};
$BT.disable=function(_629){
var _62a=$BT.getButtonObject(_629);
if(_62a!=null){
_62a.disable();
}
ColdFusion.Log.info("button.disable.disabled","widget",[_629]);
};
$BT.enable=function(_62b){
var _62c=$BT.getButtonObject(_62b);
if(_62c!=null){
_62c.enable();
}
ColdFusion.Log.info("button.enable.enabled","widget",[_62b]);
};
$BT.getButtonObject=function(_62d){
var _62e=$BT.getButtonConfigObj(_62d);
if(_62e!=null){
return _62e.buttonComp;
}else{
ColdFusion.handleError(null,"button.component.notFound","widget",[_62d],null,null,true);
}
};
$BT.setLabel=function(_62f,_630){
var _631=$BT.getButtonObject(_62f);
if(_631!=null){
_631.text=_630;
}
};
$BT.getButtonConfigObj=function(_632){
var _633=ColdFusion.objectCache[_632];
if(_633==null||typeof (_633)=="undefined"){
ColdFusion.handleError(null,"button.component.notFound","widget",[_632],null,null,true);
}
return _633;
};
$BT.toggle=function(_634){
var _635=$BT.getButtonObject(_634);
if(_635!=null){
_635.toggle();
}
};
