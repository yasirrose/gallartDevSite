

//Copyright 2013 Adobe Systems Incorporated. All Rights Reserved.

function arrayAppend(arrayObj, value, merge)
{
	_validateParameters(arrayAppend.arguments.length, 2, "arrayAppend");
	
	if("undefined" == typeof merge)
		var merge = false;
		
	if(value instanceof Array && merge)
	{
		for(var i=0;i < value.length;i++)
		{
			arrayObj[arrayLen(arrayObj)] = value[i];
		}		
	}
	else
	{
		if(arrayObj._dim > 1)
			throw "If an array with more then one dimension is passed to this function, the value passed to the array must be an array with one less dimension.";
		arrayObj[arrayLen(arrayObj)] = value;
	}
		
	return true;	
}

function arrayAvg(arrayObj)
{
	_validateParameters(arrayAvg.arguments.length, 1, "arrayAvg");
	
	var sum = 0;
	var avg = 0;
	
	if (arrayObj.length > 0) 
	{
		var temp;
		for (var i = 0; i < arrayObj.length; i++) 
		{
			temp = arrayObj[i];
			if(typeof temp != "undefined")
				sum = sum + temp;
			else
				throw "The value at position "+(i+1)+" was either not numeric or not defined.";
		}
		
		avg = sum / arrayObj.length;
	}
	
	return avg;
	
}

function arrayClear(arrayObj)
{
	_validateParameters(arrayClear.arguments.length, 1, "arrayClear");
	
	arrayObj.splice(0, arrayObj.length);
	
	return true;
}

function arrayDeleteAt(arrayObj, position)
{
	_validateParameters(arrayDeleteAt.arguments.length, 2, "arrayDeleteAt");
	
	position = position - 1;
	
	if (arrayObj instanceof Array) 
	{
		if (position < 0 || (position > arrayObj.length)) 
			throw "Invalid Array Index";
		
		arrayObj.splice(position, 1);
		
		return true;
	}
	
	return false;
}
function arrayEach(arrayObj, func)
{
	_validateParameters(arrayEach.arguments.length, 2, "arrayEach");
	if (arrayObj instanceof Array) 
	{
		if(typeof func != "function")
			throw new IllegalArgumentException();
			
		for (var i = 0; i < arrayObj.length; i++) 
		{
			func(arrayObj[i]);
		}
	}
}

function arrayFilter(arrayObj, func)
{
	_validateParameters(arrayFilter.arguments.length, 2, "arrayFilter");
	if (arrayObj instanceof Array) 
	{
		if(typeof func != "function")
			throw new IllegalArgumentException();
			
		var temp = [];
		var index = 0;
		for (var i = 0; i < arrayObj.length; i++) 
		{
			if(func(arrayObj[i]))
			{
				temp[index] = arrayObj[i];
				index++;
			}
		}
		
		return temp;
	}
}

function arrayMap(arrayObj, func)
{
	_validateParameters(arrayMap.arguments.length, 2, "arrayMap");
	if (arrayObj instanceof Array) 
	{
		if(typeof func != "function")
			throw new IllegalArgumentException();
			
		var temp = [];
		for (var i = 0; i < arrayObj.length; i++) 
		{
			temp[i] = func(arrayObj[i],i+1,arrayObj);			
		}
		
		return temp;
	}
}

function arrayReduce(arrayObj, func, initValue)
{
	_validateParameters(arrayReduce.arguments.length, 2, "arrayReduce");
	
	if(typeof initValue != "undefined")
		var temp = initValue;
	else
		var temp = "";
	
	if (arrayObj instanceof Array) 
	{
		if(typeof func != "function")
			throw new IllegalArgumentException();
			
		
		for (var i = 0; i < arrayObj.length; i++) 
		{
			temp = func(temp,arrayObj[i],i+1,arrayObj);			
		}		
	}
	return temp;
}

function arrayFind(arrayObj, obj)
{
	_validateParameters(arrayFind.arguments.length, 2, "arrayFind");
	
	return _arrayfind(arrayObj, obj, true);
}



function arrayFindAll(arrayObj, obj)
{
	_validateParameters(arrayFindAll.arguments.length, 2, "arrayFindAll");
	
	return _arrayfindall(arrayObj, obj, true);
}

function arrayFindAllNoCase(arrayObj, obj)
{
	_validateParameters(arrayFindAllNoCase.arguments.length, 2, "arrayFindAllNoCase");
	
	return _arrayfindall(arrayObj, obj, false);
}



function arrayFindNoCase(arrayObj, obj)
{
	_validateParameters(arrayFindNoCase.arguments.length, 2, "arrayFindNoCase");
	
	return _arrayfind(arrayObj, obj, false);
}

function arrayInsertAt(arrayObj, position, value)
{
	_validateParameters(arrayInsertAt.arguments.length, 3, "arrayInsertAt");
	
	position = position - 1;
	
	if(arrayObj instanceof Array)
	{
		if(position < 0 || (position > arrayObj.length))
			throw "Invalid Array Index";
			
		arrayObj.splice(position, 0, value);
		return true;
	}
	
	return false;
}

function arrayContains(arrayObj, value)
{
	_validateParameters(arrayContains.arguments.length, 2, "arrayContains");
	
	if (arrayObj instanceof Array) 
	{
		for (var i = 0; i < arrayObj.length; i++) 
		{
			if (arrayObj[i] == value) 
				return true;
		}
	}
	
	return false;
}

function arraySlice(arrayObj, offset, length)
{
	_validateParameters(arraySlice.arguments.length, 2, "arraySlice");
	
	
	if(offset < 0)
		offset = arrayObj.length + offset;
	else
		offset = offset - 1;
	
	if(arrayObj instanceof Array)
	{
		if ("undefined" != typeof length) 
		{
			if(offset + length > arrayObj.length)
				throw new "Invalid array index";
				
			return arrayObj.slice(offset, offset + length);
		}
		else		
			return arrayObj.slice(offset, arrayObj.length);
	}
}

function arrayIsDefined(arrayObj,index)
{				
	_validateParameters(arrayIsDefined.arguments.length, 2, "arrayIsDefined");
	index = index - 1;
	return ("undefined" != typeof arrayObj[index]);
}

function arrayIsEmpty(arrayObj)
{
	_validateParameters(arrayIsEmpty.arguments.length, 1, "arrayIsEmpty");
	return arrayObj.length == 0;
}

function arrayLen(arrayObj)
{
	_validateParameters(arrayLen.arguments.length, 1, "arrayLen");
	return arrayObj.length;
}

function arrayMax(arrayObj)
{
	_validateParameters(arrayMax.arguments.length, 1, "arrayMax");
	var max;
	var n;
	for (var i = 0; i < arrayObj.length; i++)
	{
		n = arrayObj[i];
		if (!isNaN(n) && (typeof n != "boolean")) 
		{
			if("undefined" == typeof max || n > max)
				max = n;
		}
	}
	if("undefined" != typeof max)
		return max;
	return 0;
}

function arrayMin(arrayObj)
{
	_validateParameters(arrayMin.arguments.length, 1, "arrayMin");
	var min;
	var n;
	for (var i = 0; i < arrayObj.length; i++)
	{
		n = arrayObj[i];
		if (!isNaN(n)) 
		{
			if("undefined" == typeof min || n < min)
				min = n;
		}
	}
	if("undefined" != typeof min)
		return min;
	return 0;
}

function arrayDelete(arrayObj, value)
{
	_validateParameters(arrayDelete.arguments.length, 2, "arrayDelete");
	if (arrayObj instanceof Array) 
	{
		for (var i = 0; i < arrayObj.length; i++) 
		{
			if (arrayObj[i] == value) 
			{
				arrayObj.splice(i, 1);
				return true;
			}				
		}
	}
	
	return false;
}
	
function arrayNew(dimension)
{
	_validateParameters(arrayNew.arguments.length, 1, "arrayNew");
	if("undefined" == typeof dimension)
		var dimension = 1;
		
	if(dimension < 1 || dimension > 3)
		throw new "Array dimension "+dimension+" must be between 1 and 3";
		
	var arr = new Array();
	
	//add _dim as non iteratable property
	Object.defineProperty(arr, "_dim", {
    enumerable: false,
    configurable: false,
    writable: false,
    value: dimension
	});
	
	return arr;
		
}

function arrayPrepend(arrayObj, value)
{
	_validateParameters(arrayPrepend.arguments.length, 2, "arrayPrepend");
	if(arrayObj instanceof Array)
	{
		arrayObj.unshift(value);
		return true;
	}
	
	return false;
}

function arrayResize(arrayObj, minSize)
{
	_validateParameters(arrayResize.arguments.length, 2, "arrayResize");
	
	minSize = Math.floor(minSize);
	
	if(minSize < 1)
		throw "Minimum size should be greater than 0";
	if(arrayObj instanceof Array)
	{
		if (minSize > arrayObj.length) 
		{
			arrayObj.length = minSize;
			return true;
		}
		
		return true;
	}
	
	return false;
}

function arraySet(arrayObj, start, end, value)
{
	_validateParameters(arraySet.arguments.length, 4, "arraySet");
	if(arrayObj instanceof Array)
	{
		for(var i=start-1; i <= end-1; i++)
		{
			arrayObj[i] = value;
		}
		
		return true;
	}
	
	return false;
}

function arraySort(arrayObj, sortType, sortOrder, localeSensitive)
{	
	_validateParameters(arraySort.arguments.length, 2, "arraySort");
	
	function _arraySortClosure(obj, func)
	{
		if (obj instanceof Array) 
		{
			if(typeof func != "function")
				throw new IllegalArgumentException();
				
			obj.sort(func);
			return true;
		}
		return false;
	}
	
	if(typeof arraySort.arguments[1] == "function")
		return _arraySortClosure(arraySort.arguments[0],arraySort.arguments[1]);
	else
	{
	
	if("undefined" == typeof localeSensitive)
		localeSensitive = false;
		
	if("undefined" == typeof sortOrder)
		sortOrder = "asc";
		
	sortOrder = sortOrder.toLowerCase();

	switch (sortType.toLowerCase())
	{
		case "numeric" :
		{
			if(sortOrder != "desc")
				arrayObj.sort(function(a,b){return a-b} );
			else
				arrayObj.sort(function(a,b){return b-a} );
			
			return true;
		}
		
		case "text" :
		{
			if (localeSensitive) 
			{
				arrayObj.sort(function(a, b)
				{
					var val1 = a + "";
					var val2 = b + "";
					return val1.localeCompare(val2);
				});
			}
			else 
				arrayObj.sort();
				
			if (sortOrder == "desc") 
				arrayObj.reverse();
				
			return true;
		}
		
		case "textnocase" :
		{
			if (localeSensitive) 
			{
				arrayObj.sort(function(a, b)
				{
					var val1 = a + "";
					var val2 = b + "";
					return val1.toLowerCase().localeCompare(val2.toLowerCase()) ;
				});
			
			}
			else 
			{
				arrayObj.sort(function(a, b)
				{
					var val1 = a + "";
					var val2 = b + "";
					
					if (val1.toLowerCase() < val2.toLowerCase()) 
						return -1;
					if (val1.toLowerCase() > val2.toLowerCase()) 
						return 1;
					return 0;
				});
			}
				
			if (sortOrder == "desc") 
				arrayObj.reverse();
				
			return true;
			
		}
	}
	return false;
	}
}

function _cfSort(obj, sortType, sortOrder)
{
	var args = [obj];
	for(var i=1;i < arguments.length;i++)
	{			
		args[i] = arguments[i];
	}
	if(obj instanceof Array)		
		return arraySort.apply(obj, args);
	else
		return structSort.apply(obj, args);
}

function arraySum(arrayObj)
{
	_validateParameters(arraySum.arguments.length, 1, "arraySum");
	var sum = 0;
	var n;
	for(var i=0; i < arrayObj.length; i++)
	{
		n = arrayObj[i];
		if (!isNaN(n)) 
		{
			sum = sum + n;
		}
		else
			throw "Non-numeric value found. The value at position "+i+" was not numeric";
	}
	return sum;
}

function arraySwap(arrayObj, position1, position2)
{
	_validateParameters(arraySwap.arguments.length, 3, "arraySwap");
	
	if(arrayObj instanceof Array)
	{
		position1 = Math.floor(position1 - 1);
		position2 = Math.floor(position2 - 1);
		if(position1 >= 0 && position1 < arrayObj.length && 
			position2 >= 0 && position2 < arrayObj.length)
			{
				var temp  = arrayObj[position1];
				arrayObj[position1] = arrayObj[position2];
				arrayObj[position2] = temp;
				
				return true;
			}
	}
	
	return false;
}

function arrayToList(arrayObj, delim)
{
	_validateParameters(arrayToList.arguments.length, 1, "arrayToList");

    var result = "";
	
	if (arrayObj instanceof Array) 
	{
	
		if (typeof delim == 'undefined') 
			delim = ",";
		
		return arrayObj.join(delim);
	}
    
    return result;
}

function listToArray(list, delim, incudeEmptyFields, multiCharDelim)
{
	_validateParameters(listToArray.arguments.length, 1, "listToArray");
	if (typeof delim == 'undefined') 
		delim = ",";
		
	if (typeof incudeEmptyFields == 'undefined') 
		incudeEmptyFields = false;
		
	if (typeof multiCharDelim == 'undefined') 
		multiCharDelim = false;
		
	var result = new Array();
	if (!multiCharDelim) 
		result = _multiDelimSplit(list, delim, incudeEmptyFields);
	else 
	{
		var arrayObj = list.split(delim);	
		
		if (arrayObj.length == 0 && incudeEmptyFields) 
			result[0] = "";
		else 
		{		
			var index = 0;
			var addItem = false;
			var item = null;
			for (var i = 0; i < arrayObj.length; i++) 
			{
				item = arrayObj[i];
				addItem = true;
				if (typeof item == "undefined" || item == "") 
				{
					if (!incudeEmptyFields) 
						addItem = false;
				}
				
				if (addItem) 
				{
					result[index] = item;
					index++;
				}
			}
		}
	}
		
	return result;
}

function isArray(arrayObj)
{
	_validateParameters(isArray.arguments.length, 1, "isArray");
	if(typeof arrayObj == "undefined")
		return false;
	if(arrayObj instanceof Array)
		return true;
		//length and push function are used for duck test of an array, using the same here
	else if(typeof arrayObj.length == "number" && typeof arrayObj.push == "function")
		return true;
		
	return false;	
}

function isArray(arrayObj, dimension)
{
	//_validateParameters(isArray.arguments.length, 2, "isArray");
	if(typeof arrayObj == "undefined")
		return false;
	if(typeof dimension == "undefined" && typeof arrayObj._dim != "undefined")
		dimension = arrayObj._dim;
	if(arrayObj instanceof Array && arrayObj._dim == dimension )
		return true;
		//length and push function are used for duck test of an array, using the same here
	else if(typeof arrayObj.length == "number" && typeof arrayObj.push == "function" && arrayObj._dim == dimension)
		return true;
		
	return false;	
}

function _arrayfind(arrayObj, obj, caseSensitive)
{
	if (arrayObj instanceof Array) 
	{
		var _compareFunction = compareObj;
		if (typeof obj != "function") 
		{
			if(typeof obj == "string")
				_compareFunction = compareStr;
				
			for (var i = 0; i < arrayObj.length; i++) 
			{				
				if (_compareFunction(i,obj)) 
					return i + 1;
			}
			
		}
	}
		
	function compareStr(i, obj)
	{
		return _compareString(arrayObj[i], obj, caseSensitive);
	}
	
	function compareObj(i, obj)
	{
		return _equals(arrayObj[i],obj);
	}
	
	return 0;
}

function _arrayfindall(arrayObj, obj, caseSensitive)
{
	var result = new Array();
	
	if (arrayObj instanceof Array) 
	{
		var _compareFunction = compareObj;
		if (typeof obj != "function") 
		{
			if(typeof obj == "string")
				_compareFunction = compareStr;
				
			for (var i = 0; i < arrayObj.length; i++) 
			{				
				if (_compareFunction(i,obj))
					result.push(i+1); 
			}
			
		}
	}
		
	function compareStr(i, obj)
	{
		return _compareString(arrayObj[i], obj, caseSensitive);
	}
	
	function compareObj(i, obj)
	{
		return (arrayObj[i] == obj);
	}
	
	return result;
}

function _compareString(str1, str2, caseSensitive)
{
	if (typeof str1 == "string" && typeof str2 == "string") 
	{
		if (caseSensitive) 
			return (str1 == str2);
		else 
			return str1.toLowerCase() == str2.toLowerCase();
	}
	
	return false;
}
function createDate(_Year, _Month, _Day)
{
	_validateParameters(createDate.arguments.length, 3, "createDate");
	
	if(_Month < 1 || _Month > 12)
		throw "Invalid Day Month combination";
		
	if(_Day < 1 || _Day > 31)
		throw "Invalid Day of Month";
		
	if(_Year >=0 && _Year <= 29)
		_Year = parseInt(_Year) + 2000; //add 2000 to match CF behavior as by default JS dates start from 1900
	else if (_Year > 29 && _Year <= 99)
		_Year = parseInt(_Year) + 1900;
	
	_Month = _Month - 1;
	
	var retDate = new Date(_Year, _Month, _Day);
	
	if(day(retDate) != _Day && month(retDate) != _Month)
		throw "Invalid Day and Month combination";
		
	return retDate;	
	
}

