/*ADOBE SYSTEMS INCORPORATED
Copyright 2012 Adobe Systems Incorporated
All Rights Reserved.

NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
terms of the Adobe license agreement accompanying it.  If you have received this file from a
source other than Adobe, then your use, modification, or distribution of it requires the prior
written permission of Adobe.*/
ColdFusion.WebSocket={NS:"coldfusion.websocket.channels",WELCOME:"welcome",AUTHENTICATE:"authenticate",SUBSCRIBE:"subscribe",UNSUBSCRIBE:"unsubscribe",PUBLISH:"publish",INVOKE_AND_PUBLISH:"invokeAndPublish",GET_CHANNELS:"getChannels",GET_SUBSCRIBER_COUNT:"getSubscriberCount",GET_SUBSCRIPTIONS:"getSubscriptions",SEND_MESSAGE:"sendMessage",INVOKE_AND_MESSAGE:"invokeAndSend",INVOKE:"invoke",STOP:"stop",init:function(id,_5c7,_5c8,_5c9,_5ca,_5cb,_5cc,_5cd,_5ce,_5cf,_5d0){
if(cf_ws.isWebSocketSupported()){
lWSC=new cf_ws.CFWebSocketWrapper();
ColdFusion.WebSocket[id]=lWSC;
lWSC.options={OnWelcome:this.cfonOpencallBk,OnMessage:this.cfMessageHandlerCallBk,OnClose:_5cd,onError:_5ce,appName:_5c7,cfauth:_5c9,subscribeTo:_5ca,referrer:_5cf};
var _5d1=self.location.hostname;
if(!(self.WebSocket||self.MozWebSocket)&&_5c8==true){
var _5d2={ns:ColdFusion.WebSocket.NS,reqType:ColdFusion.WebSocket.WELCOME,code:-1,msg:"WebSocket over SSL will not work as your browser does not have native WebSockets support."};
var _5d3=_5ce!=null?_5ce:_5cb;
_5d3(_5d2);
return;
}
if(_5c8==false&&_5d1&&_5d1=="localhost"){
_5d1="127.0.0.1";
}
var _5d4;
var port;
if(_5d0){
if(self.location.port!=""){
port=self.location.port;
}else{
if(self.location.protocol!=""&&self.location.protocol=="https:"){
port=443;
}else{
port=80;
}
}
if(self.location.protocol!=""&&self.location.protocol=="https:"){
protocol="wss://";
}else{
protocol="ws://";
}
_5d4="/cfws";
}else{
port=_5c8?_cf_websocket_ssl_port:_cf_websocket_port;
_5d4="/cfusion"+"/cfusion";
protocol=_5c8?"wss://":"ws://";
}
var lURL=protocol+(_5d1)+":"+port+_5d4;
lWSC.options.url=lURL;
var lRes=lWSC.open(lURL,lWSC.options);
lWSC.isOpen=true;
lWSC.processConnected=function(_5d8){
};
lWSC.processDisconnected=function(_5d9){
};
lWSC.defaultMessageHandler=_5cb;
if(_5cc){
lWSC.appOnOpenHandler=_5cc;
}
lWSC.channelSpecificResHandlers={};
lWSC.subscribercount_callbackHandlers={};
return lWSC;
}else{
var _5d2={ns:ColdFusion.WebSocket.NS,reqType:ColdFusion.WebSocket.WELCOME,code:-1,msg:"Browser neither have native WebSocket support nor a flash player for the fallback."};
var _5d3=_5ce!=null?_5ce:_5cb;
_5d3(_5d2);
}
},welcome:function(_5da,_5db,_5dc){
var lRes=this.isConnected();
if(lRes==true){
this.sendToken({ns:ColdFusion.WebSocket.NS,type:ColdFusion.WebSocket.WELCOME,authKey:_5da,subscribeTo:_5db,appName:_5dc});
}
return lRes;
},authenticate:function(_5de,_5df){
var lRes=this.isConnected();
if(lRes==true){
this.sendToken({ns:ColdFusion.WebSocket.NS,type:ColdFusion.WebSocket.AUTHENTICATE,username:_5de,password:_5df,appName:this.options.appName});
}
return lRes;
},subscribe:function(_5e1,_5e2,_5e3){
var lRes=this.isConnected();
if(lRes==true){
var _5e5={ns:ColdFusion.WebSocket.NS,type:ColdFusion.WebSocket.SUBSCRIBE,channel:_5e1,appName:this.options.appName};
if(_5e2!=null&&(typeof _5e2=="object")){
_5e5.customOptions=_5e2;
}
this.sendToken(_5e5);
if(_5e3){
this.channelSpecificResHandlers[_5e1]=_5e3;
this.channelName_subscriptionInProcess=_5e1;
}
}
return lRes;
},unsubscribe:function(_5e6){
var lRes=this.isConnected();
if(lRes==true){
var _5e8={ns:ColdFusion.WebSocket.NS,type:ColdFusion.WebSocket.UNSUBSCRIBE,channel:_5e6,appName:this.options.appName};
this.sendToken(_5e8);
delete this.channelSpecificResHandlers[_5e6];
}
return lRes;
},publish:function(_5e9,_5ea,_5eb){
var lRes=this.isConnected();
if(lRes==true){
var _5ed={ns:ColdFusion.WebSocket.NS,type:ColdFusion.WebSocket.PUBLISH,channel:_5e9,data:_5ea,appName:this.options.appName};
if(_5eb!=null&&(typeof _5eb=="object")){
_5ed.customOptions=_5eb;
}
this.sendToken(_5ed);
}
return lRes;
},invokeAndPublish:function(_5ee,_5ef,_5f0,_5f1,_5f2){
var lRes=this.isConnected();
if(lRes==true){
var _5f4={ns:ColdFusion.WebSocket.NS,type:ColdFusion.WebSocket.INVOKE_AND_PUBLISH,channel:_5ee,cfcName:_5ef,cfcMethod:_5f0,methodArguments:_5f1,appName:this.options.appName,referrer:this.options.referrer};
if(_5f2!=null&&(typeof _5f2=="object")){
_5f4.customOptions=_5f2;
}
this.sendToken(_5f4);
}
return lRes;
},getSubscriberCount:function(_5f5,_5f6){
var lRes=this.isConnected();
if(lRes==true){
var _5f8={ns:ColdFusion.WebSocket.NS,type:ColdFusion.WebSocket.GET_SUBSCRIBER_COUNT,channel:_5f5,appName:this.options.appName};
this.sendToken(_5f8);
}
if(_5f6){
if(!this.subscribercount_callbackHandlers){
this.subscribercount_callbackHandlers={};
}
this.subscribercount_callbackHandlers[_5f5]=_5f6;
}
return lRes;
},getSubscriptions:function(_5f9){
var lRes=this.isConnected();
if(lRes==true){
var _5fb={ns:ColdFusion.WebSocket.NS,type:ColdFusion.WebSocket.GET_SUBSCRIPTIONS,appName:this.options.appName};
this.sendToken(_5fb);
}
if(_5f9){
this.subscriptions_callbackHandler=_5f9;
}
return lRes;
},sendMessage:function(_5fc,_5fd,_5fe){
var lRes=this.isConnected();
if(lRes==true){
var _600={ns:ColdFusion.WebSocket.NS,type:ColdFusion.WebSocket.SEND_MESSAGE,targetId:_5fc,data:_5fd,appName:this.options.appName};
if(_5fe!=null&&(typeof _5fe=="object")){
_600.customOptions=_5fe;
}
this.sendToken(_600);
}
return lRes;
},invokeAndSend:function(_601,_602,_603,_604,_605){
var lRes=this.isConnected();
if(lRes==true){
var _607={ns:ColdFusion.WebSocket.NS,type:ColdFusion.WebSocket.INVOKE_AND_MESSAGE,target:_601,cfcName:_602,cfcMethod:_603,methodArguments:_604,appName:this.options.appName};
if(_605!=null&&(typeof _605=="object")){
_607.customOptions=_605;
}
this.sendToken(_607);
}
return lRes;
},invoke:function(_608,_609,_60a,_60b){
var lRes=this.isConnected();
if(lRes==true){
var _60d={ns:ColdFusion.WebSocket.NS,type:ColdFusion.WebSocket.INVOKE,cfcName:_608,cfcMethod:_609,methodArguments:_60a,appName:this.options.appName,referrer:this.options.referrer};
if(_60b!=null&&(typeof _60b=="object")){
_60d.customOptions=_60b;
}
this.sendToken(_60d);
}
return lRes;
},openConnection:function(){
var lURL=lWSC.options.url;
this.open(lURL,this.options);
},isConnectionOpen:function(){
var _60f=this.isConnected();
return _60f;
},closeConnection:function(){
this.close({fireClose:true});
},cfonOpencallBk:function(_610){
if(this.cfauth!=null||this.susbcribeTo!=null){
_610.welcome(this.cfauth,this.subscribeTo,this.appName);
}
if(_610.appOnOpenHandler){
_610.appOnOpenHandler(_610);
}
},cfMessageHandlerCallBk:function(_611,_612){
var _613=_612.defaultMessageHandler;
if((_611.type=="event")&&(_611.name=="connect"||_611.name=="disconnect")){
return;
}
if((_611.reqType=="subscribe")&&_612.channelName_subscriptionInProcess!=null){
if(_611.code==-1){
delete _612.channelSpecificResHandlers[_612.channelName_subscriptionInProcess];
}
delete _612.channelName_subscriptionInProcess;
}
if((_611.reqType=="getSubscriberCount")&&_612.subscribercount_callbackHandlers[_611.channel]!=null){
_612.subscribercount_callbackHandlers[_611.channel].call(this,_611);
delete _612.subscribercount_callbackHandlers[_611.channelname];
return;
}
if((_611.reqType=="getSubscriptions")&&_612.subscriptions_callbackHandler!=null){
_612.subscriptions_callbackHandler(_611);
delete _612.subscriptions_callbackHandler;
return;
}
if(_611.type=="data"&&_611.channelname){
var _614=_611.channelname;
var _615=_612.channelSpecificResHandlers[_614];
while(_615==null){
var lPos=_614.lastIndexOf(".");
if(lPos>0){
_614=_614.substr(0,lPos);
_615=_612.channelSpecificResHandlers[_614];
}else{
break;
}
}
if(_615){
_613=_615;
}
}
_613.call(this,_611);
}};
function cfwebsocketinit(){
var _617=ColdFusion.WebSocket;
ns=cf_ws;
for(var _618 in _617){
ns["CFWebSocketWrapper"].prototype[_618]=_617[_618];
}
}
cfwebsocketinit();
