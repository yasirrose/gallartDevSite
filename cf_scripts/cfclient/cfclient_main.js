/**
 * @author Ram Kulkarni 
 */
//MozDev: "Any copyright is dedicated to the Public Domain."
if (!Array.prototype.indexOf) {
    Array.prototype.indexOf = function (searchElement /*, fromIndex */ ) {
        "use strict";
        if (this === null) {
            throw new TypeError();
        }
        var t = Object(this);
        var len = t.length >>> 0;
        if (len === 0) {
            return -1;
        }
        var n = 0;
        if (arguments.length > 1) {
            n = Number(arguments[1]);
            if (n != n) { // shortcut for verifying if it's NaN
                n = 0;
            } else if (n !== 0 && n != Infinity && n != -Infinity) {
                n = (n > 0 || -1) * Math.floor(Math.abs(n));
            }
        }
        if (n >= len) {
            return -1;
        }
        var k = n >= 0 ? n : Math.max(len - Math.abs(n), 0);
        for (; k < len; k++) {
            if (k in t && t[k] === searchElement) {
                return k;
            }
        }
        return -1;
    };
}

__builtInFunctions = ["setTimeout", "eval"];


(function(){

    var _cfclient = function(){
        var self = this;
        this.initialized = false;
		this.callbackFunction = [];
		this.loadAPI = false;
		this.loadDeviceDetection = false;
        this.loadServerPlugin = false;
        this.cfClientReady = false;
        this.localStorageSupported = window.localStorage ? true : false;
        this.enableDebugLog = false;
        
		this.server_int_plugin_path = "ajax/package/cfajax.js";
		this.msg_int_plugin_path = "ajax/messages/cfmessage.js";
        this.server_int_plugin_loaded = false;
		
		this.dd_plugin_path = "cf_scripts/cfclient/cfclient_dd_plugin.js";
        this.dd_plugin_loaded = false;
        this.mobile_api_plugin_path = "cf_scripts/cfclient/cfclient_pg_plugin.js";
        this.mobile_api_plugin_loaded = false;

		this.customTags = [];
        this.saveContentStack = [];
		
		this.device = null; //this will be set to cfclient_mobile_api_plugin object once phone api plugin is loaded.
		
        this.init = function(flags, callback){
            if(!window.cfclientPath) {
            	if (window.ispgbuild)
            		window.cfclientPath = "";
            	else
	                window.cfclientPath = "/";
            }
            self.loadAPI = flags.loadAPIPlugin;
            self.loadDeviceDetection = flags.loadDeviceDetectionPlugin;
            self.loadServerPlugin = flags.loadServerPlugin;
            self.enableDebugLog = flags.enableDebugLog;
            if(typeof _cfAjaxPathInit == "undefined")
            {
	            if(flags.ajaxScriptSrcPath.charAt(flags.ajaxScriptSrcPath.length -1) == "/")
	            {
	            	self.server_int_plugin_path = flags.ajaxScriptSrcPath + self.server_int_plugin_path;
	            	self.msg_int_plugin_path = flags.ajaxScriptSrcPath + self.msg_int_plugin_path;
	            }
	            else
	            {
	            	 self.server_int_plugin_path = flags.ajaxScriptSrcPath + "/" + self.server_int_plugin_path;
	            	 self.msg_int_plugin_path = flags.ajaxScriptSrcPath + "/"+ self.msg_int_plugin_path;
	            }
	           
	            _cfAjaxPathInit = true;//flag so that we don't reassign path in case its already done
            }
            	
            	 
            if (self.cfClientReady) {
				// If the cfclient is already initialized, invoking the callback passed. This callback is called irrespective of whether all the required plugins are loaded.
				// Only the first cfclient callback contains the oncfclientready callback.
				if(self.loadServerPlugin && !self.server_int_plugin_loaded)
				{
					//load dom plugin
					self.loadJSFile(window.cfclientPath + self.msg_int_plugin_path, function(){
						self.loadJSFile(window.cfclientPath + self.server_int_plugin_path, function(){
							self.server_int_plugin_loaded = true;
							callback();
							self.replaceLinks();
						});
					});
					return;
				}else{
					callback();
					self.replaceLinks();
					return;
				}
            }
            if(typeof globalCallerVariables != 'undefined')
            {
                for (var i in globalCallerVariables) {
                    delete i;
                }
            }
            globalCallerVariables = {};
			//Saving the callbackFunction, so it can be called from the onCFClientReady and onDeviceDetected.
			self.callbackFunction.push(callback);
			if(self.callbackFunction.length >1)
				return;
			self.initialized = true;
			if( self.loadDeviceDetection ){
				//load device detection plugin
				self.loadJSFile(window.cfclientPath + self.dd_plugin_path, function(){
					cfclient_device_detection_plugin.init(function(){
						self.dd_plugin_loaded = true;
						self.onCFClientReadyCallback();
					});
				});
			}
			
			if( self.loadAPI ){
				//load api plugin
				self.loadJSFile(window.cfclientPath + self.mobile_api_plugin_path, function(){
					if (typeof cfclient_mobile_api_plugin != 'undefined') 
						cfclient_mobile_api_plugin.init(function(){
							self.mobile_api_plugin_loaded = true;
							self.device = cfclient_mobile_api_plugin;
							self.onCFClientReadyCallback();
						});
				});
			}
			
			if( self.loadServerPlugin ){
				//load dom plugin
				self.loadJSFile(window.cfclientPath + self.msg_int_plugin_path, function(){
					self.loadJSFile(window.cfclientPath + self.server_int_plugin_path, function(){
						self.server_int_plugin_loaded = true;
						self.onCFClientReadyCallback();
					});
				});
			}
			
			
			self.onCFClientReadyCallback();
		};
		
		this.addOrientationListener = function(listener){
            return cfclient_device_detection_plugin.addOrientationListener(listener);
        };
		
		this.removeOrientationListener = function(listener){
            return cfclient_device_detection_plugin.removeOrientationListener(listener);
        };
		
		this.addResizeListener = function(listener){
            return cfclient_device_detection_plugin.addResizeListener(listener);
        };
		
		this.removeResizeListener = function(listener){
            return cfclient_device_detection_plugin.removeResizeListener(listener);
        };

        this.onCFClientReadyCallback = function(){
			if(self.loadAPI && !self.mobile_api_plugin_loaded){
				return;
			}
			if(self.loadDeviceDetection && !self.dd_plugin_loaded){
				return;
			}
			if(self.loadServerPlugin && !self.server_int_plugin_loaded){
				return;
			}
            self.cfClientReady = true;
			if (self.callbackFunction.length !== 0){
				for (var i=0;i<self.callbackFunction.length;i++)
					self.callbackFunction[i]();
				self.replaceLinks();
				self.callbackFunction = [];
			}
		};

        this.addCustomTagData = function(tagName, attributes, tagData, caller){
            tagName = tagName.toLowerCase();
            //var customTagData = {};
            //customTagData.tagname = tagName;
            //customTagData.attributes = attributes;
            //customTagData.caller = tagData.__caller;
            //customTagData.thistag = tagData;
            self.customTags.push({tagName:tagName, attributes:attributes, caller:tagData.__caller, thisTag:tagData});
        };

        this.getLastCustomTag = function(){
            if(self.customTags.length > 0)
            {
                return self.customTags[self.customTags.length - 1].thisTag;    
            }
            else
            {
                return null;
            }
        };

        this.removeCustomTagData = function(){
			self.customTags.pop();
        };

        this.markGeneratedContent = function(localDivStruct){
            var tempContent = localDivStruct.outputvar;
            localDivStruct.outputvar = "";
            return tempContent;
        };

        this.updateBufferWithGeneratedContent = function(localDivStruct, startContent, tagData){
            localDivStruct.outputvar = startContent + tagData.generatedContent + localDivStruct.outputvar;
        };

        this.updateCustomTagData = function(tagData, executionmode, generatedcontent){
            tagData.executionMode = executionmode;
            tagData.generatedContent = generatedcontent;
        };

        this.getCustomTagList = function(){
			var result = [];
			for (var i=self.customTags.length;i--;) {
				result[self.customTags.length - i - 1] = self.customTags[i].tagName;
			}
			return arrayToList(result);
        };

        this.getCustomTagData = function(tagName, number){
            tagName = tagName.toLowerCase();
			for (var i=self.customTags.length;i--;) {
				if(self.customTags[i].tagName === tagName)
                    if( number === undefined)
                    {
                        return self.customTags[i];    
                    }
					else
                    {
                        if( number <= 1 )
                        {
                            return self.customTags[i];           
                        }
                        else
                        {
                            number--;
                        }
                    }
			}
			return null;
        };

        this.addAssocAttributes = function(attributes, baseTag, dataCollectionName){
            baseTag = baseTag.toLowerCase();
            if( dataCollectionName === undefined || dataCollectionName === null )
            {
                dataCollectionName = "assocAttribs";
            }
            else
            {
                dataCollectionName = dataCollectionName;
            }
            // When a customtag is invoked from the same custom tag as parent, then both tags will have same name. 
            // So ignoring the current tag and associating attributeCollection to the parent.
            var num = 1;
            if(self.customTags.length>0)
            {
                if(self.customTags[self.customTags.length - 1].tagName === baseTag)
                {
                    num = 2;
                }    
            }
            var customTagData = self.getCustomTagData(baseTag, num);
            if(null === customTagData)
            {
                throw ("The base tag " + baseTag + " does not expose any data. The likely cause is that the tag does not exist or is not a custom tag.");
            }
            var dataCollection = null;
            var tag = customTagData.thisTag;
            if(structKeyExists(tag, dataCollectionName))
            {
                dataCollection = tag[dataCollectionName];
            }
            else
            {
                dataCollection = [];
                tag[dataCollectionName] = dataCollection;
            }
            var thistag = Object.create(attributes);
            /*for (var i in attributes) {
                thistag[i] = attributes[i];
            }*/
            dataCollection.push(thistag);
        };

        this.pushBuffer =  function(bufferData){
            self.saveContentStack.push(bufferData);
        };

        this.popBuffer =  function(){
            return self.saveContentStack.pop();
        };

        this.getLastBuffer =  function(bufferData){
            if(self.saveContentStack.length > 0)
            {
                return self.saveContentStack[self.saveContentStack.length - 1];    
            }
            else
            {
                return null;
            }
        };

		this.replaceLinks = function(){
            if( window.ispgbuild === true )
            {
				var links = document.getElementsByTagName("a"); 
				for(var i = 0; i < links.length; i++)
				{
					if(links[i].href.toLowerCase().indexOf(".cfm") !== -1)
						links[i].href = links[i].href.replace(/.cfm/i, ".html");
				}
			}
		};	
				
        this.isCFClientReady = function(){
            return self.cfClientReady;
        };
        
        this.isEndTagMode = function(thisTag){
            if (thisTag && thisTag.executionMode && thisTag.executionMode == 'end') 
                return true;
            else 
                return false;
        };
        
        this.getLocalStorage = function(key, defaultVal){
            if (self.localStorageSupported) {
                var value = window.localStorage.getItem(key);
                if (!value && defaultVal) {
                    self.setLocalStorage(key, defaultVal);
                    return defaultVal;
                }
                return value;
            }
            else 
                return defaultVal ? defaultVal : null;
        };
        
        this.setLocalStorage = function(key, value){
            if (self.localStorageSupported) {
                window.localStorage.setItem(key, value);
                return true;
            }
            
            return false;
        };
        
        this.loadJSFile = function(scriptPath, callbackFunc){
            var newElm = document.createElement("script");
            newElm.setAttribute("type", "text/javascript");
            newElm.setAttribute("src", scriptPath);
            if (callbackFunc) {
                newElm.onload = callbackFunc;
                newElm.onreadystatechange = function(){
                    if (this.readyState == 'complete') {
                        callbackFunc();
                    }
                };
            }
            document.getElementsByTagName("head")[0].appendChild(newElm);
        };
		
		this.loadjsfile = function(callbackFunc, scriptPath){
            self.loadJSFile(scriptPath, function(){
					returnFromAsyncFunc(callbackFunc,null,null);
			});
        };
        
        this.loadCSSFile = function(cssPath, callbackFunc){
            var newElm = document.createElement("link");
            newElm.setAttribute("rel", "stylesheet");
            newElm.setAttribute("type", "text/css");
            newElm.setAttribute("href", cssPath);
            document.getElementsByTagName("head")[0].appendChild(newElm);
			// workaround as load or onreadystatechange are not reliable
			var img = document.createElement('img');
			img.onerror = function(){
				if(callbackFunc) callbackFunc();
			}
			img.src = cssPath;			
        };
		
		this.loadcssfile = function(callbackFunc, cssPath){
            self.loadCSSFile(cssPath, function(){
					returnFromAsyncFunc(callbackFunc,null,null);
			});
        };	
		
		this.getUrlParam = function (paramName)
		{
			var regexStr = "[?&]" + paramName + "=([^&]*)";
			var regex = new RegExp(regexStr);
			var match;
			if ((match = regex.exec(window.location.search)))
				return match[1];
		};	
    };
			
    window.cfclient = new _cfclient();
})();