function createDateTime(Year, Month, Day, Hour, Minutes, Seconds)
{
	_validateParameters(createDateTime.arguments.length, 6, "createDateTime");
	
	if(Month < 1 || Month > 12)
		throw "Invalid Day Month combination";
		
	if(Day < 1 || Day > 31)
		throw "Invalid Day of Month";
		
	if(Year >=0 && Year <= 29)
		Year = parseInt(Year) + 2000; //add 2000 to match CF behavior as by default JS dates start from 1900
	else if (Year > 29 && Year <= 99)
		Year = parseInt(Year) + 1900;
	
	Month = Month - 1;
	
	if(Hour < 0 || Hour > 23)
		throw "Invalid Hour value";
	if(Minutes < 0 || Minutes > 59)
		throw "Invalid mintute value";
	if(Seconds < 0 || Seconds > 59)
		throw "Invalid Second value";
	
	return new Date(Year, Month, Day, Hour, Minutes, Seconds);
}

function createTime(Hour, Minutes, Seconds)
{
	_validateParameters(createTime.arguments.length, 3, "createTime");
	
	if(Hour < 0 || Hour > 23)
		throw "Invalid Hour value";
	if(Minutes < 0 || Minutes > 59)
		throw "Invalid mintute value";
	if(Seconds < 0 || Seconds > 59)
		throw "Invalid Second value";
	
	return new Date(1899, 11, 30, Hour, Minutes, Seconds);
}

function createTimespan(Days, Hour, Minutes, Seconds)
{
	_validateParameters(createTimespan.arguments.length, 4, "createTimespan");
	
	return Days + ( ( Seconds / 60 + Minutes ) / 60 + Hour ) / 24 ;
}

function _dateadd(date, dp, _number)
{
	return dateAdd(dp, _number, date);
}

function dateAdd(dp, _number, date)
{
	_validateParameters(dateAdd.arguments.length, 3, "dateAdd");	
	
	var number = new Number(_number);
		
	var Year = datePart("yyyy",date);
	var Month = datePart("m",date);
	var Day = datePart("y",date);
	var DayOfMonth = date.getDate();
	var Hours = date.getHours();
	var Minutes = date.getMinutes();
	var Seconds = date.getSeconds();
	
	var DaysInYear = 365;
	if(isLeapYear(Year))
		DaysInYear = 366;
			
	var _dp = dp.toLowerCase();
	if(_dp == "l" || _dp == "s" || _dp == "n" || _dp == "h" || _dp == "ww" || _dp == "d" || _dp == "y")
		return new Date(new Date(date).setMilliseconds( _getMilliSecondsForDatePart(_dp,number)));
	else if(_dp == "yyyy")
		Year = Year + number;
	else if(_dp == "m")
	{		
		var offset = Month + number;
		if(offset <0 )
			Year = -(Math.floor(-offset/12)) + Year;
		else
			Year = Math.floor(offset/12) + Year;
			
		Month = offset%12;
	}
	else if(_dp == "q")
	{
		var qToAdd = number*3;
		return dateAdd("m",qToAdd,date);
	}
	else if(_dp == "w")
	{
		var DayOfWeek = dayOfWeek(date);
		var retDate = new Date(date.getTime());

	    var _Day = retDate.getDay();
		var offset = 0;
		if(number >= 0)
		{
			offset = DayOfWeek - 2;
			if(offset >= 5)
				offset -= 7;
		}
		else
		{
			offset = -(6 - DayOfWeek); 
            if (offset <= -5)
                offset += 7;  
		}
		
		retDate = dateAdd("d", -offset, retDate);
		if(DayOfWeek == 1 || DayOfWeek == 7)
		{
			offset = 0;
			if(number > 0)
				number -= 1;
			else if (number < 0)
				number += 1;
		}
		number += offset;
		
		if(number < 0)
			offset = -(Math.floor(-number/5))*7 + (number % 5);
		else
			offset = Math.floor(number/5)*7 + (number % 5);
			
		retDate = dateAdd("d", offset, retDate);
	
	    return retDate;
	}
		
	return new Date(Year, Month -1, DayOfMonth, Hours, Minutes, Seconds);
	
	
	function _getMilliSecondsForDatePart(dPart, number)
	{
		switch(dPart)
		{
			case "l":
				return number;
			case "s":
				return number * 1000;
			case "n":
				return number * 1000 * 60;
			case "h":
				return number * 1000 * 3600;
			case "ww":
				return number * 86400000 * 7;
			case "d":
				return number * 3600000 * 24;	
			case "y":
				return number * 3600000 * 24;
			
		}
	}	
	
}

function dateCompare(date1, date2, datePart)
{
	_validateParameters(dateCompare.arguments.length, 2, "dateCompare");
	
	if("undefined" == typeof datePart)
		datePart = "s";
		
	var part1 = date1;
	var part2 = date2;
	
	var compareLevel = getCompareLevel(datePart);
	var result = 0;
	
	for (var currentLevel = 1; currentLevel <= compareLevel; currentLevel++) 
	{
		if (currentLevel == 1) 
		{
			part1 = date1.getFullYear();
			part2 = date2.getFullYear();
		}
		else if (currentLevel == 2)
		{
			part1 = date1.getMonth();
			part2 = date2.getMonth();
		}
		else if (currentLevel == 3)
		{
			part1 = date1.getDate();
			part2 = date2.getDate();
		}
		else if (currentLevel == 4)
		{
			part1 = date1.getHours();
			part2 = date2.getHours();
		}
		else if (currentLevel == 5)
		{
			part1 = date1.getMinutes();
			part2 = date2.getMinutes();
		}
		else if (currentLevel == 6)
		{
			part1 = date1.getSeconds();
			part2 = date2.getSeconds();
		}
		
		result = checkParts(part1, part2);
		if (result == 0 && compareLevel > currentLevel) 
			continue;
		else 
			return result;
	}
	
	return result;
	
	
	function checkParts(part1, part2)
	{
		if (part1 > part2) 
			return 1;
		else 
			if (part1 < part2) 
				return -1;
			else 
				return 0;
	}
	
	
	function getCompareLevel(datePart)
	{
	
	
		switch (datePart.toLowerCase())
		{
			case "s":
			{
				part1 = date1.getSeconds();
				part2 = date2.getSeconds();
				return 6;
			}
			case "n":
			{
				part1 = date1.getMinutes();
				part2 = date2.getMinutes();
				return 5;
			}
			case "h":
			{
				part1 = date1.getHours();
				part2 = date2.getHours();
				return 4;
			}
			case "d":
			{
				part1 = date1.getDate();
				part2 = date2.getDate();
				return 3;
			}
			case "m":
			{
				part1 = date1.getMonth();
				part2 = date2.getMonth();
				return  2;
			}
			case "yyyy":
			{
				part1 = date1.getFullYear();
				part2 = date2.getFullYear();
				return 1;
			}
			default:
				return 6;
		}
		
	}	
	
	
}

function _dateconvert(date, conversionType)
{
	return dateConvert(conversionType, date);
}

function dateConvert(conversionType, date)
{
	_validateParameters(dateConvert.arguments.length, 2, "dateConvert");
	
	if(conversionType.toLowerCase() == "localtoutc")
		return new Date(date.toUTCString());
	else if(conversionType.toLowerCase() == "utctolocal")
		return new Date(date.toLocaleDateString());
	
	return date;
}

function _datediff(date2, datePart, date1)
{
	return dateDiff(datePart, date1, date2);
}

function dateDiff(datePart, date1, date2)
{
	_validateParameters(dateDiff.arguments.length, 3, "dateDiff");
	
	var timeDiff = date2.getTime() - date1.getTime();
	var sign = (timeDiff < 0) ? -1 : 1;
	timeDiff = Math.abs(timeDiff);	
	var result = 0;
	switch(datePart.toLowerCase())
	{
		case "s":
		{			
			result = Math.floor(timeDiff / (1000));
			break;
		}
		case "n":
		{
			result =  Math.floor(timeDiff / (1000 * 60));
			break;
		}
		case "h":
		{
			result =  Math.floor(timeDiff / (1000 * 60 * 60));
			break;
		}
		case "d":
		{
			result =  Math.floor(timeDiff / (1000 * 60 * 60 * 24));
			break;
		}
		case "w":
		{
			result =  Math.floor(timeDiff / (1000 * 60 * 60 * 24 * 7));
			break;
		}
		case "ww":
		{
			result = Math.floor(timeDiff / (1000 * 60 * 60 * 24 * 7));
			break;
		}
		case "m":
		{
			var hoursDiff= date2.hour() - date1.hour();
			if(hoursDiff > 0)
				hoursDiff = -1;
			else if(hoursDiff < 0)
				hoursDiff = 1;
			var nYears  = date2.getUTCFullYear() - date1.getUTCFullYear();
			
			var dayDiff = Math.abs(date2.getDate() - date1.getDate());
			var monthDiff = Math.abs(date2.month() - date1.month());
			
			if(nYears == 0 && monthDiff == 1 && dayDiff < 30)
				return 0;
				
			return (date2.month() - (date1.month()+ hoursDiff) + (nYears!=0 ? nYears*12 : 0));
		}
		case "q":
		{
			result = Math.floor(timeDiff / (1000 * 60 * 60 * 24 * 31 * 3));
			break;
		}
		case "y":
		{
			result = Math.floor(timeDiff / (1000 * 60 * 60 * 24));
			break;
		}
		case "yyyy":
		{
			result = Math.floor(timeDiff / (1000 * 60 * 60 * 24 * 31 * 12));
			break;
		}
		
	}	
	
	return result * sign;
}

function dateFormat(d, mask)
{
	_validateParameters(dateFormat.arguments.length, 1, "dateFormat");
	
	return _dateformat(d, mask);
}
function _dateformat(d, mask, formatType)
{   
	if("undefined" == typeof formatType)
		formatType = "dateFormat";
		
   var _mask = mask;   
  
    if ("undefined" == typeof _mask) 
    {
		if(formatType == "DateTimeFormat")
   			_mask = "dd-mmm-yyyy hh:nn:ss";
		else if(formatType == "TimeFormat")
			_mask = "hh:nn tt";
		else
			_mask = "dd-mmm-yy";
    }   						
	else if (_mask.toLowerCase() == "short") 
	{
		if(formatType == "DateTimeFormat")
			_mask = "m/D/yy hh:nn tt";
		else if (formatType == "TimeFormat")
			_mask = "h:nn tt";
		else
			_mask = "m/D/yy";
	}
	else if (_mask.toLowerCase() == "medium")
	{ 
		if(formatType == "DateTimeFormat")
			_mask = "mmm D, yyyy hh:nn:ss tt";
		else if (formatType == "TimeFormat")
			_mask = "h:nn:ss tt";
		else
			_mask = "mmm D, yyyy";
	}
	else if (_mask.toLowerCase() == "long")
	{ 
		if(formatType == "DateTimeFormat")
			_mask = "mmmm D, yyyy hh:nn:ss tt Z";
		else if (formatType == "TimeFormat")
			_mask = "h:nn:ss tt Z";
		else
			_mask = "mmmm D, yyyy";
	} 
	else if (_mask.toLowerCase() == "full")
	{ 
							
		if(formatType == "DateTimeFormat")
			_mask = "dddd, mmmm D, yyyy hh:nn:ss tt Z";
		else if (formatType == "TimeFormat")
			_mask = "h:nn:ss tt Z";
		else
			_mask = "dddd, mmmm D, yyyy";
	}
   
    var m, makeZero;
    
    if (!(d instanceof Date)) 
    {
        d = new Date(d);
    }
    
    makeZero = function(value, length)
    {
        var i;
        if (!length) 
        {
            length = 2;
        }
        value = String(value);
        for (i = 0, zeros = ''; i < (length - value.length); i++) 
        {
            zeros += '0';
        }
        return zeros + value;
    };
		
	
	_mask = _mask.replace(new RegExp("nn","g"),"n");
	_mask = _mask.replace(new RegExp("a","g"),"tt");
	_mask = _mask.replace(new RegExp("G","g"),"z");	
	_mask = _mask.replace(new RegExp("H","g"),"%");
	_mask = _mask.replace(new RegExp("F","g"),";");
	_mask = _mask.replace(new RegExp("T","g"),"#");
	_mask = _mask.replace(new RegExp("K","g"),"@");		
	_mask = _mask.toLowerCase();
	_mask = _mask.replace(new RegExp("%","g"),"H");
	_mask = _mask.replace(new RegExp(";","g"),"F");
	_mask = _mask.replace(new RegExp("#","g"),"T");
	_mask = _mask.replace(new RegExp("@","g"),"K");
	
	if(formatType == "TimeFormat")
	{
		_mask = _mask.replace(new RegExp("m","g"),"M");
	}
	
	/* handle non mask characters to match cf beavior */
	var allowedChars = "kKtTzhHFmMsSdDmMnyYgG-/: ";
	var temp = "";
	var startIndex = -1;
	var count = 1;
	var finalStr = "";
	var replaceObj = new Object();
	for(var i=0;i<_mask.length;i++)
	{
		if( allowedChars.indexOf(_mask[i]) == -1)
		{
			temp = temp + _mask[i];
			if(startIndex == -1)
				startIndex = i;
		}
		else
		{
			if(temp != "" && startIndex != -1)
			{
				var replaceCode = "$"+count+" ";
				finalStr = finalStr.replace(temp, replaceCode);
				replaceObj[replaceCode] = temp;
				count++;
				temp = "";
				startIndex = -1;
			}
			
		}
		finalStr = finalStr + _mask[i];
	}
    
    var formattedDate =  finalStr.replace(/"[^"]*"|'[^']*'|\b(?:d{1,4}|e{1,4}|D{1}|w{1}|F{1}|m{1,4}|n{1,2}|y{1}|yy(?:yy)?|gg|([hHkKMstT])\1?|[lLZz])\b/g, function($0)
    {
		
        switch ($0)
        {
            case 'd':
                return d.getDate();
            case 'dd':
                return makeZero(d.getDate());
            case 'ddd':
                return ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][d.getDay()];
            case 'dddd':
                return ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'][d.getDay()];
			case 'e':
                return ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][d.getDay()];
            case 'eeee':
                return ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'][d.getDay()];
			case 'F':
                {
					var _DayOfMonth = d.getDate();
					var count = 0;
				
					while(_DayOfMonth >= 1)
					{
						_DayOfMonth = _DayOfMonth - 7;
						count++;
					}
					
					return count;
				}
			case 'gg':
                return "AD";
            case 'm':
                return d.getMonth() + 1;
            case 'mm':
                return makeZero(d.getMonth() + 1);
            case 'mmm':
                return ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][d.getMonth()];
            case 'mmmm':
                return ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'][d.getMonth()];
			case 'y':
                return String(d.getFullYear()).substr(2);
            case 'yy':
                return String(d.getFullYear()).substr(2);
            case 'yyyy':
                return d.getFullYear();
             case 'h':
             	var _hours = d.getHours();
                return ((_hours === 0 ? "12":  _hours% 12));
            case 'hh':
            {
            	var _hours = d.getHours();
            	if(_hours === 12)
            		return "12";
            		
                return _hours === 0 ? "12": makeZero(_hours % 12 );
            }
            case 'k':
                var _hours = d.getHours();
                return _hours === 0 ? "24": (_hours);
            case 'kk':
            {
            	var _hours = d.getHours();
            	return makeZero((_hours === 0 ? "24": (_hours)));
            }
            case 'K':
            {
            	var _hours = d.getHours();            	            		
                return _hours === 0 ? "0": (_hours % 12 );
            }
            case 'KK':
            {
            	var _hours = d.getHours();
                return _hours === 0 ? "0": makeZero(_hours % 12 );
            }
            case 'H':
                return d.getHours();
            case 'HH':
                return makeZero(d.getHours());
            case 'M':
                return d.getMinutes();
            case 'MM':
                return makeZero(d.getMinutes());
			case 'n':
                return makeZero(d.getMinutes());
            case 's':
                return d.getSeconds();
            case 'ss':
                return makeZero(d.getSeconds());
            case 'l':
			{
				if(d.getMilliseconds() == 0)
					return 0;
				return makeZero(d.getMilliseconds(), 3);
			}
            case 'tt':
                return d.getHours() < 12 ? 'AM' : 'PM';
            case 't':
                return d.getHours() < 12 ? 'a' : 'p';
            case 'TT':
                return d.getHours() < 12 ? 'AM' : 'PM';
            case 'T':
                return d.getHours() < 12 ? 'A' : 'P';
			case 'w':
                return week(d);
            case 'z':
                {
					var Now = d.toString();
					var timeZone = Now.indexOf('(') > -1 ?
					Now.match(/\([^\)]+\)/)[0].match(/[A-Z]/g).join('') :
					Now.match(/[A-Z]{3,4}/)[0];
					if (timeZone == "GMT" && /(GMT\W*\d{4})/.test(Now))
						 timeZone = RegExp.$1;
						 
					return timeZone;
				}
            // Return quoted strings with the surrounding quotes removed
            default:
            {
                return $0.substr(1, $0.length - 2);
            }
        }
    });
    
    for(var key in replaceObj)
	{
		if(replaceObj.hasOwnProperty(key))
		{
			formattedDate = formattedDate.replace(key, replaceObj[key]);
		}
	}
	
    return formattedDate;
}

