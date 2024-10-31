/*ADOBE SYSTEMS INCORPORATED
Copyright 2012 Adobe Systems Incorporated
All Rights Reserved.

NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
terms of the Adobe license agreement accompanying it.  If you have received this file from a
source other than Adobe, then your use, modification, or distribution of it requires the prior
written permission of Adobe.*/
if(!ColdFusion.Menu){
ColdFusion.Menu={};
}
ColdFusion.Menu.menuItemMouseOver=function(id,_55c){
var _55d=document.getElementById(id);
_55d.tempfontcolor=_55d.firstChild.style.color;
if(_55c){
_55d.firstChild.style.color=_55c;
}
};
ColdFusion.Menu.menuItemMouseOut=function(id){
var _55f=document.getElementById(id);
if(_55f.tempfontcolor){
_55f.firstChild.style.color=_55f.tempfontcolor;
}else{
_55f.firstChild.style.color="black";
}
};
ColdFusion.Menu.initMenu=function(_560,_561){
return new YAHOO.widget.Menu(_560,_561);
};
ColdFusion.Menu.initMenuBar=function(_562,_563){
return new YAHOO.widget.MenuBar(_562,_563);
};