function onError(tx, err){
    if (typeof err == 'undefined' || err === null) 
        throw ("Err performing the operation");
    var msg = err;
    if (typeof err.message != 'undefined') 
        msg = err.message;
    throw ("Error processing SQL: " + msg);
}
window.__$cf = (window.__$cf || {});

__$cf.__loopCheck = function (ind,to,from,step){
	if(to == from)
		return ind == to;
    if(to > from)
		return ind<=to;
	if(step > 0)
		return false;
	return ind>=to;
}

__$cf.__wrapError = function (e){
	if(typeof e == "string")
	{
		e = {type:"application",message:e};
	}
	else if (e.type === undefined){
		e.type = "application";
	}
	return e;
}

__$cf.__wrapForVal = function (e){
	if(typeof e == "string")
	{
		return e.split(',');
	}	
	return e;
}

__$cf.__wrapForInd = function (i,c){
	if (c instanceof Array)
	{
		return c[i];
	}	
	return i;
}

__$cf.__caseValue = function (e){
	if(typeof e == "string")
	{
		return e.toLowerCase();
	}
	return e;
}
__$cf.__trunc = function (_value)
{
  if (_value<0) return Math.ceil(_value);
  else return Math.floor(_value);
}
__$cf.__mod = function (_lhs,_rhs)
{
  return __$cf.__trunc(_lhs) % __$cf.__trunc(_rhs); // CF mod is integral
}
__$cf.__idiv = function (_lhs,_rhs)
{
  return __$cf.__trunc(_lhs) / __$cf.__trunc(_rhs);
}

