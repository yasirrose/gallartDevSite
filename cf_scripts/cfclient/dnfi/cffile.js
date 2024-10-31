/*************************************************************************
*
* ADOBE CONFIDENTIAL

* ___________________
*
*  Copyright 2013 Adobe Systems Incorporated
*  All Rights Reserved.
*
* NOTICE:  All information contained herein is, and remains
* the property of Adobe Systems Incorporated and its suppliers,
* if any.  The intellectual and technical concepts contained
* herein are proprietary to Adobe Systems Incorporated and its
* suppliers and may be covered by U.S. and Foreign Patents,
* patents in process, and are protected by trade secret or copyright law.
* Dissemination of this information or reproduction of this material
* is strictly forbidden unless prior written permission is obtained
* from Adobe Systems Incorporated.
**************************************************************************/

/**
 * @author P.N. Anantharaman (ananth@adobe.com)
 * this is a wrapper that invokes the underlying DNFI layer classes
 * in order to distinguish DNFI class names with the class names in the wrapper, we prepend the class name with W
 * thus, WFile would invoke Camera class from DNFI layer. It is the job of the code generator from CF server to convert File() from 
 * the code embedded in Cfclient to WFile
 * 5 Aug 2012
 */ 

/*
 * Class: WFileManager
 * Methods:
 */
	var WFileManager = function(context) 
	{
		if(typeof File != "undefined" && typeof FileTransfer != "undefined")
		{
		var self = this;		
		this.successObject = new DnfiStatus('WFileManager', dnfi.SUCCESS.code, dnfi.SUCCESS.message);
		
		// the var statements below define the properties of the object
		this.fileSystem = null; //this variable holds the current file system in use
		this.persistentFileSystem = null; 
		this.tempFileSystem = null;
		
		this.FILE_NOT_FOUND_ERR = FileTransferError.FILE_NOT_FOUND_ERR;
		this.INVALID_URL_ERR = FileTransferError.INVALID_URL_ERR;
		this.CONNECTION_ERR = FileTransferError.CONNECTION_ERR;
		this.ABORT_ERR = FileTransferError.ABORT_ERR;

		this.currentWorkingDirEntryObject = null; //directory entry for the current working directory
		
		this.source = {
			type: null,
			provider: 'local',
			url: null,
			path: null,
			name: null,
			auth: {}
		};
		
		this.destination = {
			type: 'local',
			provider: '',
			url: '',
			path: null,
			name: null,
			auth: {}
		};
		
	var _validateEntry = function(context, path, type)
	{
		if(typeof path == "string")
		{
			if(path != null && trim(path) != "")
				return true;
			else
				runCallBacks(context.cb, new DnfiStatus('wFileManager', wFileManagerError.FILE_INVALID_NAME_ERROR.code, 
															wFileManagerError.FILE_INVALID_NAME_ERROR.message), null);
			return false;
		}
		
		if(type == "dir" && path.isDirectory)
			return true;
		else if(type == "file" && path.isFile)
			return true;
		else if(type == "both" &&(typeof path.isFile != "undefined"))
			return true;
			
		runCallBacks(context.cb, new DnfiStatus('wFileManager', wFileManagerError.FILE_TYPE_MISMATCH_ERROR.code, wFileManagerError.FILE_TYPE_MISMATCH_ERROR.message), null);
		
		return false;
	}
		
	var syncFileEntry = function(entry)
	{
		if(entry != null)
		{
			entry.isfile = entry.isFile;
			entry.isdirectory = entry.isDirectory;
			entry.fullpath = entry.fullPath;
		}
	}
	
	var syncDirectoryEntry = function(entry)
	{
		if(entry != null)
		{
			entry.isfile = entry.isFile;
			entry.isdirectory = entry.isDirectory;
			entry.fullpath = entry.fullPath;
		}
	}
	
	var handleError = function(context,e,retVal)
	{
		var dnfiError = null;
			
		if (e.code == FileError.NOT_FOUND_ERR) 
			dnfiError = new DnfiStatus('wFileManager', wFileManagerError.FILE_NOT_FOUND_ERROR.code, wFileManagerError.FILE_NOT_FOUND_ERROR.message);
		else if(e.code == FileError.SECURITY_ERR) 
			dnfiError = new DnfiStatus('wFileManager', wFileManagerError.SECURITY_ERROR.code, wFileManagerError.SECURITY_ERROR.message);
		else if(e.code == FileError.ABORT_ERR || e.code == FileError.INVALID_MODIFICATION_ERR) 
			dnfiError = new DnfiStatus('wFileManager', wFileManagerError.ABORT_ERROR.code, wFileManagerError.ABORT_ERROR.message);
		else if(e.code == FileError.NOT_READABLE_ERR) 
			dnfiError = new DnfiStatus('wFileManager', wFileManagerError.FILE_READ_ERROR.code, wFileManagerError.FILE_READ_ERROR.message);
		else if(e.code == FileError.ENCODING_ERR) 
			dnfiError = new DnfiStatus('wFileManager', wFileManagerError.FILE_ENCODING_ERROR.code, wFileManagerError.FILE_ENCODING_ERROR.message);
		else if(e.code == FileError.NO_MODIFICATION_ALLOWED_ERR) 
			dnfiError = new DnfiStatus('wFileManager', wFileManagerError.FILE_MODIFICATION_NOT_ALLOWED_ERROR.code, wFileManagerError.FILE_MODIFICATION_NOT_ALLOWED_ERROR.message);
		else if(e.code == FileError.INVALID_STATE_ERR) 
			dnfiError = new DnfiStatus('wFileManager', wFileManagerError.FILE_STATE_ERROR.code, wFileManagerError.FILE_STATE_ERROR.message);
		else if(e.code == FileError.SYNTAX_ERR) 
			dnfiError = new DnfiStatus('wFileManager', wFileManagerError.FILE_SYNTAX_ERROR.code, wFileManagerError.FILE_SYNTAX_ERROR.message);		
		else if(e.code == FileError.QUOTA_EXCEEDED_ERR) 
			dnfiError = new DnfiStatus('wFileManager', wFileManagerError.FILE_QUOTA_ERROR.code, wFileManagerError.FILE_QUOTA_ERROR.message);
		else if(e.code == FileError.TYPE_MISMATCH_ERR) 
			dnfiError = new DnfiStatus('wFileManager', wFileManagerError.FILE_TYPE_MISMATCH_ERROR.code, wFileManagerError.FILE_TYPE_MISMATCH_ERROR.message);
		else if(e.code == FileError.PATH_EXISTS_ERR) 
			dnfiError = new DnfiStatus('wFileManager', wFileManagerError.FILE_EXISTS_ERROR.code, wFileManagerError.FILE_EXISTS_ERROR.message);		
		
		if(dnfiError == null)
			dnfiError = new DnfiStatus('wFileManager', wFileManagerError.GENERAL_ERROR.code, 
							wFileManagerError.GENERAL_ERROR.message);
		runCallBacks(context.cb, dnfiError, retVal);
	}
	
	var getFilePathFromURL = function(str)
	{
		var tempStr = str;
		var strA;
		if (str.indexOf("file://localhost") == 0) //for ios
			strA = str.split("file://localhost");
		else 
			strA = str.split("file://");
		if (strA.length > 1) 
			tempStr = strA[1];
		
		return tempStr;
	}
	
	var sortEntries = function(list,sortorder)
	{
		if(list instanceof Array)
		{
			function sortControl()
			{
				this.col;
				this.sortType;
			}
			var controller = [];
			if(typeof sortorder != "undefined")
			{
				var tokens = sortorder.split(",");
				var rowIndex = 0;
				for(token in tokens)
				{
					
					var singleColumn = tokens[token].split(" ");
					if (singleColumn.length == 2) 
					{
						var obj = new sortControl();
						obj.col = singleColumn[0];
						obj.sortType = singleColumn[1];
						controller[rowIndex] = obj;
					}		
					
				}
			}
			else
			{
				var obj = new sortControl();
				obj.col = "name";
				obj.sortType = "asc";
				controller[0] = obj;
			}
			
		if(controller.length > 0)
		{
			var column = controller[0].col;
			var sortType= controller[0].sortType;
			
			list.sort(function(a, b)
			{
				
				var val1 = a.name + "";
				var val2 = b.name + "";
				
								
				if(column.toLowerCase() == "datemodified")
				{
					
					if(typeof a.modificationTime != null && typeof b.modificationTime != null)
					{
						//compare only when you have valid time
						var val1 = a.modificationTime.getTime() ;
						var val2 = b.modificationTime.getTime();
						
						if(val1 > val2)
							return 1;
						else if(val1 < val2)
							return -1;
					}
					
					return 0;
				}
				return val1.localeCompare(val2);
			});
			
			if(sortType.toLowerCase() == "desc")
				list.reverse();
		}		
		
	}
	}
		
	var gettempfileName = function(context) {
		var str =  self.tempFileSystem.root.fullPath + "/" +  new Date().getTime();
		var strA = str.split("file://");
		if (strA.length > 1) 
			str = strA[1];
		
        if (!context)
            return str;
        else
        	runCallBacks(context.cb, self.successObject, str);
	}
	
	var getdirectoryname = function (fn)
	{
		//example: fname, /fname, /d/fname
		
		var arr = fn.split("/");
		if (arr.length == 0) return null;
		if (arr.length == 1) return ("root");
		if (arr.length > 1)	return arr[arr.length - 2];
	}
	
	/* returns resolved path based on given path is absolute or relative */
	var getResolvedPath = function(path)
	{
		if(typeof path == "string")
		{
			var resolvedPath = path;
			if (path != null && typeof path == 'string')
			{
				var workDir = self.currentWorkingDirEntryObject.fullPath;
				var workDirRelative = "";
					
				if(workDir.indexOf(self.fileSystem.root.fullPath) == 0)
				{
					workDir = workDir.substring(self.fileSystem.root.fullPath.length);
				}
				
				if(workDir.length > 0 && workDir[0] == "/")
					workDirRelative = workDir.substring(1);
					 
				resolvedPath = getFilePathFromURL(path);	
								
				if (resolvedPath[0] != '/') //relative path
				{
					//resolved path w.r.t working directory						 
					if(workDirRelative.length > 0 && workDirRelative[workDirRelative.length - 1] != "/")
						resolvedPath = workDirRelative + "/" + resolvedPath;	
					else
						resolvedPath = workDirRelative + resolvedPath;	
				}
				else
				{
					if(resolvedPath.length > 1 && resolvedPath[0] == "/" && resolvedPath[1] == "/")
						resolvedPath = resolvedPath.substring(1);
						
					if(resolvedPath.indexOf(self.fileSystem.root.fullPath) == 0)
					{
						resolvedPath = resolvedPath.substring(self.fileSystem.root.fullPath.length);
					}
				}
				
			}
			
			if(resolvedPath.length > 0 && resolvedPath[0] == "/")
					resolvedPath = resolvedPath.substring(1);
			
			return resolvedPath;
		}
		else if(typeof path.isFile != "undefined")
			return getResolvedPath(path.toURL());
		
	}
	
	var getResolvedURI = function(path)
	{
		if(typeof path == "string")
		{
			var resolvedPath = path;

			if(path.indexOf("://") == -1)
			{
			
			
			if (__cfclient_os != undefined && __cfclient_os != null)
			{
				if (__cfclient_os.toLowerCase() == "ios" && (resolvedPath.indexOf("file://localhost") != 0 && resolvedPath.indexOf("file://") != 0 )) //for ios
					resolvedPath = "file://localhost" + appendSlash(convertToAbsolutePath(resolvedPath));
				else if(resolvedPath.indexOf("file://") != 0 && resolvedPath.indexOf("file://localhost") != 0)
					resolvedPath = "file://" + appendSlash(convertToAbsolutePath(resolvedPath));
			}
			else
				resolvedPath = convertToAbsolutePath(resolvedPath);
			
				
			function convertToAbsolutePath(p)
			{
				if (p != null && typeof p == 'string')
				{								
					if (p[0] != '/') //relative path
						return self.getWorkingDirectory() + "/" + p;	//resolved path w.r.t working directory				
				}
				
				return p;
			}
			function appendSlash(p)
			{
				if(p.length > 0)
				{
					if(p.charAt(0) != "/")
						return "/" + p;
					else
						return p;
				}
				
				return "/";
			}
			}
			
			return resolvedPath;
		}
		else if(typeof path.isFile != "undefined") //check for FileEntry or DirectoryEntry object
			return path.toURL();
	}
	
	var getFileEntryForPath = function(path, callback, getDir)
	{
		function onResolveSuccess(entry)
		{
			var args = [1,entry];//return success 1 and file/dir entry
			callback.apply(callback,args);
		}
		function fail(event)
		{				
			var args = [0,event];//return failure 0 and error
			callback.apply(callback, args);
		}
		//need to make sure fileName isin URI format eg. file:// or file://localhost
		if(typeof path == "string")
		{
			if(path.indexOf("://") != -1) // fileName in URL format
			{
				window.resolveLocalFileSystemURI(path, onResolveSuccess, fail);
			}
			else
			{
				flags = {create: false};
				
				var resolvedPath = getResolvedPath(path);				
				if(!getDir)									
					self.fileSystem.root.getFile(resolvedPath, flags, onResolveSuccess, fail);
				else
					self.fileSystem.root.getDirectory(resolvedPath, flags, onResolveSuccess, fail);
			}
		}
		else if(typeof path.isFile != "undefined") //check for FileEntry or DirectoryEntry object
			onResolveSuccess(path);
		
	}
				
	var open = function(context, fileName, mode, data, throwErrorIfExists)
	{
		var flags = {};
		
		if (self.fileSystem != null)
		{
			if(_validateEntry(context,fileName,"file"))
			{
				function _append(entry)
				{
					var append = false;
					if(mode == 'append')
					
						append = true;

					entry.createWriter(function(writer)
					{
						writer.onwriteend = function(evt)
						{
							__$cf._log("file write completed");
							runCallBacks(context.cb, self.successObject, null);
						} //this.fileWriteEnd;
						if (data != null)
						{
							if(append)
								writer.seek(writer.length);
								
							writer.write(data);
						}
						else
						{
							runCallBacks(context.cb, self.successObject, null);
						}
					}, function (e) {
							handleError(context,e,null);
							return;
					});
					
				}
				
				function _process(entry)
				{
					if(mode == "get")
					{						
						runCallBacks(context.cb, self.successObject, entry);
						return;	
					}
					else if(mode == "create")
					{
						__$cf._log("created file " +entry.fullPath);
						runCallBacks(context.cb, self.successObject, entry.fullPath);
						return;	
					}											
					else if ((mode == 'write') || (mode == 'createandwrite') || (mode == 'append')) 
					{
						
						_append(entry);						
						return;
					}
				}
			
			if(typeof fileName == "string")
			{
				name = getResolvedPath(fileName);
				
				if(typeof throwErrorIfExists == "undefined")
					throwErrorIfExists = false;
					
				if ((mode == 'create') || (mode == 'createandwrite'))					
					flags = {create: true, exclusive: throwErrorIfExists};
				else				 
					flags = {create: false};
					
				
				self.fileSystem.root.getFile(name, flags, function (entry) 
				{
					__$cf._log("File entry found for "+name);
					_process(entry);
				}
				, function (e) 
				{
					__$cf._log("File operation error "+e.code);
					handleError(context,e,null);			
				});
				
				
			}
			else
			{
				_process(fileName);
			}
									
			
			}
		}
	}  
	
	/* **************************************************************************************************************************************
 * moveTo - moves the file from the src to dest
 * Usage example: moveTo(context, "/sdcard/abc", "/sdcard/ananth/abc")
 * inputs:
 * 		context - context variable that holds the callback and return value
 * 		src		- source object (can be a string or object)
 * 		dest	- destination object (can be a string or object)
 * 		copy	- if copy is true do the file copy otherwise just move it to the new location
 * 		1. Get the fileEntry corresponding to the source object
 * 		2. Get the parent directory name as a string
 * 		3. Create the name to a directory entry 
 * 		4. Use the phonegap's moveTo method to move the file to destination
 * Key questions to be addressed in spec
 * 		1. what happens if the path specified in destination directory didnt exist? Should we create it?
  ***************************************************************************************************************************************/		
		var moveOrCopy = function (context, src, dest, copy)
		{
			//TODO: Need to implement this function for src and dest as general objects than strings
			var parent = null;
			var fileName = null;
			if (self.fileSystem != null) {
				
			if(_validateEntry(context,src,"file"))
			{				
				fileName = getResolvedPath(dest);
				
				var dPath = getdirectorypath(fileName);
				if(dPath == null)
					dPath = self.currentWorkingDirEntryObject.fullPath;				
				
				var srcEntry = null;
				var destEntry = null; //self.fileEntryObject;
				
				//get the file entry for the destination
				getFileEntryForPath(dPath,function(status, parentEntry)
				{
					if(status == 1)
					{
						//get the file entry of the src
					getFileEntryForPath(src,function(status, retVal) 
					{
				
						if (status == 1)
						{
							if(retVal instanceof FileEntry)					
							{
							var fileEntry = retVal;

							var name1 =  fileName.substring(fileName.lastIndexOf('/')+1);
														
							var func = null;
							
							if (copy)
							{
								fileEntry.copyTo(parentEntry, name1, function (entry) {
									__$cf._log("File successfully moved/copied to: " + entry.fullPath);
									runCallBacks(context.cb, self.successObject, entry); 
								}, function (e) {
									//need to process the error that occured during file rename
									__$cf._log("Error while trying to copy file - code = " + e.code);
									handleError(context,e,null); 								
								});
							}
							else
							{
								fileEntry.moveTo(parentEntry, name1, function (entry) {
									__$cf._log("File successfully moved/copied to: " + entry.fullPath);
									runCallBacks(context.cb, self.successObject, entry); 
								}, function (e) {
									//need to process the error that occured during file rename
									__$cf._log("Error while trying to rename file - code = " + e.code);
									handleError(context,e,null); 								
								});
							}
							
							}//
							else
								runCallBacks(context.cb, new DnfiStatus('wFileManager', wFileManagerError.FILE_TYPE_MISMATCH_ERROR.code, wFileManagerError.FILE_TYPE_MISMATCH_ERROR.message), null);
							
						} //open for getting src entry
						else //open failed
						{
							__$cf._log("error: " + retVal.code + " message: " + retVal.message);
							handleError(context,retVal,null);
							return;							
						}
					});
					}
					else
					{
						handleError(context,parentEntry,null);
						return;
					}
					
				},true);
				
				}														
			}			
			else //if fileSystem is null return error
			{
				runCallBacks(context.cb, new DnfiStatus('WFileManager', WFileManager.NULL_FILESYSTEM_ERROR.code, WFileManager.NULL_FILESYSTEM_ERROR.message), null);
				return;
			}			
		}
		
		/* **************************************************************************************************************************************
 * moveOrCopyDirectory - moves or copies the dir from the src to dest
 * Usage example: moveOrCopyDirectory(context, "/sdcard/abc", "/sdcard/ananth/abc", false)
 * inputs:
 * 		context - context variable that holds the callback and return value
 * 		src		- source object (can be a string or object)
 * 		dest	- destination object (can be a string or object)
 * 		copy	- if copy is true do the file copy otherwise just move it to the new location
 * 		1. Get the DirectoryEntry corresponding to the source object
 * 		2. Get the DirectoryEntry corresponding to the destination object
 * 		3. Use the phonegap's moveTo or copyTo method to move the directory to destination
 * Key questions to be addressed in spec
 * 		1. what happens if the path specified in destination directory didnt exist? Should we create it?
  ***************************************************************************************************************************************/		
		var moveOrCopyDirectory = function (context, source, destination, copy, ren)
		{
			var newName = null;
			
			var parent = null;
			var dirName = null;
			
			if (self.fileSystem != null) 
			{
				if(_validateEntry(context,source,"dir") && _validateEntry(context,destination,"dir"))
				{
				var src = getResolvedPath(source);
				var dest = getResolvedPath(destination);
				
				if (typeof dest == 'string') 
				{
					dirName = dest;
					if (ren) 
					{
						dirName = getdirectorypath(dest);
						newName = dest.substring(dest.lastIndexOf('/') + 1);
					}
				}
				
				//get the dir entry for the destination - it is an error if it doesn't exist
				self.getDirectory({cb:[function(e, entry) {
					if (e.code == dnfi.SUCCESS.code)
					{
						__$cf._log("Destination directory found, fullPath:" + entry.fullPath);
						//TODO: lookup for the src directory 				
						if (typeof src == 'string')
						{
							//get the dir entry of the src
							self.getDirectory({cb: [function(e, srcEntry) 
							{
								__$cf._log("Found source directory");
														
								if (e.code == dnfi.SUCCESS.code)
								//if(e.code == 0)
								{																
									var func = null;							
									if (copy)
									{
										srcEntry.copyTo(entry, null, function (entry) {
											__$cf._log("Directory successfully copied to: " + entry.fullPath);
											runCallBacks(context.cb, self.successObject, entry); 
										}, function (e) {
											//need to process the error that occured during file rename
											__$cf._log("Error while copying the directory - code = " + e.code);
											handleError(context,e,null);  								
										});
									} // end for copy
									else
									{  //do the dir move
										srcEntry.moveTo(entry, newName, function (entry) {
											__$cf._log("Directory successfully moved to: " + entry.fullPath);
											runCallBacks(context.cb, self.successObject, entry); 
										}, function (e) {
											//need to process the error that occured during dir move
											__$cf._log("Error while trying to move directory - code = " + e.code);
											handleError(context,e,null); 								
										});
									} // enf of dir move
							
						} // lookup for getting src entry
						else // lookup failed
						{
							__$cf._log("error: " + e.code + " message: " + e.message);
							runCallBacks(context.cb, e, null);
							return;							
						}
					}], ret:'ret'}, src); 
				}
				else //src is an object not a simple string
				{
					
				}
						return;	
				}
				else
				{
					runCallBacks(context.cb, e, null);																					
				}			
				}], ret:"ret"}, dirName); 
				
				}			
				
			}			
			else //if fileSystem is null return error
			{
				runCallBacks(context.cb, new DnfiStatus('WFileManager', WFileManager.NULL_FILESYSTEM_ERROR.code, WFileManager.NULL_FILESYSTEM_ERROR.message), null);
				return;
			}			
		}
		
/* *******************************************************************************************************************
		setfilesystem(context, fsName) - sets the file system to the specified value - either PERSISTENT or TEMPORARY
******************************************************************************************************************** */
		this.setFileSystem = function(context, fsName)
		{
			if(_validateDeviceAPI(context, arguments.length-1, 1, "setFileSystem"))
			{
			var t = null;
			
			if (typeof fsName != "undefined" && fsName != null) 
			{
				switch (fsName.toLowerCase())
				{
					case "persistent":
					{
						if (self.persistentFileSystem != null) 
						{
							self.fileSystem = self.persistentFileSystem;
							self.currentWorkingDirEntryObject = self.persistentFileSystem.root;
							runCallBacks(context.cb, self.successObject, self.fileSystem);
							return;
						}
						
						t = LocalFileSystem.PERSISTENT;	
						break;
					}
					case "temporary":
					{
						if (self.tempFileSystem != null)
						{							
							self.fileSystem = self.tempFileSystem;
							self.currentWorkingDirEntryObject = self.tempFileSystem.root;
							runCallBacks(context.cb, self.successObject, self.fileSystem);				
							return;
						}
						t = LocalFileSystem.TEMPORARY;
						break;
						
					}
					default:
					{
						__$cf._log("invalid file system");
						runCallBacks(context.cb, new DnfiStatus('wFileManager', wFileManagerError.INVALID_FILESYSTEM_ERROR.code, 
									wFileManagerError.INVALID_FILESYSTEM_ERROR.message), null);
						return;
					}
				}
				
				window.requestFileSystem(t, 0, function(fs) 
				{					
					self.fileSystem = fs; 

					__$cf._log("valid file system obtained");
				
					if (t == LocalFileSystem.PERSISTENT) 
						self.persistentFileSystem = fs;
					else if (t == LocalFileSystem.TEMPORARY) 
						self.tempFileSystem = fs;
				
					self.currentWorkingDirEntryObject = fs.root;				
					runCallBacks(context.cb, self.successObject, fs);				
				return;				
				}, 
				function(error)
				{
					runCallBacks(context.cb, new DnfiStatus('wFileManager', wFileManagerError.FILESYSTEM_SET_ERROR.code, 
									wFileManagerError.FILESYSTEM_SET_ERROR.message + " "+ error.code), null);
				});	
				return;	
			}
		}
		}

 
		this.write = function(context, name, data) 
		{	
			if(_validateDeviceAPI(context, arguments.length-1, 1, "write"))
			{
				var myself = this;

				if(_validateEntry(context,name,"file"))					
					open(context, name, 'createandwrite', data);
				
			}
			
		} //write method
		
		this.append = function(context, name, data) 
		{
			if(_validateDeviceAPI(context, arguments.length-1, 2, "append"))
			{			
				
					if(_validateEntry(context,name,"file"))
					{
									
							open(context, name, 'append', data);
					}
					else
					{
						runCallBacks(context.cb, new DnfiStatus('wFileManager', wFileManagerError.FILE_INVALID_NAME_ERROR.code, 
															wFileManagerError.FILE_INVALID_NAME_ERROR.message), null);
					}
				
			}
			
		} //write method
		
		
		var _read = function(context, name, mode)
		{
			getFileEntryForPath(name,function(status,ret)
			{
				if(status === 1)
				{
					if(ret instanceof FileEntry)
					{
						ret.file(function(f)
						{
							var reader1 = new FileReader();
							reader1.onloadend = function(evt)
							{
								runCallBacks(context.cb, self.successObject, evt.target.result);
							} //onload function for reader;
							if (mode == 'readdataurl')
							{
								reader1.readAsDataURL(f); //read the file as base64 data
							}
							else
							{
								reader1.readAsText(f); //read the file as text
							}
							},
							function (e) 
							{
								handleError(context,e,null);
						});
					
					}					
					else
						runCallBacks(context.cb, new DnfiStatus('wFileManager', wFileManagerError.FILE_TYPE_MISMATCH_ERROR.code, wFileManagerError.FILE_TYPE_MISMATCH_ERROR.message), null);
					
				}
				else
				{
					__$cf._log("read error " + ret);
					handleError(context,ret,null);
				}
			});
		}
		
		this.read = function(context, name) 
		{	
			if(_validateDeviceAPI(context, arguments.length-1, 1, "read"))
			{	
				/*
				 * Step 2 - set up the parameters required 
				 */
				 this.ret; //variable to hold return value from sequencer
				 var readObj = this;
	
				if (name != null) // we need first to open the file and then do the writing
				{		
					//open(context, name, 'read');
					_read(context,name,'read');
					
				}
			}
			
		} //read method
		
		//the method readDataURL is similar to read but reads the data in binary form
		this.readAsBase64 = function(context, name) 
		{
			if(_validateDeviceAPI(context, arguments.length-1, 1, "readAsBase64"))
			{			
				/*
				 * Step 2 - set up the parameters required 
				 */
				if (name != null) // we need first to open the file and then do the writing
				{				
					//open(context, name, 'readdataurl');
					_read(context,name,'readdataurl');
				}
			}
			
		} //read method
		
/* ************************************************************************************************************************************
 * getdirectoryname(fileName_with_path)
 * 
 * This function is intended to cull out the directory name in which the given file resides.
 * The file name may be a full path or a relative path 
 * NOTE: 
 * 
 * 1. For determining the directory name we search and split against a separator '/'. In systems where '/' is not the separator for directory
 * we need to rewrite this function
 * 2. Suppose just the file name (without the directory path) is specified, we need to interpret this as the file in the current working dir - we return null
 * 3. If the file name is specified like: /filename, this refers to a file under the root directory and we return 'root' 
 ****************************************************************************************************************************************/
						
/* ************************************************************************************************************************************
 * getdirectorypath(fileName_with_path)
 * 
 * This function is intended to cull out the directory full path in which the given file resides.
 * The file name may be a full path or a relative path 
 * NOTE: 
 * 
 * 1. For determining the directory name we search and split against a separator '/'. In systems where '/' is not the separator for directory
 * we need to rewrite this function
 * 2. Suppose just the file name (without the directory path) is specified, we need to interpret this as the file in the current working dir - we return null
 * 3. If the file name is specified like: /filename, this refers to a file under the root directory and we return 'root' ISSUE: what happens for a/b? 
 ****************************************************************************************************************************************/
		var getdirectorypath = function (path)
		{
			var fn = path; 
			if(typeof path != "string")
			{
				if(typeof path.isFile != "undefined")
					fn =path.fullPath;
			}
			
			var arr = fn.split("/");
			if (arr.length == 1) return null;
			if (arr.length == 2) {
				if (fn[0] == '/') return ("/");
				else return(fn.substring(0, fn.lastIndexOf('/')));
			}	
			if (arr.length > 2)	return fn.substring(0, fn.lastIndexOf('/'));
			
		}
		
		

		
/* **************************************************************************************************************************************
 * move
 */
	this.move = function(context, src, dest)
	{
		if(_validateDeviceAPI(context, arguments.length-1, 2, "move"))
		{			
			moveOrCopy({cb: [function(e, entry) {
					if (e.code == dnfi.SUCCESS.code)
					{
						runCallBacks(context.cb, self.successObject, entry); 							
					}
					else
					{
						runCallBacks(context.cb, e, null); 															
					}			
			}]}, src, dest, false);
			return;	
		}
			
	}		
/* **************************************************************************************************************************************
 * copy
 */
	this.copy = function(context, src, dest)
	{
		if(_validateDeviceAPI(context, arguments.length-1, 2, "copy"))
		{
			moveOrCopy({cb: [function(e, entry) 
			{
				if (e.code == dnfi.SUCCESS.code)
				{
					runCallBacks(context.cb, self.successObject, null); 							
				}
				else
				{
					runCallBacks(context.cb, e, null); 															
				}			
			}]}, src, dest, true);
			return;
		}
				
	}		
		
/* *****************************************************************************************************************************
 * rename(src, dest) - rename the src file to destination
 * 
 * Inputs:
 * 		src: 	Full path name of the file to be renamed
 * 		dest:	Full path name of the new name of the file
 * 		Example: rename("/sdcard/ananth/a.txt", "/sdcard/ananth/b.txt")
 * 
 * It is an error if rename is invoked with files whose parent directories are different
 * 
 * TODO: Explore later whether we should support the concept of current working directory and allow renames like: rename(a.txt, b.txt) on current directory
 * 
 ******************************************************************************************************************************/				
		this.rename = function(context, source, destination)
		{
			if(_validateDeviceAPI(context, arguments.length-1, 2, "rename"))
			{
				if(_validateEntry(context,source,"file"))
				{
				var src = getResolvedPath(source);
				var dest = getResolvedPath(destination);
				
				var srcDir = getdirectorypath(src);
				var destDir = getdirectorypath(dest);
				if (srcDir == destDir)
				{					
					self.move({
						cb: [function(e, entry){
							if (e.code == dnfi.SUCCESS.code)
							{
								runCallBacks(context.cb, self.successObject, entry); 							
							}
							else
							{
								runCallBacks(context.cb, e, null); 															
							}
						}], ret:"ret"
					}, src, dest);
					return;
				}
				else
				{
					runCallBacks(context.cb, new DnfiStatus('wFileManager', wFileManagerError.SOURCE_DESTINATION_SAME_PATH_ERROR.code, wFileManagerError.SOURCE_DESTINATION_SAME_PATH_ERROR.message), null);
					return; 																			
				}
				}
			}
		}
		
/* ***********************************************************************************************************************************
 * 	remove(fileName) - deletes the file
 * 		
 *************************************************************************************************************************************/
	this.remove = function(context, fileName)
	{
		if(_validateDeviceAPI(context, arguments.length-1, 1, "remove"))
		{
			
			if(_validateEntry(context,fileName,"file"))
			{			
			getFileEntryForPath(fileName, function(status, ret)
			{
				if(status == 1)
				{
					if(ret instanceof FileEntry)
					{
					function success(entry) {
						__$cf._log("File removed successfully");
						runCallBacks(context.cb, self.successObject, true); 
						}
						
						function fail(error) {
							handleError(context,error,null);
						}
					ret.remove(success,fail);
					}					
					else
						runCallBacks(context.cb, new DnfiStatus('wFileManager', wFileManagerError.FILE_TYPE_MISMATCH_ERROR.code, wFileManagerError.FILE_TYPE_MISMATCH_ERROR.message), null);
				}
				else
					handleError(context,ret,null);
			//open(context,fileName,"delete");
			});
			}
		}
	}
/* ***********************************************************************************************************************************
 * 	getParent - gets the parent directory entry of the file
 * 		
 *************************************************************************************************************************************/
	this.getParent = function(context, fileName)
	{
		if(_validateDeviceAPI(context, arguments.length-1, 1, "getParent"))
		{
			if(_validateEntry(context,fileName,"both"))
			{
			getFileEntryForPath(fileName, function(status, ret)
			{
				if(status == 1)
				{
					ret.getParent(function(entry) 
					{					
						//syncDirectoryEntry(entry);
						runCallBacks(context.cb, self.successObject, entry);																	
					}, function (e) {
						handleError(context, e,null); 																							
					});
				}
				else
					handleError(context,ret,null);
			});		
			return;	
			}	
		}
	}
/* ***********************************************************************************************************************************
 * 	toURI - gets the parent directory entry of the file
 * 		
 *************************************************************************************************************************************/
	this.toURI = function(context, fileName)
	{
		if(_validateDeviceAPI(context, arguments.length-1, 1, "toURI"))
		{
			if(_validateEntry(context,fileName,"both"))
			{
				getFileEntryForPath(fileName, function(status, ret)
				{
					if(status == 1)
					{
						runCallBacks(context.cb, self.successObject, ret.toURL());
					}
					else
						handleError(context,ret,null);
				});	
			}		
		}
	}
	
 /* ********************************************************************************************************************************
 * 		exists - check whether a given file or directory exists
 * 
 *************************************************************************************************************************************/
	this.exists = function(context, name)
	{
		
		if(_validateDeviceAPI(context, arguments.length-1, 1, "exists"))
		{
			if(_validateEntry(context,name,"file"))
			{
				//process here for local file system
				if(self.fileSystem != null)
				{
					var fileName = name;
					if(typeof name.fullPath == "string")
						fileName = name.fullPath;
						
					getFileEntryForPath(fileName, function(status, ret)
					{
						if(status == 1)
						{
							if(ret instanceof FileEntry)
							{
								runCallBacks(context.cb,self.successObject,true);
							}
							else
								runCallBacks(context.cb, new DnfiStatus('wFileManager', wFileManagerError.FILE_TYPE_MISMATCH_ERROR.code, wFileManagerError.FILE_TYPE_MISMATCH_ERROR.message), null);
						}
						else
						{
							__$cf._log("File operation error "+ret.code);				    
							runCallBacks(context.cb,self.successObject,false);
						}
					});
				}	
			}
		}			
	}
	
	this.directoryExists = function(context, dPath)
	{
		if(_validateDeviceAPI(context, arguments.length-1, 1, "directoryExists"))
		{
			if(_validateEntry(context,dPath,"dir"))
			{
				//process here for local file system
				if(self.fileSystem != null)
				{
					var fileName = dPath;
					if(typeof dPath.fullPath == "string")
						fileName = dPath.fullPath;
						
					getFileEntryForPath(fileName, function(status, ret)
					{
						if(status == 1)
						{
							if(ret instanceof DirectoryEntry)
								runCallBacks(context.cb,self.successObject,true);
							else
								runCallBacks(context.cb, new DnfiStatus('wFileManager', wFileManagerError.FILE_TYPE_MISMATCH_ERROR.code, wFileManagerError.FILE_TYPE_MISMATCH_ERROR.message), null);
							
						}
						else
						{
							__$cf._log("Directory operation error "+ret.code);				    
							runCallBacks(context.cb,self.successObject,false);
						}
					},true);				
				}	
			}
		}					
	}		
/* ++++++++++++++++++++++++++++++++++++++ Directory related functions ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
 
	this.getWorkingDirectory = function(context)
	{	
		
		var str = self.currentWorkingDirEntryObject.fullPath;
		str = getFilePathFromURL(str);
		if(!context)
			return str;
		runCallBacks(context.cb, self.successObject, str);
		
	}

/* ********************************************************************************************************************************
 * 		setCurrentWorkingDirectory - creates a directory entry for the current working directory and sets it in the global variable
 * 		dirPath - absolute path or relative
 * 		TODO: need to run tests for dirpath values: /a/b/c, /a, a, where some or all of the directory components exist
 *************************************************************************************************************************************/
	this.setWorkingDirectory = function(context, dPath)
	{
		if(_validateDeviceAPI(context, arguments.length-1, 1, "setWorkingDirectory"))
		{
			if(_validateEntry(context,dPath,"dir"))
			{
				var dirPath = getResolvedPath(dPath);
				
				var dEntry = self.getDirectory({cb:[function(e, entry) {
					if (e.code == dnfi.SUCCESS.code)
					{
						__$cf._log("Successfully set working directory to:" + entry.fullPath);
						self.currentWorkingDirEntryObject = entry;	
						runCallBacks(context.cb, self.successObject, null);																	
					}
					else
					{
						runCallBacks(context.cb, new DnfiStatus('wFileManager', wFileManagerError.DIRECTORY_LOOKUP_ERROR.code, wFileManagerError.DIRECTORY_LOOKUP_ERROR.message), null);																					
					}			
				}], ret:"ret"}, dirPath);
			}
		}
	}
/* ********************************************************************************************************************************
 * 		createDirectory - creates the directory on the file system given the directory entry
 * 		dirPath - absolute path or relative
 * 		throwError - boolean - true - throw error if directory already exists
 * 							   false - create if dire not present else return existing directory entry
 * 		TODO: need to run tests for dirpath values: /a/b/c, /a, a, where some or all of the directory components exist
 * 			  Also need to support creation of intermediate directory components if they don't exist
 *************************************************************************************************************************************/
	this.createDirectory = function(context, dirPath, throwError)
	{
		if(_validateDeviceAPI(context, arguments.length-1, 1, "createDirectory"))
		{
			var dEntry = null;
			var throwErr = true;
			if(throwError)
				throwErr = throwError;
			if (dirPath == null || trim(dirPath) == "") 
			{
				runCallBacks(context.cb, new DnfiStatus('wFileManager', wFileManagerError.FILE_INVALID_NAME_ERROR.code, 
								wFileManagerError.FILE_INVALID_NAME_ERROR.message), null);
			}
			
			dirPath = getFilePathFromURL(dirPath);
														
			if (typeof dirPath == 'string')
			{
				if (dirPath[0] == '/') //absolute path is specified, we will use the dirEntry: self.fileSystem.root
				{
					dEntry = self.fileSystem.root;
				}
				else
				{
					dEntry = self.currentWorkingDirEntryObject;
				}
				dEntry.getDirectory(dirPath, {create:true, exclusive:throwErr}, function (entry) 
				{
					__$cf._log("directory created: " + entry.name + "  full path: " + entry.fullPath);
					//syncDirectoryEntry(entry);
					runCallBacks(context.cb, self.successObject, entry);																	
				}, 
				function(e) 
				{
					__$cf._log("Error while creating the directory, code: " + e.code);
					handleError(context,e,null);																									
				});		
				return;
			}
			else
				runCallBacks(context.cb, new DnfiStatus('wFileManager', wFileManagerError.FILE_TYPE_MISMATCH_ERROR.code, wFileManagerError.FILE_TYPE_MISMATCH_ERROR.message), null);
			
		}
	}

/* ********************************************************************************************************************************
 * 		lookup - lookup the file on the file system
 * 		fileName - name of file for lookup
 *************************************************************************************************************************************/
	this.get = function(context, name)
	{
		if(_validateDeviceAPI(context, arguments.length-1, 1, "get"))
		{
		if(self.fileSystem != null)
		{
			var fileName = name;
			if(typeof name.fullPath == "string")
				fileName = name.fullPath;
						
			getFileEntryForPath(fileName, function(status,ret)
			{
				if(status == 1)
				{
					if(ret instanceof FileEntry)
						runCallBacks(context.cb, self.successObject, ret);
					else
						runCallBacks(context.cb, new DnfiStatus('wFileManager', wFileManagerError.FILE_TYPE_MISMATCH_ERROR.code, wFileManagerError.FILE_TYPE_MISMATCH_ERROR.message), null);
				}
				else
				{
					__$cf._log("Error getting file/directory - error code "+ret.code);
					handleError(context,ret,null);
				}
			});		
		}
		else
			runCallBacks(context.cb, new DnfiStatus('WFileManager', WFileManager.NULL_FILESYSTEM_ERROR.code, WFileManager.NULL_FILESYSTEM_ERROR.message), null);
		}
	}
	
/* ********************************************************************************************************************************
 * 		getdirectory - looks up to a given directory in the current working directory
 * 		dirPath - absolute path or relative
 * 		TODO: need to run tests for dirpath values: /a/b/c, /a, a, where some or all of the directory components exist
 *************************************************************************************************************************************/
	this.getDirectory = function(context, dPath)
	{		
		if(_validateDeviceAPI(context, arguments.length-1, 1, "getDirectory"))
		{
			if(self.fileSystem != null)
		{
			var fileName = dPath;
			if(typeof dPath.fullPath == "string")
				fileName = dPath.fullPath;
				
			getFileEntryForPath(fileName, function(status,ret)
			{
				if(status == 1)
				{
					if(ret instanceof DirectoryEntry)
						runCallBacks(context.cb, self.successObject, ret);
					else
						runCallBacks(context.cb, new DnfiStatus('wFileManager', wFileManagerError.FILE_TYPE_MISMATCH_ERROR.code, wFileManagerError.FILE_TYPE_MISMATCH_ERROR.message), null);
				}
				else
				{
					__$cf._log("Error getting file/directory - error code "+ret.code);
					handleError(context,ret,null);
				}
			},true);		
		}
		else
			runCallBacks(context.cb, new DnfiStatus('WFileManager', WFileManager.NULL_FILESYSTEM_ERROR.code, WFileManager.NULL_FILESYSTEM_ERROR.message), null);
		}		
	}
	
	this.getFileSystem = function(context)
	{
		runCallBacks(context.cb, self.successObject, self.fileSystem);
	}
/* ********************************************************************************************************************************
 * 		listDirectory - lists the contents of a given directory in the current working directory
 * 		dirPath - absolute path or relative
 * 		TODO: need to run tests for dirpath values: /a/b/c, /a, a, where some or all of the directory components exist
 *************************************************************************************************************************************/
	this.listDirectory = function(context, dirPath, sortType)
	{
		if(_validateDeviceAPI(context, arguments.length-1, 1, "listDirectory"))
		{
			var dirReader = null;
				
			/* if ((typeof dirPath != 'string') && (dirPath != null) ) 
			{
				invokeProviderAction(context, dirPath.provider, "listDirectory", dirPath.path);
				return;
			}
			
			if (dirPath == null) //list the current working directory 
			{
				dirReader = self.currentWorkingDirEntryObject.createReader();	
				dirReader.readEntries(function (entries) {
					runCallBacks(context.cb, self.successObject, entries);																					
				}, function (e) {
					handleError(context,e,null);																									
				});
			} */
			
			if(_validateEntry(context,dirPath,"dir"))			
			{
				//look up to the directory specified and then read the entries
				getFileEntryForPath(dirPath, function(status, ret) 
				{
					if (status == 1)
					{
						if(ret instanceof DirectoryEntry)
						{						
						ret.createReader().readEntries(function(entries) 
						{
							/*
							for(var i=0; i<entries.length;i++)
							{
								var entry = entries[i];
								if(entry instanceof FileEntry)
									syncFileEntry(entry);
								else if(entry instanceof DirectoryEntry)
									syncDirectoryEntry(entry);
							}
							*/
							if (typeof sortType != "undefined") 
							{
								function returnSortedEntries(entries,s)
								{
									sortEntries(entries,s);
									runCallBacks(context.cb, self.successObject, entries);
								}
								
								function getModificationDate(index)
								{
									if(index >= 0)
									{
										var tempEntry = entries[index];
										
										function success(metadata)
										{
											entries[index].modificationTime = metadata.modificationTime;
											index = index - 1;
											getModificationDate(index);
										}
										
										function error()
										{
											__$cf._log("error getting metadata for "+entries[index].name);
											entries[index].modificationTime = null;
										}
										
										tempEntry.getMetadata(success, error);
									}
									else
									{
										returnSortedEntries(entries,sortType);
									}
								}
								
								if(findNoCase("datemodified",sortType) > 0)
								{
									getModificationDate(entries.length - 1);
								}
								else
									returnSortedEntries(entries,sortType);
								
								
							}
							else
								runCallBacks(context.cb, self.successObject, entries);																					
						}, function(e) 
						{
							handleError(context,e,null);																															
						});
						return;	
						//runCallBacks(context.cb, self.successObject, entry);		
						}									
						else
							runCallBacks(context.cb, new DnfiStatus('wFileManager', wFileManagerError.FILE_TYPE_MISMATCH_ERROR.code, wFileManagerError.FILE_TYPE_MISMATCH_ERROR.message), null);						
					}
					else
					{
						handleError(context,ret,null);																					
					}			
				},true);			
			}
		}
		
	}  

/* ********************************************************************************************************************************
 * 		removeDirectory - removes the specified directory 
 * 		the directory needs to be empty for removal or we should remove recursively
 * 		dirPath - absolute path or relative, if this is null remove the CWD
 * 		TODO: need to run tests for dirpath values: /a/b/c, /a, a, where some or all of the directory components exist
 *************************************************************************************************************************************/
	this.removeDirectory = function(context, dirPath, recurse)
	{
		if(_validateDeviceAPI(context, arguments.length-1, 1, "removeDirectory"))
		{
			
		var err;
		
		var removeSuccess = function(entry) {
			__$cf._log("successfully removed directory");
			runCallBacks(context.cb, self.successObject, true);																					
		}
		
		var removeFail = function(e) {
			__$cf._log("Erro while removing directory - code: " + e.code);
			handleError(context,e,null);																											
		}
		
		var _remove = function(entry)
		{
			if (recurse == true) 
				entry.removeRecursively(removeSuccess, removeFail);
			else 
				entry.remove(removeSuccess, removeFail);	
		}
		
		if(_validateEntry(context,dirPath,"dir"))			
		{
			getFileEntryForPath(dirPath, function(status, ret)
			{
				if(status == 1)
				{
					if(ret instanceof DirectoryEntry)
						_remove(ret);
					else
						runCallBacks(context.cb, new DnfiStatus('wFileManager', wFileManagerError.FILE_TYPE_MISMATCH_ERROR.code, wFileManagerError.FILE_TYPE_MISMATCH_ERROR.message), null);
					
				}
				else
				{
					__$cf._log("Directory operation error "+ret.code);	
					handleError(context,ret,null);
				}
			},true);
			
			
		}
		
		}		
		
	}

		
/* **************************************************************************************************************************************
 * move
 */
	this.moveDirectory = function(context, src, dest, ren)
	{
		if(_validateDeviceAPI(context, arguments.length-1, 2, "moveDirectory"))
		{
			/* if ((typeof src != 'string') && (typeof dest != 'string'))
			{
				invokeProviderAction(context, src.provider, "moveDirectory", dest.path, src.path);
				return;
			}*/
			
			moveOrCopyDirectory({cb: [function(e, entry) {
					if (e.code == dnfi.SUCCESS.code)
					{
						//syncDirectoryEntry(entry);
						runCallBacks(context.cb, self.successObject, entry); 							
					}
					else
					{
						runCallBacks(context.cb, e, null); 															
					}			
			}]}, src, dest, false, ren);
			return;	
		}	
	}		
/* **************************************************************************************************************************************
 * copy
 */
	this.copyDirectory = function(context, src, dest)
	{
		if(_validateDeviceAPI(context, arguments.length-1, 2, "copyDirectory"))
		{
			/* if ((typeof src != 'string') && (typeof dest != 'string'))
			{
				invokeProviderAction(context, src.provider, "copyDirectory", dest.path, src.path);
				return;
			}*/
			
			moveOrCopyDirectory({cb: [function(e, entry) 
			{
				if (e.code == dnfi.SUCCESS.code)
				{
					runCallBacks(context.cb, self.successObject, null); 							
				}
				else
				{
					runCallBacks(context.cb, e, null); 															
				}			
			}]}, src, dest, true);
			return;	
		}	
	}
/* *****************************************************************************************************************************
 * renameDir(src, dest) - rename the src dir to destination
 * 
 * Inputs:
 * 		src: 	name of the dir to be renamed
 * 		dest:	name of the new name of the dir
 * 		Example: rename("/sdcard/ananth/a.txt", "/sdcard/ananth/b.txt")
 * 
 * It is an error if rename is invoked with files whose parent directories are different
 * 
 * TODO: Explore later whether we should support the concept of current working directory and allow renames like: rename(a.txt, b.txt) on current directory
 * 
 ******************************************************************************************************************************/				
		this.renameDirectory = function(context, src, dest)
		{
			if(_validateDeviceAPI(context, arguments.length-1, 2, "renameDirectory"))
			{
				
			if(_validateEntry(context,src,"dir"))
			{
				var srcDir = getdirectorypath(getResolvedPath(src));
				var destDir = getdirectorypath(getResolvedPath(dest));
				if (srcDir == destDir)
				{
					if (typeof src == "string" && src[0] != '/') //if relative path is specified, prefix the src and dest with the current working directory
					{
						src = self.getWorkingDirectory() + "/" + src;
						dest = self.getWorkingDirectory() + "/" + dest;
					}
	
					moveOrCopyDirectory({
						cb: [function(e, entry){
							if (e.code == dnfi.SUCCESS.code)
							{
								runCallBacks(context.cb, self.successObject, entry); 							
							}
							else
							{
								runCallBacks(context.cb, e); 															
							}
						}], ret:"ret"
					}, src, dest, false,true);
					return;
				}
				else
				{
					runCallBacks(context.cb, new DnfiStatus('wFileManager', wFileManagerError.SOURCE_DESTINATION_SAME_PATH_ERROR.code, wFileManagerError.SOURCE_DESTINATION_SAME_PATH_ERROR.message), null);
					return; 																			
				}
			}
			}
		}
		
		this.upload = function(context, filePath,url,success,error,opts)
		{
			if(_validateDeviceAPI(context, arguments.length-1, 4, "upload"))
			{
				var failcb = function(e) 
				{
					var argsArray = [e];		
					errorCallback.apply(error,argsArray);
				};
	
				var callbackFunction = null;
				var errorCallback = null;
				
				if(typeof success == "undefined")
					runCallBacks(context.cb, new DnfiStatus('wFileManager', wFileManagerError.CALLBACK_ERROR.code, 
														wFileManagerError.CALLBACK_ERROR.message),null);
				if(typeof success == "string")
					callbackFunction =_getFunctionForName(success);
				else
					callbackFunction = success;
					
				if(typeof error == "string")
						errorCallback =_getFunctionForName(error);
					else
						errorCallback = error;
					
				var _cb = function(pos)
				{
					__$cf._log("file upload successful");
					
					var argsArray = [pos];		
					callbackFunction.apply(success,argsArray);
				}
	
				if (typeof callbackFunction == "function") 
				{
					if(errorCallback != null)
					{
	
						if(!(typeof errorCallback == "function"))
						{
							runCallBacks(context.cb, new DnfiStatus('wFileManager', wFileManagerError.CALLBACK_ERROR.code, 
														wFileManagerError.CALLBACK_ERROR.message),null);
						return;
						}
					}
	
					var ft = new FileTransfer();
					var fileURI = "";
					
					fileURI = getResolvedURI(filePath);
					var options = new FileUploadOptions();
					options.fileKey = "file";
					options.fileName = fileURI.substr(fileURI.lastIndexOf('/') + 1);
					options.mimeType = "text/plain"; 				
					
					var trustAllHosts = false;
					if(typeof opts != "undefined" )
					{
						if(opts.trustAllHosts)
							trustAllHosts = opts.trustAllHosts;
						if(opts.mimeType)
							options.mimeType = opts.mimeType;
							
						if(opts.fileKey)
							options.fileKey = opts.fileKey;
					}
							
					ft.upload(fileURI,encodeURI(url),_cb,failcb,options,trustAllHosts);
						
					runCallBacks(context.cb, self.successObject, null);
				}
				else
				{
					runCallBacks(context.cb, new DnfiStatus('wFileManager', wFileManagerError.CALLBACK_ERROR.code, 
														wFileManagerError.CALLBACK_ERROR.message),null);
				}
				return;
			}
			
		}
		
		this.download = function(context, url,filepath,success,error,opts)
		{
			if(_validateDeviceAPI(context, arguments.length-1, 4, "download"))
			{
				var failcb = function(e) 
				{
					var argsArray = [e];		
					errorCallback.apply(error,argsArray);
				};
				
				var callbackFunction = null;
				var errorCallback = null;
				
				if(typeof success == "undefined")
					runCallBacks(context.cb, new DnfiStatus('wFileManager', wFileManagerError.CALLBACK_ERROR.code, 
														wFileManagerError.CALLBACK_ERROR.message),null);
				if(typeof success == "string")
					callbackFunction =_getFunctionForName(success);
				else
					callbackFunction = success;
					
				if(typeof error == "string")
						errorCallback =_getFunctionForName(error);
					else
						errorCallback = error;
					
				var _cb = function(pos)
				{
					__$cf._log("file download successful");
					var argsArray = [pos];		
					callbackFunction.apply(success,argsArray);
				}
				if (typeof callbackFunction == "function") 
				{
					if(errorCallback != null)
					{
						if(!(typeof errorCallback == "function"))
						{
							runCallBacks(context.cb, new DnfiStatus('wFileManager', wFileManagerError.CALLBACK_ERROR.code, 
														wFileManagerError.CALLBACK_ERROR.message),null);
							return;
						}
					}
	
					var ft = new FileTransfer();
					var fileURI = getResolvedPath(filepath);
					var options = new FileUploadOptions();
					
					var trustAllHosts = false;
					if(typeof opts != "undefined" )
					{
						if(opts.trustAllHosts)
							trustAllHosts = opts.trustAllHosts;
						if(opts.headers)
							options.headers = opts.headers;
					}
							
						
					ft.download(encodeURI(url),fileURI,_cb,failcb,trustAllHosts,options);
						
					runCallBacks(context.cb, self.successObject, null);
				}
				else
				{
					runCallBacks(context.cb, new DnfiStatus('wFileManager', wFileManagerError.CALLBACK_ERROR.code, 
														wFileManagerError.CALLBACK_ERROR.message),null);
				}
				return;
			}
			
		}
/* -------------------------------------------------------------------------------------------------------------------------------------- */
	this.toString = function() 
	{
		return("WFileManager");
	}
/* ---------------------------Set up file system as a part of constructor-------------------------------------- */		
	if (typeof context != 'undefined' && context != null) {
		__$cf._log("Initializing FileManager...");
		self.setFileSystem({cb: [function(e, fs) {
				if (e.code == dnfi.SUCCESS.code)
				{
					__$cf._log("temporary file system obtained:" + self.tempFileSystem.root.fullPath);
					//syncDirectoryEntry(self.tempFileSystem.root);
					
					self.setFileSystem({cb: [function(e, fs) {

								__$cf._log("persistent file system obtained: " + self.persistentFileSystem.root.fullPath);
								//syncDirectoryEntry(self.persistentFileSystem.root);
								this.successObject = new DnfiStatus('DNFI', dnfi.SUCCESS.code, dnfi.SUCCESS.message);
								runCallBacks(context.cb, self.successObject, self);									
							}]}, 'persistent');
					return;
				}
				else //failure in getting temp file system
				{
					runCallBacks(context.cb, self.successObject, null);
				}
					
		}]}, 'temporary');
	}
}
/* ------------------------------------------------------------------------------------------------------------------- */					
} //WFileManager
