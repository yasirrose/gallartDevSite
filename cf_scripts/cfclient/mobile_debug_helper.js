__is_valid_server_url = true;
__this_script_name = "mobile_debug_helper.js";
__client_bps = null;
__last_step_op = null;



serverUrl = serverIP;
function startDebugSession()
{
	if (typeof serverUrl == 'undefined')
		serverUrl = getServerURL();
		
	var requestUrl = serverUrl + "?op=newSession&getBPs=true";
	
	var resp = executeCommand(requestUrl);
//	if (resp != null)
//	{
//		__client_bps = JSON.parse(resp.RESULT);
//	}
}

startDebugSession();

window.onerror = function(error, url, line) {

	if (error instanceof Event)
	{
		console.log("Error Event ->");
		console.log(error);
		//This is an event. Skip this to prevent displaying large error message.
		return;
	}
		
   // _cdError(JSON.stringify(error));
   if(error instanceof Object)
   {	
	   	maxDepth = 2;
		error = objectToString(error,0);
		maxDepth = 1;
		
   }
   
    error = JSON.stringify(error);
	var requestUrl = serverUrl + "?op=handleError";
	msg = encodeURIComponent(error);
	xmlHttp = new XMLHttpRequest();
	
	xmlHttp.open("POST",requestUrl,true);
	xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	
	
	xmlHttp.send("data="+msg);
	return false;
	throw error;
};

function getFunctionArguments(func) {
	var STRIP_COMMENTS = /((\/\/.*$)|(\/\*[\s\S]*?\*\/))/mg;
    func = func.replace(STRIP_COMMENTS, '');
    return func.slice(func.indexOf('(')+1, func.indexOf(')')).match(/([^\s,]+)/g);
}

function getLocalVarNames (code)
{
   
    var regex = /\bvar\s+([^;]+);/g;
    var matches, result = [];
    while (matches = regex.exec(code))
    {
        for (var i = 1; i < matches.length; i++) {
            if (matches[i] != undefined) {
                //filter framework specific variables here
                matchvar = matches[i].split(",");
				//result.push(matchvar);
				for(var j =0; j <matchvar.length;j++)
				{
					var currvar = matchvar[j].trim();
					if(currvar.indexOf("=") == -1)
						result.push(currvar);
				}
				
				
            }
        }
    }
	var funcargs = getFunctionArguments(code);
	if(!(typeof funcargs == 'undefined') && funcargs instanceof Array )
	{
	for(var i = 0; i < funcargs.length ; i++)
		result.push(funcargs[i]);
	}
	
    return result;
}
window._cdError = function _cdError(msg)
{
	var requestUrl = serverUrl + "?op=handleError";
	msg = encodeURIComponent(msg);
	
	executeCommand(requestUrl,"POST", msg);
	
	
}	
window._cd = function _cd(lineNum, path, __ctx,func, isLast)
{
	

	
	if (!__is_valid_server_url)
		return;
		
	if (arguments.length == 0) {


				
		var stackInfo = getLineNumAndPath();
		if (stackInfo == null) 
			return;
		lineNum = stackInfo.lineNum;
		path = stackInfo.path;
	}
	
	//server url has to be declared in the main file.
	if (typeof serverUrl == 'undefined')
		return;
	
	if (!path)	
		path = "default...";
//	path = encodeURIComponent(path);
	if(!func)
		func = "default"; 
		
	if (__client_bps != null && __last_step_op != 'step_over' && __last_step_op != 'step_in')
	{
		var trimmedUrl = trimUrl(path);
		if (trimmedUrl && __client_bps[trimmedUrl] != undefined)
		{
			var bps = __client_bps[trimmedUrl];
			var bpFound = false;
			for (var i = 0; i < bps.length; i++)
			{
				if (bps[i] == lineNum)
				{
					bpFound = true;
					break;
				}
			}
			
			if (!bpFound)
				return;
		}
	}

	if (!shouldSuspend(lineNum, path, func, isLast))
		return true;
	
	suspend(lineNum, path,__ctx,func);
	return true;
}

function getLocation()
{
	var loc = window.location.href;
	var index = loc.lastIndexOf("?");
	if (index > 0)
		loc = loc.slice(0,index);
	return encodeURI(loc);
}

