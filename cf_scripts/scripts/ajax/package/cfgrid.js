/*ADOBE SYSTEMS INCORPORATED
Copyright 2012 Adobe Systems Incorporated
All Rights Reserved.

NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
terms of the Adobe license agreement accompanying it.  If you have received this file from a
source other than Adobe, then your use, modification, or distribution of it requires the prior
written permission of Adobe.*/
cfinitgrid=function(){
Ext.override(Ext.form.field.Number,{decimalPrecision:6});
if(!ColdFusion.Grid){
ColdFusion.Grid={};
}
var $G=ColdFusion.Grid;
if(!$G.GridBindelementsMap){
$G.GridBindelementsMap={};
}
var $L=ColdFusion.Log;
$G.init=function(id,name,_671,_672,edit,_674,_675,_676,_677,_678,_679,_67a,_67b,_67c,_67d,_67e,_67f,_680,_681,_682,_683,_684,_685,_686,_687,_688,_689,_68a,_68b,_68c){
var grid;
var _68e;
var _68f=false;
if(_680&&typeof (_680)!="undefined"){
_68e=_680;
_68f=true;
}else{
_68e="rowmodel";
_68e=new Ext.selection.RowModel({mode:"SINGLE"});
}
var _690=_677;
var _691={store:_678,columns:_677,selModel:_68e,autoSizeColumns:_675,autoSizeHeaders:_675,stripeRows:_67b,autoExpandColumnId:_676};
if(_68a!=null&&typeof _68a!="undefined"){
_691.plugins=_68a;
}
var _692=ColdFusion.objectCache[id];
var _693=document.getElementById(_692.gridId);
if(_693!=null){
var _694=_693.style.cssText;
if(typeof _694=="undefined"){
_694="";
}
_694="width:"+_679+"px;"+_694;
_693.style.cssText=_694;
}
_691.width=_679;
if(_675===true){
_691.viewConfig={forceFit:true};
_691.forceFit=true;
}else{
if(_680&&typeof (_680)!="undefined"){
_691.autoExpandColumn=_676;
}else{
_691.autoExpandColumn=_676;
}
}
if(_67a){
_691.height=_67a;
}else{
_691.autoHeight=true;
var _695=".x-grid3-header {position: relative;}";
Ext.util.CSS.createStyleSheet(_695,"_cf_grid"+id);
}
if(_682&&typeof (_682)!="undefined"){
_691.features={ftype:"grouping",groupHeaderTpl:"{columnName}: {groupValue} ({rows.length} items)"};
}
_691.title=_683;
_691.collapsible=_681;
if(_681&&_683==null){
_691.title="  ";
}
var _696=ColdFusion.objectCache[id];
_696.bindOnLoad=_674;
_696.dynamic=_672;
_696.styles=_67c;
_696.grouping=_682;
_696.onLoadFunction=_689;
_696.multiRowSelection=_68f;
_691.renderTo=_696.gridId;
Ext.onReady(function(){
_691.dockedItems={xtype:"toolbar",dock:"top"};
_691.tbar=new Ext.Toolbar({hidden:true});
if(_672){
_691.bbar=new Ext.PagingToolbar({pageSize:_67d,store:_678});
if(_687&&(_684||_685)){
var _697=_691.bbar;
if(_684){
_697.add({xtype:"button",text:_684,handler:$G.insertRow,scope:_696});
_697.add({xtype:"button",text:" save ",handler:$G.saveNewRecord,scope:_696});
_697.add({xtype:"button",text:" cancel ",handler:$G.cancelNewRecord,scope:_696});
}
if(_685){
_697.add({xtype:"button",text:_685,handler:$G.deleteRow,scope:_696});
}
}
}
if(edit&&!_672){
var bbar=new Ext.Toolbar();
if(_684||_685){
if(_684){
bbar.add({xtype:"button",text:_684,handler:$G.insertRow,scope:_696});
}
if(_685){
bbar.add({xtype:"button",text:_685,handler:$G.deleteRow,scope:_696});
}
}else{
var bbar=new Ext.Toolbar({hidden:true});
}
_691.bbar=bbar;
}
_678.pageSize=_67d;
var fn=function(){
grid=Ext.create("Ext.grid.Panel",_691);
$G.Ext_caseInsensitive_sorting();
_678.addListener("load",$G.Actions.onLoad,_696,{delay:50});
grid.view.addListener("beforeshow",function(menu){
var _69b=_690.getColumnCount();
for(var i=0;i<_69b;i++){
if("CFGRIDROWINDEX"==_690.getDataIndex(i)){
menu.remove(menu.items["items"][i]);
break;
}
}
},this);
_696.grid=grid;
if(!_672){
_678.addListener("load",$G.Actions.onLoad,_696,{delay:50});
_678.load();
}
if(_672){
_678._cf_errorHandler=_688;
_678.proxy._cf_actions=_696;
if(_696.bindOnLoad){
_678.load({params:{start:0,limit:_67d}});
}else{
_696.bindOnLoad=true;
}
}else{
$G.applyStyles(_696);
}
if(_68b){
ColdFusion.Bind.register(_68b,{actions:_696},$G.bindHandler,false);
}
$L.info("grid.init.created","widget",[id]);
_696.init(id,name,_671,_686,_672,edit,_687,_688,_67f,_67d,_67e,_682);
};
if(_672&&_68c){
setTimeout(fn,0);
}else{
fn();
}
});
};
$G.applyStyles=function(_69d){
Ext.util.CSS.createStyleSheet(_69d.styles);
_69d.stylesApplied=true;
};
$G.bindHandler=function(e,_69f){
$G.refresh(_69f.actions.id,_69f.actions.preservePageOnSort);
};
$G.bindHandler._cf_bindhandler=true;
$G.refresh=function(_6a0,_6a1){
var _6a2=ColdFusion.objectCache[_6a0];
if(_6a2&&$G.Actions.prototype.isPrototypeOf(_6a2)==true){
var _6a3=_6a2.grid.getStore();
if(_6a2.dynamic){
_6a2.editOldValue=null;
_6a2.selectedRow=-1;
var bind=$G.GridBindelementsMap[_6a0];
if(bind){
var url=_6a3.proxy.url;
var _6a6=bind.split(";");
for(i=0;i<_6a6.length;i++){
var _6a7=_6a6[i].split(",");
indx=url.indexOf("&"+_6a7[0]+"=");
var _6a8=0;
if(indx<1){
indx=url.indexOf(_6a7[0]+"=");
_6a8=indx;
}else{
_6a8=indx+1;
}
url1=url.substring(0,indx);
nxtindx=url.indexOf("&",_6a8);
url2=url.substring(nxtindx);
var val=_6a7[2];
var eval="";
if(_6a7[2]&&_6a7[2].endsWith("()")){
val=_6a7[2].substring(0,val.length-2);
eval=window[val]();
}else{
if(_6a7[2]){
eval=ColdFusion.Bind.getBindElementValue(_6a7[1],val,_6a7[3]);
}else{
eval=_6a7[1];
}
}
url=url1+"&"+_6a7[0]+"="+eval+url2;
}
_6a3.proxy.url=url;
}
if(_6a1){
_6a3.reload();
}else{
if(_6a3.lastOptions){
_6a3.lastOptions.page=1;
}
_6a3.currentPage=1;
_6a3.reload({params:{start:0,limit:_6a2.pageSize}});
}
}
}else{
ColdFusion.handleError(null,"grid.refresh.notfound","widget",[_6a0],null,null,true);
return;
}
if(_6a2.multiRowSelection){
}
$L.info("grid.refresh.success","widget",[_6a0]);
};
$G.Ext_caseInsensitive_sorting=function(){
Ext.data.Store.prototype.sortData=function(f,_6ac){
_6ac=_6ac||"ASC";
var st=this.fields.get(f).sortType;
var fn=function(r1,r2){
var v1=st(r1.data[f]),v2=st(r2.data[f]);
if(v1.toLowerCase){
v1=v1.toLowerCase();
v2=v2.toLowerCase();
}
return v1>v2?1:(v1<v2?-1:0);
};
this.data.sort(_6ac,fn);
if(this.snapshot&&this.snapshot!=this.data){
this.snapshot.sort(_6ac,fn);
}
};
};
$G.getTopToolbar=function(_6b2){
var _6b3=ColdFusion.objectCache[_6b2];
if(!_6b3){
ColdFusion.handleError(null,"grid.getTopToolbar.notfound","widget",[_6b2],null,null,true);
return;
}
return _6b3.grid.getDockedItems()[1];
};
$G.showTopToolbar=function(_6b4){
var _6b5=ColdFusion.objectCache[_6b4];
if(!_6b5){
ColdFusion.handleError(null,"grid.showTopToolbar.notfound","widget",[_6b4],null,null,true);
return;
}
var tbar=_6b5.grid.getDockedItems()[1];
if(!tbar){
ColdFusion.handleError(null,"grid.showTopToolbar.toolbarNotDefined","widget",[_6b4],null,null,true);
return;
}
tbar.show();
};
$G.hideTopToolbar=function(_6b7){
var _6b8=ColdFusion.objectCache[_6b7];
if(!_6b8){
ColdFusion.handleError(null,"grid.hideTopToolbar.notfound","widget",[_6b7],null,null,true);
return;
}
var tbar=_6b8.grid.getDockedItems()[1];
if(!tbar){
ColdFusion.handleError(null,"grid.hideTopToolbar.toolbarNotDefined","widget",[_6b7],null,null,true);
return;
}
tbar.hide();
};
$G.refreshTopToolbar=function(_6ba){
var _6bb=ColdFusion.objectCache[_6ba];
if(!_6bb){
ColdFusion.handleError(null,"grid.refreshTopToolbar.notfound","widget",[_6ba],null,null,true);
return;
}
var tbar=_6bb.grid.getDockedItems()[1];
if(!tbar){
ColdFusion.handleError(null,"grid.refreshTopToolbar.toolbarNotDefined","widget",[_6ba],null,null,true);
return;
}
tbar.doLayout();
if(tbar.isVisible()==false){
tbar.show();
}
};
$G.getBottomToolbar=function(_6bd){
var _6be=ColdFusion.objectCache[_6bd];
if(!_6be){
ColdFusion.handleError(null,"grid.getBottomToolbar.notfound","widget",[_6bd],null,null,true);
return;
}
return _6be.grid.getDockedItems()[_6be.grid.getDockedItems().length-1];
};
$G.showBottomToolbar=function(_6bf){
var _6c0=ColdFusion.objectCache[_6bf];
if(!_6c0){
ColdFusion.handleError(null,"grid.showBottomToolbar.notfound","widget",[_6bf],null,null,true);
return;
}
var tbar=_6c0.grid.getDockedItems()[_6c0.grid.getDockedItems().length-1];
if(!tbar){
ColdFusion.handleError(null,"grid.showBottomToolbar.toolbarNotDefined","widget",[_6bf],null,null,true);
return;
}
tbar.show();
};
$G.hideBottomToolbar=function(_6c2){
var _6c3=ColdFusion.objectCache[_6c2];
if(!_6c3){
ColdFusion.handleError(null,"grid.hideBottomToolbar.notfound","widget",[_6c2],null,null,true);
return;
}
var tbar=_6c3.grid.getDockedItems()[_6c3.grid.getDockedItems().length-1];
if(!tbar){
ColdFusion.handleError(null,"grid.hideBottomToolbar.toolbarNotDefined","widget",[_6c2],null,null,true);
return;
}
tbar.hide();
};
$G.refreshBottomToolbar=function(_6c5){
var _6c6=ColdFusion.objectCache[_6c5];
if(!_6c6){
ColdFusion.handleError(null,"grid.refreshBottomToolbar.notfound","widget",[_6c5],null,null,true);
return;
}
var tbar=_6c6.grid.getDockedItems()[_6c6.grid.getDockedItems().length-1];
if(!tbar){
ColdFusion.handleError(null,"grid.refreshBottomToolbar.toolbarNotDefined","widget",[_6c5],null,null,true);
return;
}
tbar.doLayout();
if(tbar.isVisible()==false){
tbar.show();
}
};
$G.sort=function(_6c8,_6c9,_6ca){
var _6cb=ColdFusion.objectCache[_6c8];
if(!_6cb){
ColdFusion.handleError(null,"grid.sort.notfound","widget",[_6c8],null,null,true);
return;
}
_6c9=_6c9.toUpperCase();
var _6cc=-1;
var _6cd=_6cb.grid.columns;
for(var i=0;i<_6cd.length-1;i++){
if(_6c9==_6cd[i].colName){
_6cc=i;
break;
}
}
if(_6cc==-1){
ColdFusion.handleError(null,"grid.sort.colnotfound","widget",[_6c9,_6c8],null,null,true);
return;
}
if(!_6ca){
_6ca="ASC";
}
_6ca=_6ca.toUpperCase();
if(_6ca!="ASC"&&_6ca!="DESC"){
ColdFusion.handleError(null,"grid.sort.invalidsortdir","widget",[_6ca,_6c8],null,null,true);
return;
}
var _6cf=_6cb.grid.getStore();
_6cf.sort(_6c9,_6ca);
};
$G.getGridObject=function(_6d0){
if(!_6d0){
ColdFusion.handleError(null,"grid.getgridobject.missinggridname","widget",null,null,null,true);
return;
}
var _6d1=ColdFusion.objectCache[_6d0];
if(_6d1==null||$G.Actions.prototype.isPrototypeOf(_6d1)==false){
ColdFusion.handleError(null,"grid.getgridobject.notfound","widget",[_6d0],null,null,true);
return;
}
return _6d1.grid;
};
$G.getSelectedRows=function(_6d2){
if(!_6d2){
ColdFusion.handleError(null,"grid.getSelectedRowData.missinggridname","widget",null,null,null,true);
return;
}
var _6d3=ColdFusion.objectCache[_6d2];
var _6d4=new Array();
var _6d5=_6d3.grid.getSelectionModel();
var _6d6=_6d5.selected;
var _6d7=_6d3.grid.columns;
var _6d8=0;
if(_6d3.multiRowSelection===true&&_6d3.dynamic===false){
_6d8++;
}
for(i=0;i<_6d6.length;i++){
var _6d9=_6d6.items[i].data;
var _6da={};
for(var _6db=_6d8;_6db<_6d7.length-1;_6db++){
var key=_6d7[_6db].dataIndex;
_6da[key]=_6d9[key];
}
_6d4[i]=_6da;
}
return _6d4;
};
$G.clearSelectedRows=function(_6dd){
if(!_6dd){
ColdFusion.handleError(null,"grid.getSelectedRowData.missinggridname","widget",null,null,null,true);
return;
}
var _6de=ColdFusion.objectCache[_6dd];
var _6df=_6de.grid.getSelectionModel();
_6df.deselectAll();
if(_6de.multiRowSelection){
}
};
$G.Actions=function(_6e0){
this.gridId=_6e0;
this.init=$G.Actions.init;
this.onChangeHandler=$G.Actions.onChangeHandler;
this.onChangeHandler_MultiRowsDelete=$G.Actions.onChangeHandler_MultiRowsDelete;
this.selectionChangeEvent=new ColdFusion.Event.CustomEvent("cfGridSelectionChange",_6e0);
this.fireSelectionChangeEvent=$G.fireSelectionChangeEvent;
this._cf_getAttribute=$G.Actions._cf_getAttribute;
this._cf_register=$G.Actions._cf_register;
this.loaded=false;
};
$G.Actions.init=function(id,_6e2,_6e3,_6e4,_6e5,edit,_6e7,_6e8,_6e9,_6ea,_6eb,_6ec){
this.id=id;
this.gridName=_6e2;
this.formId=_6e3;
this.form=document.getElementById(_6e3);
this.cellClickInfo=_6e4;
this.edit=edit;
this.onChangeFunction=_6e7;
this.onErrorFunction=_6e8;
this.preservePageOnSort=_6e9;
this.pageSize=_6ea;
this.selectedRow=-1;
this.selectOnLoad=_6eb;
this.grouping=_6ec;
this.grid.addListener("cellclick",$G.cellClick,this,true);
this.editField=document.createElement("input");
this.editField.setAttribute("name",_6e2);
this.editField.setAttribute("type","hidden");
this.form.appendChild(this.editField);
if(edit){
if(!_6e5){
var _6ed=this.grid.columns;
this.editFieldPrefix="__CFGRID__EDIT__=";
var i=0;
var _6ef=_6ed.length-1;
if(this.multiRowSelection===true&&this.dynamic===false){
i++;
_6ef--;
}
this.editFieldPrefix+=_6ef+$G.Actions.fieldSep;
var _6f0=true;
for(i;i<_6ed.length-1;i++){
if(!_6f0){
this.editFieldPrefix+=$G.Actions.fieldSep;
}
this.editFieldPrefix+=_6ed[i].colName;
this.editFieldPrefix+=$G.Actions.valueSep;
if(_6ed[i].getEditor()){
this.editFieldPrefix+="Y";
}else{
this.editFieldPrefix+="N";
}
_6f0=false;
}
this.editFieldPrefix+=$G.Actions.fieldSep;
}
this.editFieldState=[];
this.editFieldState.length=this.grid.getStore().getTotalCount();
$G.Actions.computeEditField(this);
this.insertInProgress=false;
this.insertEvent=null;
this.grid.addListener("beforeedit",$G.Actions.beforeEdit,this);
this.grid.addListener("edit",$G.Actions.afterEdit,this,true);
}
if(_6e5){
this.grid.getStore().addListener("beforeload",$G.Actions.beforeLoad,this,true);
}
this.grid.getSelectionModel().addListener("select",$G.rowSelect,this,true);
this.grid.getSelectionModel().addListener("beforerowselect",$G.beforeRowSelect,this,true);
};
$G.Actions.beforeLoad=function(_6f1,_6f2){
var _6f3=_6f1.sortInfo;
var _6f4=(_6f2.sorters&&_6f2.sorters[0]&&_6f2.sorters[0].property!=this.sortCol);
if(_6f4&&!this.preservePageOnSort){
_6f2.start=0;
_6f2.page=1;
_6f1.currentPage=1;
}
if(_6f2.sorters&&_6f2.sorters[0]){
this.sortCol=_6f2.sorters[0].property;
this.sortDir=_6f2.sorters[0].direction;
}
};
$G.Actions.onLoad=function(_6f5){
this.editOldValue=null;
this.selectedRow=-1;
this.insertInProgress=false;
var _6f6=0;
if((this.bindOnLoad||!this.dynamic)&&this.selectOnLoad&&!this.grouping){
this.grid.getSelectionModel().select(_6f6,false);
}
if(!this.gridRendered&&this.onLoadFunction&&typeof this.onLoadFunction=="function"){
this.gridRendered=true;
this.onLoadFunction.call(null,this.grid);
}
$G.applyStyles(_6f5);
try{
var _6f7=Ext.ComponentQuery.query("tabpanel");
if(_6f7&&this.grid&&this.loaded==false){
for(var i=0;i<_6f7.length;i++){
if(_6f7[i].body.dom.innerHTML.indexOf(this.grid.id)>0){
_6f7[i].updateLayout();
this.loaded=true;
}
}
}
}
catch(exception){
}
};
$G.Actions._cf_getAttribute=function(_6f9){
_6f9=_6f9.toUpperCase();
var _6fa=this.selectedRow;
var _6fb=null;
if(_6fa!=0&&(!_6fa||_6fa==-1)){
return _6fb;
}
var ds=this.grid.getStore();
var _6fd=(this.dynamic)?ds.getAt(_6fa):ds.getById(_6fa);
_6fb=_6fd.get(_6f9);
return _6fb;
};
$G.Actions._cf_register=function(_6fe,_6ff,_700){
this.selectionChangeEvent.subscribe(_6ff,_700);
};
$G.rowSelect=function(_701,_702,row){
var _704="";
var _705=_701.selected.items;
if(_705.length==0){
return;
}
var _706=_705[0].get("CFGRIDROWINDEX")||row;
if(_706&&(_706+"").indexOf("cf_gridmodel")==0){
_706=row;
}
if(this.selectedRow!=_706){
this.selectedRow=_706;
var _707=true;
for(col in _705[0].data){
if(col=="CFGRIDROWINDEX"){
continue;
}
if(typeof col=="undefined"||col=="undefined"){
continue;
}
if(!_707){
_704+="; ";
}
_704+="__CFGRID__COLUMN__="+col+"; ";
_704+="__CFGRID__DATA__="+_705[0].data[col];
_707=false;
}
this.fireSelectionChangeEvent();
this.insertInProgress=false;
}
};
$G.beforeRowSelect=function(_708,row){
var ds=this.grid.getStore();
var _70b=ds.getAt(row);
return !$G.isNullRow(_70b.data);
};
$G.isNullRow=function(data){
var _70d=true;
for(col in data){
if(data[col]!=null){
_70d=false;
break;
}
}
return _70d;
};
$G.fireSelectionChangeEvent=function(){
$L.info("grid.fireselectionchangeevent.fire","widget",[this.id]);
this.selectionChangeEvent.fire();
};
$G.cellClick=function(grid,td,_710,_711,tr,_713,e,_715){
var _716=this.cellClickInfo.colInfo[_710];
if(_716){
var _717=grid.getSelectionModel().selected;
var url;
if(_717.items.length>0&&_717.items[0].data){
url=_717.items[0].data[_716.href.toUpperCase()];
}
if(!url){
url=_716.href;
}
var _719=_716.hrefKey;
var _71a=_716.target;
var _71b=this.appendKey;
if(this.cellClickInfo.appendKey){
var _71c;
if(_719||_719==0){
var _71d=grid.getStore().getAt(_713);
var _71e=grid.panel.columns[_719].dataIndex;
_71c=_71d.get(_71e);
}else{
var _71f=this.grid.columns;
_71c=_717.items[0].get(_71f[0].dataIndex);
for(var i=1;i<_71f.length-1;i++){
_71c+=","+_717.items[0].get(_71f[i].dataIndex);
}
}
if(url.indexOf("?")!=-1){
url+="&CFGRIDKEY="+_71c;
}else{
url+="?CFGRIDKEY="+_71c;
}
}
if(_71a){
_71a=_71a.toLowerCase();
if(_71a=="_top"){
_71a="top";
}else{
if(_71a=="_parent"){
_71a="parent";
}else{
if(_71a=="_self"){
_71a=window.name;
}else{
if(_71a=="_blank"){
window.open(encodeURI(url));
return;
}
}
}
}
if(!parent[_71a]){
ColdFusion.handleError(null,"grid.cellclick.targetnotfound","widget",[_71a]);
return;
}
parent[_71a].location=encodeURI(url);
}else{
window.location=encodeURI(url);
}
}
};
$G.insertRow=function(){
if(this.insertInProgress&&this.dynamic){
ColdFusion.handleError(null,"Multiple row insert is not supported","Grid",[this.gridId],null,null,true);
return;
}
var _721={action:"I",values:[]};
var _722=this.grid.columns;
var _723=this.grid.getStore();
var _724={};
var _725="{";
for(var i=0;i<_722.length-1;i++){
var _727="";
_721.values[i]=[_727,_727];
_724[_722[i].dataIndex]=_727;
_725=_725+"\""+_722[i].colName+"\":\""+_727+"\",";
}
_724["CFGRIDROWINDEX"]=_723.getCount()+1;
_725=_725+"\"CFGRIDROWINDEX\":\""+(_723.getCount()+1)+"\"}";
_723.add(JSON.parse(_725));
_723.getAt(_723.getCount()-1).data["CFGRIDROWINDEX"]=_723.getCount();
if(this.dynamic==true){
this.selectedRow=_723.getCount();
}
this.editFieldState.push(_721);
this.grid.getSelectionModel().select(_723.getCount()-1);
this.insertInProgress=true;
$G.Actions.computeEditField(this);
};
$G.saveNewRecord=function(){
if(!this.insertInProgress){
return;
}
var _728=this.selectedRow;
var _729=this.insertEvent;
if(_728==-1){
return;
}
if(this.onChangeFunction){
this.onChangeHandler("I",_728-1,_729,$G.insertRowCallback);
}else{
if(this.dynamic==false){
var _72a=this.grid.getStore();
var _72b=_729.record;
var _72c=new Array(1);
_72c[0]=_72b;
var _72d=_72a.getAt(this.selectedRow-1);
_72a.remove(_72d);
_72a.add(_72c);
}
}
this.insertInProgress=false;
this.insertEvent=null;
};
$G.cancelNewRecord=function(){
if(!this.insertInProgress){
return;
}
this.editFieldState.pop();
var _72e=this.grid.getStore();
var _72f=_72e.getAt(this.selectedRow-1);
_72e.remove(_72f);
this.insertInProgress=false;
this.insertEvent=null;
this.selectedRow=this.selectedrow-1;
};
$G.deleteRow=function(){
var _730=null;
var _731;
if(this.multiRowSelection===true){
var _732=this.grid.getSelectionModel();
_730=_732.selected;
}
_730=this.grid.getSelectionModel().getSelection();
if(_730!=null&&_730.length<2){
_730=null;
}
if(_730==null){
_731=this.selectedRow;
}
if(_731==-1&&_730==null){
return;
}
if(this.onChangeFunction){
if(_730!=null){
this.onChangeHandler_MultiRowsDelete("D",_730,null,$G.deleteRowCallback);
}else{
this.onChangeHandler("D",_731,null,$G.deleteRowCallback);
}
}else{
if(!this.dynamic){
var _733=this.grid.getStore();
if(_730!=null){
for(i=0;i<_730.length;i++){
var _734=_733.indexOf(_730[i]);
var _735=this.editFieldState[_734];
if(_735){
_735.action="D";
}else{
_735=$G.Actions.initEditState(this,"D",_730[i],_734+1);
}
}
for(i=0;i<_730.length;i++){
_733.remove(_730[i]);
}
}else{
var _735=this.editFieldState[_731-1];
if(_735){
_735.action="D";
}else{
var _736=this.grid.getStore().getById(_731);
_735=$G.Actions.initEditState(this,"D",_736,_731);
}
_733.remove(this.grid.getSelectionModel().getSelection());
}
$G.Actions.computeEditField(this);
this.grid.editingPlugin.completeEdit();
this.selectedRow=-1;
}
}
};
$G.deleteRowCallback=function(_737,_738){
var _739=_738._cf_grid.getStore();
var _73a=_738._cf_grid_properties;
var _738=_739.lastOptions;
var key="start";
if(_739.getCount()==1){
if(_738.start>=_738.limit){
_738.start=_738.start-_738.limit;
}
_738.page=_738.page-1;
_739.reload(_738);
}else{
_739.reload();
}
if(_73a.multiRowSelection){
var _73c=_73a.grid.getView().headerCt(0);
if(_73c!=null){
var _73d=Ext.Element.get(_73c).first();
if(_73d){
_73d.replaceClass("x-grid3-hd-checker-on");
}
}
}
};
$G.insertRowCallback=function(_73e,_73f){
var _740=_73f._cf_grid.getStore();
var _741=_73f._cf_grid.actions;
_740.reload();
};
$G.Actions.beforeEdit=function(_742,e,_744){
if($G.isNullRow(e.record.data)){
return false;
}
this.editColumn=e.column;
this.editOldValue=e.value;
};
$G.Actions.afterEdit=function(_745,_746,_747){
var _748=_746.value;
if(_748==this.editOldValue){
return;
}
if(this.insertInProgress==false&&this.onChangeFunction){
this.onChangeHandler("U",this.selectedRow,_746);
}else{
if(!this.dynamic){
rowidx=_746.rowIdx;
if(!rowidx&&rowidx!=0){
rowidx=_746.row;
}
var _749=$G.computeActualRow_editField(this.editFieldState,_746.record.data.CFGRIDROWINDEX);
var _74a=this.editFieldState[_749-1];
var _74b=_746.colIdx;
if(!_74b&&_74b!=0){
_74b=_746.column;
}
var cols=_745.grid.columns;
var _74d=_746.field;
for(i=0;i<cols.length;i++){
var col=cols[i];
if(_74d==col.colName){
_74b=i;
}
}
if(_74a){
if(this.multiRowSelection===true&&this.insertInProgress==true){
_74b=_74b-1;
}
_74a.values[_74b][1]=_748;
}else{
var _74f=this.grid.getStore().getById(_746.record.data.CFGRIDROWINDEX);
_74a=$G.Actions.initEditState(this,"U",_74f,_749);
var _750=this.editOldValue+"";
if(_746.column.type=="date"){
if(_750&&typeof _750=="string"){
_750=new Date(_750);
}
var _751="F, j Y H:i:s";
if(_746.column&&_746.column.format){
_751=_746.column.format;
}
_74a.values[_74b][1]=Ext.Date.format(_748,_751);
_74a.values[_74b][0]=_750?Ext.Date.format(_750,_751):_750;
}else{
_74a.values[_74b][0]=_750;
_74a.values[_74b][1]=_748;
}
}
$G.Actions.computeEditField(this);
}
}
this.editOldValue=null;
this.fireSelectionChangeEvent();
};
$G.computeActualRow_editField=function(_752,_753){
if(_752.length==_753){
return _753;
}
var _754=0;
var _755=0;
for(;_755<_752.length&&_754<_753;_755++){
var _756=_752[_755];
if(!_756||_756.action!="D"){
_754++;
}
}
return _755;
};
$G.Actions.onChangeHandler=function(_757,_758,_759,_75a){
var _75b={};
var _75c={};
var data="";
if(null==_759){
data=this.grid.getStore().getAt(_758).data;
}else{
data=_759?_759.record.data:this.grid.getStore().getAt(_758).data;
}
for(col in data){
_75b[col]=data[col];
}
if(_757=="U"){
if((_759.value==null||_759.value=="")&&(_759.originalValue==null||_759.originalValue=="")){
return;
}
if(_759.value&&_759.column.type=="date"){
if(typeof _759.originalValue=="string"){
var _75e=new Date(_759.originalValue);
}
if(_75e!=null&&_75e.getElapsed(_759.value)==0){
return;
}else{
_75b[_759.field]=_759.originalValue;
var _75f="F, j Y H:i:s";
if(_759.column.format){
_75f=_759.column.format;
}
_75c[_759.field]=Ext.Date.format(_759.value,_75f);
}
}else{
_75b[_759.field]=_759.originalValue;
_75c[_759.field]=_759.value;
}
}
this.onChangeFunction(_757,_75b,_75c,_75a,this.grid,this.onErrorFunction,this);
};
$G.Actions.onChangeHandler_MultiRowsDelete=function(_760,_761,_762,_763){
var _764=new Array();
var _765={};
for(i=0;i<_761.length;i++){
_764[i]=_761.items[i].data;
}
this.onChangeFunction(_760,_764,_765,_763,this.grid,this.onErrorFunction,this);
};
$G.Actions.initEditState=function(_766,_767,_768,_769){
var _76a={action:_767,values:[]};
var _76b=_766.grid.columns;
var _76c=_76b.length-1;
_76a.values.length=_76c;
var i=0;
if(_766.multiRowSelection===true&&_766.dynamic===false){
i=i++;
}
for(i;i<_76c;i++){
var _76e=_768.get(_76b[i].colName);
_76a.values[i]=[_76e,_76e];
}
_766.editFieldState[_769-1]=_76a;
return _76a;
};
$G.Actions.fieldSep=eval("'\\u0001'");
$G.Actions.valueSep=eval("'\\u0002'");
$G.Actions.nullValue=eval("'\\u0003'");
$G.Actions.computeEditField=function(_76f){
if(_76f.dynamic){
return;
}
var _770=_76f.editFieldPrefix;
var _771=_76f.editFieldState;
var _772=_76f.grid.columns;
var _773=0;
var _774="";
for(var i=0;i<_771.length;i++){
var _776=_771[i];
if(_776){
_773++;
_774+=$G.Actions.fieldSep;
_774+=_776.action+$G.Actions.valueSep;
var _777=_776.values;
if(_76f.multiRowSelection===true&&_76f.dynamic===false&&_776.action!="I"){
_777=_777.slice(1,_777.length);
}
for(var j=0;j<_777.length;j++){
if(j>0){
_774+=$G.Actions.valueSep;
}
var _779=($G.Actions.isNull(_777[j][0]))?$G.Actions.nullValue:_777[j][0];
var _77a=($G.Actions.isNull(_777[j][1]))?$G.Actions.nullValue:_777[j][1];
var _77b=j;
if(_76f.multiRowSelection===true){
_77b++;
}
if(_772[_77b].getEditor()&&_77a==$G.Actions.nullValue&&_772[_77b].getEditor().xtype=="checkbox"){
_77a="0";
}
if(_776.action!="I"||(_776.action=="I"&&_772[_77b].getEditor())){
_774+=_77a;
if(_776.action=="U"&&_772[_77b].getEditor()){
_774+=$G.Actions.valueSep+_779;
}
}
}
}
}
_770+=_773+_774;
_76f.editField.setAttribute("value",_770);
};
$G.Actions.isNull=function(val){
var ret=(val==null||typeof (val)=="undefined"||val.length==0);
return ret;
};
$G.loadData=function(data,_77f){
_77f._cf_gridDataProxy.loadResponse(data,_77f);
var _780=ColdFusion.objectCache[_77f._cf_gridname];
$G.applyStyles(_780);
$L.info("grid.loaddata.loaded","widget",[_77f._cf_gridname]);
if($G.Actions.isNull(data.TOTALROWCOUNT)==false&&data.TOTALROWCOUNT==0){
_780.fireSelectionChangeEvent();
}
};
$G.printObject=function(obj){
var str="";
for(key in obj){
str=str+"  "+key+"=";
value=obj[key];
str+=value;
}
return str;
};
$G.formatBoolean=function(v,p,_785){
return "<div class=\"x-grid3-check-col"+(v?"-on":"")+" x-grid3-cc-"+this.id+"\">&#160;</div>";
};
$G.formatDate=function(_786,p,_788){
if(_786&&!_786.dateFormat){
_786=new Date(_786);
}
var _789=this.dateFormat?this.dateFormat:"m/d/y";
return _786?Ext.Date.dateFormat(_786,_789):"";
};
$G.convertDate=function(_78a,p,_78c){
if(_78a&&!_78a.dateFormat){
_78a=new Date(_78a);
}
var _78d=this.dateFormat?this.dateFormat:"m/d/y";
return _78a;
};
$G.ExtProxy=function(_78e,_78f){
this.api={load:true,create:undefined,save:undefined,destroy:undefined};
$G.ExtProxy.superclass.constructor.call(this);
this.bindHandler=_78e;
this.errorHandler=_78f;
};
Ext.extend($G.ExtProxy,Ext.data.DataProxy,{_cf_firstLoad:true,load:function(_790,_791,_792,_793,arg){
if(!this._cf_actions.bindOnLoad){
var _795={"_cf_reader":_791,"_cf_grid_errorhandler":this.errorHandler,"_cf_scope":_793,"_cf_gridDataProxy":this,"_cf_gridname":this._cf_gridName,"_cf_arg":arg,"_cf_callback":_792,"ignoreData":true};
var data=[];
for(i=0;i<_790.limit;i++){
data.push(new Ext.data.Record({}));
}
this.loadResponse(data,_795);
this._cf_actions.bindOnLoad=true;
}else{
var _797=(_790.start/_790.limit)+1;
if(!_790.sort){
_790.sort="";
}
if(!_790.dir){
_790.dir="";
}
this.bindHandler(this,_797,_790.limit,_790.sort,_790.dir,this.errorHandler,_792,_793,arg,_791);
}
},loadResponse:function(data,_799){
var _79a=null;
if(_799.ignoreData){
_79a={success:true,records:data,totalRecords:data.length};
}else{
var _79b;
if(!data){
_79b="grid.extproxy.loadresponse.emptyresponse";
}else{
if(!data.TOTALROWCOUNT&&data.TOTALROWCOUNT!=0){
_79b="grid.extproxy.loadresponse.totalrowcountmissing";
}else{
if(!ColdFusion.Util.isInteger(data.TOTALROWCOUNT)){
_79b="grid.extproxy.loadresponse.totalrowcountinvalid";
}else{
if(!data.QUERY){
_79b="grid.extproxy.loadresponse.querymissing";
}else{
if(!data.QUERY.COLUMNS||!ColdFusion.Util.isArray(data.QUERY.COLUMNS)||!data.QUERY.DATA||!ColdFusion.Util.isArray(data.QUERY.DATA)||(data.QUERY.DATA.length>0&&!ColdFusion.Util.isArray(data.QUERY.DATA[0]))){
_79b="grid.extproxy.loadresponse.queryinvalid";
}
}
}
}
}
if(_79b){
ColdFusion.handleError(_799._cf_grid_errorHandler,_79b,"widget");
this.fireEvent("loadexception",this,_799,data,e);
return;
}
_79a=_799._cf_reader.readRecords(data);
}
this.fireEvent("load",this,_799,_799._cf_arg);
_799._cf_callback.call(_799._cf_scope,_79a,_799._cf_arg,true);
},update:function(_79c){
},updateResponse:function(_79d){
}});
$G.ExtReader=function(_79e){
this.recordType=Ext.data.Record.create(_79e);
};
Ext.extend($G.ExtReader,Ext.data.DataReader,{readRecords:function(_79f){
var _7a0=[];
var cols=_79f.QUERY.COLUMNS;
var data=_79f.QUERY.DATA;
for(var i=0;i<data.length;i++){
var _7a4={};
for(var j=0;j<cols.length;j++){
_7a4[cols[j]]=data[i][j];
}
_7a0.push(new Ext.data.Record(_7a4));
}
return {success:true,records:_7a0,totalRecords:_79f.TOTALROWCOUNT};
}});
$G.CheckColumn=function(_7a6){
Ext.apply(this,_7a6);
if(!this.id){
this.id=Ext.id();
}
this.renderer=this.renderer.bind(this);
};
$G.findColumnIndex=function(grid,_7a8){
var _7a9=grid.headerCt.getGridColumns();
for(var i=0;i<_7a9.length;i++){
if(_7a9[i].dataIndex==_7a8){
return i;
}
}
};
$G.CheckColumn.prototype={init:function(grid){
this.grid=grid;
this.count=0;
this.columnIndex=$G.findColumnIndex(this.grid,this.dataIndex);
this.grid.on("render",function(){
var view=this.grid.getView();
if(this.editable==true){
this.grid.addListener("itemmousedown",this.onMouseDown,this);
}
},this);
},onMouseDown:function(thi,_7ae,item,_7b0,e,_7b2){
var t=e.target;
if(t.className&&t.className.indexOf("x-grid-cc-"+this.id)!=-1){
e.stopEvent();
var _7b4=ColdFusion.clone(_7ae);
_7b4.data=ColdFusion.clone(_7ae.data);
this.grid.getSelectionModel().select(_7b0);
this.grid.getSelectionModel().fireEvent("rowselect",this.grid.getSelectionModel(),_7b0);
this.grid.fireEvent("beforeedit",this,{grid:this.grid,row:_7b0,record:_7ae,column:this.columnIndex,field:this.dataIndex,value:_7ae.data[this.dataIndex]});
_7ae.set(this.dataIndex,this.toggleBooleanValue(_7ae.data[this.dataIndex]));
this.grid.fireEvent("edit",this,{grid:this.grid,row:_7b0,record:_7b4,column:this.columnIndex,field:this.dataIndex,value:_7ae.data[this.dataIndex],originalValue:_7b4.data[this.dataIndex]});
}
},toggleBooleanValue:function(v){
v=typeof v=="undefined"?"N":(typeof v=="string"?v.toUpperCase():v);
if(v==="Y"){
return "N";
}
if(v==="N"){
return "Y";
}
if(v===true){
return false;
}
if(v===false){
return true;
}
if(v===0){
return 1;
}
if(v===1){
return 0;
}
if(v==="YES"){
return "NO";
}
if(v==="NO"){
return "YES";
}
if(v==="T"){
return "F";
}
if(v==="F"){
return "T";
}
return "Y";
},renderer:function(v,p,_7b8){
p.css+=" x-grid-check-col-td";
var _7b9=false;
v=(typeof v=="string")?v.toUpperCase():v;
if(typeof v!="undefined"&&(v==1||v=="1"||v=="Y"||v=="YES"||v=="TRUE"||v===true||v==="T")){
_7b9=true;
}
return "<div style=\"background-repeat: no-repeat;background-position:center center;width:auto\" class=\"x-grid-cell-checker"+(_7b9!=true?"-off":"")+" x-grid-cc-"+this.id+"\">&#160;</div>";
}};
$G.convertBoolean=function(v,_7bb){
v=typeof v=="undefined"?"N":(typeof v=="string"?v.toUpperCase():v);
if(v==="Y"){
return "YES";
}
if(v==="N"){
return "NO";
}
if(v===true){
return "YES";
}
if(v===false){
return "NO";
}
if(v===0){
return "NO";
}
if(v===1){
return "YES";
}
if(v==="YES"){
return "YES";
}
if(v==="NO"){
return "NO";
}
if(v==="T"){
return "YES";
}
if(v==="F"){
return "NO";
}
if(v==="FALSE"){
return "NO";
}
if(v==""){
return "NO";
}
if(v.toUpperCase()=="NULL"){
return "NO";
}
return "YES";
};
Ext.define("MyReader",{extend:"Ext.data.reader.Json",alias:"reader.my-json",read:function(_7bc){
var _7bd;
if(_7bc.request){
_7bd=_7bc.request.proxy;
}
var _7be=_7bc.responseText;
if(!_7be){
_7be=_7bc.responseJson;
}
if(!_7be){
_7be=_7bc;
}
var _7bf="";
if(_7bd&&!_7bd._cf_actions.bindOnLoad){
_7bf="{  totalrows:0, data :[] }";
_7bd._cf_actions.bindOnLoad=true;
}else{
_7bf=$G.queryToJson(_7be);
}
if(_7bd){
$G.applyStyles(_7bd._cf_actions);
}
Ext.USE_NATIVE_JSON=false;
return this.callParent([Ext.decode(_7bf)]);
}});
Ext.define("customcfajax",{extend:"Ext.data.proxy.Ajax",alias:"proxy.customcfajax",getParams:function(_7c0){
params=this.callParent(arguments);
if(!(this.sortParam&&_7c0.config.sorters&&_7c0.config.sorters.length>0)){
params[this.sortParam]="";
params[this.directionParam]="ASC";
}
return params;
}});
Ext.define("Ext.data.proxy.JsProxy",{requires:["Ext.util.MixedCollection","Ext.Ajax"],extend:"Ext.data.proxy.Server",alias:"proxy.jsajax",alternateClassName:["Ext.data.HttpProxy","Ext.data.JsProxy"],actionMethods:{create:"POST",read:"GET",update:"POST",destroy:"POST"},binary:false,jsfunction:"",extraparams:[],getParams:function(_7c1){
params=this.callParent(arguments);
if(_7c1.config&&_7c1.config.sorters){
_7c1.sorters=_7c1.config.sorters;
}
if(!(this.sortParam&&_7c1.sorters&&_7c1.sorters.length>0)){
params[this.sortParam]="";
params[this.directionParam]="ASC";
}
return params;
},processResponse:function(_7c2,_7c3,_7c4,_7c5){
var me=this,exception,reader,resultSet,meta,destroyOp;
if(me.destroying||me.destroyed){
return;
}
me.fireEvent("beginprocessresponse",me,_7c5,_7c3);
if(_7c2===true){
reader=me.getReader();
if(_7c5.status===204){
resultSet=reader.getNullResultSet();
}else{
resultSet=reader.read(me.extractResponseData(_7c5),{recordCreator:_7c3.getRecordCreator()||reader.defaultRecordCreatorFromServer});
}
if(!_7c3.$destroyOwner){
_7c3.$destroyOwner=me;
destroyOp=true;
}
_7c3.process(resultSet,_7c4,_7c5);
exception=!_7c3.wasSuccessful();
}else{
me.setException(_7c3,_7c5);
exception=true;
}
if(me.destroyed){
if(!_7c3.destroyed&&destroyOp&&_7c3.$destroyOwner===me){
_7c3.destroy();
}
return;
}
if(exception){
me.fireEvent("exception",me,_7c5,_7c3);
}else{
meta=resultSet.getMetadata();
if(meta){
me.onMetaChange(meta);
}
}
if(me.destroyed){
if(!_7c3.destroyed&&destroyOp&&_7c3.$destroyOwner===me){
_7c3.destroy();
}
return;
}
me.fireEvent("endprocessresponse",me,_7c5,_7c3);
if(!_7c3.destroyed&&destroyOp&&_7c3.$destroyOwner===me){
_7c3.destroy();
}
},doRequest:function(_7c7,_7c8,_7c9){
var me=this;
op=_7c7;
if(!op.page){
op.page=op._page;
}
sorters=_7c7.sorters;
sortcol="";
sortdir="ASC";
if(sorters&&sorters.length>0){
sortcol=sorters[0].property;
sortdir=sorters[0].direction;
}
if(this._cf_actions.bindOnLoad){
result=eval(this.jsfunction);
}else{
var _7cb=[];
for(i=0;i<this._cf_actions.grid.columns.length;i++){
var _7cc=this._cf_actions.grid.columns[i];
_7cb[i]=_7cc.colName;
}
result="{  totalrows:0, QUERY : { COLUMNS : "+_7cb+" data :[] }}";
}
me.processResponse(true,_7c7,"",result,_7c8,_7c9);
return null;
},getMethod:function(_7cd){
return this.actionMethods[_7cd.action];
},createRequestCallback:function(_7ce,_7cf,_7d0,_7d1){
var me=this;
return function(_7d3,_7d4,_7d5){
me.processResponse(_7d4,_7cf,_7ce,_7d5,_7d0,_7d1);
};
}},function(){
Ext.data.HttpProxy=this;
});
$G.queryToJson=function(data){
var _7d7=[];
jsondata=ColdFusion.AjaxProxy.JSON.decode(data);
var cols=jsondata.QUERY.COLUMNS;
var data=jsondata.QUERY.DATA;
var _7d9="{  totalrows:"+jsondata.TOTALROWCOUNT+", data :[";
for(var i=0;i<data.length;i++){
var _7db={};
_7d9=_7d9+"{";
for(var j=0;j<cols.length;j++){
if(data[i][j]==null){
data[i][j]="";
}
_7db[cols[j]]=data[i][j];
encodedata=ColdFusion.AjaxProxy.JSON.encode(data[i][j]);
_7d9=_7d9+cols[j]+":"+encodedata;
if(j!=cols.length-1){
_7d9=_7d9+",";
}
}
_7d9=_7d9+"}";
if(i!=data.length-1){
_7d9=_7d9+",";
}
}
_7d9=_7d9+"]}";
return _7d9;
};
$G.queryToArray=function(data){
var _7de=[];
jsondata=ColdFusion.AjaxProxy.JSON.decode(data);
var cols=jsondata.QUERY.COLUMNS;
var data=jsondata.QUERY.DATA;
var _7e0=new Array();
for(var i=0;i<data.length;i++){
var _7e2=new Array(1);
for(var j=0;j<cols.length;j++){
_7e2[j]=data[i][j];
}
_7e0[i]=_7e2;
}
return _7e0;
};
};
cfinitgrid();