function _datepart(date1, dp)
{
	return datePart(dp,date1);
}

function datePart(dp,date1)
{
	_validateParameters(datePart.arguments.length, 2, "datePart");
	
	if("undefined" == typeof dp)
		dp = "s";
		
	var part1 = date1.getSeconds();
	switch(dp.toLowerCase())
	{
		case "s":
		{
			part1 = date1.getSeconds();
			break;
		}
		case "n":
		{
			part1 = date1.getMinutes();
			break;
		}
		case "h":
		{
			part1 = date1.getHours();
			break;
		}
		case "d":
		{
			part1 = date1.getDate();
			break;
		}
		case "m":
		{
			part1 = date1.getMonth() + 1;
			break;
		}
		case "y":
		{
			var first = new Date(date1.getFullYear(), 0, 1);
			part1 = Math.round(((date1 - first) / 1000 / 60 / 60 / 24) + .5, 0);
			break;
		}
		case "yyyy":
		{
			part1 = date1.getFullYear();
			break;
		}
		case "w":
		{
			part1 = dayOfWeek(date1);
			break;
		}
		case "ww":
		{
			part1 = week(date1);
			break;
		}
		case "q":
		{
			part1 = quarter(date1);
			break;
		}
		
	}	
	
	return part1;
}

function day(date)
{
	_validateParameters(day.arguments.length, 1, "day");
	
	return date.getDate();
}

function dayOfWeek(date)
{
	_validateParameters(dayOfWeek.arguments.length, 1, "dayOfWeek");
	
	return date.getDay() + 1;
}

function dayOfWeekAsString(date)
{
	_validateParameters(dayOfWeekAsString.arguments.length, 1, "dayOfWeekAsString");
	
	if (date >= 1 && date <= 7) 
	{
	
		var Days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
		return Days[date -1];
	}
	else
		throw date + " must be within range (1-7).";
	
}

function dayOfYear(date)
{
	_validateParameters(dayOfYear.arguments.length, 1, "dayOfYear");
	
	var first = new Date(date.getFullYear(), 0, 1);
	return Math.round(((date - first) / 1000 / 60 / 60 / 24) + .5, 0);
}

function daysInMonth(date)
{
	_validateParameters(daysInMonth.arguments.length, 1, "daysInMonth");
	
	return 32 - new Date(date.getFullYear(), date.getMonth(), 32).getDate();
}

function daysInYear(date)
{
	_validateParameters(daysInYear.arguments.length, 1, "daysInYear");
	
	var Year = date.getFullYear();
	
	if(Year % 4 === 0 && (Year % 100 !== 0 || Year % 400 === 0)) 
        return 366;
    else
	    return 365;
}

function firstDayOfMonth(date)
{
	_validateParameters(firstDayOfMonth.arguments.length, 1, "firstDayOfMonth");
	
	date.setDate(1);
	
	var first = new Date(date.getFullYear(), 0, 1);
	return Math.round(((date - first) / 1000 / 60 / 60 / 24) + .5, 0);
}

function getHTTPTimeString(date)
{
	_validateParameters(getHTTPTimeString.arguments.length, 1, "getHTTPTimeString");
	
	return date.toUTCString();
}

function getTickCount()
{
	return new Date().getTime();
}

function getTimezoneInfo()
{
	var result = new Object();
	var date = new Date();
	var offset = date.getTimezoneOffset();	
	var correction = 1;
	if(offset < 0)
		correction = -1;
	result["utcTotalOffset"] = offset * 60;
	result["utcHourOffset"] = correction * Math.floor(Math.abs(offset/60));
	result["utcMinuteOffset"] = offset % 60;
	result["isDSTOn"] = false;
	
	return result;
}

function hour(date)
{
	_validateParameters(hour.arguments.length, 1, "hour");
	
	return date.getHours();
}

function isDate(date)
{
	_validateParameters(isDate.arguments.length, 1, "isDate");
	
	if(date instanceof Date)
		return true;		

	if(typeof date === "string")
	{
		if(/^[0-9a-zA-Z]*$/.test(date))
			return false;
			
		var d = parseDateTime(date + "");
	
		if(d == "Invalid Date")
			return false;
			
		if(d instanceof Date)
			return true;
	}
	
	return false;
}

function isLeapYear(yr)
{
    _validateParameters(isLeapYear.arguments.length, 1, "isLeapYear");
    
    if ((parseInt(yr) % 4) == 0) 
    {
        if (parseInt(yr) % 100 == 0) 
        {
            if (parseInt(yr) % 400 != 0) 
                return "false";
            if (parseInt(yr) % 400 == 0) 
                return "true";

        }
        if (parseInt(yr) % 100 != 0) 
            return "true";
    }
    if ((parseInt(yr) % 4) != 0) 
        return "false";

}

function isNumericDate(obj)
{
    _validateParameters(isNumericDate.arguments.length, 1, "isNumericDate");
    
	if(obj instanceof Date)
		return true;
		
	if(!isNaN(obj))
		return true;
	else if(obj instanceof String)
	{
		var date = parseInt(obj);
		if(! isNan(date))
			return true;
	}
   
   
   return false;

}

function minute(date)
{
    _validateParameters(minute.arguments.length, 1, "minute");
    
	return date.getMinutes();
}

function month(date)
{
    _validateParameters(month.arguments.length, 1, "month");
    
	return date.getMonth() + 1;
}

function monthAsString(date)
{
	_validateParameters(monthAsString.arguments.length, 1, "monthAsString");
	
	if (date >= 1 && date <= 31) 
	{
	
		var Months = ["January", "February", "March", "April", "May", "June", "July",
		"August", "September", "October", "November", "December"];
		return Months[date -1];
	}
	else
		throw date + " must be within range (1-31).";
	
}

function now()
{
	return new Date();
}

function parseDateTime(str, conversiontype)
{
	_validateParameters(parseDateTime.arguments.length, 1, "parseDateTime");
	
	var parsedDate = Date.parse(str);
	
	var date = new Date(parsedDate);
	
	if(typeof conversiontype == "undefined")
		conversiontype = "standard";
		
	if(conversiontype.toLowerCase() == "pop")
	{
		date = new Date(date.getTime() + date.getTimezoneOffset()*60*1000); 
	}	
	return date;
}

function quarter(date)
{
    _validateParameters(quarter.arguments.length, 1, "quarter");
    
	return Math.ceil((date.getMonth() + 1 )/3);
}

function second(date)
{
    _validateParameters(second.arguments.length, 1, "second");
    
	return date.getSeconds();
}

function timeFormat(d, mask)
{
    _validateParameters(timeFormat.arguments.length, 1, "timeFormat");
   		
	return _dateformat(d, mask, "TimeFormat");
}

function week(date)
{
    _validateParameters(week.arguments.length, 1, "week");
    
	var start = new Date(date.getFullYear(),0,1);
	return Math.ceil((((date - start) / 86400000) + start.getDay()+1)/7);
}

function year(date)
{
    _validateParameters(year.arguments.length, 1, "year");
    
	return date.getFullYear();	
}

function dateTimeFormat(d, mask)
{
    _validateParameters(dateTimeFormat.arguments.length, 1, "dateTimeFormat");
    
	if("undefined" == typeof mask)
		mask = "dd-mmm-yyyy HH:nn:ss";
		
	return _dateformat(d, mask, "DateTimeFormat");
}
function getToken(str, position, delim)
{
	_validateParameters(getToken.arguments.length, 2, "getToken");
	
	position = position -1;
	
	position = Math.floor(position);
	
	if ("undefined" == typeof delim) 
	{
		delim = " " + String.fromCharCode(9) + String.fromCharCode(10);
	}
	
	var result = _multiDelimSplit(str,delim,false);
	
	if(result.length == 0)
		return str;
	
	if (position >= 0 && position < result.length) 
			return result[position];
		
	return "";
}

function listAppend(list, value, delimiter)
{
	_validateParameters(listAppend.arguments.length, 2, "listAppend");
	
	if("undefined" == typeof delimiter)
		delimiter = ",";
	
	if(delimiter.length == 0)
		return list;
	else if(list.length == 0)
		return value;
	else
		return list + delimiter.charAt(0) + value;
		
	
}

function listChangeDelims(list, newDelimiter, oldDelimiter, includeEmptyFields)
{
	_validateParameters(listChangeDelims.arguments.length, 2, "listChangeDelims");
	
	if("undefined" == typeof oldDelimiter)
		oldDelimiter = ",";
	
	if("undefined" == typeof includeEmptyFields)
		includeEmptyFields = false;
	
	var result = "";

	var tokens = _multiDelimSplit(list,oldDelimiter);		
	
	for(var i=0;i<tokens.length;i++)
	{
		if (tokens[i] != "" || includeEmptyFields) 
		{
			result = result + tokens[i];
			if (i + 1 < tokens.length) 
				result = result + newDelimiter;
		}
	}

		
	return result;
}

function listContains(list, subString, delimiter, includeEmptyFields)
{
	_validateParameters(listContains.arguments.length, 2, "listContains");
	
	if("undefined" == typeof delimiter)
		delimiter = ",";
	
	if("undefined" == typeof includeEmptyFields)
		includeEmptyFields = false;
	
	var tokens = _multiDelimSplit(list, delimiter);		
	var index = 0;
	for(var i=0;i<tokens.length;i++)
	{
		if (tokens[i] != "" || includeEmptyFields) 
		{
			index++;
			if( find(subString, tokens[i])  > 0)
				return index;
		}
	}
		
	return 0;
}

function listContainsNoCase(list, subString, delimiter, includeEmptyFields)
{
	_validateParameters(listContainsNoCase.arguments.length, 2, "listContainsNoCase");
	
	if("undefined" == typeof delimiter)
		delimiter = ",";
	
	if("undefined" == typeof includeEmptyFields)
		includeEmptyFields = false;
	
	var tokens = _multiDelimSplit(list, delimiter);		
	var index = 0;
	for(var i=0;i<tokens.length;i++)
	{
		if (tokens[i] != "" || includeEmptyFields) 
		{
			index++;
			if( findNoCase(subString, tokens[i])  > 0)
				return index;
		}
	}
		
	return 0;
}

function listDeleteAt(list, position, delimiter, includeEmptyFields)
{
	_validateParameters(listDeleteAt.arguments.length, 2, "listDeleteAt");
	
	if("undefined" == typeof delimiter)
		delimiter = ",";
	
	if("undefined" == typeof includeEmptyFields)
		includeEmptyFields = false;
		
	position = position - 1;
	
	var splitResult = _multiDelimSplit(list,delimiter,true,true);	
	var tokens = splitResult["tokens"];
	var delimArray = splitResult["delims"];
	
	if(position >= tokens.length)
		throw "Invalid List index";	
	
	var result = "";
	var addedToken = -1;
	var index = 0;
	var skip = false;
	for(var i=0;i<tokens.length;i++)
	{
		
		if (index != position || tokens[i] == "") 
		{

			if (tokens[i] != "" || !skip || includeEmptyFields) 
			{
				if (i - 1 < delimArray.length && result != "") 
					result = result + delimArray[i-1];
				result = result + tokens[i];
				
			}
		}
		
		if (tokens[i] != "" || includeEmptyFields) 
		{
			index++;
			if(skip )
				skip = false; //turn it off once we get a non empty token
			if((index -1) == position) //turn on only for matching position
				skip = true;
		}
			
				
	}
		
	return result;
}

function listFind(list, value, delimiter, includeEmptyFields)
{
	_validateParameters(listFind.arguments.length, 2, "listFind");
	
	if("undefined" == typeof delimiter)
		delimiter = ",";
	
	if("undefined" == typeof includeEmptyFields)
		includeEmptyFields = false;
	
	var tokens = _multiDelimSplit(list,delimiter);		
	
	var index = 0;
	for(var i=0;i<tokens.length;i++)
	{
		if (tokens[i] != "" || includeEmptyFields) 
		{
			index++;
			
			if(tokens[i] == value)
				return index;
		}
	}
		
	return 0;
}

function listFindNoCase(list, value, delimiter, includeEmptyFields)
{
	_validateParameters(listFindNoCase.arguments.length, 2, "listFindNoCase");
	
	if("undefined" == typeof delimiter)
		delimiter = ",";
	
	if("undefined" == typeof includeEmptyFields)
		includeEmptyFields = false;
	
	var tokens = _multiDelimSplit(list,delimiter);		
	
	var index = 0;
	for(var i=0;i<tokens.length;i++)
	{
		if (tokens[i] != "" || includeEmptyFields) 
		{
			index++;
			
			if(tokens[i].toLowerCase() == value.toLowerCase())
				return index;
		}
	}
		
	return 0;
}

function listFirst(list, delimiter, includeEmptyFields)
{
	_validateParameters(listFirst.arguments.length, 1, "listFirst");
	
	if("undefined" == typeof delimiter)
		delimiter = ",";
	
	if("undefined" == typeof includeEmptyFields)
		includeEmptyFields = false;
	
	var tokens = _multiDelimSplit(list,delimiter);		
	
	for(var i=0;i<tokens.length;i++)
	{
		if(tokens[i] != "" || includeEmptyFields)
			return tokens[i]; 
	}
	
	return list;
}

function listGetAt(list, position, delimiter, includeEmptyFields)
{
	_validateParameters(listGetAt.arguments.length, 2, "listGetAt");
	
	if("undefined" == typeof delimiter)
		delimiter = ",";
	
	if("undefined" == typeof includeEmptyFields)
		includeEmptyFields = false;
	
	var tokens = _multiDelimSplit(list,delimiter);		
	
	position = position - 1;
	
	if(position >= tokens.length )
		throw "Invalid List index";
		
	var index = -1;
	
	for(var i=0;i<tokens.length;i++)
	{
		if (tokens[i] != "" || includeEmptyFields) 
		{
			index++;
			if(index == position)
				return tokens[i];
		} 
	}
	
	if(position > index)
		throw "Invalid List index";
	
	return list;
}

function listInsertAt(list, position, value, delimiter, includeEmptyFields)
{
	_validateParameters(listInsertAt.arguments.length, 3, "listInsertAt");
	
	if("undefined" == typeof delimiter)
		delimiter = ",";
	
	if("undefined" == typeof includeEmptyFields)
		includeEmptyFields = false;
	
	var splitResult = _multiDelimSplit(list,delimiter,true,true);		
	var tokens = splitResult["tokens"];
	var delimArray = splitResult["delims"];
	position = position - 1;
	
	if(position >= tokens.length )
		throw "Invalid List index";
		
	var index = -1;	
	var result = "";
	var actualIndex = 0;
	for(var i=0;i<tokens.length;i++)
	{
		
		if (i != 0 && i -1  < delimArray.length && (addedToken <= i -1 && addedToken != -1)) 
			result = result + delimArray[addedToken];
			
		if (actualIndex == position && (tokens[i] != "" || includeEmptyFields)) 
		{
			result = result + value;
			
			if (i < tokens.length) 
				result = result + delimiter.charAt(0);
			
			actualIndex++;
		}
			
		if (tokens[i] != "" || includeEmptyFields) 
		{
			result = result + tokens[i];
			actualIndex++;
		}
		addedToken = i;	
		
		
	}
		
	return result;
}

function listLast(list, delimiter, includeEmptyFields)
{
	_validateParameters(listLast.arguments.length, 1, "listLast");
	
	if("undefined" == typeof delimiter)
		delimiter = ",";
	
	if("undefined" == typeof includeEmptyFields)
		includeEmptyFields = false;
	
	var tokens = _multiDelimSplit(list,delimiter);		
	var result = tokens[0];
	for(var i=0;i<tokens.length;i++)
	{
		if(tokens[i] != "" || includeEmptyFields)
			result = tokens[i]; 
	}
	
	return result;
}

function listLen(list, delimiter, includeEmptyFields)
{
	_validateParameters(listLen.arguments.length, 1, "listLen");
	
	if("undefined" == typeof delimiter)
		delimiter = ",";
	
	if("undefined" == typeof includeEmptyFields)
		includeEmptyFields = false;
	
	var tokens = _multiDelimSplit(list,delimiter, includeEmptyFields);		

	return tokens.length;
}

function listPrepend(list, value, delimiter)
{
	_validateParameters(listPrepend.arguments.length, 2, "listPrepend");
	
	if("undefined" == typeof delimiter)
		delimiter = ",";	
		
	if(delimiter.length > 1)
		delimiter = delimiter.charAt(0);
		
	return value + delimiter + list;	
}

function listQualify(list, qualifier, delimiter, elements, includeEmptyFields)
{
	_validateParameters(listQualify.arguments.length, 2, "listQualify");
	
	if("undefined" == typeof delimiter)
		delimiter = ",";
			
	if("undefined" == typeof elements)
		elements = "all";
	else if (elements.toLowerCase() != "all" && elements.toLowerCase() != "char")
		throw "Invalid elements type "+elements;
	
	if("undefined" == typeof includeEmptyFields)
		includeEmptyFields = false;
	
	var tokens = _multiDelimSplit(list,delimiter);		

	for(var i=0;i<tokens.length;i++)
	{
		if(tokens[i] != "" || includeEmptyFields)
		{
			if(elements.toLowerCase() == "all" || _isAlphabetic(tokens[i]))
				tokens[i] = qualifier + tokens[i] + qualifier;
		}
			
	}
	
	var result = "";
	for(var i=0;i<tokens.length;i++)
	{
		if (tokens[i] != "" || includeEmptyFields) 
		{
			if( i != 0)
				result = result + delimiter[0];
				
			result = result + tokens[i];
			
		} 
	}
	
	return result;
}