function shouldSuspend(lineNum, path, func, isLast)
{
	var requestUrl = serverUrl + "?op=shouldSuspend&lineNum=" + lineNum + "&path=" + path + "&func=" + func;
	if(isLast)
	{
		 requestUrl = serverUrl + "?op=shouldSuspend&lineNum=" + lineNum + "&path=" + path + "&func=" + func + "&isLast=" + isLast;
	}	 
	var ret = executeCommand(requestUrl);
	__last_step_op = null;	
	if (ret == null || ret.result == false)
		return false;
	return true;
}

function suspend(lineNum, path,__ctx,func)
{
	
	var requestUrl = serverUrl + "?op=suspended&lineNum=" + lineNum + "&path=" + path +"&func=" + func;
	var ret = executeCommand(requestUrl);	
	if (ret == null || ret.result == false)
		return false;
	if (typeof ret.command != 'undefined')
	{
		if (ret.command == 'step_over' || ret.command == "step_in" || ret.command == "continue" )
			__last_step_op = ret.command;
		else
		{
			handleCommand(ret, lineNum, path,__ctx,func);
		}
	}
	return true;
}
maxDepth = 1;
function determineMaxDepth(expr)
{
	if(expr === "document"  || expr === "window" || expr.indexOf("document.") != -1 || expr.indexOf("document[") != -1 || expr.indexOf("window.") != -1 || expr.indexOf("window[") != -1)
		maxDepth = 1;
	else
		maxDepth = 1;
}	
function arrayToString(arr, depth)
{
	var obj = {};
	if(depth >= maxDepth)
		return {};
	
	if(arr instanceof Array)
	{
	//	arr.visited = true;
		for(var key in arr)
		{
	
			if( arr[key] instanceof HTMLCollection || arr[key] instanceof StyleSheetList || arr[key] instanceof DOMImplementation || 
				arr[key] instanceof DOMStringMap || arr[key] instanceof NamedNodeMap ||typeof arr[key] == 'undefined' || arr[key] == null  ||
				typeof arr[key] == 'function' || !arr[key] || arr[key] === "")
			{
				continue;
				
			}
			
			if(arr[key] instanceof Array)
			{		
				if(depth > maxDepth)
					continue;	
				obj[key] = arrayToString(arr[key], depth+1);
				
			}
			else if(arr[key] instanceof Object)
			{
				if(depth > maxDepth)
					continue;
				obj[key] = objectToString(arr[key], depth+1);
				
			}
			else 
			{
				objstr = new String(arr[key]);
				if(typeof objstr == 'undefined')
					continue;
				
				if(objstr.length == 0)
					continue;
				if(objstr.length > 50)
				{
					obj[key] = objstr.substr(0,50) + ".....";
				}
				else
				{
					obj[key] = objstr;
				}	
				
			}
				
		}	
	}
	return obj;
}
function objectToString(arr, depth)
{
	var obj = {};
	var maxErrorLen = 200;
	
	if(depth >= maxDepth)
			return {};
	
	if(arr instanceof Object)
	{
		//arr.visited = true;
		for(var key in arr)
		{
			
			if(arr[key] instanceof HTMLCollection || arr[key] instanceof StyleSheetList || arr[key] instanceof DOMImplementation || 
				arr[key] instanceof DOMStringMap || arr[key] instanceof NamedNodeMap ||typeof arr[key] == 'undefined' || arr[key] == null  ||
				typeof arr[key] == 'function' || !arr[key] || arr[key] === "")
			{
				continue;
				
			}
			if(arr[key] instanceof Object)
			{
				if(depth > maxDepth)
					continue;
				obj[key] = objectToString(arr[key], depth+1);
				
			}
			else if(arr[key] instanceof Array)
			{
				if(depth > maxDepth)
					continue;
				obj[key] = arrayToString(arr[key], depth+1);
				
			}
			else 
			{
				
				objstr = new String(arr[key]);
				if(typeof objstr == 'undefined')
					continue;
				if(objstr.length == 0)
					continue;
				if(objstr.length > maxErrorLen)
				{
					obj[key] = objstr.substr(0,maxErrorLen) + "..... See error log.";
				}
				else
				{
					obj[key] = objstr;
				}	
			}
			
		}	
	}
	return obj;
}	
function handleCommand (resp, lineNum, path,__ctx,func)
{
	
	if (resp.command == "getVar")
	{
	//	alert(resp.command +" -- "+  resp.varName + " ::" + eval(resp.varName));
	
		var commandArgs = resp.varName;
		commandArgs = JSON.parse(commandArgs);
		var resl = {};
		var resg = {};
		if( typeof __ctx != 'undefined')
		{
		var localVars = __ctx.getLocalVars();
		
		for(index = 0; index < localVars.length ;  index++)
		{
			try{
					var valueCurrent = __ctx.getvar(localVars[index]);
					determineMaxDepth(localVars[index]);
					
					if( valueCurrent == false)
						continue;
				    
					 
					if(valueCurrent instanceof Array)
					 {
						resl[localVars[index] ] = arrayToString(valueCurrent,0);
					 }
					 else if(valueCurrent instanceof Object)
					 {
						 resl[localVars[index]] = objectToString(valueCurrent,0);
					 }
					 else
					 {
						  resl[localVars[index]] = valueCurrent + "";
					 }
					 
				}catch (err)
				{
				}	
	    }
	} 
		
		
		for(index = 0; index < commandArgs.length ; index++)
		{
			
			try
			{
				var valueCurrent = window[commandArgs[index] + ""];
				determineMaxDepth(commandArgs[index] + "");
				
				if(typeof valueCurrent != 'undefined')
				{
					
					
					if(valueCurrent instanceof Array)
					{
						resg[commandArgs[index]] = arrayToString(valueCurrent,0);
					}
					else if(valueCurrent instanceof Object)
					{
						resg[commandArgs[index]] = objectToString(valueCurrent,0);
					}
					else
					{
					resg[commandArgs[index]] = valueCurrent + "";
					}
					
				}
			}
			catch(err)
			{
			}
			
		}
	
			
	//	document.write(JSON.stringify(resg));
		

		
		var requestUrl = serverUrl + "?op=post";
		var varValue = eval(commandArgs);
		var data = {
			"command": resp.command,
			"local":resl,
			"global" : resg,
			"lineNum": lineNum,
			"path": path
		};
		data = JSON.stringify(data);
	//	var regex = new RegExp('%', 'g');
	//	data.replace(regex, ' ');
		 data = encodeURIComponent(data);
	//	document.write(data +"<br>");
		executeCommand(requestUrl,"POST", data);
		suspend(lineNum, path,__ctx,func);
		
	} 
	else if (resp.command == "setVar")
	{
		var commandArgs = resp.commandArgs;
		var requestUrl = serverUrl + "op=post";
		eval(commandArgs.NAME + " = "  + commandArgs.VALUE);
		suspend(lineNum, path);
	}
	
	else if (resp.command == "evalExprsn")
	{
		
		var commandArgs = resp.varName;
		determineMaxDepth(commandArgs);
		var varValue ;
		try{
			varValue = __ctx.getvar(commandArgs);
		}catch(err)
		{
			varValue = false;
		}
		
		if(varValue === false)
		{
			try{
				varValue = eval(commandArgs);
			}catch(err)
			{
				varValue = "error";
			}	
		}
		if(typeof varValue === 'undefined')
		{
			varValue = "error";
		}
		
		if(varValue instanceof Array)
		{
			varValue = arrayToString(varValue,0);
		}
		else if(varValue instanceof Object)
		{
			varValue = objectToString(varValue,0);
		}
		else
		{
			varValue = varValue + ""; 
			
		}
		var requestUrl = serverUrl + "?op=post";
		
		var data = {
			"command": resp.command,
			"value":varValue,
			"lineNum": lineNum,
			"path": path
		};
	//	document.write(JSON.stringify(varValue) +"<br>");
		data = JSON.stringify(data);
		 data = encodeURIComponent(data);
	//	document.write(data +"<br>");
		executeCommand(requestUrl,"POST", data);
		suspend(lineNum, path,__ctx,func)
	}
	
}
function badSleep(delay) {
    var start = new Date().getTime();
    while (new Date().getTime() < start + delay);
  }

