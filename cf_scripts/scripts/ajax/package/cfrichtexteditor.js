/*ADOBE SYSTEMS INCORPORATED
Copyright 2012 Adobe Systems Incorporated
All Rights Reserved.

NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
terms of the Adobe license agreement accompanying it.  If you have received this file from a
source other than Adobe, then your use, modification, or distribution of it requires the prior
written permission of Adobe.*/
ColdFusion.RichText||(ColdFusion.RichText={});
ColdFusion.RichText.editorState={};
ColdFusion.RichText.buffer=null;
ColdFusion.RichText.registerAfterSet=function(_59b){
if(ColdFusion.RichText.editorState[_59b]){
var _59c=function(){
ColdFusion.RichText.fireChangeEvent(_59b);
};
var _59d=CKEDITOR.instances[_59b];
_59d.on("OnAfterSetHTML",_59c);
}else{
setTimeout(function(){
ColdFusion.RichText.registerAfterSet(_59b);
},1000);
}
};
ColdFusion.RichText.getEditorObject=function(_59e){
if(!_59e){
ColdFusion.handleError(null,"richtext.geteditorobject.missingtextareaname","widget",null,null,null,true);
return;
}
var _59f=ColdFusion.objectCache[_59e];
if(_59f==null||CKEDITOR.editor.prototype.isPrototypeOf(_59f)==false){
ColdFusion.handleError(null,"richtext.geteditorobject.notfound","widget",[_59e],null,null,true);
return;
}
return CKEDITOR.instances[_59f.richtextid];
};
ColdFusion.RichText.setValue=function(_5a0,_5a1){
if(ColdFusion.RichText.editorState[_5a0]){
var _5a2=CKEDITOR.instances[_5a0];
_5a2.setData(_5a1);
_5a2.fire("onAfterSetHTML");
}else{
setTimeout(function(){
ColdFusion.RichText.setValue(_5a0,_5a1);
},1000);
}
};
ColdFusion.RichText.getValue=function(_5a3){
if(ColdFusion.RichText.editorState[_5a3]){
return CKEDITOR.instances[_5a3].getData();
}else{
ColdFusion.Log.error("richtext.initialize.getvalue.notready","widget",[_5a3]);
return null;
}
};
ColdFusion.RichText.fireChangeEvent=function(_5a4){
var _5a5=ColdFusion.objectCache[_5a4];
ColdFusion.Log.info("richtext.firechangeevent.firechange","widget",[_5a5._cf_name]);
var _5a6=document.getElementById(_5a4);
if(_5a6){
if(_5a6.fireEvent){
_5a6.fireEvent("onchange");
}
if(document.createEvent){
var evt=document.createEvent("HTMLEvents");
if(evt.initEvent){
evt.initEvent("change",true,true);
}
if(_5a6.dispatchEvent){
_5a6.dispatchEvent(evt);
}
}
}
ColdFusion.Event.callBindHandlers(_5a4,null,"change");
};
ColdFusion.RichText.editor_onfocus=function(e){
document.getElementById(e.editor.id+"_top").style.display="block";
};
ColdFusion.RichText.editor_onblur=function(e){
document.getElementById(e.editor.id+"_top").style.display="none";
};
ColdFusion.RichText.setChangeBuffer=function(e){
ColdFusion.RichText.buffer=CKEDITOR.instances[e.editor.name].getData();
};
ColdFusion.RichText.resetChangeBuffer=function(e){
if(ColdFusion.RichText.buffer!=CKEDITOR.instances[e.editor.name].getData()){
ColdFusion.RichText.fireChangeEvent(e.editor.name);
}
ColdFusion.RichText.buffer=null;
};
var parameters={};
CKEDITOR.on("instanceCreated",function(e){
var _5ad=e.editor.name;
if(parameters[_5ad].Id){
ColdFusion.RichText.editorState[parameters[_5ad].Id]=false;
e.editor.richtextid=parameters[_5ad].Id;
ColdFusion.objectCache[parameters[_5ad].Id]=e.editor;
}
if(parameters[_5ad].Name){
e.editor._cf_name=parameters[_5ad].Name;
ColdFusion.objectCache[parameters[_5ad].Name]=e.editor;
}
if(parameters[_5ad].Val){
e.editor.Value=parameters[_5ad].Val;
}
e.editor._cf_setValue=function(_5ae){
ColdFusion.RichText.setValue(_5ad,_5ae);
};
e.editor._cf_getAttribute=function(){
return ColdFusion.RichText.getValue(_5ad);
};
e.editor._cf_register=function(_5af,_5b0,_5b1){
var _5b2=document.getElementById(_5ad);
if(_5b2){
ColdFusion.Event.addListener(_5b2,_5af,_5b0,_5b1);
}
};
});
ColdFusion.RichText.initialize=function(Id,Name,Val,_5b6,_5b7,_5b8,_5b9,_5ba,_5bb,Skin,_5bd,_5be,_5bf,_5c0,_5c1){
parameters[Id]={};
parameters[Id].Id=Id;
parameters[Id].Name=Name;
parameters[Id].Val=Val;
var _5c2=function(evt){
if(_5bd==true){
evt.editor.on("focus",ColdFusion.RichText.editor_onfocus);
evt.editor.on("blur",ColdFusion.RichText.editor_onblur);
document.getElementById(evt.editor.id+"_top").style.display="none";
}
evt.editor.on("focus",ColdFusion.RichText.setChangeBuffer);
evt.editor.on("blur",ColdFusion.RichText.resetChangeBuffer);
ColdFusion.RichText.editorState[evt.editor.name]=true;
if(ColdFusion.RichText.OnComplete){
ColdFusion.RichText.OnComplete(evt.editor);
}
};
var _5c4={on:{"instanceReady":_5c2}};
_5c4["toolbar"]="Default";
if(_5b8!=null){
_5c4["height"]=_5b8;
}
if(_5b7!=null){
_5c4["width"]=_5b7;
}
if(_5b9!=null){
_5c4["font_names"]=_5b9;
}
if(_5ba!=null){
_5c4["fontSize_sizes"]=_5ba;
}
if(_5bb!=null){
_5c4["format_tags"]=_5bb;
}
if(Skin!=null){
_5c4["skin"]=Skin;
}
if(_5bd==true){
_5c4["toolbarCanCollapse"]=false;
}
if(_5be!=null){
_5c4["toolbar"]=_5be;
}
var _5c5=CKEDITOR.replace(Id,_5c4);
};