function listRest(list, delimiter, includeEmptyFields)
{
	_validateParameters(listRest.arguments.length, 1, "listRest");
	
	if("undefined" == typeof delimiter)
		delimiter = ",";
	
	if("undefined" == typeof includeEmptyFields)
		includeEmptyFields = true;
	
	var splitResult = _multiDelimSplit(list,delimiter, includeEmptyFields, true);
	var tokens = splitResult["tokens"];
	var delimArray = splitResult["delims"];
		
	var result = "";
	var addedFirst = false;
	var startedList = false;
	var hasEmptuFieldsAtStart = false;
	for(var i=1;i<tokens.length;i++)
	{
		
		if (tokens[i] == "" && !startedList) 
		{
			hasEmptuFieldsAtStart = true;
			continue;
		}
		if(!startedList)
		{
			startedList = true;
			if(hasEmptuFieldsAtStart) //skip first non empty element as previous elements were empty
				continue;
		}			
		result = result + tokens[i];			
		if(delimArray != null && i < delimArray.length)
			result = result + delimArray[i];

	}
	
	return result;
}

function listSetAt(list, position, value, delimiter, includeEmptyFields)
{
	_validateParameters(listSetAt.arguments.length, 3, "listSetAt");
	
	if("undefined" == typeof delimiter)
		delimiter = ",";
	
	if("undefined" == typeof includeEmptyFields)
		includeEmptyFields = false;
		
	var splitResult = _multiDelimSplit(list,delimiter,true,true);	
	var tokens = splitResult["tokens"];
	var delimArray = splitResult["delims"];	
	
	position = Math.floor(position);
	
	position = position - 1;
	
	if(position >= tokens.length )
		throw "Invalid List index";
		
	var index = -1;
	//---
	var result = "";
	if(includeEmptyFields)
	{
		for(var i=0;i<tokens.length;i++)
		{
			if(i === position)
				result = result + value;
			else
				result = result + tokens[i]; 
				
			if(i != tokens.length -1)
				result = result + (delimiter);
		}	
	}
	else
	{
		var idx = -1;
		var cfBehaviorOn = false;
		var isDelim = false;
		var didOneDelim = false;
		var isDelimAtLast = false;
		var temp;
		tokens = _splitWithDelims(list,delimiter,false);
		
		function _isValidDelim(val)
		{
			return delimiter.indexOf(val) >= 0;
		}
		
		for(var i=0;i<tokens.length;i++)
		{
			isDelim = false;
			
			if(!_isValidDelim(tokens[i]))
			{
				idx++;
			}
			else
				isDelim = true;
			
			
				
			if(idx === position)
			{
				result = result + value;
				idx++;
				cfBehaviorOn = true;
			}
			else
			{
				if(!isDelim && cfBehaviorOn)
					cfBehaviorOn = false;
					
				if (cfBehaviorOn && isDelim && !didOneDelim && position != tokens.length)
				{
					result = result + delimiter.charAt(0);
					didOneDelim = true;
					isDelimAtLast = true;
				}
				else if(!cfBehaviorOn)
				{
					result = result + tokens[i];
					isDelimAtLast = false;
				}
					
			}
				
		}
		
		if(isDelimAtLast)
		{
			//remove delims from end of result
			for(var j=0; j < delimiter.length;j++)
			{
				if(result[result.length -1] == delimiter[j])
					result  = result.substring(0,result.length - 1);
			}
		}
		
	}
		
		
	return result;
}

function listSort(list, sortType, sortOrder, delimiter, includeEmptyFields, localeSensitive)
{
	_validateParameters(listSort.arguments.length, 2, "listSort");
	
	if("undefined" == typeof delimiter)
		delimiter = ",";
	
	if("undefined" == typeof includeEmptyFields)
		includeEmptyFields = false;
	
	var tokens = _multiDelimSplit(list,delimiter,includeEmptyFields,false);
		
	arraySort(tokens,sortType, sortOrder,localeSensitive);
	
	var result = "";
	for(var i=0;i<tokens.length;i++)
	{
		if (i != 0) 
			result = result + delimiter[0];
			
		result = result + tokens[i];
	}
		
	return result;
	
}

function listValueCount(str, value, delim)
{
	_validateParameters(listValueCount.arguments.length, 2, "listValueCount");
	
	if("undefined" == typeof delim)
		var delim = ",";
	
	var result = _multiDelimSplit(str,delim);
		
	var count = 0;
	for(var i=0; i < result.length; i++)
	{
		if(result[i] == value)
			count++;
	}
			
	
	return count;
}

function listValueCountNoCase(str, value, delim)
{
	_validateParameters(listValueCountNoCase.arguments.length, 2, "listValueCountNoCase");
	
	if("undefined" == typeof delim)
		var delim = ",";
	
	var result = _multiDelimSplit(str,delim);
		
	var count = 0;
	for(var i=0; i < result.length; i++)
	{
		if(_compareStr(result[i], value, false) == 0)
			count++;
	}
			
	
	return count;
}

function replaceList(str, list1, list2, delim1, delim2)
{
	_validateParameters(replaceList.arguments.length, 3, "replaceList");
	
	if("undefined" == typeof delim1)
		var delim1 = ",";
	if("undefined" == typeof delim2)
		var delim2 = delim1;
	
	var tokens1 = _multiDelimSplit(list1, delim1, false);
	var tokens2 = _multiDelimSplit(list2, delim2, false);
	var elementToReplace = null;
	for(var i=0; i < tokens1.length;i++)
	{
		if(find(tokens1[i], str) > 0)
		{
			if(i < tokens2.length)
				str = replace(str,tokens1[i],tokens2[i], "all");
			else
				str = replace(str,tokens1[i],"", "all");
		}	
	}
	
	return str;
}

function listRemoveDuplicates(str,delim,ignoreCase)
{
	_validateParameters(listRemoveDuplicates.arguments.length, 1, "listRemoveDuplicates");
	
	if("undefined" == typeof delim)
		var delim = ",";
		
	if("undefined" == typeof ignoreCase)
		var ignoreCase = false;
	
	var result = _multiDelimSplit(str,delim);
		
	var index = 0;
	var itemArray = [];
	for(var i=0; i < result.length; i++)
	{
		var res = 0;
		if(ignoreCase)
			res = arrayFindNoCase(itemArray,result[i]);
		else
			res = arrayFind(itemArray, result[i]);
			
		if(res == 0)
		{
			//item not present, add to itemArray
			itemArray[index] = result[i];
			index++;			
		}
		
	}
	
	return arrayToList(itemArray);
}

function _multiDelimSplit(str, delim, includeEmptyFields, keepDelims)
{
	var regexStr = "[";
	
	if("undefined" == typeof includeEmptyFields)
		includeEmptyFields = true;
	
	for(var i = 0; i < delim.length; i++)
	{
		switch(delim[i])
		{
			case " ":
				regexStr = regexStr + "\\s|";
				break;
			default :
				regexStr = regexStr + delim[i] + "|";
		}
	}
	
	if(regexStr.length > 2 && regexStr.charAt(regexStr.length - 1) == "|")
		regexStr = regexStr.substring(0, regexStr.length -1);
		
	regexStr = regexStr +"]";
	
	var regex = new RegExp(regexStr,"g");
	var splitResult = null;
	var resultStrArray = str.split(regex);
	var delimArray = null;
	
	if(keepDelims)
		delimArray = str.match(regex);
	
	var tokenRemoveIndexes = new Array();
	
	if(! includeEmptyFields)
	{
		for(var i=0; i < resultStrArray.length; i++)
		{
			if(resultStrArray[i] == "")
			{

				resultStrArray.splice(i, 1);
				
				if(keepDelims && delimArray != null && delimArray.length > i )
					delimArray.splice(i,1);
					
				--i;
			}
		}
	}
	
	var finalResult = new Array(); 
	if (keepDelims) 
	{
		finalResult["tokens"] = resultStrArray;
		finalResult["delims"] = delimArray;
	}
	else
		finalResult = resultStrArray;

		
	return finalResult;	
	
}
function _splitWithDelims(str, delim, includeEmptyFields)
{
	var regexStr = "([";
	
	if("undefined" == typeof includeEmptyFields)
		includeEmptyFields = true;
	
	for(var i = 0; i < delim.length; i++)
	{
		switch(delim[i])
		{
			case " ":
				regexStr = regexStr + "\\s|";
				break;
			default :
				regexStr = regexStr + delim[i] + "|";
		}
	}
	
	if(regexStr.length > 2 && regexStr.charAt(regexStr.length - 1) == "|")
		regexStr = regexStr.substring(0, regexStr.length -1);
		
	regexStr = regexStr +"])";
	
	var regex = new RegExp(regexStr,"g");
	var splitResult = null;
	var resultStrArray = str.split(regex);
	
	
	var tokenRemoveIndexes = new Array();
	
	if(! includeEmptyFields)
	{
		for(var i=0; i < resultStrArray.length; i++)
		{
			if(resultStrArray[i] == "")
			{
				resultStrArray.splice(i, 1);
					
				--i;
			}
		}
	}
		
	return resultStrArray;	
	
}


function abs(number)
{
	_validateParameters(abs.arguments.length, 1, "abs");
	
	return Math.abs(number);
}

function aCos(number)
{
	_validateParameters(aCos.arguments.length, 1, "aCos");
	
	if(number < -1 || number > 1)
		throw number+" must be within range ( -1 : 1 )"
	
	return Math.acos(number);
}

function aSin(number)
{
	_validateParameters(aSin.arguments.length, 1, "aSin");
	
	if(number < -1 || number > 1)
		throw number+" must be within range ( -1 : 1 )"
	
	return Math.asin(number);
}

function atn(number)
{
	_validateParameters(atn.arguments.length, 1, "atn");
	return Math.atan(number);
}

function bitAND(number1, number2)
{
	_validateParameters(bitAND.arguments.length, 2, "bitAND");
	return number1 & number2;
}

function bitMaskClear(number, start, len)
{
	_validateParameters(bitMaskClear.arguments.length, 3, "bitMaskClear");
	
	if(start > 31 || start < 0)
		throw "Invalid argument: start should be within 0 and 31";
		
	if(len > 31 || len < 0)
		throw "Invalid argument: length should be within 0 and 31";
		
	return number & ~ ( ( ( 1 << len ) - 1 ) << start );
}

function bitMaskRead(number, start, len)
{
	_validateParameters(bitMaskRead.arguments.length, 3, "bitMaskRead");
	
	if(start > 31 || start < 0)
		throw "Invalid argument: start should be within 0 and 31";
		
	if(len > 31 || len < 0)
		throw "Invalid argument: length should be within 0 and 31";
		
	return ( number >> start ) & ( ( 1 << len ) - 1 );
}

function bitMaskSet(number, mask, start, len)
{
	_validateParameters(bitMaskSet.arguments.length, 4, "bitMaskSet");
	
	if(start > 31 || start < 0)
		throw "Invalid argument: start should be within 0 and 31";
		
	if(len > 31 || len < 0)
		throw "Invalid argument: length should be within 0 and 31";
		
	var m = ( ( 1 << len ) - 1 ) << start; 
    mask &= ( ( 1 << len ) - 1 ); 
    return ( number & ~m ) | ( mask << start );
}

function bitNOT(number)
{
	_validateParameters(bitNOT.arguments.length, 1, "bitNOT");
	
	return ~number;
}

function bitOR(number1, number2)
{
	_validateParameters(bitOR.arguments.length, 2, "bitOR");
	
	return number1 | number2;
}

function bitShln(number, count)
{
	_validateParameters(bitShln.arguments.length, 2, "bitShln");
	
	return number << count;
}

function bitShrn(number, count)
{
	_validateParameters(bitShrn.arguments.length, 2, "bitShrn");
	
	return number >>> count;
}

function bitXOR(number1, number2)
{
	_validateParameters(bitXOR.arguments.length, 2, "bitXOR");
	
	return number1 ^ number2;
}

function ceiling(number)
{
	_validateParameters(ceiling.arguments.length, 1, "ceiling");
	
	return Math.ceil(number);
}

function cos(number)
{
	_validateParameters(cos.arguments.length, 1, "cos");
	
	return Math.cos(number);
}

function decrementValue(number)
{
	_validateParameters(decrementValue.arguments.length, 1, "decrementValue");
	
	return fix(number) - 1;
}

function exp(number)
{
	_validateParameters(exp.arguments.length, 1, "exp");
	
	return Math.exp(number);
}

function fix(number)
{
	_validateParameters(fix.arguments.length, 1, "fix");
	
	return number == 0.0 ? 0.0 : (number > 0 ? Math.floor(number) : Math.ceil(number));
}

function incrementValue(number)
{
	_validateParameters(incrementValue.arguments.length, 1, "incrementValue");
	
	return fix(number + 1);
}

function int(number)
{
	_validateParameters(int.arguments.length, 1, "int");
	
	return Math.floor(number);
}

function log(number)
{
	_validateParameters(log.arguments.length, 1, "log");
	
	return Math.log(number);
}

function log10(number)
{
	_validateParameters(log10.arguments.length, 1, "log10");
	
	return Math.log(number)/ Math.LN10;
}

function max(number1, number2)
{
	_validateParameters(max.arguments.length, 2, "max");
	
	return number1 >= number2 ? number1 : number2;
}

function min(number1, number2)
{
	_validateParameters(min.arguments.length, 2, "min");
	
	return number1 <= number2 ? number1 : number2;
}

function pi()
{
	return 3.14159265358979;
}

function rand()
{
	return Math.random();
}

function randomize(number)
{
	_validateParameters(randomize.arguments.length, 1, "randomize");
	
	return Math.floor((Math.random() * number) + 1);
}

function randRange(number1, number2)
{
	_validateParameters(randRange.arguments.length, 2, "randRange");
	
	return Math.floor(Math.random()*(number2-number1+1)+number1);
}

function round(number)
{
	_validateParameters(round.arguments.length, 1, "round");
	
	return Math.round(number);
}

function sgn(number)
{
	_validateParameters(sgn.arguments.length, 1, "sgn");
	
	if(number > 0)
		return 1;
	else if(number < 0)
		return -1;
		
	return 0;
}

function sin(number)
{
	_validateParameters(sin.arguments.length, 1, "sin");
	
	return Math.sin(number);
}

function sqr(number)
{
	_validateParameters(sqr.arguments.length, 1, "sqr");
	
	return Math.sqrt(number);
}

function tan(number)
{
	_validateParameters(tan.arguments.length, 1, "tan");
	
	return Math.tan(number);
}
function isBoolean(obj)
{
	_validateParameters(isBoolean.arguments.length, 1, "isBoolean");
	
	if(obj == null || "undefined" == typeof obj)
		return false;
		
	if(typeof obj == "boolean" || obj instanceof Boolean)
		return true;
	
	return false;
}

function QueryEach(q, func){

    var data = q.DATA;
	var cols = q.COLUMNS;
	var rowStruct = {};
	for(var m = 0;m < q.length;m++){
	for(var key in data){
		if (data.hasOwnProperty(key)) {       
		  rowStruct[key] =  data[key][m];
        }
	 }
	 func.call(this, rowStruct);
	}
  
}


function QueryReduce(q, func, i){
    var data = q.DATA;
	var cols = q.COLUMNS;
	var rowStruct = {};
	for(var m = 0;m < q.length;m++){
	for(var key in data){
		if (data.hasOwnProperty(key)) {       
		  rowStruct[key] =  data[key][m];
        }
	 }
	 i = func.call(this, i, rowStruct);
	}
  return i;
}

function QueryMap(q, func){

    var data = q.DATA;
	var cols = q.COLUMNS;
	var rowStruct = {};
	for(var m = 0;m < q.length;m++){
	 for(var key in data){
		if (data.hasOwnProperty(key)) {       
		  rowStruct[key] =  data[key][m];
        }
		
	 }
	 var r =func.call(this, rowStruct);
	 for(var key in r){
		if (r.hasOwnProperty(key)) {       
		  data[key][m] =  r[key];
        }
	  }
	}
	return q;
  
}

function QueryFilter(q, func){

    var data = {};
	for(var key in q.DATA){
		if (q.DATA.hasOwnProperty(key)) {       
		  data[key] =  [];
        }
		
	 }
	var cols = q.COLUMNS;
	var length = q.length;
	if(!length)
		length = q.DATA.length;
	var n = 0;
	var rowStruct = {};
	for(var m = 0;m < length;m++){
	 for(var key in q.DATA){
		if (q.DATA.hasOwnProperty(key)) {       
		  rowStruct[key] =  q.DATA[key][m];
        }
		
	 }
	 var b =func.call(this, rowStruct);
	 if(b){
	 for(var key in q.DATA){
		if (q.DATA.hasOwnProperty(key)) { 
		  
		   data[key][n] = q.DATA[key][m];
        }
	  }
	  
	  n++;
	 }
	}
	q.DATA = data;
	return q;
  
}