// arguments will be passed unreferenced
__$cf.__callAsyncFunction = function (funcName, thisObj, argMap, callbackStack){
    //check if buitl-in javascript functions
    if (funcName == 'alert') 
        return alert(arguments[arguments.length - 1]);
    
    var _tmpFunction = null;
    if (thisObj != undefined)
    {
    	if (typeof thisObj[funcName] === 'function') 
        	_tmpFunction = thisObj[funcName];
		else if (typeof thisObj[funcName.toLowerCase()] === 'function') 
        	_tmpFunction = thisObj[funcName.toLowerCase()];
    }
    if (_tmpFunction == null)
    {
	    if ( typeof window[funcName] != "undefined")
	        _tmpFunction = window[funcName];
		else
			_tmpFunction = window[funcName.toLowerCase()];
	}
		
	if (_tmpFunction == null || _tmpFunction == undefined)
	{
		//try to find the member in 'this' object
		if (typeof this[funcName] !== 'undefined')
			_tmpFunction = this[funcName];
	}
    
    //first arg is function name and the second argument is thisObj
    var newThisObj = arguments[1];
    
    if (__builtInFunctions.indexOf(funcName) >= 0) 
        newThisObj = null;
    var argsArray = [];
    if(funcName == "setTimeout")
    {
		// Replacing the first function argument with wrapper which invokes the callbackstack.
		for (var i = 3; i < arguments.length; i++) {
			if( typeof arguments[i] === 'function' ){
				var callbackFunc = arguments[i];
				arguments[i] = function(){
					var before = callbackStack.cb.length;
					callbackFunc.call();
					var after = callbackStack.cb.length;

					//Checking if the function passed as an argument to setTimeout is an asynchronous function or not. 
					//If the function is asynchronous (after == before), then the callback from callbackstack, if any has to be invoked.
					if( after == before )
					{
						if (callbackStack && callbackStack.cb && callbackStack.cb.length > 0){
							var callback = callbackStack.cb.pop();
							callback(callbackStack, null, null);
						}
					}
				};
				break;
			}
		}

		for (var i = 4; i < arguments.length; i++) 
        	argsArray.push(arguments[i]);
	}
    else
    {
    	for (var i = 3; i < arguments.length; i++) 
        	argsArray.push(arguments[i]);
    }
    
    if (_tmpFunction == undefined) //-Ram
    {
    	//try to evaluate function name and check if it is a function
    	try
    	{
    		var _tmpObj = eval(funcName);
    		if (typeof _tmpObj == 'function')
    			_tmpFunction = _tmpObj;
    	} catch (e){
    		throw ("Error : could not resolve function " + funcName);
    	}
    }
    
    return _tmpFunction.apply(newThisObj, argsArray);
}

