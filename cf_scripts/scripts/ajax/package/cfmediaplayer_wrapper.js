/*ADOBE SYSTEMS INCORPORATED
Copyright 2012 Adobe Systems Incorporated
All Rights Reserved.

NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
terms of the Adobe license agreement accompanying it.  If you have received this file from a
source other than Adobe, then your use, modification, or distribution of it requires the prior
written permission of Adobe.*/
if(!ColdFusion.MediaPlayer){
ColdFusion.MediaPlayer={};
}
var $MP=ColdFusion.MediaPlayer;
$MP.defaultSWFLocation=_cf_ajaxscriptsrc+"/resources/cf/assets/StrobeMediaPlayback.swf",$MP.defaultOptions={swf:$MP.defaultSWFLocation,width:480,height:275,src:"",javascriptControls:true,playButtonOverlay:true,loop:false,autoPlay:false,controlBarMode:"docked",javascriptCallbackFunction:"triggerHandler"};
$MP.playerMap={};
$MP.playerWrapperMap={};
$MP.playerOptionsMap={};
$MP.jsFunctionMap={};
$MP.titleDataMap={};
$MP.videoMonitorMap={};
$MP.bindInfoMap={};
$MP.bindElements={};
$MP.baseURI;
$MP.fancyBoxLeftBorderOffset=5;
$MP.fancyBoxBottonBorderOffset=6;
$MP.hasHTML5VideoPlaybackSupport=!!document.createElement("video").canPlayType;
String.prototype.trim=function(){
return this.replace(/^\s+|\s+$/g,"");
};
ColdFusion.MediaPlayer.init=function(_3e9){
var _3ea=$MP.defaultOptions;
_3ea.id=_3e9.id;
var _3eb={};
var _3ec={};
var _3ed={};
var _3ee=null;
var _3ef={onStart:null,onComplete:null,onPause:null,onError:null,onLoad:null,onStartCallback:playbackStart,onPauseCallback:playbackPause};
if(_3e9.width!=null&&typeof (_3e9.width)!="undefined"){
_3ea.width=_3e9.width;
}else{
_3ea.width=480;
}
if(_3e9.height!=null&&typeof (_3e9.height)!="undefined"){
_3ea.height=_3e9.height;
}else{
_3ea.height=275;
}
if(_3e9.baseURI!=null){
$MP.baseURI=_3e9.baseURI;
}
if(_3e9.src!=null&&_3e9.src!=""){
_3ea.src=resolveSource(_3e9.src);
}else{
_3ea.src="";
}
if(_3e9.PosterImage!=null&&_3e9.PosterImage!=""){
_3ea.poster=resolveSource(_3e9.PosterImage);
}else{
_3ea.poster="";
}
if(_3e9.javascriptControls==null){
_3ea.javascriptControls=true;
}
if(_3e9.playButtonOverlay==null){
_3ea.playButtonOverlay=true;
}
if(_3e9.repeat!=null){
if(_3e9.repeat=="true"){
_3ea.loop=true;
}else{
_3ea.loop=false;
}
}else{
_3ea.loop=false;
}
if(_3e9.autoPlay!=null){
if(_3e9.autoPlay=="true"){
_3ea.autoPlay=true;
}else{
_3ea.autoPlay=false;
}
}else{
_3ea.autoPlay=false;
}
if(_3e9.bgcolor!=null){
_3ea.backgroundColor=_3e9.bgcolor;
_3ec.bgColor=_3e9.bgcolor;
}
if(_3e9.controlbar!=null){
if(_3e9.controlbar==false){
_3ea.controlBarMode="none";
}else{
_3ea.controlBarMode="docked";
}
}
if(_3e9.skin!=null){
_3ea.skin=resolveSource(_3e9.skin);
}else{
_3ea.skin="";
}
if(_3e9.onComplete!=null){
_3ef.onComplete=_3e9.onComplete;
}
if(_3e9.onLoad!=null){
_3ef.onLoad=_3e9.onLoad;
}
if(_3e9.onStart!=null){
_3ef.onStart=_3e9.onStart;
}
if(_3e9.onPause!=null){
_3ef.onPause=_3e9.onPause;
}
if(_3e9.onError!=null){
_3ef.onError=_3e9.onError;
}
if(_3e9.onBind!=null){
_3ef.onBind=_3e9.onBind;
}
if(_3e9.hideTitle!=null){
_3eb.hideTitle=_3e9.hideTitle;
}
if(_3e9.title!=null){
_3eb.title=_3e9.title;
}
if(_3e9.title_text_color!=null){
_3eb.title_text_color=_3e9.title_text_color;
}
if(_3e9.title_bgcolor!=null){
_3eb.title_bgcolor=_3e9.title_bgcolor;
}
if(_3e9.border_left!=null){
_3ec.border_left=_3e9.border_left;
}
if(_3e9.border_right!=null){
_3ec.border_right=_3e9.border_right;
}
if(_3e9.border_top!=null){
_3ec.border_top=_3e9.border_top;
}
if(_3e9.border_bottom!=null){
_3ec.border_bottom=_3e9.border_bottom;
}
if(_3e9.progress_color!=null){
_3ed.progress_color=_3e9.progress_color;
}
if(_3e9.progress_bgcolor!=null){
_3ed.progress_bgcolor=_3e9.progress_bgcolor;
}
if(_3e9.controls_color!=null){
_3ed.controls_color=_3e9.controls_color;
}
if(_3e9.controlbar_bgcolor!=null){
_3ed.controlbar_bgcolor=_3e9.controlbar_bgcolor;
}
if(!_3ea.javascriptControls){
$(".strobeMediaPlaybackControlBar,.smp-error,.playoverlay").show();
}
if(_3e9.bindData!=null&&_3e9.bindData!="undefined"){
_3ee=$.extend(true,{},_3ea);
handleBindingMediaPlayer(_3ee,_3e9.bindData,_3e9.type,_3ef);
return;
}
handleWmode(_3e9,_3ea);
playerInitialization(_3ea,_3e9.type,_3ef,_3eb,_3ec,_3ed);
};
function handleWmode(_3f0,_3f1){
if(navigator.platform.indexOf("Linux")!=-1){
_3f1.wmode="direct";
return;
}
if(_3f0.wmode!=null){
_3f1.wmode=_3f0.wmode;
}else{
_3f1.wmode="direct";
}
var _3f2=document.getElementById(_3f1.id+"_"+"videoTitle");
if((_3f2!==null&&(_3f0.hideTitle==null||_3f0.hideTitle==false))||(_3f1.backgroundColor!=null&&_3f1.backgroundColor.trim()!="")){
_3f1.wmode="transparent";
}
}
function isValidSourceElementExist(_3f3,type){
if(_3f3.src!=null&&_3f3.src!=""){
if(type=="html"&&$MP.hasHTML5VideoPlaybackSupport&&isHTMLFileFormatSupported(_3f3.src)){
return true;
}else{
if(type=="flash"&&isFlashSupported()&&isFlashFileFormatSupported(_3f3.src)){
return true;
}
}
}
var _3f5=document.getElementById(_3f3.id+"_extendData");
if(_3f5==null||_3f5.childNodes==null||!isFlashSupported()){
return false;
}
var _3f6=_3f5.getElementsByTagName("source");
for(var k=0;k<_3f6.length;k++){
var src=_3f6[k].getAttribute("src");
if(type=="html"&&$MP.hasHTML5VideoPlaybackSupport&&isHTMLFileFormatSupported(src)){
return true;
}else{
if(type=="flash"&&isFlashSupported()&&isFlashFileFormatSupported(src)){
return true;
}
}
}
return false;
}
function hideTitle(id){
var _3fa=document.getElementById(id+"_"+"videoTitle");
if(_3fa==null){
id=id.substring(0,id.indexOf("_strobemediaplayback-video"));
_3fa=document.getElementById(id+"_"+"videoTitle");
}
if(_3fa!=null){
$("#"+id+"_"+"videoTitle").fadeOut(600,null);
}
}
function playbackStart(id){
var _3fc=getFuncMap(id);
if(_3fc.onStart!=null){
_3fc.onStart();
}
var _3fd=getWrapper(id);
if(_3fd!=null){
_3fd.playOverlay.fadeOut(600);
}
hideTitle(id);
}
function showTitle(id){
var _3ff=document.getElementById(id+"_"+"videoTitle");
if(_3ff==null){
id=id.substring(0,id.indexOf("_strobemediaplayback-video"));
_3ff=document.getElementById(id+"_"+"videoTitle");
}
if(_3ff!=null){
$("#"+id+"_"+"videoTitle").fadeIn(1,null);
}
}
function playbackPause(id){
var _401=getFuncMap(id);
if(_401.onPause!=null){
_401.onPause();
}
var _402=getWrapper(id);
if(_402!=null){
_402.playOverlay.fadeIn(600);
}
showTitle(id);
}
function playbackComplete(id){
var _404=getFuncMap(id);
if(_404.onComplete!=null){
_404.onComplete();
}
var _405=getWrapper(id);
if(_405!=null){
_405.playOverlay.fadeIn(600);
_405.slider.css("left",0+"px");
_405.currenttime.html("0:00");
}
showTitle(id);
}
function updateFlashVideoSource(_406){
if(_406.src!=null&&_406.src!=""){
if(isFlashSupported()&&isFlashFileFormatSupported(_406.src)){
return;
}
}
var _407=document.getElementById(_406.id+"_extendData");
if(_407==null||_407.childNodes==null||!isFlashSupported()){
return;
}
var _408=_407.getElementsByTagName("source");
for(var k=0;k<_408.length;k++){
var src=_408[k].getAttribute("src");
if(isFlashSupported()&&isFlashFileFormatSupported(src)){
_406.src=resolveSource(src);
return;
}
}
return;
}
function playerInitialization(_40b,type,_40d,_40e,_40f,_410){
var _411=true;
var _412=isValidSourceElementExist(_40b,"html");
var _413=isValidSourceElementExist(_40b,"flash");
var _414=$MP.handleUserDefinedFlashParams(_40b,type);
if(_414){
_40b.favorFlashOverHtml5Video=true;
}else{
if(isFlashSupported()){
if(type==null||type=="flash"){
if(_413){
_40b.favorFlashOverHtml5Video=true;
}else{
if(_412){
_40b.favorFlashOverHtml5Video=false;
}else{
_411=false;
}
}
}else{
if(_412){
_40b.favorFlashOverHtml5Video=false;
}else{
if(_413){
_40b.favorFlashOverHtml5Video=true;
}else{
_411=false;
}
}
}
}else{
if($MP.hasHTML5VideoPlaybackSupport){
_40b.favorFlashOverHtml5Video=false;
}else{
_411=false;
}
}
}
if(_40b.favorFlashOverHtml5Video){
updateFlashVideoSource(_40b);
}
if(!_411){
if($MP.hasHTML5VideoPlaybackSupport){
_40b.favorFlashOverHtml5Video=false;
}else{
$(".playoverlay").hide();
ColdFusion.MediaPlayer.logError(_40b.id,"The video could not be loaded");
return;
}
}
var _415={"tablet":{"startSize":{"width":+_40b.width,"height":+_40b.height},"name":_40b.id+"_"+"strobemediaplayback-video"},"smartphone":{"startSize":{"width":+_40b.width,"height":+_40b.height},"name":_40b.id+"_"+"strobemediaplayback-video"},"default":{"startSize":{"width":+_40b.width,"height":+_40b.height},"name":_40b.id+"_"+"strobemediaplayback-video"}};
strobeMediaPlayback.draw(_40b.id+"_"+"strobemediaplayback-video",_415,_40b);
var _416=$("#"+_40b.id+"_"+"strobemediaplayback-video");
var _417=$("#"+_40b.id);
var _418=_417.get(0);
var _419;
if(_418==null){
_40b.id=_40b.id+"_strobemediaplayback-video";
$MP.playerOptionsMap[_40b.id]=_40b;
$MP.videoMonitorMap[_40b.id]={paused:true,muted:false};
}else{
_419=$("#"+_40b.id+"_"+"strobemediaplayback-video  .html5player").strobemediaplaybackhtml5(_40b,_40d);
$MP.playerMap[_40b.id]=_418;
$MP.playerWrapperMap[_40b.id]=_419;
$MP.playerOptionsMap[_40b.id]=_40b;
}
$MP.jsFunctionMap[_40b.id]=_40d;
$MP.titleDataMap[_40b.id]=_40e;
if(_418!=null&&_418.nodeName!=null&&_418.nodeName.toLowerCase()=="video"){
handleVolumeSlider(_40b.id);
_418.volume=0.6;
handlePlayoverlay(_40b.id,_40b.width,_40b.height);
handleErrorElement(_40b.id,_40b.width,_40b.height);
var _41a=$MP.playerWrapperMap[_40b.id];
_41a.playOverlay.css("display","block");
_416.css("width","100%");
_416.css("height","100%");
handlebackgroundColor(_40b);
handleControlsStyle(_40b.id,_410);
_419.useHTML5=true;
var _41b=document.getElementById(_40b.id+"_extendData");
if(_41b!=null){
$MP.handleUserDefinedHTML5Element(_418,_40b.id+"_extendData");
}else{
handleTitle(_40b.id,_40b.src,_40e);
var _41c=getFuncMap(_40b.id);
var _41d=document.getElementById(_40b.id);
var _41e=_41d.getElementsByTagName("source");
if(_41e!=null&&_41e.length!=0){
_41e[0].setAttribute("onerror","onError(event)");
}
}
}else{
handleTitle(_40b.id,_40b.src,_40e);
}
handleBorderStyle(_40b.id,_40f);
if($MP.bindInfoMap[_40b.id]==null){
var _41f=document.getElementById(_40b.id+"_extendData");
if(_41f==null){
var id=_40b.id.substring(0,_40b.id.indexOf("_"));
_41f=document.getElementById(id+"_extendData");
}
if(_41f!=null&&_41f.parentNode!=null){
_41f.parentNode.removeChild(_41f);
}
}
}
function handleVolumeChangeUI(_421,_422){
var _423=getWrapper(_421);
if(_422<=0){
_423.volumeHigh.css("background-position","0px -72px");
}else{
if(_422<=0.3){
_423.volumeHigh.css("background-position","-24px -72px");
}else{
if(_422<=0.7){
_423.volumeHigh.css("background-position","-48px -72px");
}else{
_423.volumeHigh.css("background-position","-72px -72px");
}
}
}
}
function handleVolumeSlider(_424){
var _425=getWrapper(_424);
var _426=_425.volumeSlider;
_426.slider({orientation:"vertical",range:"min",min:0,max:90,value:60,slide:function(_427,ui){
var _429=ui.value/100;
_425.currentVolume=_429;
handleChangeVolume(_424,_429);
}});
_425.volumeHigh.mouseover(function(){
var _42a=getWrapper(_424);
var _42b=_42a.volumeSlider;
_42b.css("display","block");
_42a.volumeContainer.css("display","block");
});
_425.volumeHigh.mouseout(function(_42c){
var _42d=getWrapper(_424);
var _42e=_42d.volumeSlider;
var _42f=_42d.volumeContainer;
var _430=_42c.relatedTarget;
if(_430.className!="controls"){
_42e.css("display","none");
_42f.css("display","none");
}
});
_425.volumeHigh.click(function(_431){
var _432=getWrapper(_424);
if(_432.currentVolume==null){
_432.currentVolume=0.6;
}
var pos=_425.volumeHigh.css("background-position");
if(pos.indexOf("0px")!=0){
_425.volumeHigh.css("background-position","0px -72px");
_425.volumeSlider.slider("value",0);
handleChangeVolume(_424,0);
}else{
_425.volumeSlider.slider("value",_432.currentVolume*100);
if(_432.currentVolume<=0.1){
_425.volumeHigh.css("background-position","0px -72px");
}else{
if(_432.currentVolume<=0.3){
_425.volumeHigh.css("background-position","-24px -72px");
}else{
if(_432.currentVolume<=0.7){
_425.volumeHigh.css("background-position","-48px -72px");
}else{
_425.volumeHigh.css("background-position","-72px -72px");
}
}
}
handleChangeVolume(_424,_432.currentVolume);
}
});
_425.controlbar.mouseout(function(_434){
if(_434.relatedTarget==null){
return;
}
var _435=_434.relatedTarget.className;
if(_434.relatedTarget.className!="controls"&&_435!="volume-container"&&_435.indexOf("ui-slider")==-1){
var _436=getWrapper(_424);
var _437=_436.volumeSlider;
var _438=_436.volumeContainer;
_437.css("display","none");
_438.css("display","none");
}
});
}
function handleBindingMediaPlayer(_439,_43a,type,_43c){
var _43d=document.getElementById(_439.id+"_"+"html5MediaPlayback");
if(_43d==null){
return;
}
var _43e=_43d.innerHTML;
if(_43e==null){
return;
}
var _43f={};
_43f.videoContent=_43e;
_43f.type=type;
_43f.player_options=_439;
_43f.jsfunction=_43c;
$MP.bindInfoMap[_439.id]=_43f;
var _440=-1;
var _441=0;
var _442=_43a;
do{
var _443;
_440=_43a.indexOf(",",_441);
if(_440!=-1){
_443=_43a.substring(_441,_440);
_441=_440+1;
_442=_43a.substring(_440+1);
}else{
_443=_442;
}
var _444=_443;
var _445;
if(_443.indexOf("@")!=-1){
_444=_443.substring(0,_443.indexOf("@"));
_445=_443.substring(_443.indexOf("@")+1);
}else{
_444=_443;
_445="onClick";
}
var _446=document.getElementById(_444);
if(_446==null){
continue;
}
handleTitle(_439.id,_439.src);
var _447=getVideoTitle(_439.src);
if(_445==null||_445.toLowerCase()=="onclick"){
bindFancyBox(false,true,_444,_445,_439,type,_43c,_43e,_447);
}else{
var _448=document.getElementById(_444);
_445=_445.substring(2);
$("#"+_444).live(_445.toLowerCase(),function(e){
bindFancyBox(true,true,_444,_445,_439,type,_43c,_43e,_447);
});
}
}while(_440!=-1);
var _44a=document.getElementById(_439.id+"_"+"mediacontainer");
_44a.parentNode.removeChild(_44a);
}
function bindFancyBox(fire,_44c,_44d,_44e,_44f,type,_451,_452,_453){
var _454=document.getElementById(_44f.id+"_"+"videoTitle");
if(_454==null){
_453="";
}else{
if(_453==null||_453==""){
_453="video";
}
}
if(fire){
$("#"+_44d).fancybox({content:_452,overlayShow:true,overlayOpacity:0.7,width:_44f.width+$MP.fancyBoxLeftBorderOffset,height:_44f.height+$MP.fancyBoxBottonBorderOffset,title:_453,autoDimensions:false,onComplete:function(){
var _455=$.extend(true,{},$MP.bindInfoMap[_44f.id].player_options);
if(_44c&&_451.onBind!=null){
_451.onBind(_44d,_44e);
}
var _456=$MP.bindInfoMap[_44f.id].player_options;
playerInitialization(_456,type,_451);
handleBindEvents(_456,$MP.bindInfoMap[_44f.id]);
$MP.bindInfoMap[_44f.id].player_options=$.extend(true,{},_455);
}}).trigger("click");
}else{
$("#"+_44d).fancybox({content:_452,overlayShow:true,overlayOpacity:0.7,width:_44f.width+$MP.fancyBoxLeftBorderOffset,height:_44f.height+$MP.fancyBoxBottonBorderOffset,title:_453,autoDimensions:false,onComplete:function(){
var _457=$.extend(true,{},$MP.bindInfoMap[_44f.id].player_options);
if(_44c&&_451.onBind!=null){
_451.onBind(_44d,_44e);
}
var _458=$MP.bindInfoMap[_44f.id].player_options;
playerInitialization(_458,type,_451);
handleBindEvents(_458,$MP.bindInfoMap[_44f.id]);
$MP.bindInfoMap[_44f.id].player_options=$.extend(true,{},_457);
}});
}
}
function handleBindEvents(_459,_45a){
var _45b=$MP.getPlayer(_459.id);
if(_45a.mute!=null){
_45b.muted=mute;
}
if(_45a.volume!=null){
handleChangeVolume(_459.id,_45a.volume);
}
if(_45a.startPlay!=null){
_45b.start();
}
if(_45a.stopPlay!=null){
_45b.pause();
}
}
function updateVideoType(_45c){
var _45d=_45c.childNodes;
if(_45d==null){
return;
}
var _45e=_45c.getElementsByTagName("source");
if(_45e==null||_45e.length===0){
return;
}
var _45f=_45e[0].getAttribute("src");
if(_45f==null){
return;
}
var type=_45e[0].getAttribute("type");
if(type!=null){
return;
}
if(_45f.lastIndexOf(".")==-1){
return;
}
var _461=_45f.substring(_45f.lastIndexOf(".")+1);
_461=_461.toLowerCase();
if(_461=="mp4"){
_45e[0].setAttribute("type","video/mp4");
}else{
if(_461=="ogv"){
_45e[0].setAttribute("type","video/ogg");
}else{
if(_461=="webm"){
_45e[0].setAttribute("type","video/webm");
}
}
}
}
$MP.handleUserDefinedHTML5Element=function(_462,_463){
var _464=document.getElementById(_463);
var _465=_464.childNodes;
var _466=false;
updateVideoType(_462);
if(_465!=null){
var _467=null;
for(var k=0;k<_465.length;k++){
var _469=_465[k];
if(_469.tagName!=null&&_469.tagName.toLowerCase()=="video"){
_467=_469;
break;
}
}
if(_467==null){
return;
}
_465=_467.childNodes;
var _46a=null;
var _46b;
for(var i=0;i<_465.length;i++){
var _469=_465[i];
if(_469.tagName!=null&&_469.tagName.toLowerCase()=="track"){
_462.appendChild(_469);
}else{
if(_469.tagName!=null&&_469.tagName.toLowerCase()=="source"){
if(!_466){
var _46d=_462.getAttribute("src");
if(_46d==null){
var _46e=_462.childNodes;
if(_46e!=null){
for(var l=0;l<_46e.length;l++){
if(_46e[l].tagName.toLowerCase()=="source"){
var src=_46e[l].getAttribute("src");
if(src!=null&&src.trim()!=0&&isHTMLFileFormatSupported(src)){
_46a=src;
break;
}
}
}
}
}
if(_46d!=null&&_46d!=""&&_46d.lastIndexOf(".")!=-1){
var _471=document.createElement("source");
_471.setAttribute("src",_46d);
var _472=_46d.substring(_46d.lastIndexOf(".")+1);
if(_472=="mp4"){
_471.setAttribute("type","video/mp4");
}else{
if(_472=="ogv"){
_471.setAttribute("type","video/ogg");
}else{
if(_472=="webm"){
_471.setAttribute("type","video/webm");
}
}
}
_462.appendChild(_471);
}
if(_46a==null&&isHTMLFileFormatSupported(_46d)){
_46a=_46d;
}
_462.removeAttribute("src");
}
var src=_469.getAttribute("src");
src=resolveSource(src);
_469.setAttribute("src",src);
_462.appendChild(_469);
_466=true;
_46b=_469;
if(_46a==null&&isHTMLFileFormatSupported(src)){
_46a=src;
}
}
}
}
if(_46a!=null){
handleTitle(_462.id,_46a);
}
if(_46b!=null){
_46b.setAttribute("onerror","onError(event)");
}
}
_462.load();
};
$MP.handleUserDefinedFlashParams=function(_473,type){
var _475=document.getElementById(_473.id+"_extendData");
if(_475==null||_475.childNodes==null||!isFlashSupported()){
return;
}
var _476=_475.childNodes;
var _477=false;
if(_476!=null){
var _478=null;
for(var k=0;k<_476.length;k++){
var _47a=_476[k];
if(_47a.tagName!=null&&(_47a.tagName.toLowerCase()=="object"||_47a.tagName.toLowerCase()=="video")){
_478=_47a;
var _47b=_478.childNodes;
for(var i=0;i<_47b.length;i++){
var _47a=_47b[i];
if(_47a.tagName!=null&&_47a.tagName.toLowerCase()=="param"){
_477=true;
var _47d=_47a.getAttribute("name");
if(_47d=="flashvars"){
var _47e=_47a.getAttribute("value");
var _47f=0;
var _480=_47e;
do{
var _481=_480.indexOf("&");
var _482;
if(_481>0){
_482=_480.substring(_47f,_481);
}else{
_482=_480;
}
if(_482.indexOf("=")>0){
var _483=_482.substring(0,_482.indexOf("="));
var _484=_482.substring(_482.indexOf("=")+1);
if(_483!=""||_484!=""){
_473[_483]=resolveSource(_484);
}
}
_47f=_481+1;
_480=_480.substring(_47f);
}while(_481>0);
}
}
}
}
}
return _477;
}
};
function isFlashSupported(){
return swfobject.hasFlashPlayerVersion("1");
}
function isFlashFileFormatSupported(_485){
if(_485.indexOf("rtmp")==0){
return true;
}
var _486=["flv","f4v","f4m","m3u","mp4","swf","mpeg-4","m4v","f4f","3gpp","mp3","3gpp2","pbg","gif","jpg","jpeg","aac","speex","nellymoser","QuickTime"];
var _487=_485.lastIndexOf(".");
var _488=_485.substring(_487+1,_485.length);
_488=_488.toLowerCase();
for(var i=0;i<_486.length;i++){
if(_486[i]==_488){
return true;
}
}
return false;
}
function isHTMLFileFormatSupported(_48a){
if(_48a==null){
return false;
}
var _48b=["webm","mp4","ogv"];
var _48c=_48a.lastIndexOf(".");
var _48d=_48a.substring(_48c+1,_48a.length);
_48d=_48d.toLowerCase();
var elem=document.createElement("video");
var ogg=elem.canPlayType("video/ogg; codecs=\"theora\"");
var h264="video/mp4; codecs=\"avc1.42E01E";
var mp4=elem.canPlayType(h264+"\"")||elem.canPlayType(h264+", mp4a.40.2\"");
var webm=elem.canPlayType("video/webm; codecs=\"vp8, vorbis\"");
for(var i=0;i<_48b.length;i++){
if(_48b[i]==_48d){
if(_48d=="ogv"){
return ogg;
}else{
if(_48d=="webm"){
return webm;
}else{
if(_48d=="mp4"){
return mp4;
}
}
}
}
}
return false;
}
function getWrapper(name){
var _495=$MP.playerWrapperMap[name];
if(_495==null||typeof (_495)=="undefined"){
return $MP.playerWrapperMap[name+"_strobemediaplayback-video"];
}
return _495;
}
function getFuncMap(name){
var _497=$MP.jsFunctionMap[name];
if(_497==null||typeof (_497)=="undefined"){
return $MP.jsFunctionMap[name+"_strobemediaplayback-video"];
}
return _497;
}
ColdFusion.MediaPlayer.setMute=function(name,mute){
if($MP.bindInfoMap[name]!=null){
var _49a=getBindInfo(name);
if(_49a==null){
return;
}
_49a.mute=mute;
return;
}
var _49b=$MP.getPlayer(name);
var _49c=$MP.getType(name);
var _49d=getWrapper(name);
if(_49c=="html"){
_49b.muted=mute;
if(mute){
_49d.volumeHigh.css("background-position","0px -72px");
_49d.volumeSlider.slider("value",0);
}else{
handleChangeVolume(name,_49b.volume);
}
}else{
if(_49c=="flash"){
_49b.setMuted(mute);
}
}
};
function resolveSource(src){
if(src==null){
return null;
}
if(src.charAt(0)!="/"&&src.indexOf("://")<0){
var _49f="";
var _4a0=document.location.href;
if(_4a0||_4a0.indexOf("/")>-1){
_49f=_4a0.substring(0,_4a0.lastIndexOf("/")+1);
}
var _4a1=_49f+src;
var _4a2=_4a1.split("/");
var _4a3=new Array();
var _4a4=0;
for(var i=0;i<_4a2.length;i++){
if(_4a2[i]==".."){
_4a3[--_4a4]="";
}else{
_4a3[_4a4++]=_4a2[i];
}
}
src=_4a3[0];
for(var i=1;i<_4a4;i++){
src=src+"/"+_4a3[i];
}
}
if(src.indexOf("/")==0){
src=$MP.baseURI+src;
}
return src;
}
ColdFusion.MediaPlayer.getPlayer=function(name){
var _4a7=$MP.playerMap[name];
if(_4a7==null||typeof (_4a7)=="undefined"){
_4a7=$MP.playerMap[name+"_strobemediaplayback-video"];
if(_4a7==null||typeof (_4a7)=="undefined"){
ColdFusion.handleError(null,"mediaplayer.getplayer.notfound","widget",[name],null,null,true);
}
}
return _4a7;
};
ColdFusion.MediaPlayer.setTitle=function(name,_4a9){
if(_4a9==null){
ColdFusion.handleError(null,"mediaplayer.settitle.invalidtitle","widget",[name],null,null,true);
}
var _4aa=$MP.titleDataMap[name];
if(_4aa==null){
_4aa={};
$MP.titleDataMap[name]=_4aa;
}
var _4ab=document.getElementById(name+"_videoTitle");
if(_4ab==null){
var _4ac="<div id=\""+name+"_videoTitle\">";
$("#"+name+"_videoContainer").prepend(_4ac);
}
_4aa.hideTitle=false;
_4aa.title=_4a9;
handleTitle(name,_4a9,_4aa);
};
ColdFusion.MediaPlayer.setSource=function(name,src){
if(src==null||src=="undefined"){
ColdFusion.handleError(null,"mediaplayer.setsource.invalidsource","widget",[name],null,null,true);
}
if($MP.bindInfoMap[name]!=null){
var _4af=getBindInfo(name);
if(_4af==null){
return;
}
_4af.player_options.src=resolveSource(src);
if(isFlashFileFormatSupported(src)&&isFlashSupported()){
_4af.player_options.favorFlashOverHtml5Video=true;
}else{
_4af.player_options.favorFlashOverHtml5Video=false;
}
_4af.videoTitle=getVideoTitle(src);
return;
}
var _4b0=$MP.getPlayer(name);
var _4b1=$MP.getType(name);
src=resolveSource(src);
var _4b2=getWrapper(name);
var _4b3,jsFunctionMap;
if(_4b2!=null&&_4b2.errorwindow!=null){
_4b2.errorwindow.html("");
_4b2.errorwindow.hide();
_4b3=$MP.playerOptionsMap[_4b2.options.id];
}else{
_4b3=$MP.playerOptionsMap[name+"_"+"strobemediaplayback-video"];
jsFunctionMap=$MP.jsFunctionMap[name+"_"+"strobemediaplayback-video"];
}
if(_4b3==null){
_4b3=$MP.defaultOptions;
}
var _4b4={"tablet":{"name":_4b3.id+"_"+"strobemediaplayback-video"},"smartphone":{"startSize":{"width":360,"height":200},"name":_4b3.id+"_"+"strobemediaplayback-video"},"default":{"startSize":{"width":+_4b3.width,"height":+_4b3.height},"name":_4b3.id+"_"+"strobemediaplayback-video"}};
if(_4b1=="html"){
if(isHTMLFileFormatSupported(src)){
_4b0.src=src;
_4b0.load();
_4b0.pause();
_4b2.playOverlay.fadeIn(600);
_4b2.playtoggle.removeClass("paused");
_4b2.slider.css({"left":"0%"});
_4b2.playedbar.css({"width":"0%"});
_4b2.currenttime.html("0:00");
_4b2.duration.html("0:00");
var css={"left":"0%","width":"0%"};
_4b2.bufferbar.removeClass("done");
_4b2.bufferbar.css(css);
var _4b6=$MP.titleDataMap[_4b3.id];
handleTitle(name,src,_4b6);
}else{
if(isFlashFileFormatSupported(src)&&isFlashSupported()){
_4b3.isHTML5=false;
_4b3.favorFlashOverHtml5Video=true;
_4b3.src=src;
var _4b6=$MP.titleDataMap[_4b3.id];
if(_4b6.hideTitle!=null&&!_4b6.hideTitle){
_4b3.wmode="opaque";
}
strobeMediaPlayback.draw(_4b3.id+"_"+"strobemediaplayback-video",_4b4,_4b3);
var _4b7=$("#"+_4b3.id+"_"+"strobemediaplayback-video");
var _4b8=_4b7.find("video");
var _4b9=_4b8.get(0);
var _4ba=$("#"+_4b3.id+"_"+"strobemediaplayback-video  .html5player").strobemediaplaybackhtml5(_4b3,_4b2.jsCallbackFunctions);
$MP.playerMap[_4b3.id]=_4b9;
$MP.playerWrapperMap[_4b3.id]=_4ba;
handleTitle(_4b3.id,_4b3.src,_4b6);
}
}
}else{
if(_4b1=="flash"){
if(isFlashFileFormatSupported(src)&&isFlashSupported()){
_4b0.setMediaResourceURL(src);
handleTitle(name,src,$MP.titleDataMap[id]);
}else{
if(isHTMLFileFormatSupported(src)){
var id=_4b3.id+"_strobemediaplayback-video";
$("#"+id).replaceWith("<div  id=\""+id+"\"></div>");
$("#"+id).css("visibility","visible");
_4b3.isHTML5=true;
_4b3.favorFlashOverHtml5Video=false;
_4b3.src=src;
strobeMediaPlayback.draw(id,_4b4,_4b3);
var _4b7=$("#"+id);
var _4b8=_4b7.find("video");
var _4b9=_4b8.get(0);
if(_4b9==null){
return;
}
var _4bc=getFuncMap(id);
var _4ba=$("#"+id+"  .html5player").strobemediaplaybackhtml5(_4b3,_4bc);
$MP.playerMap[_4b3.id]=_4b9;
$MP.playerWrapperMap[_4b3.id]=_4ba;
handlePlayoverlay(_4b3.id,_4b3.width,_4b3.height);
handleErrorElement(_4b3.id,_4b3.width,_4b3.height);
_4ba.playOverlay.css("display","block");
handleTitle(_4b3.id,_4b3.src,$MP.titleDataMap[id]);
_4b9.load();
if(_4b3.autoPlay==false){
_4b9.pause();
}
}
}
}
}
};
function getBindInfo(name){
var _4be=$MP.bindInfoMap[name];
if(_4be!=null){
return _4be;
}
return;
}
function handleBindElements(_4bf){
if(_4bf!=null){
if(_4bf.bindEvent==null||_4bf.bindEvent.toLowerCase()=="onclick"){
bindFancyBox(false,false,_4bf.bindElement,_4bf.player_options,_4bf.type,_4bf.jsFuncc,_4bf.videoContent,_4bf.videoTitle);
}else{
var _4c0=document.getElementById(_4bf.bindElement);
var _4c1=_4bf.bindEvent.substring(2);
$("#"+_4bf.bindElement).live(_4c1.toLowerCase(),function(e){
bindFancyBox(true,false,_4bf.bindElement,_4bf.player_options,_4bf.type,_4bf.jsFuncc,_4bf.videoContent,_4bf.videoTitle);
});
}
}
}
function handleChangeVolume(name,_4c4){
var _4c5=$MP.getPlayer(name);
var _4c6=$MP.getType(name);
if(_4c6=="html"){
if(_4c5.muted){
_4c5.muted=false;
}
_4c5.volume=_4c4;
var _4c7=getWrapper(name);
var _4c8=_4c7.volumeSlider;
_4c8.slider("value",_4c4*100);
handleVolumeChangeUI(name,_4c4);
}else{
if(_4c6=="flash"){
_4c5.setVolume(_4c4);
}
}
}
ColdFusion.MediaPlayer.setVolume=function(name,_4ca){
if(_4ca<=0){
ColdFusion.handleError(null,"mediaplayer.setvolume.invalidvalue","widget",[name],null,null,true);
}
if($MP.bindInfoMap[name]!=null){
var _4cb=getBindInfo(name);
if(_4cb==null){
return;
}
_4cb.volume=_4ca;
return;
}
handleChangeVolume(name,_4ca);
};
ColdFusion.MediaPlayer.resize=function(name,_4cd,_4ce){
if(_4cd<=0||_4ce<=0){
ColdFusion.handleError(null,"mediaplayer.resize.invalidvalue","widget",[name],null,null,true);
}
if($MP.bindInfoMap[name]!=null){
var _4cf=getBindInfo(name);
if(_4cf==null){
return;
}
_4cf.player_options.width=_4cd;
_4cf.player_options.height=_4ce;
return;
}
var _4d0=false;
var _4d1=$MP.getPlayer(name);
var _4d2=$MP.getType(name);
var _4d3=getWrapper(name);
_4d1.width=_4cd;
_4d1.height=_4ce;
if(_4d3!=null){
_4d3.options.width=_4cd;
_4d3.options.height=_4ce;
_4d3.controlbar.css("width",_4cd-1.5);
if(_4d3.options.width>180){
_4d3.progressbar.css("width",_4cd-180);
_4d3.trackswidth=_4cd-180;
}else{
_4d3.progressbar.css("width","50%");
_4d3.trackswidth="50%";
}
handlePlayoverlay(name,_4cd,_4ce);
handleErrorElement(name,_4cd,_4ce);
}
$("#"+name+"_"+"videoContainer").css("width",_4cd);
$("#"+name+"_"+"videoContainer").css("height",_4ce);
if(_4d1.paused==false){
_4d3.playOverlay.hide();
}
};
ColdFusion.MediaPlayer.getType=function(name){
var elem=document.getElementById(name);
if(elem==null||elem=="undefined"){
elem=document.getElementById(name+"_strobemediaplayback-video");
if(elem==null||typeof (elem)=="undefined"){
return "unknown";
}
}
var type=elem.nodeName;
if(type==null){
return "unknown";
}
type=type.toLowerCase();
if(type=="video"){
return "html";
}else{
if(type=="object"){
return "flash";
}else{
return "unknown";
}
}
};
ColdFusion.MediaPlayer.startPlay=function(name){
if($MP.bindInfoMap[name]!=null){
var _4d8=getBindInfo(name);
if(_4d8==null){
return;
}
_4d8.startPlay=true;
return;
}
var _4d9=$MP.getPlayer(name);
var _4da=$MP.getType(name);
if(_4da=="html"){
_4d9.play();
}else{
if(_4da=="flash"){
_4d9.play2();
}
}
};
ColdFusion.MediaPlayer.stopPlay=function(name){
if($MP.bindInfoMap[name]!=null){
var _4dc=getBindInfo(name);
if(_4dc==null){
return;
}
_4dc.stopPlay=true;
return;
}
var _4dd=$MP.getPlayer(name);
_4dd.pause();
};
ColdFusion.MediaPlayer.logError=function(name,_4df){
if(name==null||_4df==null){
return;
}
var _4e0=$MP.playerWrapperMap[name];
if(_4e0==null){
_4e0=$MP.playerWrapperMap[name+"_strobemediaplayback-video"];
if(_4e0==null){
return;
}
}
_4e0.errorwindow.html(_4df);
_4e0.errorwindow.show();
_4e0.playOverlay.hide();
};
function handlePlayoverlay(name,_4e2,_4e3){
if(!isDesktop){
return;
}
var _4e4=getWrapper(name);
_4e4.playOverlay.css("left","");
_4e4.playOverlay.css("top","");
_4e4.playOverlay.css("left",(_4e2-116)/2+"px");
_4e4.playOverlay.css("top",(_4e3-107)/2+"px");
}
function handleErrorElement(name,_4e6,_4e7){
var _4e8=getWrapper(name);
_4e8.playOverlay.css("display","none");
_4e8.errorwindow.css("left","");
_4e8.errorwindow.css("top","");
_4e8.errorwindow.css("display","none");
var _4e9=_4e8.controlbar;
var _4ea=0;
if(_4e9!=null){
_4ea=_4e9.css("height");
if(_4ea!=null&&_4ea.indexOf("px")!=-1){
_4ea=_4ea.substring(0,_4ea.indexOf("px"));
}else{
_4ea=0;
}
}
_4e8.errorwindow.css("margin-top",_4e7/2-_4ea+"px");
}
function handleTitleResize(id,_4ec,_4ed){
$("#"+id+"_videoTitle").css("width","");
$("#"+id+"_videoTitle").css("width",_4ec+"px");
}
function handleTitle(_4ee,_4ef,_4f0){
var _4f1=document.getElementById(_4ee+"_"+"videoTitle");
if(_4f1==null){
_4ee=_4ee.substring(0,_4ee.indexOf("_strobemediaplayback-video"));
_4f1=document.getElementById(_4ee+"_"+"videoTitle");
}
var _4f2=document.getElementById("fancybox-title-float-main");
if(_4f1!=null){
if(_4f0==null){
_4f0=$MP.titleDataMap[_4ee];
if(_4f0==null||_4f0.hideTitle){
var _4f3=_4f1.parentNode;
_4f3.removeChild(_4f1);
return;
}
}else{
if(_4f0.hideTitle){
var _4f3=_4f1.parentNode;
_4f3.removeChild(_4f1);
return;
}
}
var _4f4=_4f0.title;
if(_4f0==null||_4f0.title==null||_4f0.title.trim()==""){
_4f4=getVideoTitle(_4ef);
}
if(_4f4!=""){
_4f1.innerHTML=_4f4;
}else{
return;
}
$("#"+_4ee+"_"+"videoTitle").css("position","absolute");
$("#"+_4ee+"_"+"videoTitle").css("z-index",2);
if(_4f0==null||_4f0.title_text_color==null){
$("#"+_4ee+"_"+"videoTitle").css("color","white");
}else{
$("#"+_4ee+"_"+"videoTitle").css("color",_4f0.title_text_color);
}
if(_4f0!=null&&_4f0.title_bgcolor!=null){
$("#"+_4ee+"_"+"videoTitle").css("background-color",_4f0.title_bgcolor);
}
$("#"+_4ee+"_"+"videoTitle").css("font-weight","bold");
$("#"+_4ee+"_"+"videoTitle").css("font-family","Arial,Helvetica,sans-serif");
$("#"+_4ee+"_"+"videoTitle").css("font-size","13px");
$("#"+_4ee+"_"+"videoTitle").css("word-wrap","break-word");
if(_4f1.style.backgroundColor==null||_4f1.style.backgroundColor==""){
$("#"+_4ee+"_"+"videoTitle").css("margin-left","5px");
}
$("#"+_4ee+"_"+"videoTitle").show();
$("#"+_4ee+"_"+"strobemediaplayback").css("z-index",1);
}else{
if(_4f2!=null&&_4ef!=null){
$("#fancybox-title-float-main").text(_4ef);
}
}
}
function getVideoTitle(_4f5){
var _4f6=null;
if(_4f5!=null&&_4f5!=""){
var _4f7=_4f5.lastIndexOf("/");
if(_4f7==-1){
_4f7=_4f5.lastIndexOf("\\");
}
if(_4f7==-1){
_4f6=_4f5;
}
if(_4f6==null){
_4f6=_4f5.substring(_4f7+1,_4f5.length);
}
}
if(_4f6==null||_4f6.indexOf(".")<0){
return _4f5;
}else{
return _4f6;
}
}
function handlebackgroundColor(_4f8){
if(_4f8.backgroundColor==null){
return;
}
var _4f9=document.getElementById(_4f8.id);
if(_4f9==null){
return;
}
_4f9.setAttribute("style","background-color:"+_4f8.backgroundColor+";");
}
function handleBorderStyle(_4fa,_4fb){
if(_4fb.hideBorder){
return;
}
var _4fc="#fff";
if(_4fb.bgColor){
_4fc=_4fb.bgColor;
}
var _4fd=document.getElementById(_4fa+"_"+"videoContainer");
if(_4fd==null){
_4fa=_4fa.substring(0,_4fa.indexOf("_"));
}
if(_4fb.border_left!=null){
$("#"+_4fa+"_"+"videoContainer").css("border-left",_4fb.border_left+"px"+" solid "+_4fc);
}
if(_4fb.border_right!=null){
$("#"+_4fa+"_"+"videoContainer").css("border-right",_4fb.border_right+"px"+" solid "+_4fc);
}
if(_4fb.border_top!=null){
$("#"+_4fa+"_"+"videoContainer").css("border-top",_4fb.border_top+"px"+" solid "+_4fc);
}
if(_4fb.border_bottom!=null){
$("#"+_4fa+"_"+"videoContainer").css("border-bottom",_4fb.border_bottom+"px"+" solid "+_4fc);
}
}
function handleControlsStyle(_4fe,_4ff){
var _500=getWrapper(_4fe);
if(_4ff.controlbar_bgcolor!=null){
_500.controlbar.css("background-color",_4ff.controlbar_bgcolor);
}
if(_4ff.controls_color!=null){
_500.playtoggle.css("background-color",_4ff.controls_color);
_500.slider.css("background-color",_4ff.controls_color);
_500.fullview.css("background-color",_4ff.controls_color);
_500.currenttime.css("color",_4ff.controls_color);
_500.duration.css("color",_4ff.controls_color);
_500.seekbar.css("background-color",_4ff.controls_color);
_500.volumeHigh.css("background-color",_4ff.controls_color);
}
if(_4ff.progress_bgcolor!=null){
_500.bufferbar.css("background-color",_4ff.progress_bgcolor);
}
if(_4ff.progress_color!=null){
_500.playedbar.css("background-color",_4ff.progress_color);
}
}
function triggerHandler(id,_502,_503){
if(_502=="onJavaScriptBridgeCreated"){
return;
}else{
if(_502=="play"){
var _504=getFuncMap(id);
var _505=$MP.videoMonitorMap[id];
if(_504.onStartCallback!=null&&_505.paused){
_504.onStartCallback(id);
_505.paused=false;
}
hideTitle(id);
}else{
if(_502=="pause"){
var _504=getFuncMap(id);
var _505=$MP.videoMonitorMap[id];
if(_504.onPauseCallback!=null&&!_505.paused){
_504.onPauseCallback(id);
_505.paused=true;
}
showTitle(id);
}else{
if(_502=="complete"){
var _504=getFuncMap(id);
if(_504.onComplete!=null){
_504.onComplete();
}
var _505=$MP.videoMonitorMap[id];
_505.paused=true;
showTitle(id);
}else{
if(_502=="loadedmetadata"){
var _504=getFuncMap(id);
if(_504.onLoad!=null){
_504.onLoad();
}
}else{
if(_502=="error"){
var _504=getFuncMap(id);
if(_504.onError!=null){
_504.onError();
}
}else{
if(_502=="volumechange"){
var _505=$MP.videoMonitorMap[id];
_505.muted=_503.muted;
}
}
}
}
}
}
}
}
function onError(_506){
var _507;
var _508;
var _509;
var _50a;
if(_506.target!=null&&_506.target.tagName.toLowerCase()=="video"){
_509=getFuncMap(_506.target.id);
if(_506.target.error!=null){
_508=_506.target.error.code;
}
_50a=getWrapper(_506.target.id);
}else{
if(_506.target!=null&&_506.target.tagName.toLowerCase()=="source"){
var _50b=_506.target.getAttribute("src");
var _50c=_506.target.getAttribute("onerror");
if(_50b!=null&&_50c!=null){
_508=4;
}else{
return;
}
}
var _50d=_506.target.parentNode;
_509=getFuncMap(_50d.id);
_50a=getWrapper(_50d.id);
}
if(_508==null){
return;
}
if(_509.onError!=null){
_509.onError(_508);
return;
}
switch(_508){
case 1:
_507="You aborted the video playback.";
break;
case 2:
_507="A network error caused the video download to fail part-way.";
break;
case 3:
_507="The video playback was aborted due to a corruption problem or because the video used features your browser did not support.";
break;
case 4:
_507="The video could not be loaded, either because the server or network failed or because the format is not supported.";
break;
default:
_507="An unknown error occurred.";
break;
}
_50a.playOverlay.css("display","none");
_50a.errorwindow.html(_507);
_50a.errorwindow.show();
}
function onFlashEmbedComplete(_50e){
var _50f=$("#"+_50e.id);
var _510=_50f.get(0);
$MP.playerMap[_50e.id]=_510;
}
function removejscssfile(_511,_512){
var _513=(_512=="js")?"script":(_512=="css")?"link":"none";
var _514=(_512=="js")?"src":(_512=="css")?"href":"none";
var _515=document.getElementsByTagName(_513);
for(var i=_515.length;i>=0;i--){
if(_515[i]&&_515[i].getAttribute(_514)!=null&&_515[i].getAttribute(_514).indexOf(_511)!=-1){
_515[i].parentNode.removeChild(_515[i]);
}
}
}