function QuerySort(q, func){
 //q = _queryRowToColumnFormat(q)
    var data = q.DATA;
	var cols = q.COLUMNS;
	var rowAry = [];
	var rowStruct = {};
	var dData = {};
	var length = q.length;
	if(!length)
		length = q.DATA.length;
	
	for(var m = 0;m < length;m++){
		rowStruct = {};
	 for(var key in data){
		if (data.hasOwnProperty(key)) {       
		  rowStruct[key] =  data[key][m];
		  dData[key] = [];
        }
		
	 }
    
	rowAry.push(rowStruct);
	 
	}

	rowAry.sort(func);
	for(var x = 0; x < rowAry.length;x++){
      var ary = [];
      var obj = rowAry[x];
	  for(var key in obj){
        if (obj.hasOwnProperty(key)) {       
		  dData[key].push(obj[key]);
        }
	  }

	}
	q.DATA =dData;
	return q;
  
}

function PreserveSingleQuotes(str){
    return str;
}

function isDefined(obj)
{
	_validateParameters(isDefined.arguments.length, 1, "isDefined");
	
	if(obj == null || "undefined" == typeof obj)
		return false;
		
	var keys = obj.split(".");
	var tempObj = null;
	var defined = true;
	
	for(var i=0; i<keys.length;i++)
	{		
		var temp = keys[i];
		if(typeof temp == "string")
			temp = temp.toLowerCase();
		
		if(i == 0)
		{
			
			if("undefined" == typeof window[temp])
			{
				defined = false;
				break;
			}
			else
				tempObj = window[temp];
		}
		else
		{
			if (! temp in tempObj) 
			{
				defined = false;
				break;
			}
			else
				tempObj = tempObj[temp];
		}		
	}
	
	return defined;
}

function isNull(obj)
{
	_validateParameters(isNull.arguments.length, 1, "isNull");
	
	if(obj == null || "undefined" == typeof obj)
		return true;
	else
	{
		var result = eval(obj);
		
		if(result == null || "undefined" == typeof result)
			return true;
	}
	
	return false;
}

function isNumeric(obj)
{
	_validateParameters(isNumeric.arguments.length, 1, "isNumeric");
	
	if(obj == null || "undefined" == typeof obj || obj instanceof Array)
		return false;
	
	return ! isNaN(obj);
}

function isSimpleValue(obj)
{
	_validateParameters(isSimpleValue.arguments.length, 1, "isSimpleValue");
	
	if(obj == null || "undefined" == typeof obj)
		return false;
	else
	{
		if(typeof obj == "date" || typeof obj == "number" || typeof obj == "string" ||
			typeof obj == "boolean")
			return true;
	}
	
	return false;
}