function returnFromAsyncFunc (callbackStack, status, retValue)
{
	if (callbackStack && callbackStack.cb && callbackStack.cb.length > 0)
	{
		var callback = callbackStack.cb.pop();
		callback(callbackStack,status, retValue);
	}
}

__$cf.__incrNum = function(a, isArr)
{
	if (isArr) 
	{
		if (typeof a != "string" && a == parseInt(a)) 
		{
			return a + 1;
		}
		else 
			if (typeof a == "string") 
			{
				var temp = a.replace(/^\s+|\s+$/g, ''); //trim string
				if (temp !== "") 
				{
					var num = Number(temp);
					if (!isNaN(num)) 
					{
						return num + 1;
					}
				}
			}
	}
	return a ;
}

__$cf.__decrNum = function (a, isArr)
{
	if(isArr)
	{
		if (typeof a != "string" && a == parseInt(a))
		{		
			return a-1;
		}
		else if (typeof a == "string" )
		{
			var temp = a.replace(/^\s+|\s+$/g, ''); //trim string
			if (temp !== "") 
			{
				var num = Number(temp);
				if (!isNaN(num)) 
				{
					return num - 1;
				}
			}
		}
	}
	return a ;
}

__$cf.__arraySet = function (aVar, value)
{
	var isArr = isArray(aVar);
	var args= __$cf.__splitKeys(arguments,2);	
	var aLength = args.length;
	if(aLength <= 1)
	{
		aVar[__$cf.__decrNum(args[0],isArr)]=value;
	}
	else
	{
		var temp = aVar;
		for(var i=0;i<aLength-1;i++)
		{
			var index = __$cf.__decrNum(args[i],isArr);
			var temp1 = temp[index];
			if("undefined" == typeof temp1)
			{
				if(typeof index === "string")
					temp[index] = {};
				else
					temp[index] = [];
				temp = temp[index];
			}
			else
				temp = temp1;
		}
		temp[__$cf.__decrNum(args[aLength-1],isArr)]=value;	
	}
}

