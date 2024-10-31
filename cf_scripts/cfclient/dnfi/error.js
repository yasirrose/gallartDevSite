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

/*
 * This file contains the objects and definition to handle errors
 * P.N. Anantharaman
 */

//Error codes and definitions
var wCameraError = {
	GENERAL_ERROR: 1,
	LOCAL_FILE_READ_ERROR: {code: 2, message: "Error reading the image file from local file system"},	
	LOCAL_FILE_WRITE_ERROR: {code: 3, message: "Error Writing the image file to local file system"},
	FILE_UPLOAD_ERROR: {code: 4, message: "Error in uploading the file to server"},	
	FILE_DOWNLOAD_ERROR: {code: 5, message: "Error in downloading the file from server"},	
	FILE_OBJECT_CREATION_ERROR: {code: 6, message: "Error in creating file object out of the downloaded image"},
	INVALID_ARGUMENT_ERROR: {code: 7, message: "Invalid Argument"},
	UNSUPPORTED_OPERATION_ERROR: {code: 8, message: "Operation not supported"}	
};

var wFileManagerError = {
	GENERAL_ERROR: {code: 1, message: "Unknown error while performing file operation"},
	
	NULL_FILESYSTEM_ERROR: {code: 2, message: "File System is null"},
	INVALID_FILESYSTEM_ERROR: {code: 3, message: "File system value specified in not valid"},
	FILESYSTEM_SET_ERROR: {code: 4, message: "Error occurred while setting file system"},
	
	SECURITY_ERROR: {code: 5, message: "Security error while performing file operation"},
	ABORT_ERROR: {code: 6, message: "File/Dir operation aborted or modification not allowed"},
	
	FILE_NOT_FOUND_ERROR: {code: 101, message: "File/Directory specified was not found"},
	FILE_READ_ERROR: {code: 102, message: "Unable to read file"},
	FILE_ENCODING_ERROR: {code: 103, message: "File encoding error"},
	FILE_MODIFICATION_NOT_ALLOWED_ERROR: {code: 104, message: "File modification not allowed"},
	FILE_STATE_ERROR: {code: 105, message: "Invalid State"},
	FILE_SYNTAX_ERROR: {code: 106, message: "Syntax Error"},
	FILE_INVALID_MODIFICATION_ERROR: {code: 107, message: "Invalid file modification"},
	FILE_QUOTA_ERROR: {code: 108, message: "Quota exceeded"},
	FILE_TYPE_MISMATCH_ERROR: {code: 109, message: "Type mismatch error"},
	FILE_EXISTS_ERROR: {code: 110, message: "File/Directory already exists"},	
	FILE_INVALID_NAME_ERROR: {code: 111, message: "File/Directory name is not valid"},
	
	FILE_OPEN_ERROR: {code: 2, message: "Error while opening the file, possibly file entry couldn't be obtained"},
	FILE_OPEN_GETENTRY_ERROR: {code: 3, message: "Error while opening the file, file entry couldn't be obtained, check file name/path"},
	DESTINATION_FILEPATH_ERROR: {code: 4, message: "Error while opening the destination file, possibly some directories along the path not created"},
	GET_PARENT_ERROR: {code: 5, message: "Error getting the directory entry for the parent"},
	SOURCE_DESTINATION_SAME_PATH_ERROR: {code: 6, message: "Source and destination paths are different"},
	FILE_REMOVE_ERROR: {code:7, message: "Error while removing the file"},
	GET_PARENT_ERROR: {code:8, message: "Error while getting the parent"},
	DIRECTORY_CREATE_ERROR: {code:9, message: "Error while creating directory, possibly some directory components don't exist"},
	DIRECTORY_LOOKUP_ERROR: {code:10, message: "The specified directory doesn't exist"},
	DIRECTORY_READ_ERROR: {code:11, message: "The specified directory could not be read"},	
	DIRECTORY_GETFILE_ERROR: {code:14, message: "The getfile operation executed as a directory entry method failed"},
	SOURCE_FILEPATH_ERROR: {code:15, message: "Error in getting a reference to specified file/directory"},
	PROVIDER_NOT_FOUND_ERROR: {code:16, message: "Unable to find or load provider plugin"},
	CALLBACK_ERROR: {code: 17, message: "Callback function not found"},

};