function isValid(type, value, min, max)
{
	_validateParameters(isValid.arguments.length, 2, "isValid");
	
	var i,digit,sum=0;
	
		switch(type.toLowerCase())
		{
			case "any": 	return (typeof value !== 'undefined');//isSimpleValue(value);
			case "array": 	return isArray(value);
			case "date": 	return isDate(value);
			case "boolean":	return isBoolean(value);
			case "email": 	return isValid("regex",value,/(^[a-z0-9]([a-z_\.0-9]*)@([a-z_\.0-9]*)([.][a-z]{2,4})$)/i);
			case "eurodate":return isDate(value);
			case "float": 	return isNumeric(value);
			case "guid": 	return isValid("regex",value,/(^[0-9-a-fA-F]{8}-([0-9-a-fA-F]{4}-){3}[0-9-a-fA-F]{12}$)/);
			case "integer": return isValid("regex",value,/(^-?\d\d*$)/);
			case "numeric": return isNumeric(value);
			case "range": 	return (((value*1) >= min) && ((value*1) <= max))? true:false;
			case "regex": 	return value.toString().match(min) ? true:false;
			case "regular_expression": 	isValid("regex",value,min);
			case "social_security_number": 	return isValid("ssn",value);
			case "ssn": 	return isValid("regex",value,/^([0-9]\d{2}|7[0-9]\d|77[0-9])([ \-]?)(\d{2})\2(\d{4})$/);
			case "string": 	return isString(value);
			case "struct": 	return isStruct(value);
			case "telephone":return isValid("regex",value,/^(\([1-9]\d{2}\)\s?|[1-9]\d{2}[\.\-])?\d{3}[\.\-]\d{4}$/);
			case "time": 	return isDate(value);
			case "url": 	return isValid("regex",value,/(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/i);
			case "uuid": 	return isValid("regex",value,/(^[0-9-a-fA-F]{8}-[0-9-a-fA-F]{4}-[0-9-a-fA-F]{4}-[0-9-a-fA-F]{16}$)/);
			case "variablename": return isValid("regex",value,/(^[a-zA-Z_][0-9a-zA-Z_]*$)/);
			case "zipcode": return isValid("regex",value,/(^\d{5}$)|(^\d{5}-\d{4}$)/);
			case "creditcard": 
				if(!isValid("range",value.length,13,16))
					return false;
				for (i=(2-(value.length % 2)); i<=value.length; i+=2)
				{
					sum += parseInt(value.charAt(i-1),10);
				}
				for (i=(value.length % 2) + 1; i<value.length; i+=2)
				{
					digit = parseInt(value.charAt(i-1),10) * 2;
					sum += (digit < 10)? digit : (digit-9); 
				}
				return ((sum % 10) === 0) ? true : false;			
		}
	
	
}


function decimalFormat(number)
{
	_validateParameters(decimalFormat.arguments.length, 1, "decimalFormat");

	var num = number.toFixed(2); 
	return _addCommas(num);
}

function dollarFormat(number)
{
	_validateParameters(dollarFormat.arguments.length, 1, "dollarFormat");

	var num = number.toFixed(2); 
	var decFormat = _addCommas(Math.abs(number));
	decFormat = "$" + decFormat;
	if(number < 0)
		decFormat = "(" + decFormat + ")";
		
	return decFormat;
}


function htmlEditFormat(str)
{
	_validateParameters(htmlEditFormat.arguments.length, 1, "htmlEditFormat");
	
	var result = "";
	
	for(var i =0; i<str.length; i++)
	{
		switch(str[i])
		{
			case '"':
			{
				result = result + '&quot;';
				break;
			}
			case '&':
			{
				result = result +  '&amp;';
				break;
			}
			case '>':
			{
				result = result + '&gt;';
				break;
			}
			case '<':
			{
				result = result + '&lt;';
				break;
			}
			default:
			{
				result = result + str[i];
				break;
			}
		}
	}
	
	return result;
	
}

function htmlCodeFormat(str)
{
	_validateParameters(htmlCodeFormat.arguments.length, 1, "htmlCodeFormat");
	
	return "<pre>" + htmlEditFormat(str) + "</pre>";
	
}

function numberFormat(number,mask)
{
	_validateParameters(numberFormat.arguments.length, 1, "numberFormat");
	
	return decimalFormat(number);
	
}

function createUUID()
{
    var d = new Date().getTime(); //get timestamp
    var uuid = 'xxxxxxxx-xxxx-xxxx-yxxxxxxxxxxxxxxx'.replace(/[xy]/g, function(singleChar) 
	{
        var num = (d + Math.random()*16)%16 | 0;
        d = Math.floor(d/16);
        return (singleChar == 'x' ? num : (num&0x7|0x8)).toString(16).toUpperCase();
    });
    return uuid;
};

function _addCommas(number)
{
	number += '';
	var tokens = number.split('.');
	token1 = tokens[0];
	var token2 = tokens.length > 1 ? '.' + tokens[1] : '';
	var rgx = /(\d+)(\d{3})/;
	while (rgx.test(token1)) 
	{
		token1 = token1.replace(rgx, '$1' + ',' + '$2');
	}
	return token1 + token2;
}

function getBaseTagList()
{
	return cfclient.getCustomTagList();
}

function getBaseTagData(tagname, number)
{
	return cfclient.getCustomTagData(tagname, number);
}

function _setCFQueryProperties(aQuery, columns, data,length,recordCount,columnList,currentRow)
{
	  aQuery["COLUMNS"] = columns;
	  aQuery["DATA"]= data;
	  aQuery["__QUERY__"] = true;
	  aQuery["length"] = length;
	  aQuery["recordCount"] = length;
	  aQuery["columnList"] = columnList;
	  aQuery["currentRow"] = currentRow;	 
}

function _toCFQueryRowFormat(q1)
{
	  var len = q1.length, i;
	  var first = true;
	  var aQuery = new Object();
	  var queryRows = [];
	  var colList = [];
	  for (i = 0; i < len; i++) 
	  {
	  	var aRow = q1.item(i);
	  	var aRecord = [];
		for(var key in aRow)
		{
			if(aRow.hasOwnProperty(key))
			{
				aRecord.push(aRow[key]);
				if(first)
				{
					colList.push(key);
				}
			}
		}
		first = false;	
		queryRows.push(aRecord);
	  }		
	  _setCFQueryProperties(aQuery,colList,queryRows,q1.length,q1.length,colList,queryRows[0]);	  
	  return aQuery;
}

function _toCFQueryColumnFormat(qResult)
{
	  var q1 = qResult.rows;
	  var len = q1.length, i;
	  var first = true;
	  var aQuery = new Object();
	  var queryCols = {};
	  var colList = [];
	  for (i = 0; i < len; i++) 
	  {
	  	var aRow = q1.item(i);
		for(var key in aRow)
		{
			if(aRow.hasOwnProperty(key))
			{
				if(first)
				{
					colList.push(key);
					queryCols[key] = [];
				}
				queryCols[key].push(aRow[key]);
			}
		}
		first = false;	
	  }	
      var firstRow = [];
      for (i = 0; i < colList.length; i++) 
      {
            var colName = colList[i];
            firstRow.push(queryCols[colName][0]);
      } 	  
     
	  _setCFQueryProperties(aQuery,colList,queryCols,q1.length,q1.length,colList,firstRow);
	   aQuery["ROWCOUNT"]= q1.length;
	  return aQuery;
}

function _toCFQueryColumnFormat2(qResult,vName)
{
	if(qResult.DATA && qResult.COLUMNS){
	  var q1 = qResult.DATA;
	  var len = q1.length, i;
	  var first = true;
	  var aQuery = new Object();
	  var queryCols = {};
	  var colList = qResult["columnList"];
	  if(!colList)
         colList = qResult.COLUMNS;
	  for (i = 0; i < len; i++) 
	  {
	  	var aRow = q1[i];
		x = 0;
		for(x = 0; x < aRow.length; x++)
		{
			//if(aRow.hasOwnProperty(key))
			{
				var key = colList[x];
				if(first)
				{
					//colList.push(key);
					queryCols[key] = [];
				}
				queryCols[key].push(aRow[x]);
			}
		}
		first = false;	
	  }	
      var firstRow = [];
      for (i = 0; i < colList.length; i++) 
      {
            var colName = colList[i];
			if(queryCols[colName])
             firstRow.push(queryCols[colName][0]);
      } 	  
     
	  _setCFQueryProperties(aQuery,colList,queryCols,q1.length,q1.length,colList,firstRow);
	   aQuery["ROWCOUNT"]= q1.length;
	   if(vName)
	    aQuery["VNAME"]= vName;
	  return aQuery;
	}
	return qResult;
}

function _queryRowToColumnFormat(qry)
{
	
	try{
		  qry  = JSON.parse(qry);
		}catch(e){
	
	}
	if(qry.hasOwnProperty('queryvariablename')){
       qry.delete('queryvariablename')	
	}
	if(qry.hasOwnProperty("ROWCOUNT") || qry.hasOwnProperty("rowcount"))
	{
		return qry;
	}
	else
	{
	  qry = _toCFQueryColumnFormat2(qry);
	  if(qry.hasOwnProperty("ROWCOUNT") || qry.hasOwnProperty("rowcount"))
	{
		return qry;
	}
	
	  var len = qry.length;
	  var first = true;
	  var queryCols = {};
	  var data = qry["DATA"];
	  var colList = qry["columnList"];	  
	  for (var i = 0; i < len; i++) 
	  {
	  	var aRow = data[i];
	  	for (var j = 0; j < aRow.length; j++) 
		{
		 	if(first)
			{
				queryCols[colList[j]] = [];
			}
			queryCols[colList[j]].push(aRow[j]);
		}
		first = false;
	  }		
	  qry["DATA"]= queryCols;
	  qry["ROWCOUNT"]= qry.length;
      var firstRow = [];
      for (var i = 0; i < colList.length; i++) 
      {
            var colName = colList[i];
            firstRow.push(queryCols[colName][0]);
      } 	  
	  qry["currentRow"] = firstRow;
	  return qry;
	}
}

function isCustomFunction(value){
	   if(typeof value == 'function')
		          return 'YES'
		return 'NO'
}

function _getQueryRow(qry, rowNum)
{
	var qRow = new Object();
	for (var i = 0; i < qry.columnList.length; i++) 
	{
		var colName= qry.columnList[i];
		qRow[colName] = qry["DATA"][colName][rowNum];
	}
	return qRow;
}

function isQuery(q1)
{
	return typeof q1 !== 'undefined' && q1.hasOwnProperty("__QUERY__");
}

function sleep(ms) {
    var date = new Date();
    var curDate = null;
    do { curDate = new Date(); }
    while(curDate-date < ms);
}

function IsObject(value){
	//example = createObject("component","_GetComponentMetaData"); 
    //writeOutput( IsObject( example ) )
	//handling above scenario
	if(value.hasOwnProperty('cfcPath'))
		return 'YES';
	if(isSimpleValue( value ) || isStruct( value ) || isArray( value ) )
		return 'NO';
   return 'YES';
}

function asc(str)
{
	_validateParameters(asc.arguments.length, 1, "asc");
	if(str == "")
		return 0;
	
	return str.charCodeAt(0);
}

function chr(code)
{
	_validateParameters(chr.arguments.length, 1, "chr");
	
	if(code == 0)
		return "";
	
	return String.fromCharCode(code);
}

function cJustify(valStr, length)
{
	_validateParameters(cJustify.arguments.length, 2, "cJustify");	
	
	var str = new String(valStr);
	var prefix = Math.floor((length - len(str))/2);
	var suffix = Math.floor((length - (len(str) + prefix)));
	
	for(var i=0;i < prefix;i++)
	{
		str = " " + str;
	}
	
	for(var i=0;i < suffix;i++)
	{
		str = str + " ";
	}
	
	return str;
}

function compare(str1, str2)
{
	_validateParameters(compare.arguments.length, 2, "compare");
	
	return _compareStr(str1, str2, true);
}

function compareNoCase(str1, str2)
{
	_validateParameters(compareNoCase.arguments.length, 2, "compareNoCase");
	
	return _compareStr(str1, str2, false);
}

function _find(str, subString, start)
{
	return find(subString, str, start);
}
function find(subString, str, start)
{
	_validateParameters(find.arguments.length, 2, "find");
	
	if(typeof start == "undefined" || start < 1)
		start = 0;
	else
		start = start - 1;
	
	var tempStr = str.substring(start);
	
	var index = tempStr.search(____escapeRegExp(subString));
	
	if(index == -1)
		return 0; 
	
	return  Math.floor(index + 1 + start);
}

function _findnocase(str, subString, start)
{
	return findNoCase(subString, str, start);
}

function findNoCase(subString, str, start)
{
	_validateParameters(findNoCase.arguments.length, 2, "findNoCase");
	
	if(typeof start == "undefined" || start < 1)
		start = 0;
	else
		start = start - 1;
	
	var tempStr = str.substring(start).toLowerCase();
	
	var index = tempStr.search(____escapeRegExp(subString.toLowerCase()));
	
	if(index == -1)
		return 0; 
	
	return  Math.floor(index + 1 + start);
}

function _findoneof(str, subString, start)
{
	return findOneOf(subString, str, start);
}

function findOneOf(subString, str, start)
{
	_validateParameters(findOneOf.arguments.length, 2, "findOneOf");
	
	if(typeof start == "undefined" || start < 1)
		start = 0;
	else
		start = start - 1;
		
	var tempStr = str.substring(start);
	var minIndex = tempStr.length;
	var found = false;
	for(var i=0; i<subString.length;i++)
	{
		var index = tempStr.search(____escapeRegExp(subString[i]));
		if (index >= 0 && index < minIndex) 
		{
			minIndex = index;
			found = true;
		} 
	}
	
	if(found)
		return Math.floor(minIndex + start + 1);
	
	return 0;
	
}

function formatBaseN(_number, radix)
{
	_validateParameters(formatBaseN.arguments.length, 2, "formatBaseN");
	
	if (radix == 2) 
	{
	
		var number = new Number(_number);		
		
		var num = number.valueOf();
		var temp = Math.pow(2, 31);
		if (num > (temp * 2 - 1) || num < -temp) 
			return '';
		var arr = new Array(32);
		for (var i = 31; i >= 0; --i) 
		{
			arr[i] = (num & 1);
			num = num >>> 1;
		}
		var retStr =  arr.join('');
		var result = "";
		var notStarted = true;
		for(var i=0;i < retStr.length; i++)
		{
			if(retStr[i] == 0 && notStarted)
				continue;
			else
			{
				result = result + retStr[i];
				if(notStarted)
					notStarted = false;
			}
		}
		if(notStarted)
			result = "0";
		
		return result;
	}
	else
		return _number.toString(radix);
}

function _insert(str, subString, position)
{
	return insert(subString, str, position);
}

function insert(subString, str, position)
{
	_validateParameters(insert.arguments.length, 3, "insert");
	
	if(position < 0 || position > str.length)
		throw "position parameter must be less than or equal to length of second parameter which is now "+str+" and had length of "+str.length;
	
	return str.substr(0, position) + subString + str.substr(position);	
}

function isString(str)
{
	_validateParameters(isString.arguments.length, 1, "isString");
	
	if(typeof str == "string")
		return true;
		
	return false;
}

function jsStringFormat(str)
{
	_validateParameters(jsStringFormat.arguments.length, 1, "jsStringFormat");
	var result = "";
	for(var i=0; i<str.length;i++)
	{
		var c = str[i];
		
		switch(c)
		{
			case '\n':
			{
				result = result + "\\n";
				break;
			}
			case '\r':
			{
				result = result + "\\r";
				break;
			}
			case '\t':
			{
				result = result + "\\t";
				break;
			}
			case '\b':
			{
				result = result + "\\b";
				break;
			}
			case '\f':
			{
				result = result + "\\f";
				break;
			}
			case '"':
			{
				result = result + "\\\"";
				break;
			}
			case '\'':
			{
				result = result + "\\'";
				break;
			}
			case '\\':
			{
				result = result + "\\\\";
				break;
			}
			default:
			{
				result = result + c;
			}
		}
	}
	return result;
}

function lCase(str)
{
	_validateParameters(lCase.arguments.length, 1, "lCase");
	return str.toLowerCase();
}

function left(str, count)
{
	_validateParameters(left.arguments.length, 2, "left");
	return str.substring(0, count);
}

function len(str)
{
	 str = str + "";
	_validateParameters(len.arguments.length, 1, "len");
	
	if(typeof str == "undefined")
		return 0;
	
	if(str == "" || asc(str[0]) == 0)
		return 0;
			
	return str.length;
}

function lJustify(str, length)
{
	_validateParameters(lJustify.arguments.length, 2, "lJustify");
	
	var result = new String(str);
	
	length = Math.floor(length);
	
	if(length > len(result))
	{
		var count = length - len(result);
		for(var i=0; i < count; i++)
		{
			result = result + " ";
		}
	}		
	
	return result;
}

function lTrim(str)
{
	_validateParameters(lTrim.arguments.length, 1, "lTrim");	
    
    return str.replace(/^\s+/g,'');
}

function rTrim(str)
{
	_validateParameters(rTrim.arguments.length, 1, "rTrim");	
	
    return str.replace(/\s+$/g,'');
}

function removeChars(str, start, count)
{
	_validateParameters(removeChars.arguments.length, 3, "removeChars");	
	
	start = --start;
	start = Math.floor(start);
	
	if(start < 0)
		throw "Second parameter start should be positive integer";
	
	if (start > str.length)
		throw "Second parameter start should be less than length of first parameter";
			
	if(start + count > str.length)
		return str.substring(0, start);		
	
	var result = str.substring(0,start);
	result = result + str.substring(start+count,str.length);
		
	return result;
}

function repeatString(str, count)
{
	_validateParameters(repeatString.arguments.length, 2, "repeatString");	
	
	var result = "";
	
	count = Math.floor(count);
	
	for(var i=0; i < count ; i++)
	{
		result = result + str;
	}
		
	return result;
}

function mid(str, start, count)
{
	_validateParameters(mid.arguments.length, 3, "mid");
	
	start = --start;	
	
	start = Math.floor(start);
	
	if (start < 0 || start > str.length)
		return "";	
		
	count = Math.floor(count);

	var result = "";
	var len = str.length;
	
	if(len > start + count)
		len = start + count;
		
	for(var i=start; i < len;i++)
	{
			result = result + str[i];
	}
	
    return result;
}

function paragraphFormat(str)
{
	_validateParameters(paragraphFormat.arguments.length, 1, "paragraphFormat");
	
	var result = "";
	var newLine = false;
	
	for (var i = 0; i < str.length; i++) 
	{
		var c = str[i];
		
		switch (c)
		{
			case '\n':
			{
				if (newLine) 
				{
					result = result + "<p>\r\n";
					newLine = false;
				}
				else 
				{
					result = result + " ";
					newLine = true;
				}
				
				break;
			}
			case '\r':
			{
				if(i + 1 < str.lenght)
				{
					if(str.charat(i+1) == '\r')
						newLine = false;
				}
				result = result + " ";
				break;
			}
			default:
			{
				result = result + c;
				newLine = false;
			}
		}
	}
	
    return str;
}

function spanExcluding(str, set)
{
	_validateParameters(spanExcluding.arguments.length, 2, "spanExcluding");
	
	for (var i = 0; i < str.length; i++) 
	{
		var c = str[i];
		
		if(find(c,set) > 0)
			return str.substring(0,i);
	}
	
    return str;
}

function right(str, count)
{
	_validateParameters(right.arguments.length, 2, "right");
	
	if(count >= str.length)
		return str;
	if(str == "")
		return str;
		
	return str.substring(str.length - count, str.length);
}

function rJustify(str, length)
{
	_validateParameters(rJustify.arguments.length, 2, "rJustify");
	
	var result = new String(str);
	
	if(length > result.length)
	{
		var count = length - result.length;
		for(var i=0; i < count; i++)
		{
			result = " " + result;
		}
	}		
	
	return result;
}

function spanIncluding(str, set)
{
	_validateParameters(spanIncluding.arguments.length, 2, "spanIncluding");
	
	var result = "";
	for (var i = 0; i < str.length; i++) 
	{
		var c = str[i];
		
		if (find(c, set) > 0) 
		{
			result = result + c;
		}
		else if(result.length >  0)
			break;
	}
	
    return result;
}

function stripCR(str)
{
	_validateParameters(stripCR.arguments.length, 1, "stripCR");
	
	var result = "";
	for (var i = 0; i < str.length; i++) 
	{
		if(str[i] != "\r")
			result = result + str[i];
	}
	
    return result;
}

function trim(str)
{
	_validateParameters(trim.arguments.length, 1, "trim");
	
	return str.replace(/^\s+|\s+$/g,'');
}

function uCase(str)
{
	_validateParameters(uCase.arguments.length, 1, "uCase");
	
	return str.toUpperCase();
}

function val(str)
{
	_validateParameters(val.arguments.length, 1, "val");
	
	var result = "";
	var number = 0;
	var gotDecimal = false;
	var foundNumber = false;
	var sign = 1;
	if (str.length > 0) 
	{
		if (str[0] == "-" || str[0] == "+")
		{
			if(str[0] == "-")
				sign = -1;
			str = str.substring(1);
		}
		 
		for (var i = 0; i < str.length; i++) 
		{
			if ((!isNaN(str[i]) && str[i] != " ") || (str[i] == "." && !gotDecimal)) 
			{
				if (str[i] == ".") 
					gotDecimal = true;
				result = result + str[i];
				foundNumber = true;
				
			}
			else 
				if (foundNumber || str[i] != " ") 
					break;
		}
		
		if (result != "") 
			number = new Number(result).valueOf();
	}
		
	return number*sign;
}

function reFind(expression, str, start, returnSubExpression)
{
	_validateParameters(reFind.arguments.length, 2, "reFind");
	
	return _refind(expression, str, start, returnSubExpression, false);
}

function reFindNoCase(expression, str, start, returnSubExpression)
{
	_validateParameters(reFindNoCase.arguments.length, 2, "reFindNoCase");
	
	return _refind(expression, str, start, returnSubExpression, true);
}

function reEscape(regexExpr)
{
	_validateParameters(reEscape.arguments.length, 1, "reEscape");
	
	return ____escapeRegExp(regexExpr);
}

function reverse(str)
{
	_validateParameters(reverse.arguments.length, 1, "reverse");
	
	var result = "";
	for(var i = str.length -1 ; i >=0 ; --i)
	{
		result = result + str[i];
	}
	
	return result;
}

function inputBaseN(str, radix)
{
	_validateParameters(inputBaseN.arguments.length, 2, "inputBaseN");
	return parseInt(str, radix);
}

function _refind(expression, str, start, returnSubExpression, ignoreCase)
{
	
	if("undefined" == typeof start || start < 1)
		start = 1;
		
	start = start -1;
	
	if("undefined" == typeof returnSubExpression)
		returnSubExpression = false;
		
	var searchString = str.substring(start);
	
	var adjustedRegex = _adaptPOSIXRegex(expression);
	var modifier = "";
	if(find("(?m)",adjustedRegex) > 0)
	{
		adjustedRegex = replace(adjustedRegex,"(?m)","");
		modifier = modifier + "m";
	}
	if(find("\\A",adjustedRegex) > 0)
		adjustedRegex = replace(adjustedRegex,"\\A","^");
	
	var pattern = new RegExp(adjustedRegex,modifier);
	
	if(ignoreCase)
	{
		modifier = modifier + "i";
		pattern = new RegExp(adjustedRegex, modifier);
	}
	
	searchResult = pattern.exec(searchString);
	if (searchResult != null) 
	{
	
		if (!returnSubExpression) 
			return Math.floor(searchResult["index"] + 1 + start);
		else 
		{
			var result = new Object();
			var lenArray = new Array();
			var posArray = new Array();
			var strMatch;
			if (searchResult == null) 
			{
				lenArray[0] = 0;
				posArray[0] = 0;
			}
			else
			{
				for(var i=0;i<searchResult.length;i++)
				{					
					strMatch = searchResult[i];
					lenArray[i] = strMatch.length;
					posArray[i] = searchString.indexOf(strMatch,0)+1;					
				}
				
			}			
			result["LEN"] = lenArray;
			result["POS"] = posArray;
			result["MATCH"] = strMatch;
			
			return result;
		}
	}
	return 0;
	
	
}

function reMatch(expression, str)
{
	_validateParameters(reMatch.arguments.length, 2, "reMatch");
	
	return _ReMatch(expression, str, false);
}

function reMatchNoCase(expression, str)
{
	_validateParameters(reMatchNoCase.arguments.length, 2, "reMatch");
	
	return _ReMatch(expression, str, true);
}

function replace(str, subStr1, subStr2, scope)
{
	_validateParameters(replace.arguments.length, 3, "replace");
	
	if(typeof scope == "undefined")
		scope = "one";
		
	if(scope.toLowerCase() != "one" && scope.toLowerCase() != "all")
		throw "Invalid Scope";
	
	return _replace(str, subStr1, subStr2, scope, false);
}

function replaceNoCase(str, subStr1, subStr2, scope)
{
	_validateParameters(replaceNoCase.arguments.length, 3, "replaceNoCase");
	
	if(typeof scope == "undefined")
		scope = "one";
		
	if(scope.toLowerCase() != "one" && scope.toLowerCase() != "all")
		throw "Invalid Scope";
	
	return _replace(str, subStr1, subStr2, scope, true);
}

function reReplace(str, subStr1, subStr2, scope)
{
	_validateParameters(reReplace.arguments.length, 3, "reReplace");
	
	if(typeof scope == "undefined")
		scope = "one";
		
	if(scope.toLowerCase() != "one" && scope.toLowerCase() != "all")
		throw "Invalid Scope";
	
	return _rereplace(str, subStr1, subStr2, scope, false);
}

function reReplaceNoCase(str, subStr1, subStr2, scope)
{
	_validateParameters(reReplaceNoCase.arguments.length, 3, "reReplaceNoCase");
	
	if(typeof scope == "undefined")
		scope = "one";
		
	if(scope.toLowerCase() != "one" && scope.toLowerCase() != "all")
		throw "Invalid Scope";
	
	return _rereplace(str, subStr1, subStr2, scope, true);
}

function ____escapeRegExp(str) {
	  return str.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&");
	}

function _replace(str, subStr1, subStr2, scope, ignoreCase)
{
	var regExScope = "";
	if(scope.toLowerCase() == "all")
		regExScope = "g";
		
	if(ignoreCase)
		regExScope = regExScope + "i";
		
	var adjustedRegex = ____escapeRegExp(subStr1);
	
	var regEx = new RegExp(adjustedRegex, regExScope);
	return str.replace(regEx, subStr2);
	
	
	
}

function _rereplace(str, subStr1, subStr2, scope, ignoreCase)
{
	var regExScope = "";
	if(scope.toLowerCase() == "all")
		regExScope = "g";
		
	if(ignoreCase)
		regExScope = regExScope + "i";
		
	var adjustedRegex = _adaptPOSIXRegex(subStr1);
	if(adjustedRegex == subStr1)
	{
		//if there is regex of type [xyz] don't escape
		if(find("[",subStr1) == 0 && find("]",subStr1) == 0)			
			adjustedRegex = ____escapeRegExp(subStr1);//escape in case we have not adjusted posix notation
	}
	
	//adjust any $ in substitution string
	var regEx = new RegExp(____escapeRegExp("$"),"g");
	var subStr = subStr2.replace(regEx,"$$$$");
	subStr =  _adaptPOSIXRegex(subStr);
	
	var regEx = new RegExp(adjustedRegex, regExScope);
	return str.replace(regEx, subStr);
	
}

function _ReMatch(expression, str, ignoreCase)
{
	
	var pattern = new RegExp(expression,"g");
	
	if(ignoreCase)
		pattern = new RegExp(expression, "gi");
		
	var searchResult= pattern.exec(str);
	var result = new Array();
	var index = 0;
	while (searchResult != null) 
	{		
		result[index] = searchResult[0];
		++index;
		searchResult = pattern.exec(str);
	}
	
	return result;
}

function toString(obj)
{
	_validateParameters(toString.arguments.length, 1, "toString");
	
	if("object" != typeof obj)
		return obj.toString();
		
	return obj + "";
	
}

function wrap(str, limit, strip)
{
	_validateParameters(wrap.arguments.length, 2, "wrap");
	
	var result = "";
	if (strip)
    {
        str = replace(str,'\r',' ');
        str = replace(str,'\r',' ');
    }
    var start = 0;
    var backtrack = false;
    function isWhiteSpace(item)
    {
    	if(item.trim().length == 0)
    		return true;
    		
    	return false;
    }
    while(start < str.length)
    {
    	var end = start + limit;
    	if (end > str.length)
        	end = str.length;
        
        // look for next whitespace, backwards
        while (end > 0 && end < str.length &&
                !isWhiteSpace(str[end])) 
        {
            --end;
        }
        
        if (end <= start)
        {
            end = start + limit;  
            backtrack = true;
        }
        
        result = result + trim(str.substring(start, end));
        result = result + "\r\n";
        
        if(backtrack)
        	start = end;
        else
            start = end + 1;
    	
    }
    return result;
}


function _isAlphabetic(str)
{
	return /^[a-zA-Z]+$/.test(str);
}

function _compareStr(a, b, caseSensitive)
{
    if (caseSensitive) 
    {
        if (a < b) 
            return -1;
        if (a > b) 
            return 1;
        return 0;
    }
    else 
    {
        if (a.toLowerCase() < b.toLowerCase()) 
            return -1;
        if (a.toLowerCase() > b.toLowerCase()) 
            return 1;
        return 0;
    }
}

function _adaptPOSIXRegex(expression)
{
	var _expression = expression;
	var regEx = new RegExp("\\[\\[:space:\\]\\]", "gi");	
	_expression =  _expression.replace(regEx, "\\s");
	
	regEx = new RegExp("\\[\\[:alnum:\\]\\]", "gi");	
	_expression =  _expression.replace(regEx, "[A-Za-z0-9]");
	
	regEx = new RegExp("\\[\\[:alpha:\\]\\]", "gi");	
	_expression =  _expression.replace(regEx, "[A-Za-z]");
	
	regEx = new RegExp("\\[\\[:blank:\\]\\]", "gi");	
	_expression =  _expression.replace(regEx, "[ \\t]");
	
	regEx = new RegExp("\\[\\[:cntrl:\\]\\]", "gi");	
	_expression =  _expression.replace(regEx, "[\\x00-\\x1F\\x7F]");
	
	regEx = new RegExp("\\[\\[:digit:\\]\\]", "gi");	
	_expression =  _expression.replace(regEx, "[0-9]");
	
	regEx = new RegExp("\\[\\[:graph:\\]\\]", "gi");	
	_expression =  _expression.replace(regEx, "[\\x21-\\x7E]");
	
	regEx = new RegExp("\\[\\[:lower:\\]\\]", "gi");	
	_expression =  _expression.replace(regEx, "[a-z]");
	
	regEx = new RegExp("\\[\\[:print:\\]\\]", "gi");	
	_expression =  _expression.replace(regEx, "[\\x20-\\x7E]");
	
	regEx = new RegExp("\\[\\[:punct:\\]\\]", "gi");	
	_expression =  _expression.replace(regEx, '[!"#$%&\'()\\[\\]*+,./:;<=>?@\^_`{|}~-]');		
	
	regEx = new RegExp("\\[\\[:upper:\\]\\]", "gi");	
	_expression =  _expression.replace(regEx, "[A-Z]");
	
	regEx = new RegExp("\\[\\[:xdigit:\\]\\]", "gi");	
	_expression =  _expression.replace(regEx, "[A-Fa-f0-9]");
	
	regEx = new RegExp("\\[\\[:word:\\]\\]", "gi");	
	_expression =  _expression.replace(regEx, "[A-Za-z0-9_]");
	
	regEx = new RegExp("\\\\Z", "g");	
	_expression =  _expression.replace(regEx, "$");	
	
	return _expression;
}

function duplicate(structVar)
{
	_validateParameters(duplicate.arguments.length, 1, "duplicate");
	
	if(structVar == null || "object" != typeof structVar)
		return structVar;
	else
	{
		return _cf_duplicate(structVar, {});
	}
}

function _cf_duplicate(structVar, refCache)
{
	if(structVar in refCache)
		return refCache[structVar];
	else
	{
		if(structVar == null || "object" != typeof structVar)
			return structVar;
		else
		{
			var copy = new Object();
			if (structVar instanceof Array) 
			{
				for (var i=0; i< structVar.length; i++) 
				{				
					copy[i+1] = _cf_duplicate(structVar[i],refCache);
				}
			
			}
			else 
			{
			
				for (var item in structVar) 
				{
					if (structVar.hasOwnProperty(item)) 
						copy[item] = _cf_duplicate(structVar[item],refCache);
				}
			}
			
			refCache[structVar] = copy;
			return copy;
		}
	}
}

function isStruct(structVar)
{
	_validateParameters(isStruct.arguments.length, 1, "isStruct");
	
	return ("object" == typeof structVar);
	
}

function structAppend(struct1, struct2, overwriteFlag)
{
	_validateParameters(structAppend.arguments.length, 2, "structAppend");
	
	var overwrite = true;
	if(overwriteFlag != null)
		overwrite = overwriteFlag;
		
	for(var item in struct2)
	{
		if (struct2.hasOwnProperty(item)) 
		{
			if (item in struct1) 
			{
				if (overwrite) 
					struct1[item] = struct2[item];
			}
			else 
				struct1[item] = struct2[item];
		}
			
	}
	return true;
}

function structClear(structVar)
{
	_validateParameters(structClear.arguments.length, 1, "structClear");
	
    for (var prop in structVar) 
    {
        if (structVar.hasOwnProperty(prop)) 
        {
            delete structVar[prop];
        }
    }
	
	return true;
}

function structCopy(structVar)
{
	_validateParameters(structCopy.arguments.length, 1, "structCopy");
	
	if(structVar == null)
		throw new IllegalArgumentException();
	else
	{
		var copy = new Object();
		
        for (var item in structVar) 
        {
           if(structVar[item] instanceof Array)
                {
                	copy[item] = structVar[item].slice(0);
                	if(typeof structVar[item]._dim != "undefined")
                		copy[item]._dim = structVar[item]._dim;
                }
                else
                	copy[item] = structVar[item];
        }
		
		return copy;
	}
}

function structCount(structVar)
{
	_validateParameters(structCount.arguments.length, 1, "structCount");
	
	if(structVar == null)
		throw new IllegalArgumentException();
	else
	{
		var count = 0;
        for (var item in structVar) 
        {
            if (structVar.hasOwnProperty(item)) 
                count++;
        }
		
		return count;
	}
}

function structFind(structVar, key)
{
	_validateParameters(structFind.arguments.length, 2, "structFind");
	
	if(structVar == null)
		throw new IllegalArgumentException();
	
	if(key in structVar)
		return structVar[key];	
	else
		throw "Cannot find "+key+" in structure";
}

function structFindKey(top, value, scope)
{
	_validateParameters(structFindKey.arguments.length, 2, "structFindKey");
	
	if(top == null)
		throw new IllegalArgumentException();
	
	if("undefined" == typeof scope)
		var scope = "one";	
		
	if(scope.toLowerCase() != "all" && scope.toLowerCase() != "one")
		throw "Invalid Scope "+scope;
		
	var resultArray = [];
	var index = 0;
	
	_structFindKey(top,value,scope.toLowerCase(),resultArray,"",index);
	
	function _structFindKey(top, value, scope, resultArray, path, index)
	{	
		var result = null;
		
		if(index == 1 && scope != "all")
			return index;
			
		if("object" == typeof top)
		{
			for (var item in top) 
			{
				if (item == value) 
				{
					result = new Object();
					result.value = top[item];
					result.path = path + "." + item;
					result.owner = top;
					resultArray[index] = result;
					index++;
					
				}
				else 
					index = _structFindKey(top[item], value, scope, resultArray, path + "." + item, index);
					
				if(index == 1 && scope != "all")
						return index;
			}
		}
		
		return index;
		
	}
	
	return resultArray;	
}

function structFindValue(top, value, scope)
{
	_validateParameters(structFindValue.arguments.length, 2, "structFindValue");
	
	if(top == null)
		throw new IllegalArgumentException();
		
	if("undefined" == typeof scope)
		var scope = "one";	
	
	var resultArray = [];
	var index = 0;
	
	function _getItem(num)
	{
		if(isNumeric(num))
			return parseInt(num)+1;
			
		return num;
	}
	
	_structFindValue(top,value,scope,resultArray,"",index);
	
	function _structFindValue(top, value, scope, resultArray, path, index)
	{	
		var result = null;
		if(index == 1 && scope != "all")
			return index;
			
		if("object" == typeof top)
		{
			for (var item in top) 
			{
				if (top[item] == value) 
				{
					result = new Object();
					result.path = path + "." + item;
					result.owner = top;
					result.key = item;
					resultArray[index] = result;
					index++;
				}
				else 
					index = _structFindValue(top[item], value, scope, resultArray, path + "." + _getItem(item), index);
			}
		}
		
		return index;
		
	}
	
	return resultArray;
	
}

function structGet(path)
{
	_validateParameters(structGet.arguments.length, 1, "structGet");
	
	if(path == "" || typeof path == "undefined")
		throw "Invalid Path";
		
	var keys = path.split(".");
	
	var pathStr = "";
	var mainObj = null;
	
	function _getObjInstance(str)
	{
		var result = new Object();
		var start = str.indexOf("[");
		var end = str.indexOf("]");
		if(start > 0 && end > start && end == str.length-1)
		{
			var stem = str.substring(0,start);
			var key = str.substring(start+1,end);
			
			var obj = [];
			result.value = obj;
			result.path = str.substring(0,start);
			result.index = key;
		}
		else
		{
			result.value = new Object();
			result.path = str;
			result.index = "";
		}
		return result;
	}
	var arrIndex = "";
	for(var key in keys)
	{		
		pathStr = keys[key];
		if(mainObj === null)
		{
			if(typeof window[pathStr] === "undefined")
				window[pathStr]= new Object();
				
			mainObj = window[pathStr];
		}
		else
		{
			var res = _getObjInstance(pathStr);
			if(arrIndex == "")
			{
				mainObj[res.path] = res.value;
				mainObj = mainObj[res.path];				
			}
			else
			{
				var temp = new Object();
				temp[pathStr] = res.value;
				__$cf.__arraySet(mainObj, temp, arrIndex);				
				mainObj = mainObj[__$cf.__decrNum(arrIndex,true)][pathStr];

			}
			arrIndex = res.index;
		}		
		
	}
	
	return mainObj;
}

function structKeyArray(structVar)
{
	_validateParameters(structKeyArray.arguments.length, 1, "structKeyArray");
	
	if (structVar != null) 
	{
		var returnArray = new Array();
		var index = 0;
		
		for(var key in structVar)
		{
			if (structVar.hasOwnProperty(key)) 
			{
				returnArray[index] = key;
				index++;
			}
		}	
		
		return returnArray;
		
	}
	else
		throw new IllegalArgumentException();
}

function structKeyList(structVar, delim)
{
	_validateParameters(structKeyList.arguments.length, 1, "structKeyList");
    var result = "";
    
    if (typeof delim == 'undefined') 
        delim = ",";
    
    var isFirst = true;
	var isArr = isArray(structVar);
    for (var key in structVar) 
    {
		if (structVar.hasOwnProperty(key)) 
		{
			key = __$cf.__incrNum(key,isArr);//adjust key
			if (!isFirst) 
				result += delim;
			else 
				isFirst = false;
			
			result += key;
		}
    }
    
    return result;
}

function structNew()
{
	return new Object();
}

function structKeyExists(structVar, key)
{
	_validateParameters(structKeyExists.arguments.length, 2, "structKeyExists");
	
	if(structVar == null)
		return false;
	
    if (key in structVar) 
        return true;
    else 
        return false;
}

function structDelete(structVar, key, indicateNotExisting )
{
	_validateParameters(structDelete.arguments.length, 2, "structDelete");
	
	if (key in structVar) 
	{
		delete structVar[key];
		return true;
	}
	
	if(indicateNotExisting != null && indicateNotExisting)
		return false;
	else
		return true;
}

function structInsert(structVar, key1, value, allowOverwrite)
{
	_validateParameters(structInsert.arguments.length, 3, "structInsert");
	
	var overwrite = true;
	if(allowOverwrite != null)
		overwrite = allowOverwrite;
		
	var key = key1;
		
	if(key in structVar)
	{
		if(overwrite)
			structVar[key] = value;
		else
			throw "Key already Exists";
	}
	else
	{
		structVar[key] = value;
	}
	
	return true;
}

function structIsEmpty(structVar)
{
	_validateParameters(structIsEmpty.arguments.length, 1, "structIsEmpty");
	
	if(structVar != null)
	{
		if (!Object.keys) 
		{
	    	Object.keys = function (obj) 
			{
	       	 	var keys = [], k;
	        	for (var k in obj) 
				{
	            	if (Object.prototype.hasOwnProperty.call(obj, k)) 
					{
	                	keys.push(k);
					}
	        	}
	        return keys;
	    	};
		}
		
		var count = Object.keys(structVar).length;
		
		return (count == 0);
	}
	else
		throw new IllegalArgumentException();
	
}

function structSort(base, sortType, sortOrder, pathToSubElement, localeSensitive)
{
	_validateParameters(structSort.arguments.length, 1, "structSort");
	if(base == null)
		throw new IllegalArgumentException();
		
	if("undefined" == typeof sortType)
		var sortType = "text";
		
	if("undefined" == typeof sortOrder)
		var sortOrder = "asc";
		
	if("undefined" == typeof localeSensitive)
		var localeSensitive = false;
		
	if(structCount(base) == 0)
		return new Array();
		
	var value_arr = new Array();
	var value_map = new Object();
	var value_arr_index = 0;
		
	//create array of values to sort
	for(var key in base)
	{
		if (base.hasOwnProperty(key)) 
		{
			var keyName = key;
			var value = base[key];
			if(typeof pathToSubElement != "undefined")
			{
				var keys = pathToSubElement.split(".");
				for(item in keys)
				{
					value =  value[keys[item]];
				}
			}
			
			var arr = value_map[value];
			
			if (arr == null) 
			{
				arr = new Array();
				value_arr[value_arr_index] = value;
				value_arr_index++;
				value_map[value] = arr;
			}
			
			var index = arr.length;
			arr[index] = key;
		}
	}
	
	//sort value array
	arraySort(value_arr, sortType, sortOrder, localeSensitive);
	
	var resultArray = new Array();
	var index = 0;
	for(var item in value_arr)
	{
		var keyArray = value_map[value_arr[item]];
		
		if(keyArray != null)
		{
			for(var keyItem in keyArray)
			{
				resultArray[index] = keyArray[keyItem];
				index++;
			}
		}
		
	}
	
	return resultArray;
		
	
}

function structUpdate(structVar, key1, value)
{
	_validateParameters(structUpdate.arguments.length, 3, "structUpdate");
	var key = key1;
	if (structVar != null) 
	{
	
		if (key in structVar) 
		{
			structVar[key] = value;
		}
		else 
		{
			throw "Cannot find " + key + " key in structure";
		}
	}
	else
		throw new IllegalArgumentException();
	
	return true;
}

function _arraySort(arrayObj, sortType, sortOrder, localeSensitive)
{
	switch (sortType)
	{
		case "numeric" :
		{
			if(sortOrder != "desc")
				arrayObj.sort(function(a,b){return a-b} );
			else
				arrayObj.sort(function(a,b){return b-a} );
			break;
		}
		
		case "text" :
		{
			if (localeSensitive) 
			{
				arrayObj.sort(function(a, b)
				{
					return a.localeCompare(b);
				});
			}
			else 
				arrayObj.sort();
				
			if (sortOrder == "desc") 
				arrayObj.reverse();
		}
		
		case "textnocase" :
		{
			if (localeSensitive) 
			{
				arrayObj.sort(function(a, b)
				{
					return a.toLowerCase().localeCompare(b.toLowerCase()) ;
				});
			
			}
			else 
			{
				arrayObj.sort(function(a, b)
				{
					if (a.toLowerCase() < b.toLowerCase()) 
						return -1;
					if (a.toLowerCase() > b.toLowerCase()) 
						return 1;
					return 0;
				});
			}
				
			if (sortOrder == "desc") 
				arrayObj.reverse();
			
		}
	}
}

function _equals(obj1, obj2)
{
	if(obj1 === obj2)
		return true;
	if(!(obj1 instanceof Object && obj2 instanceof Object ))
		return false;
		
	if(obj1.constructor !== obj2.constructor)
		return false;
		
	for(var prop in obj1)
	{
		if(obj1.hasOwnProperty(prop))
		{
			if(obj1[prop] === obj2[prop])
				continue;
			
			if(typeof obj1[prop] !== "object")
				return false; //return false as primitive properties didn't match
				
			if(! (_equals(obj1[prop], obj2[prop]) ) )
				return false;
		}
	}
	
	return true;	
}

function _validateParameters(argumentCount, requiredCount, functionName)
{
	if(argumentCount < requiredCount)
		throw new ParameterValidationException("Parameter validation error for function "+functionName+". The function takes "+requiredCount+" parameter");		
		
}

function IllegalArgumentException()
{
	this.message = "Undefined Structure";
}

function ParameterValidationException(msg)
{
	this.message = msg;
}

function __memberWrapper(func, args, thisObj, funcName)
{
	Array.prototype.unshift.call(args,thisObj);
	try{
		return func.apply(thisObj, args);
	}catch(e){
		if(e instanceof ParameterValidationException)
		{
			var msg = e.message, len = func.name.length,index= e.message.indexOf(func.name),next = index+len;
			var num = parseInt(msg.substring(next+21,next+22)) -1;
			e.message = msg.substring(0,index)+funcName+msg.substring(next,next+21)+num + msg.substring(next+22);
		}
		throw e;
	}
}

function __initFunctionList() { // Wrap in a function so the var scoped variables stay local
	if (!window._funcInit) {
		// list functions
		Object.defineProperty( String.prototype,"listAppend",{enumerable: false, writable:true, value:function(){ return __memberWrapper(listAppend,arguments, this,"listAppend");}});
		Object.defineProperty( String.prototype,"listChangeDelims",{enumerable: false, writable:true, value:function(){ return __memberWrapper(listChangeDelims,arguments, this,"listChangeDelims");}});
		Object.defineProperty( String.prototype,"listContains",{enumerable: false, writable:true, value:function(){ return __memberWrapper(listContains,arguments, this,"listContains");}});
		Object.defineProperty( String.prototype,"listContainsNoCase",{enumerable: false, writable:true, value:function(){ return __memberWrapper(listContainsNoCase,arguments, this,"listContainsNoCase");}});
		Object.defineProperty( String.prototype,"listDeleteAt",{enumerable: false, writable:true, value:function(){ return __memberWrapper(listDeleteAt,arguments, this,"listDeleteAt");}});
		Object.defineProperty( String.prototype,"listFind",{enumerable: false, writable:true, value:function(){ return __memberWrapper(listFind,arguments, this,"listFind");}});
		Object.defineProperty( String.prototype,"listFindNoCase",{enumerable: false, writable:true, value:function(){ return __memberWrapper(listFindNoCase,arguments, this,"listFindNoCase");}});
		Object.defineProperty( String.prototype,"listFirst",{enumerable: false, writable:true, value:function(){ return __memberWrapper(listFirst,arguments, this,"listFirst");}});
		Object.defineProperty( String.prototype,"listLast",{enumerable: false, writable:true, value:function(){ return __memberWrapper(listLast,arguments, this,"listLast");}});
		Object.defineProperty( String.prototype,"listGetAt",{enumerable: false, writable:true, value:function(){ return __memberWrapper(listGetAt,arguments, this,"listGetAt");}});
		Object.defineProperty( String.prototype,"listInsertAt",{enumerable: false, writable:true, value:function(){ return __memberWrapper(listInsertAt,arguments, this,"listInsertAt");}});
		Object.defineProperty( String.prototype,"listLen",{enumerable: false, writable:true, value:function(){ return __memberWrapper(listLen,arguments, this,"listLen");}});
		Object.defineProperty( String.prototype,"listPrepend",{enumerable: false, writable:true, value:function(){ return __memberWrapper(listPrepend,arguments, this,"listPrepend");}});
		Object.defineProperty( String.prototype,"listQualify",{enumerable: false, writable:true, value:function(){ return __memberWrapper(listQualify,arguments, this,"listQualify");}});
		Object.defineProperty( String.prototype,"listRest",{enumerable: false, writable:true, value:function(){ return __memberWrapper(listRest,arguments, this,"listRest");}});
		Object.defineProperty( String.prototype,"listSetAt",{enumerable: false, writable:true, value:function(){ return __memberWrapper(listSetAt,arguments, this,"listSetAt");}});
		Object.defineProperty( String.prototype,"listSort",{enumerable: false, writable:true, value:function(){ return __memberWrapper(listSort,arguments, this,"listSort");}});
		Object.defineProperty( String.prototype,"listToArray",{enumerable: false, writable:true, value:function(){ return __memberWrapper(listToArray,arguments, this,"listToArray");}});
		Object.defineProperty( String.prototype,"listValueCount",{enumerable: false, writable:true, value:function(){ return __memberWrapper(listValueCount,arguments, this,"listValueCount");}});
		Object.defineProperty( String.prototype,"listValueCountNoCase",{enumerable: false, writable:true, value:function(){ return __memberWrapper(listValueCountNoCase,arguments, this,"listValueCountNoCase");}});
//		Object.defineProperty( String.prototype,"replace",{enumerable: false, writable:true, value:function(){ return __memberWrapper(ReplaceList,arguments, this);}});
		// string functions
		Object.defineProperty( String.prototype,"asc",{enumerable: false, writable:true, value:function(){ return __memberWrapper(asc,arguments, this,"asc");}});
		Object.defineProperty( String.prototype,"insert",{enumerable: false, writable:true, value:function(){ return __memberWrapper(_insert,arguments, this,"insert");}});
		Object.defineProperty( String.prototype,"uCase",{enumerable: false, writable:true, value:function(){ return __memberWrapper(uCase,arguments, this,"uCase");}});
		Object.defineProperty( String.prototype,"lCase",{enumerable: false, writable:true, value:function(){ return __memberWrapper(lCase,arguments, this,"lCase");}});
		Object.defineProperty( String.prototype,"left",{enumerable: false, writable:true, value:function(){ return __memberWrapper(left,arguments, this,"left");}});
		Object.defineProperty( String.prototype,"right",{enumerable: false, writable:true, value:function(){ return __memberWrapper(right,arguments, this,"right");}});
		Object.defineProperty( String.prototype,"rJustify",{enumerable: false, writable:true, value:function(){ return __memberWrapper(rJustify,arguments, this,"rJustify");}});
		Object.defineProperty( String.prototype,"lJustify",{enumerable: false, writable:true, value:function(){ return __memberWrapper(lJustify,arguments, this,"lJustify");}});
		Object.defineProperty( String.prototype,"cJustify",{enumerable: false, writable:true, value:function(){ return __memberWrapper(cJustify,arguments, this,"cJustify");}});
		Object.defineProperty( String.prototype,"mid",{enumerable: false, writable:true, value:function(){ return __memberWrapper(mid,arguments, this,"mid");}});
		Object.defineProperty( String.prototype,"len",{enumerable: false, writable:true, value:function(){ return __memberWrapper(len,arguments, this,"len");}});
		Object.defineProperty( String.prototype,"trim",{enumerable: false, writable:true, value:function(){ return __memberWrapper(trim,arguments, this,"trim");}});
		Object.defineProperty( String.prototype,"removeChars",{enumerable: false, writable:true, value:function(){ return __memberWrapper(removeChars,arguments, this,"removeChars");}});
		Object.defineProperty( String.prototype,"compare",{enumerable: false, writable:true, value:function(){ return __memberWrapper(compare,arguments, this,"compare");}});
		Object.defineProperty( String.prototype,"compareNoCase",{enumerable: false, writable:true, value:function(){ return __memberWrapper(compareNoCase,arguments, this,"compareNoCase");}});
		Object.defineProperty( String.prototype,"repeatString",{enumerable: false, writable:true, value:function(){ return __memberWrapper(repeatString,arguments, this,"repeatString");}});
		Object.defineProperty( String.prototype,"rTrim",{enumerable: false, writable:true, value:function(){ return __memberWrapper(rTrim,arguments, this,"rTrim");}});
		Object.defineProperty( String.prototype,"lTrim",{enumerable: false, writable:true, value:function(){ return __memberWrapper(lTrim,arguments, this,"lTrim");}});
		Object.defineProperty( String.prototype,"replaceNoCase",{enumerable: false, writable:true, value:function(){ return __memberWrapper(replaceNoCase,arguments, this,"replaceNoCase");}});
//		Object.defineProperty( String.prototype,"replace",{enumerable: false, writable:true, value:function(){ return __memberWrapper(Replace,arguments, this);}});
		Object.defineProperty( String.prototype,"wrap",{enumerable: false, writable:true, value:function(){ return __memberWrapper(wrap,arguments, this,"wrap");}});
		Object.defineProperty( String.prototype,"spanExcluding",{enumerable: false, writable:true, value:function(){ return __memberWrapper(spanExcluding,arguments, this,"spanExcluding");}});
		Object.defineProperty( String.prototype,"spanIncluding",{enumerable: false, writable:true, value:function(){ return __memberWrapper(spanIncluding,arguments, this,"spanIncluding");}});
		Object.defineProperty( String.prototype,"reverse",{enumerable: false, writable:true, value:function(){ return __memberWrapper(reverse,arguments, this,"reverse");}});
		Object.defineProperty( String.prototype,"stripCR",{enumerable: false, writable:true, value:function(){ return __memberWrapper(stripCR,arguments, this,"stripCR");}});
		Object.defineProperty( String.prototype,"find",{enumerable: false, writable:true, value:function(){ return __memberWrapper(_find,arguments, this,"find");}});
		Object.defineProperty( String.prototype,"findNoCase",{enumerable: false, writable:true, value:function(){ return __memberWrapper(_findnocase,arguments, this,"findNoCase");}});
		Object.defineProperty( String.prototype,"findOneOf",{enumerable: false, writable:true, value:function(){ return __memberWrapper(_findoneof,arguments, this,"findOneOf");}});
		Object.defineProperty( String.prototype,"getToken",{enumerable: false, writable:true, value:function(){ return __memberWrapper(getToken,arguments, this,"getToken");}});
		
		// Array functions
		Object.defineProperty(Array.prototype,"append",{enumerable: false, writable:true, value:function(){ return __memberWrapper(arrayAppend,arguments, this,"append");}});
		Object.defineProperty(Array.prototype,"avg",{enumerable: false, writable:true, value:function(){ return __memberWrapper(arrayAvg,arguments, this,"avg");}});
		Object.defineProperty(Array.prototype,"clear",{enumerable: false, writable:true, value:function(){ return __memberWrapper(arrayClear,arguments, this,"clear");}});
		Object.defineProperty(Array.prototype,"deleteAt",{enumerable: false, writable:true, value:function(){ return __memberWrapper(arrayDeleteAt,arguments, this,"deleteAt");}});
		Object.defineProperty(Array.prototype,"insertAt",{enumerable: false, writable:true, value:function(){ return __memberWrapper(arrayInsertAt,arguments, this,"insertAt");}});
		Object.defineProperty(Array.prototype,"contains",{enumerable: false, writable:true, value:function(){ return __memberWrapper(arrayContains,arguments, this,"contains");}});
	//	Object.defineProperty(Array.prototype,"slice",{enumerable: false, writable:true, value:function(){ return __memberWrapper(arraySlice,arguments, this);}});
		Object.defineProperty(Array.prototype,"isEmpty",{enumerable: false, writable:true, value:function(){ return __memberWrapper(arrayIsEmpty,arguments, this,"isEmpty");}});
		Object.defineProperty(Array.prototype,"len",{enumerable: false, writable:true, value:function(){ return __memberWrapper(arrayLen,arguments, this,"len");}});
		Object.defineProperty(Array.prototype,"max",{enumerable: false, writable:true, value:function(){ return __memberWrapper(arrayMax,arguments, this,"max");}});
		Object.defineProperty(Array.prototype,"min",{enumerable: false, writable:true, value:function(){ return __memberWrapper(arrayMin,arguments, this,"min");}});
		Object.defineProperty(Array.prototype,"delete",{enumerable: false, writable:true, value:function(){ return __memberWrapper(arrayDelete,arguments, this,"delete");}});
		Object.defineProperty(Array.prototype,"findAllNoCase",{enumerable: false, writable:true, value:function(){ return __memberWrapper(arrayFindAllNoCase,arguments, this,"findAllNoCase");}});
		Object.defineProperty(Array.prototype,"prepend",{enumerable: false, writable:true, value:function(){ return __memberWrapper(arrayPrepend,arguments, this,"prepend");}});
		Object.defineProperty(Array.prototype,"resize",{enumerable: false, writable:true, value:function(){ return __memberWrapper(arrayResize,arguments, this,"resize");}});
		Object.defineProperty(Array.prototype,"set",{enumerable: false, writable:true, value:function(){ return __memberWrapper(arraySet,arguments, this,"set");}});
		Object.defineProperty(Array.prototype,"_cfsort",{enumerable: false, writable:true, value:function(){ return __memberWrapper(_cfSort,arguments, this);}});
		Object.defineProperty(Array.prototype,"find",{enumerable: false, writable:true, value:function(){ return __memberWrapper(arrayFind,arguments, this,"find");}});
		Object.defineProperty(Array.prototype,"findAll",{enumerable: false, writable:true, value:function(){ return __memberWrapper(arrayFindAll,arguments, this,"findAll");}});
		Object.defineProperty(Array.prototype,"sum",{enumerable: false, writable:true, value:function(){ return __memberWrapper(arraySum,arguments, this,"sum");}});
		Object.defineProperty(Array.prototype,"swap",{enumerable: false, writable:true, value:function(){ return __memberWrapper(arraySwap,arguments, this,"swap");}});
		Object.defineProperty(Array.prototype,"toList",{enumerable: false, writable:true, value:function(){ return __memberWrapper(arrayToList,arguments, this,"toList");}});
		Object.defineProperty(Array.prototype,"findNoCase",{enumerable: false, writable:true, value:function(){ return __memberWrapper(arrayFindNoCase,arguments, this,"findNoCase");}});
		Object.defineProperty(Array.prototype,"isDefined",{enumerable: false, writable:true, value:function(){ return __memberWrapper(arrayIsDefined,arguments, this,"isDefined");}});
	//	Object.defineProperty(Array.prototype,"filter",{enumerable: false, writable:true, value:function(){ return __memberWrapper(arrayFilter,arguments, this,"filter");}});
		Object.defineProperty(Array.prototype,"map",{enumerable: false, writable:true, value:function(){ return __memberWrapper(arrayMap,arguments, this,"map");}});
		Object.defineProperty(Array.prototype,"reduce",{enumerable: false, writable:true, value:function(){ return __memberWrapper(arrayReduce,arguments, this,"reduce");}});
		Object.defineProperty(Array.prototype,"each",{enumerable: false, writable:true, value:function(){ return __memberWrapper(arrayEach,arguments, this,"each");}});		
		// Date functions
		Object.defineProperty(Date.prototype,"diff",{enumerable: false, writable:true, value:function(){ return __memberWrapper(_datediff,arguments, this,"diff");}});
		Object.defineProperty(Date.prototype,"compare",{enumerable: false, writable:true, value:function(){ return __memberWrapper(dateCompare,arguments, this,"compare");}});
		Object.defineProperty(Date.prototype,"dateFormat",{enumerable: false, writable:true, value:function(){ return __memberWrapper(dateFormat,arguments, this,"dateFormat");}});
		Object.defineProperty(Date.prototype,"second",{enumerable: false, writable:true, value:function(){ return __memberWrapper(second,arguments, this,"second");}});
		Object.defineProperty(Date.prototype,"minute",{enumerable: false, writable:true, value:function(){ return __memberWrapper(minute,arguments, this,"minute");}});
		Object.defineProperty(Date.prototype,"hour",{enumerable: false, writable:true, value:function(){ return __memberWrapper(hour,arguments, this,"hour");}});
		Object.defineProperty(Date.prototype,"day",{enumerable: false, writable:true, value:function(){ return __memberWrapper(day,arguments, this,"day");}});
		Object.defineProperty(Date.prototype,"week",{enumerable: false, writable:true, value:function(){ return __memberWrapper(week,arguments, this,"week");}});
		Object.defineProperty(Date.prototype,"month",{enumerable: false, writable:true, value:function(){ return __memberWrapper(month,arguments, this,"month");}});
		Object.defineProperty(Date.prototype,"quarter",{enumerable: false, writable:true, value:function(){ return __memberWrapper(quarter,arguments, this,"quarter");}});
		Object.defineProperty(Date.prototype,"year",{enumerable: false, writable:true, value:function(){ return __memberWrapper(year,arguments, this,"year");}});
		Object.defineProperty(Date.prototype,"daysInMonth",{enumerable: false, writable:true, value:function(){ return __memberWrapper(daysInMonth,arguments, this,"daysInMonth");}});
		Object.defineProperty(Date.prototype,"daysInYear",{enumerable: false, writable:true, value:function(){ return __memberWrapper(daysInYear,arguments, this,"daysInYear");}});
		Object.defineProperty(Date.prototype,"dayOfWeek",{enumerable: false, writable:true, value:function(){ return __memberWrapper(dayOfWeek,arguments, this,"dayOfWeek");}});
		Object.defineProperty(Date.prototype,"dayOfYear",{enumerable: false, writable:true, value:function(){ return __memberWrapper(dayOfYear,arguments, this,"dayOfYear");}});
		Object.defineProperty(Date.prototype,"firstDayOfMonth",{enumerable: false, writable:true, value:function(){ return __memberWrapper(firstDayOfMonth,arguments, this,"firstDayOfMonth");}});
		Object.defineProperty(Date.prototype,"dateTimeFormat",{enumerable: false, writable:true, value:function(){ return __memberWrapper(dateTimeFormat,arguments, this,"dateTimeFormat");}});
		Object.defineProperty(Date.prototype,"timeFormat",{enumerable: false, writable:true, value:function(){ return __memberWrapper(timeFormat,arguments, this,"timeFormat");}});
		Object.defineProperty(Date.prototype,"dateFormat",{enumerable: false, writable:true, value:function(){ return __memberWrapper(dateFormat,arguments, this,"dateFormat");}});
		Object.defineProperty(Date.prototype,"add",{enumerable: false, writable:true, value:function(){ return __memberWrapper(_dateadd,arguments, this,"add");}});
		Object.defineProperty(Date.prototype,"convert",{enumerable: false, writable:true, value:function(){ return __memberWrapper(_dateconvert,arguments, this,"convert");}});
		Object.defineProperty(Date.prototype,"datePart",{enumerable: false, writable:true, value:function(){ return __memberWrapper(_datepart,arguments, this,"datePart");}});
		//Struct functions
		// Make following functions we add to object non-iterable and writable
		Object.defineProperty(Object.prototype,"isEmpty",{enumerable: false, writable:true, value:function(){ return __memberWrapper(structIsEmpty,arguments, this,"isEmpty");}});
		Object.defineProperty(Object.prototype,"append",{enumerable: false, writable:true, value:function(){ return  __memberWrapper(structAppend,arguments, this,"append");}});
		Object.defineProperty(Object.prototype,"clear",{enumerable: false, writable:true, value:function(){ return __memberWrapper(structClear,arguments, this,"clear");}});
		Object.defineProperty(Object.prototype,"copy",{enumerable: false, writable:true, value:function(){ return __memberWrapper(structCopy,arguments, this,"copy");}});
		Object.defineProperty(Object.prototype,"count",{enumerable: false, writable:true, value:function(){ return __memberWrapper(structCount,arguments, this,"count");}});
		Object.defineProperty(Object.prototype,"delete",{enumerable: false, writable:true, value:function(){ return __memberWrapper(structDelete,arguments, this,"delete");}});
		Object.defineProperty(Object.prototype,"find",{enumerable: false, writable:true, value:function(){ return __memberWrapper(structFind,arguments, this,"find");}});
		Object.defineProperty(Object.prototype,"findValue",{enumerable: false, writable:true, value:function(){ return __memberWrapper(structFindValue,arguments, this,"findValue");}});
		Object.defineProperty(Object.prototype,"update",{enumerable: false, writable:true, value:function(){ return __memberWrapper(structUpdate,arguments, this,"update");}});
		Object.defineProperty(Object.prototype,"_cfsort",{enumerable: false, writable:true, value:function(){ return __memberWrapper(_cfSort,arguments, this,"sort");}});
	//	Object.defineProperty(Object.prototype,"insert",{enumerable: false, writable:true, value:function(){ return __memberWrapper(structInsert,arguments, this);}});
		Object.defineProperty(Object.prototype,"keyArray",{enumerable: false, writable:true, value:function(){ return __memberWrapper(structKeyArray,arguments, this,"keyArray");}});
		Object.defineProperty(Object.prototype,"keyExists",{enumerable: false, writable:true, value:function(){ return __memberWrapper(structKeyExists,arguments, this,"keyExists");}});
		Object.defineProperty(Object.prototype,"keyList",{enumerable: false, writable:true, value:function(){ return __memberWrapper(structKeyList,arguments, this,"keyList");}});

		window._funcInit = true;
	}
}
__initFunctionList();