__$cf.__arrayGet = function (aQueryOrvar)
{
    var aVar = aQueryOrvar;
    var args= __$cf.__splitKeys(arguments,1); 
    var aLength = args.length;
    var isQ = isQuery(aQueryOrvar);
    if(isQ)
    {
        var leafRef = args[aLength-1];
    }
    --aLength;

	var isArr = isArray(aVar);
	
	if(aLength <= 1)
	{
		var index = __$cf.__decrNum(args[0],isArr);
        if(isQ)
        {
            if(arrayContains(aQueryOrvar["columnList"],index))
                aVar = aQueryOrvar["DATA"];

            var retVar = aVar[index];
            if(leafRef)
            {
                if(isArray(retVar))
                   return retVar[0];
                else
                   return retVar;
            }
        }
        else
            var retVar = aVar[index];

		if(typeof retVar == "undefined" && aVar._dim > 1)
		{
			aVar[index] = arrayNew(aVar._dim - 1);
			return aVar[index];
		}
		else
			return retVar;
	}
	else
	{
		var temp = aVar;
        if(isQ)
        {
            if(arrayContains(aQueryOrvar["columnList"],args[0]))
                aVar = aQueryOrvar["DATA"];
            temp = aVar;
        }        
		for(var i=0;i<aLength;i++)
		{
            var isArr = isArray(temp);
			var index = __$cf.__decrNum(args[i],isArr);
			if (typeof temp[index] == "undefined") 
			{
				if(typeof temp._dim != "undefined" && temp._dim > 1)
					temp[index] = arrayNew(temp._dim - 1);
					
				temp = temp[index];
			}
			else 
				temp = temp[index];
		}
        if(isQ && leafRef)
        {
            if(isArray(temp))
                return temp[0];
            else
                return temp;
        }
		return temp;
	}
}

__$cf.__splitKeys = function (realArgs,ind)
{
	var args = [];
	for(var i=ind;i<realArgs.length;i++)
	{	
		args = args.concat(realArgs[i]);
	}
	return args;
}

__$cf.__break = function (breakCallBack, __callbackStack)
{
	var callback;
	while(__callbackStack.cb.length > 0)
	{
		callback = __callbackStack.cb.pop();
		if(breakCallBack == callback)
		{
			break;
		}
	}
	if(__callbackStack.cb.length > 0)
	{
        __callbackStack.dontcallnext = true;
		callback = __callbackStack.cb.pop();
		callback.call(this,__callbackStack);			
	}
	return;
}

__$cf.__continue = function (breakCallBack, __callbackStack)
{
	while(__callbackStack.cb.length > 0)
	{
		var callback = __callbackStack.cb.pop();
		if(breakCallBack == callback)
		{
			break;
		}
	}
    __callbackStack.dontcallnext = true;
	callback.call(this,__callbackStack);			
	return;
}

__$cf.__return = function (returnCallBack, __callbackStack, retVal)
{
    if(typeof returnCallBack === 'undefined' || returnCallBack === "")
    {
        while(__callbackStack.cb.length > 0)
        {
            __callbackStack.cb.pop();
        }
    }
	var callback = null;
	while(__callbackStack.cb.length > 0)
	{
		callback = __callbackStack.cb.pop();
		if(returnCallBack == callback)
		{
			break;
		}
	}
	if (callback != null)
		callback.call(this,__callbackStack, null, retVal);			
	return;
}