var wCloudManagerError = {
	GENERAL_ERROR: 1,
	AUTHENTICATION_ERROR: {code: 100, message: "DropBox Authentication Failed"},
	UPLOAD_ERROR: {code: 2, message: "DropBox Upload Failed"},
	DOWNLOAD_ERROR: {code: 3, message: "DropBox download Failed"},
	DIRECTORY_CREATE_ERROR: {code:4, message: "Error while creating directory on the cloud"},
	DIRECTORY_REMOVE_ERROR: {code:5, message: "The specified directory could not be removed"},
	DIRECTORY_READ_ERROR: {code:6, message: "The specified directory could not be read"},
	DIRECTORY_COPY_ERROR: {code:7, message: "The specified directory or file could not be copied"},
	DIRECTORY_MOVE_ERROR: {code:8, message: "The specified directory could not be moved"},
	EXISTS_ERROR: {code:9, message: "Unable to successfully complete exists call"},
};

var wContactsError = {
	GENERAL_ERROR: 1,
	NAME_ERROR: {code: 2, message: "The specified name is neither a valid string nor a valid contact name object"},	
	SAVE_ERROR: {code: 3, message: "The specified contact couldn't be saved"},	
	REMOVE_ERROR: {code: 4, message: "The specified contact couldn't be removed"},	
	FIND_ERROR: {code: 5, message: "Error when finding the contacts"}
		
};


var wGeoLocationError = {
	GENERAL_ERROR: 1,
	PERMISSION_DENIED_ERROR: {code: 2, message: "Permission denied to access geo location"},	
	POSITION_UNAVAILABLE_ERROR: {code: 3, message: "Position Unavailable"},	
	TIMEOUT_ERROR: {code: 4, message: "Timed out"},	
	CALLBACK_ERROR: {code: 5, message: "Callback function not found"},
	INVALID_ARGUMENT_ERROR: {code: 6, message: "Invalid Argument"}
};

var wConnectionError = {
	GENERAL_ERROR: 1,
	CALLBACK_ERROR: {code: 2, message: "Callback function not found"}
		
};

var wAudioError = {
	GENERAL_ERROR: 1,
	CALLBACK_ERROR: {code: 2, message: "Callback function not found"},
	INVALID_ARGUMENT_ERROR: {code: 3, message: "Invalid Argument"},
	CAPTURE_INTERNAL_ERROR: {code: 4, message: "Internal error while capturing audio"},
	CAPTURE_APPLICATION_BUSY_ERROR: {code: 5, message: "Audio capture application is currently busy with other capture request."},
	CAPTURE_INVALID_ARGUMENT_ERROR: {code: 6, message: "Invalid use of API"},
	CAPTURE_NO_MEDIA_FILES_ERROR: {code: 7, message: "No audio files captured"},
	CAPTURE_NOT_SUPPORTED_ERROR: {code: 8, message: "Requested capture operation not supported"}
		
};

var wVideoError = {
	GENERAL_ERROR: 1,
	CALLBACK_ERROR: {code: 2, message: "Callback function not found"},
	INVALID_ARGUMENT_ERROR: {code: 3, message: "Invalid Argument"},
	CAPTURE_INTERNAL_ERROR: {code: 4, message: "Internal error while capturing video"},
	CAPTURE_APPLICATION_BUSY_ERROR: {code: 5, message: "Video capture application is currently busy with other capture request."},
	CAPTURE_INVALID_ARGUMENT_ERROR: {code: 6, message: "Video use of API"},
	CAPTURE_NO_MEDIA_FILES_ERROR: {code: 7, message: "No video files captured"},
	CAPTURE_NOT_SUPPORTED_ERROR: {code: 8, message: "Requested capture operation not supported"}
		
};

var wAccelerometerError = {
	GENERAL_ERROR: 1,
	CALLBACK_ERROR: {code: 2, message: "Callback function not found"},
	INVALID_ARGUMENT_ERROR: {code: 3, message: "Invalid Argument"}		
};

var wEventsError = {
	GENERAL_ERROR: 1,
	CALLBACK_ERROR: {code: 2, message: "Callback function not found"},
	INVALID_ARGUMENT_ERROR: {code: 3, message: "Invalid Argument"}		
};


var dnfi = {
	SUCCESS: {code: 0, message:"success"},
	SOURCE_OBJECT_ERROR: {code: 1, message:"Error in source name, possibly empty string"},
	DESTINATION_OBJECT_ERROR: {code: 1, message:"Error in Destination name, possibly empty string"},
};
	

/* 
 * DnfiStatus() is intended to be used by different APIs to generate the required error code.
 * These API files would do a new DnfiErrorObject() and set the relevant fields
 */
function DnfiStatus(mod, c, mess)
{	
	this.module = mod;
	this.code = c;
	this.message = mess;
}
