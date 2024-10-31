/*ADOBE SYSTEMS INCORPORATED
Copyright 2012 Adobe Systems Incorporated
All Rights Reserved.

NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
terms of the Adobe license agreement accompanying it.  If you have received this file from a
source other than Adobe, then your use, modification, or distribution of it requires the prior
written permission of Adobe.*/
if(!ColdFusion.Tree){
ColdFusion.Tree={};
}
ColdFusion.Tree.AttributesCollection=function(){
this.cache=true;
this.fontname=null;
this.bold=false;
this.italic=false;
this.completepath=false;
this.appendkey=false;
this.delimiter=null;
this.formname=null;
this.fontsize=null;
this.formparamname=null;
this.prevspanid=null;
this.prevspanbackground=null;
this.images={};
this.images.folder=_cf_ajaxscriptsrc+"/resources/cf/images/FolderClose.gif";
this.images.cd=_cf_ajaxscriptsrc+"/resources/cf/images/Cd.png";
this.images.computer=_cf_ajaxscriptsrc+"/resources/cf/images/Computer.png";
this.images.document=_cf_ajaxscriptsrc+"/resources/cf/images/Document.gif";
this.images.element=_cf_ajaxscriptsrc+"/resources/cf/images/Elements.png";
this.images.floppy=_cf_ajaxscriptsrc+"/resources/cf/images/Floppy.png";
this.images.fixed=_cf_ajaxscriptsrc+"/resources/cf/images/HardDrive.png";
this.images.remote=_cf_ajaxscriptsrc+"/resources/cf/images/NetworkDrive.png";
this.imagesopen={};
this.imagesopen.folder=_cf_ajaxscriptsrc+"/resources/cf/images/FolderOpen.gif";
this.imagesopen.cd=_cf_ajaxscriptsrc+"/resources/cf/images/Cd.png";
this.imagesopen.computer=_cf_ajaxscriptsrc+"/resources/cf/images/Computer.png";
this.imagesopen.document=_cf_ajaxscriptsrc+"/resources/cf/images/Document.gif";
this.imagesopen.element=_cf_ajaxscriptsrc+"/resources/cf/images/Elements.png";
this.imagesopen.floppy=_cf_ajaxscriptsrc+"/resources/cf/images/Floppy.png";
this.imagesopen.fixed=_cf_ajaxscriptsrc+"/resources/cf/images/HardDrive.png";
this.imagesopen.remote=_cf_ajaxscriptsrc+"/resources/cf/images/NetworkDrive.png";
this.eventcount=0;
this.eventHandlers=new Array();
this.nodeCounter=0;
};
ColdFusion.Tree.refresh=function(_636){
var tree=ColdFusion.objectCache[_636];
var _638=ColdFusion.objectCache[_636+"collection"];
if(!tree||YAHOO.widget.TreeView.prototype.isPrototypeOf(tree)==false){
ColdFusion.handleError(null,"tree.refresh.notfound","widget",[_636],null,null,true);
return;
}
if(!_638.dynLoadFunction){
ColdFusion.Log.info("tree.refresh.statictree","widget");
return;
}
_638.dynLoadFunction.call(null,tree.getRoot());
ColdFusion.Log.info("tree.refresh.success","widget",[_636]);
};
ColdFusion.Tree.getTreeObject=function(_639){
if(!_639){
ColdFusion.handleError(null,"tree.gettreeobject.emptyname","widget",null,null,null,true);
return;
}
var _63a=ColdFusion.objectCache[_639];
if(_63a==null||YAHOO.widget.TreeView.prototype.isPrototypeOf(_63a)==false){
ColdFusion.handleError(null,"tree.gettreeobject.notfound","widget",[_639],null,null,true);
return;
}
return _63a;
};
ColdFusion.Tree.loadNodes=function(_63b,_63c){
var i=0;
var _63e=ColdFusion.objectCache[_63c.treeid+"collection"];
var tree=ColdFusion.objectCache[_63c.treeid];
var _640;
var _641=false;
if(_63b&&typeof (_63b.length)=="number"&&!_63b.toUpperCase){
if(_63b.length>0&&typeof (_63b[0])!="object"){
_641=true;
}
}else{
_641=true;
}
if(_641){
ColdFusion.handleError(tree.onbinderror,"tree.loadnodes.invalidbindvalue","widget",[_63c.treeid]);
return;
}
if(_63c.parent&&!_63c.parent.isRoot()){
tree.removeChildren(_63c.parent);
}else{
if(_63c.parent&&_63c.parent.hasChildren()){
tree.removeChildren(_63c.parent);
_63c.parent=tree.getRoot();
}
}
if(!_63c.parent.leafnode){
for(i=0;i<_63b.length;i++){
var _642=_63e.nodeCounter++;
var node={};
node.id=_63b[i].VALUE;
if(typeof (_63b[i].DISPLAY)==undefined||_63b[i].DISPLAY==null){
node.label=_63b[i].VALUE;
}else{
node.label=_63b[i].DISPLAY;
}
node.expand=_63b[i].EXPAND;
node.appendkey=_63b[i].APPENDKEY;
node.href=_63b[i].HREF;
node.img=_63b[i].IMG;
node.imgOpen=_63b[i].IMGOPEN;
node.imgid="_cf_image"+_642;
node.spanid="_cf_span"+_642;
node.target=_63b[i].TARGET;
if(_63e.appendkey&&_63e.appendkey==true&&node.href){
var _644=new String(node.href);
_644=_644.toLowerCase();
if(_644.indexOf("javascript")<0){
if(_644.indexOf("?")>=0){
node.href=_63b[i].HREF+"&";
}else{
node.href=_63b[i].HREF+"?";
}
node.href=node.href+"CFTREEITEMKEY="+node.id;
}
}
var _645="";
if(node.img){
if(_63e.images[node.img]){
_645="<img src='"+_63e.images[node.img]+"' id='"+node.imgid+"' style='border:0'/>&nbsp;";
}else{
_645="<img src='"+node.img+"' id='"+node.imgid+"' style='border:0'/>&nbsp;";
}
}
if(_63e.fontname||_63e.italic==true||_63e.bold==true||_63e.fontsize){
_645=_645+"<span id='"+node.spanid+"' style='";
if(_63e.fontname){
_645=_645+"font-family:"+_63e.fontname+";";
}
if(_63e.italic==true){
_645=_645+"font-style:italic;";
}
if(_63e.bold==true){
_645=_645+"font-weight:bold;";
}
if(_63e.fontsize){
_645=_645+"font-size:"+_63e.fontsize+";";
}
_645=_645+"'>"+node.label+"</span>";
node.label=_645;
}else{
node.label=_645+"<span id='"+node.spanid+"'  >"+node.label+"</span>";
}
node.childrenFetched=false;
var _646=new YAHOO.widget.TextNode(node,_63c.parent,false);
var _647=false;
if(_63b[i].LEAFNODE&&_63b[i].LEAFNODE==true){
_647=true;
_646.leafnode=true;
_646.iconMode=1;
}
if(_647==true||(node.expand&&node.expand==true)){
_646.expand();
}
}
}
if(!_63c.parent.isRoot()){
_63c.parent.data.childrenFetched=true;
}
if(_63c.onCompleteCallBack){
_63c.onCompleteCallBack.call();
}else{
_63c.parent.tree.draw();
}
ColdFusion.Log.info("tree.loadnodes.success","widget",[_63c.treeid]);
};
ColdFusion.Tree.onExpand=function(node){
if(node.isRoot()){
return;
}
var _649=ColdFusion.objectCache[node.tree.id+"collection"];
if(node.data.imgOpen&&typeof (node.leafnode)=="undefined"){
var _64a=ColdFusion.DOM.getElement(node.data.imgid,node.tree.id);
var src;
if(_649.imagesopen[node.data.imgOpen]){
src=_649.imagesopen[node.data.imgOpen];
}else{
src=node.data.imgOpen;
}
_64a.src=src;
}
if(_649.cache==false&&node.data.childrenFetched==false&&_649.dynLoadFunction){
node.tree.removeChildren(node);
}
};
ColdFusion.Tree.onCollapse=function(node){
if(node.isRoot()){
return;
}
var _64d=ColdFusion.objectCache[node.tree.id+"collection"];
if(node.data.img){
var _64e=ColdFusion.DOM.getElement(node.data.imgid,node.tree.id);
var src;
if(_64d.images[node.data.img]){
src=_64d.images[node.data.img];
}else{
src=node.data.img;
}
_64e.src=src;
}
node.data.childrenFetched=false;
};
ColdFusion.Tree.formPath=function(node,_651){
var _652=ColdFusion.objectCache[node.tree.id+"collection"];
if(_652.completepath==true&&node.isRoot()){
return "";
}else{
if(_652.completepath==false&&node.parent.isRoot()){
return "";
}
}
if(!_651){
_651=node;
}
var _653=ColdFusion.Tree.formPath(node.parent,_651);
_653=_653+node.data.id;
if(_651.data.id!=node.data.id){
_653=_653+_652.delimiter;
}
return _653;
};
ColdFusion.Tree.onLabelClick=function(node){
var _655="";
var _656=ColdFusion.objectCache[node.tree.id+"collection"];
var _655=ColdFusion.Tree.formPath(node);
if(_656.prevspanid){
var _657=ColdFusion.DOM.getElement(_656.prevspanid,node.tree.id);
if(_657.style){
_657.style.backgroundColor=_656.prevspanbackground;
}
}
var _658=ColdFusion.DOM.getElement(node.data.spanid,node.tree.id);
if(_658&&_658.style){
_656.prevspanbackground=_658.style.backgroundColor;
}
_658.style.backgroundColor="lightblue";
_656.prevspanid=node.data.spanid;
node.tree._cf_path=_655;
node.tree._cf_node=node.data.id;
var val="PATH="+_655+"; NODE="+node.data.id;
updateHiddenValue(val,_656.formname,_656.formparamname);
ColdFusion.Tree.fireSelectionChangeEvent(node.tree.id,_656.formname);
};
ColdFusion.Tree.fireSelectionChangeEvent=function(id,_65b){
ColdFusion.Log.info("tree.fireselectionchangeevent.fire","widget",[id]);
ColdFusion.Event.callBindHandlers(id,_65b,"change");
};
ColdFusion.Tree.getObject=function(_65c){
var _65d={};
_65d.id=_65c.value;
if(_65c.href&&_65c.href!="null"){
_65d.href=_65c.href;
}
_65d.target=_65c.target;
_65d.label=_65c.label;
_65d.display=_65c.display;
_65d.img=_65c.img;
_65d.imgOpen=_65c.imgOpen;
_65d.imgid=_65c.imgid;
_65d.spanid=_65c.spanid;
_65d.childrenfetched=_65c.childrenfetched;
return _65d;
};
ColdFusion.Tree.initializeTree=function(_65e,_65f,_660,bold,_662,_663,_664,_665,_666,_667,_668,_669){
var _66a=new YAHOO.widget.TreeView(_65e);
_66a.subscribe("expand",ColdFusion.Tree.onExpand);
_66a.subscribe("collapse",ColdFusion.Tree.onCollapse);
_66a.subscribe("labelClick",ColdFusion.Tree.onLabelClick);
_66a._cf_getAttribute=function(_66b){
_66b=_66b.toUpperCase();
if(_66b=="PATH"){
return _66a._cf_path;
}else{
if(_66b=="NODE"){
return _66a._cf_node;
}else{
return null;
}
}
};
_66a.onbinderror=_667;
ColdFusion.objectCache[_65e]=_66a;
var _66c=new ColdFusion.Tree.AttributesCollection();
_66c.cache=_65f;
_66c.italic=_660;
_66c.bold=bold;
_66c.completepath=_662;
_66c.delimiter=_664;
_66c.appendkey=_663;
_66c.formname=_665;
_66c.formparamname=_666;
_66c.fontsize=_668;
_66c.fontname=_669;
ColdFusion.objectCache[_65e+"collection"]=_66c;
ColdFusion.Log.info("tree.initializetree.success","widget",[_65e]);
return _66a;
};