__$cf.__flush = function (clientDivStr)
{
	if(clientDivStr && len(clientDivStr.outputvar)>0)
	{
		var elt = document.getElementById(clientDivStr.divId);

        var div = document.createElement('div');
        div.innerHTML = clientDivStr.outputvar;
        var scripts = div.getElementsByTagName('script');
        var i = scripts.length;
        var scriptElementsToAdd = [];
        while (i--) {
            var script = document.createElement('script');
			if(scripts[i].type !== undefined)
				script.type = scripts[i].type;
			if(scripts[i].id !== undefined)
				script.id = scripts[i].id;
            script.innerHTML = scripts[i].innerHTML;
            scriptElementsToAdd.push(script);
            scripts[i].parentNode.removeChild(scripts[i]);
        }
        var scrLength = scriptElementsToAdd.length;
        for(var i=0;i<scrLength;i++)
        {
            elt.appendChild(scriptElementsToAdd.pop());
        }

        clientDivStr.outputvar = div.innerHTML;
		elt.innerHTML += clientDivStr.outputvar;
		clientDivStr.outputvar = "";
	}
}

__$cf.__flushScript = function (clientDivStr)
{
    if(clientDivStr && len(clientDivStr.outputvar)>0)
    {
        var elt = document.getElementById(clientDivStr.divId);

        var div = document.createElement('div');
        div.innerHTML = clientDivStr.outputvar;
        var scripts = div.getElementsByTagName('script');
        var i = scripts.length;
        var scriptElementsToAdd = [];
        while (i--) {
            var script = document.createElement('script');
            script.innerHTML = scripts[i].innerHTML;
            if(typeof scripts[i].type !== 'undefined'){
                script.type = scripts[i].type;
            }
            scriptElementsToAdd.push(script);
            scripts[i].parentNode.removeChild(scripts[i]);
        }
        
        for(var i=0;i<scriptElementsToAdd.length;i++)
        {
            elt.appendChild(scriptElementsToAdd.pop());
        }

        clientDivStr.outputvar = div.innerHTML;
    }
}

function invokeCFClientFunction(funcName)
{
    var tmpSuccessCallback = null;
    var tmpFailureCallback = null;
    if(arguments.length > 2)
    {
        tmpFailureCallback = arguments[arguments.length - 1];
        tmpSuccessCallback = arguments[arguments.length - 2];
    }
    else
    {
        throw "The function signature is invokeCFClientFunction(functionName [, arg1, arg2, arg3, ...], successCallback, failureCallback). The functionName, successCallback and failureCallback are mandatory. If you don't have a successCallback or failureCallback, null can be passed as the value.";
    }
    if( tmpSuccessCallback !== null && typeof tmpSuccessCallback !== 'function' ){
        throw "The second last argument should be a success callback function.";
    }
    if( tmpFailureCallback !== null && typeof tmpFailureCallback !== 'function' ){
        throw "The last argument should be a failure callback function.";
    }
    var functionToInvoke = eval(funcName);
    if( typeof functionToInvoke === 'undefined' )
    {
        functionToInvoke = eval("self." + funcName);
    }
    if( functionToInvoke !== null && typeof functionToInvoke === 'function' ){
        var src = functionToInvoke.toString();
        var index = src.indexOf("(");
        if (index > 0)
        {
            var firstArg = "";
            for (var i = index+1; i < src.length; i++)
            {
                var ch = src.charAt(i);
                if (ch == "," || ch == ")")
                    break;
                firstArg += ch;
            }
        
            if (firstArg !== "__callbackStack")
            {
                //this is not an async function
                var args = [];
    
                for (var i = 1; i < arguments.length - 1; i++) 
                {
                    args.push(arguments[i]);
                }
                var fn = (window || this);
                var retVal;
                try{
                    retVal = functionToInvoke.apply(fn,args);
                    if(null!==tmpSuccessCallback){
                        tmpSuccessCallback(retVal);
                    }    
                }
                catch(e){
                    tmpFailureCallback(e);
                }
                return;
            }

        }
    }
	function innerCallback (__callbackStack,status,retVal){
        var localDivStruct = __callbackStack.clientDivStr;

		if(typeof __callbackStack.cb == 'undefined') 
			__callbackStack.cb = [];
//		var __callbackStackCount = __callbackStack.cb.length;
		if(status && typeof status.code != 'undefined' && status.code !== 0) {
			if (typeof status.message == 'undefined') 
				status.message = 'Unknown error when calling an asynchronous function';
            tmpFailureCallback(status);
		}
		else{
			if(null!==tmpSuccessCallback){
				tmpSuccessCallback(retVal);
			}
			//Else there is no callback to be invoked in case of success.
		}

		__$cf.__flush(localDivStruct);
	}

	var cbStack = {cb:[innerCallback], catchStack:[function(error){
        tmpFailureCallback(error);
    }], finallyStack:[function(){}],
				asyncReturnCallbackName:innerCallback,clientDivStr:globalDivStruct,
				__mark_callback:true};
	
    var tmpCallAsyncFunctionFunc = __$cf.__callAsyncFunction;

    var argsArray = [funcName,self,null,cbStack];
    
    for (var i = 1; i < arguments.length - 2; i++) 
    {
    	argsArray.push(arguments[i]);
    }

    tmpCallAsyncFunctionFunc.apply(self,argsArray);
}

