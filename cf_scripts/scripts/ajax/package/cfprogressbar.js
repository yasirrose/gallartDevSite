/*ADOBE SYSTEMS INCORPORATED
Copyright 2012 Adobe Systems Incorporated
All Rights Reserved.

NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
terms of the Adobe license agreement accompanying it.  If you have received this file from a
source other than Adobe, then your use, modification, or distribution of it requires the prior
written permission of Adobe.*/
if(!ColdFusion.ProgressBar){
ColdFusion.ProgressBar={};
}
var $P=ColdFusion.ProgressBar;
ColdFusion.ProgressBar.create=function(_564,_565,_566,_567,_568,_569,_56a,_56b,_56c,_56d){
var _56e={renderTo:_564,interval:_567,onComplete:_56b,autodisplay:_56a,onError:_56d};
var _56f={renderTo:_564};
if(_569!=null&&typeof (_569)!=undefined){
_56e.width=_569;
_56f.width=_569;
}else{
_56f.width=400;
}
if(_568!=null&&typeof (_568)!=undefined){
_56e.height=_568;
_56f.height=_568;
}else{
_56e.autoHeight=true;
_56f.autoHeight=true;
}
if(_565!=null){
_56e.manual=true;
_56e.status_retrieval_fn=_565;
}else{
_56e.manual=false;
_56e.duration=_566;
}
_56e.hidden=!_56a;
_56f.hidden=_56e.hidden;
if(_56c!=null&&typeof _56c!="undefined"){
_56e.cls=_56c;
_56f.cls=_56c;
}
var _570=new Ext.ProgressBar(_56f);
_56e.progressBarComp=_570;
ColdFusion.objectCache[_564]=_56e;
ColdFusion.Log.info("progressbar.create.created","widget",[_564]);
};
$P.start=function(_571){
var _572=$P.getProgressBarObject(_571);
var _573=ColdFusion.objectCache[_571];
if(!_572.isVisible()){
_572=_572.show();
}
_573.started=true;
if(_573.manual==false){
var _574=_573.interval;
var _575=_573.duration;
var _576=_575/_574;
_572.wait({interval:_574,duration:_575,increment:_576,fn:$P.automaticPBCompleteHandler,scope:_573});
}else{
var _577=setInterval(_573.status_retrieval_fn,_573.interval);
_573.processId=_577;
}
ColdFusion.Log.info("progressbar.start.started","widget",[_571]);
};
$P.stop=function(_578,_579){
var pBar=$P.getProgressBarObject(_578);
var _57b=ColdFusion.objectCache[_578];
var _57c=_57b.processId;
if(typeof _57b.started!="undefined"&&_57b.started==true){
_57b.started=false;
}else{
ColdFusion.Log.info("progressbar.stop.nonrunning","widget",[_578]);
return;
}
if(_57c!=null&&typeof (_57c)!="undefined"){
clearInterval(_57c);
}
if(typeof _57b.manual!="undefined"&&_57b.manual==false){
pBar.reset();
}
if(_579&&_579==true){
var _57d=_57b.onComplete;
if(_57d!=null&&_57d.call){
_57d.call();
}
}
ColdFusion.Log.info("progressbar.stop.stopped","widget",[_578]);
};
$P.hide=function(_57e){
var pBar=$P.getProgressBarObject(_57e);
if(pBar.isVisible()){
pBar.hide();
}
ColdFusion.Log.info("progressbar.hide.hidden","widget",[_57e]);
};
$P.show=function(_580){
var pBar=$P.getProgressBarObject(_580);
if(!pBar.isVisible()){
pBar.show();
}
ColdFusion.Log.info("progressbar.show.shown","widget",[_580]);
};
$P.reset=function(_582){
var pBar=$P.getProgressBarObject(_582);
if(typeof pBar!="undefined"){
pBar.reset();
}
ColdFusion.Log.info("progressbar.reset.reset","widget",[_582]);
};
$P.updateStatus=function(_584,_585,_586){
var pBar=$P.getProgressBarObject(_584);
if(typeof (_585)=="undefined"||typeof (_585)!="number"){
ColdFusion.handleError(null,"progressbar.updatestatus.invalidstatus","widget",[_584,_585],null,null,true);
return;
}
if(typeof pBar!="undefined"){
pBar.updateProgress(_585,_586);
}
ColdFusion.Log.info("progressbar.updatestatus.updated","widget",[_584]);
};
$P.update=function(_588,_589){
var _58a={};
var _58b=ColdFusion.objectCache[_588];
if(_58b==null||typeof (_58b)=="undefined"){
ColdFusion.handleError(null,"progressbar.update.notfound","widget",[_588],null,null,true);
return;
}
if(_589.duration){
if(typeof _589.duration==="number"||typeof _589.duration=="object"){
_58a.duration=_589.duration;
}else{
ColdFusion.handleError(null,"progressbar.update.invalidduration","widget",[_588],null,null,true);
return;
}
}
if(_589.interval){
if(typeof _589.interval==="number"||typeof _589.interval=="object"){
_58a.interval=_589.interval;
}else{
ColdFusion.handleError(null,"progressbar.update.invalidinterval","widget",[_588],null,null,true);
return;
}
}
if(_589.oncomplete){
if(typeof _589.oncomplete==="function"||typeof _589.oncomplete=="object"){
_58a.onComplete=_589.oncomplete;
}else{
ColdFusion.handleError(null,"progressbar.update.invalidoncomplete","widget",[_588],null,null,true);
return;
}
}
for(key in _58a){
_58b[key]=_58a[key];
}
ColdFusion.Log.info("progressbar.update.updated","widget",[_588]);
};
$P.loadStatus=function(data,_58d){
var _58e=ColdFusion.AjaxProxy.JSON.decode(data);
var _58f=_58e.MESSAGE;
var _590=_58e.STATUS;
var pBar=$P.getProgressBarObject(_58d._cf_progressbarid);
pBar.updateProgress(_590,_58f);
if(_590&&(_590===1||_590==1||_590>1)){
$P.stop(_58d._cf_progressbarid,true);
}
};
$P.automaticPBCompleteHandler=function(){
var _592=this.progressBarComp;
_592.updateProgress(1);
if(this.onComplete&&typeof this.onComplete=="function"){
this.onComplete.call(_592,_592);
}
};
$P.errorHandler=function(_593,_594,_595){
var pbId=_595.bindToParams._cf_progressbarid;
var _597=ColdFusion.objectCache[pbId];
var _598=_597.onError;
if(_598!=null&&typeof _598==="function"){
_598.call(null,_593,_594);
}
$P.stop(pbId);
};
$P.getProgressBarObject=function(_599){
var _59a=ColdFusion.objectCache[_599];
if(_59a==null||typeof (_59a)=="undefined"){
ColdFusion.handleError(null,"progressbar.getProgressBarObject.missingprogressbarid","widget",[_599],null,null,true);
return;
}
if(_59a.progressBarComp&&typeof _59a.progressBarComp!="undefined"){
return _59a.progressBarComp;
}else{
ColdFusion.handleError(null,"progressbar.getProgressBarObject.missingprogressbarcomponent","widget",[_599],null,null,true);
return;
}
};