function executeCommand(urlStr, type, postData)
{
	var xmlHttp = new XMLHttpRequest();
//	xmlHttp.timeout = 0;
	if (!type)
		type = "GET";
	
	var dataToSend = null;
	/* 	
	xmlHttp.open(type,urlStr,false);

	if (type == "POST" && postData)
	{
		xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		dataToSend = "data=" + postData;
	}
	*/
	var newID = "1";
	var count = 0;
	while(true)
	{
		try{
		
			count = count+1;
			xmlHttp = new XMLHttpRequest();
			urlNewStr = urlStr  +"&newID=" + newID + "&ver=" + Math.random();
			
	
			xmlHttp.open(type,urlNewStr,false);

			if (type == "POST" && postData)
			{
				xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
				dataToSend = "data=" + postData;
			}
			
			xmlHttp.send(dataToSend);
			
			if(typeof xmlHttp.responseText == 'undefined' || xmlHttp.responseText == "")
			{
				if(count > 2)
					break;
				newID = "0";      
				continue;
			}				
			break;
			
		} catch (err)
		{
			if(count > 2)
			{
				__is_valid_server_url = false;
				return;
			}
			
			newID = "0";
			continue;
		
		}
	}
	var respTxt = "";
	try {
		var resp = JSON.parse(xmlHttp.responseText);
	} catch (err)
	{
		console.log("Exception : " + err.message + "\n" + xmlHttp.responseText);			
	} 
	if (respTxt == '' && typeof resp == "object")
	{
		if (typeof resp.status == 'undefined')
		{
			console.log("Unknown response from the server");
		} 
		else
		{
			if (resp.status == "error")
			{
				console.log("Error : " + resp.ERROR);
			} 
			else if (resp.status == "success")
			{
				respTxt = "Status : Success <br>";
				if (typeof resp.RESULT != 'undefined')
					respTxt += "Result : " + resp.RESULT;
			//	console.log(respTxt);
				return resp;
			} 
			else
			{
				console.log("Status = " + resp.status);
			}
		}
	}
	
	return null;
}