function initializeServerPlugin()
{
	if(!self.ajaxPluginLoaded)
	{
		ColdFusion.Ajax.importTag('CFAJAXPROXY');
		self.ajaxPluginLoaded = true;
	}
}

function createObject(jsClassName, invocationPath, call)
{
	var fn = (window || this);
    var proxy = jsClassName.call(fn, false,{},{});
	proxy = ColdFusion.AjaxProxy.init(invocationPath, proxy, true); 
	if(call)//init can be remote, proxy needs to be initialized first.
	{
		[].splice.call(arguments,0,3);
		proxy.init.apply(proxy,arguments);
	}
	return proxy;
}

function callServerPlugin(thisObj, functionName, argStruct, origArgs)
{
  var opCallHandler=null, opErrorHandler=null, callFwd=true, origLen = origArgs.length, argLen = Object.keys(argStruct).length,tempHandler=null;
  
  if(origLen == argLen+2){
	callFwd = false;
	tempHandler = origArgs[origLen-2];
	opErrorHandler=origArgs[origLen-1];
  }else if(origLen == argLen+1){
	callFwd = false;
	tempHandler = origArgs[origLen-1];
  }
 
  if(!callFwd){
	opCallHandler = function(result,callbackParams) { 
				var convertedResult = __$cf._convertResult(result,thisObj);
				convertedResult = __$cf._decorateIfQuery(convertedResult);
				tempHandler( convertedResult,callbackParams); 
				};  
  }
 
  var result = ColdFusion.AjaxProxy.invokeInternal(thisObj, functionName,"", argStruct,null,true,opCallHandler,opErrorHandler);
 
  if(callFwd){
	var convertedResult = __$cf._convertResult(result,thisObj);
	return __$cf._decorateIfQuery(convertedResult);
  }
}

__$cf.setAccessToken = function (appid,token)
{
   localStorage.setItem("_cf_access_token" + appid, token);
}

__$cf.revokeAccessToken = function (appid,token)
{
   localStorage.removeItem("_cf_access_token" + appid);
}

__$cf._convertResult = function (result,proxy)
{
	var ret=result;
	if(typeof result !=='undefined' &&typeof proxy !=='undefined' && typeof proxy._metadata !=='undefined')
	{
		var variables = result.variables;
		if(typeof variables !=='undefined'){
			for (var varName in variables) { 
					var variable = variables[varName]; 
					__$cf.__caseInsensitiveSetter(proxy._variables,varName,__$cf._convertResult(variable));
				}
		}
		ret=result = result["result"];
	}
	try{
		if(typeof result === "object" && typeof result._metadata === "object")
		{
			ret = window[result._metadata.name](false,{},{})	;
			if(ret._metadata.servercfc)
				ret = ColdFusion.AjaxProxy.init(ret._metadata.classname, ret, true);
			for (var attrname in result._variables) { 
				var variable = result._variables[attrname]; 
				__$cf.__caseInsensitiveSetter(ret._variables,attrname,__$cf._convertResult(variable));
			}
			return ret;
		}else
		{
			if(isArray(result)){
				var obj = arrayNew(1);
				for (var attrname in result) { 
					if(result.hasOwnProperty(attrname)){				
						var value = result[attrname]; 
						__$cf.__caseInsensitiveSetter(obj,attrname,__$cf._convertResult(value));
					}
				}
				return obj;
			}
			if(typeof result === "object"){
				if(typeof result._date_ !== "undefined")
				{
					return new Date(result._date_);
				}
				var obj = {};
				for (var attrname in result) { 
					if(result.hasOwnProperty(attrname)){
						var value = result[attrname]; 
						__$cf.__caseInsensitiveSetter(obj,attrname,__$cf._convertResult(value));
					}
				}
				return obj;		
			}
		}
	}catch(e){}

	return result;
}

	__$cf.__caseInsensitiveSetter = function (obj,prop,val){
		var cacheProp = prop;
		prop = (prop + "").toLowerCase();
		var valSet = false;
		for(var p in obj){
			if(prop == (p+ "").toLowerCase()){
				obj[p] = val;
				valSet = true;
				break;
			}
		}
		if(!valSet)// if not found set it anyway
			obj[cacheProp] = val;
	}

