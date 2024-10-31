/*ADOBE SYSTEMS INCORPORATED
Copyright 2012 Adobe Systems Incorporated
All Rights Reserved.

NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
terms of the Adobe license agreement accompanying it.  If you have received this file from a
source other than Adobe, then your use, modification, or distribution of it requires the prior
written permission of Adobe.*/
var KT_focusedEl=null;
KT_validateSingle=function(_97a,_97b){
var _97c=_97a.charCodeAt(0);
switch(_97b){
case "9":
if(_97c<58&&_97c>47){
return true;
}
break;
case "A":
if((_97c<91&&_97c>64)||(_97c<123&&_97c>96)){
return true;
}
break;
case "X":
if((_97c<91&&_97c>64)||(_97c<123&&_97c>96)||(_97c<58&&_97c>47)){
return true;
}
break;
case "?":
return true;
break;
default:
return true;
break;
}
};
KT_maskDefaultValue=function(_97d){
switch(_97d){
case "9":
return "0";
break;
case "A":
return "a";
break;
case "X":
return "0";
break;
case "?":
return "0";
break;
default:
return "0";
break;
}
};
KT_isSpecialChar=function(_97e){
if(_97e=="9"||_97e=="A"||_97e=="X"||_97e=="?"){
return true;
}else{
return false;
}
};
mask_onValueChanged=function(){
if((typeof window.getSelection=="undefined"&&typeof document.selection=="undefined")){
return;
}
if(KT_focusedEl==null||KT_focusedEl.mask==null||KT_focusedEl.mask==""){
return;
}
var mask=KT_focusedEl.mask;
var val=KT_focusedEl.value;
var i=0;
var _982=false;
if(val==KT_focusedEl.oldText){
return;
}
if(val.length>mask.length){
val=val.substr(0,mask.length);
_982=true;
}
for(;i<mask.length;i++){
if(val.charCodeAt(i).toString()!="NaN"){
if(KT_isSpecialChar(mask.charAt(i))){
if(KT_validateSingle(val.charAt(i),mask.charAt(i))){
continue;
}else{
val=KT_focusedEl.oldText;
i=mask.length;
break;
}
}else{
if(val.charAt(i)!=mask.charAt(i)){
if(i==val.length-1){
var _983=val.substr(val.length-1,val.length);
val=val.substr(0,val.length-1)+mask.charAt(i)+_983;
_982=true;
continue;
}else{
val=KT_focusedEl.oldText;
i=mask.length;
}
break;
}
}
}else{
if(val.length<KT_focusedEl.oldText.length){
break;
}
for(;i<mask.length;i++){
if(!KT_isSpecialChar(mask.charAt(i))){
val+=mask.charAt(i);
_982=true;
}else{
break;
}
}
break;
}
}
if(val.length>mask.length){
val=val.substr(0,mask.length);
_982=true;
}
if(KT_focusedEl.value!=val){
KT_focusedEl.value=val;
}
KT_focusedEl.oldText=val;
if(_982){
}
};
mask_parseFirstTime=function(_984,mask){
var _986="";
var _987="";
cond=1;
imask=0;
ival=0;
cnt=0;
while(cond==1){
cond=1;
if(!KT_isSpecialChar(mask.charAt(imask))){
if(_984.charCodeAt(ival).toString()!="NaN"){
if(mask.charAt(imask)==_984.charAt(ival)){
imask++;
ival++;
}else{
_984=_984.substr(0,ival)+mask.charAt(imask)+_984.substr(ival,_984.length);
imask=0;
ival=0;
cond=1;
}
}else{
_984+=KT_maskDefaultValue(mask.charAt(imask));
}
}else{
imask++;
ival++;
}
if(imask>=mask.length||ival>=_984.length){
cond=0;
}
}
for(i=0;i<mask.length;i++){
if(KT_isSpecialChar(mask.charAt(i))){
_986+=mask.charAt(i);
if(_984.charCodeAt(i).toString()!="NaN"){
_987+=_984.charAt(i);
}else{
_987+=KT_maskDefaultValue(mask.charAt(i));
}
}
}
oldvalue=_984;
_984=_987;
var _988="";
for(i=0;i<_986.length;i++){
if(!KT_validateSingle(_984.charAt(i),_986.charAt(i))){
_988+=KT_maskDefaultValue(_986.charAt(i));
}else{
_988+=_984.charAt(i);
}
}
var _989="";
var j=0;
for(i=0;i<mask.length;i++){
if(KT_isSpecialChar(mask.charAt(i))){
_989+=_988.charAt(j++);
}else{
_989+=mask.charAt(i);
}
}
return _989;
};
mask_onSetFocus=function(obj,mask){
if((typeof window.getSelection=="undefined"&&typeof document.selection=="undefined")){
return;
}
if(typeof obj.mask=="undefined"){
ret="";
if(obj.value!=""){
ret=mask_parseFirstTime(obj.value,mask);
}
obj.value=ret;
obj.mask=mask;
}
KT_focusedEl=obj;
if(typeof KT_focusedEl.oldText=="undefined"){
KT_focusedEl.oldText=obj.value;
mask_onValueChanged();
}
};
mask_onKillFocus=function(){
if((typeof window.getSelection=="undefined"&&typeof document.selection=="undefined")){
return;
}
mask_onValueChanged();
KT_focusedEl=null;
};
