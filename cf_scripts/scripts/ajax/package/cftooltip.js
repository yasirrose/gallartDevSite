/*ADOBE SYSTEMS INCORPORATED
Copyright 2012 Adobe Systems Incorporated
All Rights Reserved.

NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
terms of the Adobe license agreement accompanying it.  If you have received this file from a
source other than Adobe, then your use, modification, or distribution of it requires the prior
written permission of Adobe.*/
if(!ColdFusion.Tooltip){
ColdFusion.Tooltip={};
}
ColdFusion.Tooltip.setToolTipOut=function(_190,_191){
var _192=_191.tooltip;
_192.tooltipout=true;
};
ColdFusion.Tooltip.getToolTip=function(_193,_194){
var _195=ColdFusion.objectCache[_194.context];
if(!_195){
if(_194.style){
_194.styleObj=ColdFusion.Tooltip.parseStyle(_194.style);
}
_195=new YAHOO.widget.Tooltip(_194.context+"_cf_tooltip",_194);
ColdFusion.objectCache[_194.context]=_195;
_195.doShow(_193,_194.context);
if(_194._cf_url){
var _196=function(req,_198){
_198.tooltip.cfg.setProperty("text",req.responseText);
if(_198.tooltip.tooltipout==false){
_198.tooltip.doShow(_198.event,_198.id);
}
};
YAHOO.util.Event.addListener(_194.context,"mouseout",ColdFusion.Tooltip.setToolTipOut,{"tooltip":_195});
_195.cfg.setProperty("text",_cf_loadingtexthtml);
_195.doShow(_193,_194.context);
try{
ColdFusion.Log.info("tooltip.gettooltip.fetch","widget",[_194.context]);
ColdFusion.Ajax.sendMessage(_194._cf_url,"GET",_194._cf_query,true,_196,{tooltip:_195,event:_193,id:_194.context});
}
catch(e){
tooltipdiv=ColdFusion.DOM.getElement(_194.context);
tooltipdiv.innerHTML="";
ColdFusion.globalErrorHandler(null,e,tooltipdiv);
}
}
}
_195.tooltipout=false;
};
ColdFusion.Tooltip.parseStyle=function(_199){
var _19a={};
if(_199&&typeof _199==="string"){
var _19b=_199.split(";");
for(var i=0;i<_19b.length;i++){
var temp=_19b[i];
tempArray=temp.split(":");
if(tempArray.length===2){
var key=tempArray[0];
key=key.toLowerCase();
var _19f=tempArray[1];
switch(key){
case "width":
_19a.width=_19f;
break;
case "color":
_19a.color=_19f;
break;
case "background-color":
_19a[key]=_19f;
break;
case "padding":
_19a.padding=_19f;
break;
default:
_19a[key]=_19f;
}
}
}
}
return _19a;
};