__$cf._decorateIfQuery = function (obj)
{
    if(typeof obj === "object")
    {
        if(obj.hasOwnProperty("DATA") && obj.hasOwnProperty("COLUMNS")) //looks like its a query object
        {
          var columnFormat = false; 
          if(obj.hasOwnProperty("ROWCOUNT"))
             columnFormat = true;
          obj["__QUERY__"] = true;
          obj["length"] = columnFormat ? obj["ROWCOUNT"] : obj["DATA"].length;
          obj["recordCount"] = obj["length"];
          obj["columnList"] = [];
          //change the case of column as its turned to uppercase by server serialization
          for (var i = 0; i < obj["COLUMNS"].length; i++) 
          {
             obj["columnList"].push(obj["COLUMNS"][i].toLowerCase());
          }
          if(columnFormat)
          {
              var firstRow = [];
              for (var i = 0; i < obj["COLUMNS"].length; i++) 
              {
                    var colName = obj["COLUMNS"][i];
                    firstRow.push(obj["DATA"][colName][0]);
              } 
          }
          obj["currentRow"] = columnFormat ? firstRow : obj["DATA"][0];
        }
    }
    return obj;
}

__$cf.__checkCallbackStack = function (__callbackStack, status) {
	if (typeof __callbackStack.cb == 'undefined')
		__callbackStack.cb = [];
	//var __callbackStackCount = __callbackStack.cb.length;
	if (status && typeof status.code != 'undefined' && status.code !== 0) {
		if (typeof status.message == 'undefined')
			status.message = 'Unknown error when calling an asynchronous function';
		var catchStackLen = __callbackStack.catchStack.length;
		if (catchStackLen > 0) {
			var currCatchFunc = __callbackStack.catchStack[catchStackLen - 1];
			currCatchFunc(status.message, __callbackStack);
			return false;
		} else
		{
			if(! window.ispgbuild || (typeof window.debugip != "undefined"))
					console.log(status.message);
			throw {				
				message : status.message
			};
		}
	}
    return true;
}

__$cf.__invokeNextCallback = function (callnext, __callbackStack, status, retVal) {
	if (callnext && __callbackStack.cb.length > 0) {
		var callback = __callbackStack.cb.pop();
		callback.call(this, __callbackStack, status, retVal);
	} else {
        __callbackStack.callnext = false;
		if (cfclient.getLastCustomTag() === null && cfclient.getLastBuffer() === null) {
			__$cf.__flush(__callbackStack.clientDivStr);
		}
	}
}

__$cf.__removeCallback = function (__callbackStack, callback) {
    for (var i = __callbackStack.cb.length - 1; i >= 0; i--) {
        if (__callbackStack.cb[i] === callback) {
            __callbackStack.cb.splice(i, 1);
            break;
        }
    }
}


//Do not delete this. Used in asyc processing of try-catch - Ram
function __cfclient_empty_func()
{
	
}

__$cf.__getCFDataSource = function (dbName)
{
	if(cfclient.__cfdatasource__ == null)
		cfclient.__cfdatasource__ = new Object();
		
	if(dbName in cfclient.__cfdatasource__)
		return cfclient.__cfdatasource__[dbName];
	else
	{
		var db = window.openDatabase(dbName,"1.0","CF Datasource",1000000);
		cfclient.__cfdatasource__[dbName] = db;
		return db;
	}
}

__$cf._log = function(msg)
{
	if(cfclient.enableDebugLog)
		console.log(msg);
}

__$cf._isTrue = function(b)
{
	if(b == 'NO')
		return false;
	if(b == 'YES')
		return true;
	return b;

}

__$cf._not = function(b)
{
	if(b == 'NO')
		return true;
	if(b == 'YES')
		return false;
	return !b;

}

__$cf._getQueryParamValue = function(val)
{
	if(typeof val.value != "undefined")
		return val.value;
		
	return val;
}

__$cf.invokeCallbackInternal = function (__callbackStack, status, retVal, cff_callbackIntern)
{
    if (__callbackStack.catchStack.length > 0) {
        try {
            cff_callbackIntern(__callbackStack, status, retVal);
        } catch (err) {
            var tmpCatchStack = __callbackStack.catchStack;
            var tmpFinallyStack = __callbackStack.finallyStack;
            if (tmpCatchStack.length > 0) {
                if (tmpCatchStack.length === tmpFinallyStack.length) {
                    try {
                        tmpCatchStack.pop()(err, __callbackStack);
                    } catch (err1) {
                        tmpFinallyStack[tmpFinallyStack.length - 1](true, true, err1);
                    }
                } else {
                    tmpFinallyStack[tmpFinallyStack.length - 1](true, true, err);
                }
            } else throw err;
        }
    } else {
        cff_callbackIntern(__callbackStack, status, retVal);
    }
}

	function replaceLink(src) {
		if (window.ispgbuild === true && typeof src === 'string') {
			if (src.indexOf(".cfm") !== -1)
				return src.replace(/.cfm/i, ".html");
		}
		return src;
	};