function getServerURL()
{
	var url = getLocation();
	var index = url.lastIndexOf("/");
	url = url.slice(0,index) + "/" + "mobile_debug_server.cfm";
	return url;
}

function getDummyError(){
    try { 
		throw Error('');
	} catch(err) 
	{ 
		return err; 
	}
}

function getRawStackTrace()
{
	var stack = [];
	try{
		throw new Error("dummy");
	} catch (err)
	{
		stack = err.stack.split("\n");
	}
	
	//var stack = (new Error).stack.split("\n");
	var startIndex = -1;
	for (var i = 0; i < stack.length; i++)
	{
		var index = stack[i].indexOf(__this_script_name);
		if (index > 0)
		{
			startIndex = i;
			break;
		}
	}
	
	if (startIndex < 0)
		return null;

	return stack.slice(startIndex);	
}

function _trimStr(str)
{
	return str.replace(/^\s+|\s+$/g,'');
}

function parseStackTraceLine (stackTraceLine)
{
	var index = stackTraceLine.indexOf("at");
	stackTraceLine = _trimStr(stackTraceLine.slice(index+2));
	//check if it contains function name
	index = stackTraceLine.indexOf("(");
	var functionName = null;
	if (index > 0)
	{
		functionName = _trimStr(stackTraceLine.slice(0,index));
		stackTraceLine = stackTraceLine.slice(index+1);
	}
	index = stackTraceLine.lastIndexOf(":");
	index = stackTraceLine.lastIndexOf(":", index-1);
	var path = stackTraceLine.slice(0,index);
	var index1 = stackTraceLine.indexOf(":", index+1);
	var lineNum = stackTraceLine.slice(index+1, index1);
	
	return {"path":path, "lineNum":lineNum, "functionName": functionName };
}

function getLineNumAndPath()
{
	var stack = getRawStackTrace();
	if (stack == null)
		return null;
	
	var lineNum, path;
	for (var i = 0; i < stack.length; i++)
	{
		if (stack[i].indexOf(__this_script_name) > 0)
			continue;
		return parseStackTraceLine(stack[i]);
	}
	
	return null;	
}

function trimUrl(bpUrl) 
{
	var index = 0;

	if (bpUrl.indexOf("http://") >= 0)
	{
		index = bpUrl.indexOf("/", 7);
		bpUrl = bpUrl.slice(index+1); 
	} 
	else if (bpUrl.indexOf("file:///") >= 0)
	{
		bpUrl = bpUrl.slice(8);	
	}
	
	return bpUrl;
}

function loadJSFile (scriptPath, callbackFunc){
    var newElm = document.createElement("script");
    newElm.setAttribute("type", "text/javascript");
    newElm.setAttribute("src", scriptPath);
    if (callbackFunc) {
        newElm.onload = callbackFunc;
        newElm.onreadystatechange = function(){
            if (this.readyState == 'complete') {
                callbackFunc();
            }
        }
    }
    document.getElementsByTagName("head")[0].appendChild(newElm);
}