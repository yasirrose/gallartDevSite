// ADOBE SYSTEMS INCORPORATED Copyright 2007 Adobe Systems Incorporated All Rights Reserved. 
// NOTICE: Adobe permits you to use, modify, and distribute this file in accordance with the
// terms of the Adobe license agreement accompanying it. If you have received this file from 
// a source other than Adobe, then your use, modification, or distribution of it requires the 
// prior written permission of Adobe.

// ColdFusion JavaScript functions for cfform client-side validation
var _CF_error_messages = new Array();
var _CF_error_fields = new Object();
var _CF_FirstErrorField = null;
var _CF_submit_status= new Array();

_CF_signalLoad = function()
{
	_CF_loaded = 1;
}

_CF_onError = function(form_object, input_object, object_value, error_message)
{
	if( _CF_error_fields[input_object] == null )
	{
		if( _CF_FirstErrorField == null )
		{
			_CF_FirstErrorField = input_object;
		}
		_CF_error_exists = true;
		_CF_error_fields[input_object] = error_message;
		_CF_error_messages[_CF_error_messages.length ] = error_message;
	}
}


_CF_onErrorAlert = function(msgArray)
{
	//build error message string
	var errorStr = "";
	for(var i=0; i < msgArray.length; i++)
	{
		errorStr += msgArray[i] +"\n";
	}
		
	alert(errorStr);
	return false;	
}

/**
 * called by the flash controls in an html form, to update the right hidden field
 */
updateHiddenValue = function(val, form, name)
{
//alert(form +":" +name +":" +val);
	if (form == null || form == "") form = 0;
	if (document.forms[form] == null || document.forms[form][name] == null)
	{
	    return;
	}
	document.forms[form][name].value = val;
}

_CF_hasValue = function(obj, obj_type, obj_trim)
{
	
	if (obj_type == "TEXT" || obj_type == "FILE" ||obj_type == "PASSWORD" || obj_type == "CFTEXTAREA" || obj_type == "TEXTAREA" || obj_type == "CFTEXTINPUT" || obj_type == "DATEFIELD")
	{
		if (obj.value.length == 0) 
	  		return false;
		else 
			if( obj_trim )
			{
			    //trim whitespace - for backward compatability this is optional
				str = obj.value.replace(/^\s+/,'').replace(/\s+$/,'');
				if (str.length == 0)
				{ return false; }
			}
	  		return true;
	}
	else if (obj_type == "SELECT")
	{
		for (i=0; i < obj.length; i++)
		{
			if (obj.options[i].selected && obj.options[i].value.length > 0)
				return true;
		}
	   	return false;	
	}
	else if (obj_type == "SINGLE_VALUE_RADIO" || obj_type == "SINGLE_VALUE_CHECKBOX")
	{
		if (obj.checked)
			return true;
		else
	   		return false;	
	}
	else if (obj_type == "RADIO" || obj_type == "CHECKBOX")
	{
		if( obj.length == undefined && obj.checked )
		{
			return true;
		}else{
			for (i=0; i < obj.length; i++)
			{
				if (obj[i].checked)
					return true;
			}
		}
	   	return false;	
	}else if( obj_type == "CFTREE"){
	    if( obj['value'].length > 0 )
	    {
	        return true;
        }else{
            return false;
        }
	}
	else if(obj_type == "RICHTEXT")
	{
		var editor = FCKeditorAPI.GetInstance(obj.id);
		var val = editor.GetXHTML();
		if (val.length == 0)
		{
			return false;
		} 
		else
		{
			if( obj_trim )
			{
			    //trim whitespace - for backward compatability this is optional
				str = val.replace(/^\s+/,'').replace(/\s+$/,'');
				if (str.length == 0)
				{ 
					return false; 
				}
			}
	  		return true;
		} 
	}
	else{
	    return true;
	}
}

_CF_checkdate = function(object_value, required) {
     //Returns true if value is a date format or is NULL
     //otherwise returns false
    //trim whitespace before we validate

    object_value = object_value.replace(/^\s+/,'').replace(/\s+$/,'');
    object_value = object_value = object_value.replace(/{d \'/, '').replace(/'}/, '');

    if( required )
    {
        if( object_value.length == 0 )
        {
            return false;
        }
    }else{
        if( object_value.length == 0 )
        {
            return true;
        }
    }


     if (object_value.length == 0)
         return true;


     //Returns true if value is a date in the mm/dd/yyyy format
    isplit = object_value.indexOf('/');
	splitchr = "/";

	if (isplit == -1)
	{
		isplit = object_value.indexOf('.');
		splitchr = ".";
	}

	if (isplit == -1)
	{
		isplit = object_value.indexOf('-');
		splitchr = "-";
	}

	if (isplit == -1 || isplit == object_value.length)
		return false;

    var element1 = object_value.substring(0, isplit);
    // check for yyyy-mm-dd format
    if( element1.length == 4 )
    {
        sYear = object_value.substring(0, isplit);
        isplit = object_value.indexOf(splitchr, isplit + 1);
        if (isplit == -1 || (isplit + 1 ) == object_value.length)
                return false;
        sMonth = object_value.substring((sYear.length + 1), isplit);
        sDay = object_value.substring(isplit + 1);
     }
    else
    {
        sMonth = object_value.substring(0, isplit);
        isplit = object_value.indexOf(splitchr, isplit + 1);
         if (isplit == -1 || (isplit + 1 ) == object_value.length)
                return false;
        sDay = object_value.substring((sMonth.length + 1), isplit);
        sYear = object_value.substring(isplit + 1);
     }
     
     //check if any of the parameters are blank
     if((sDay.length == 0) || (sMonth.length == 0) || (sYear.length == 0))
		return false;
     
         if (!_CF_checkinteger(sMonth)) //check month
                 return false;
         else
         if (!_CF_checkrange(sMonth, 1, 12)) //check month
                 return false;
         else
         if (!_CF_checkinteger(sYear)) //check year
                 return false;
         else
         if( sYear.length != 1 && sYear.length != 2 && sYear.length != 4 )
                return false;
         else
         if (!_CF_checkrange(sYear, 0, 9999)) //check year
                 return false;
         else
         if (!_CF_checkinteger(sDay)) //check day
                 return false;
         else
         if (!_CF_checkday(sYear, sMonth, sDay)) // check day
                 return false;
         else
                 return true;

 }


_CF_checkeurodate = function(object_value, required)
{
	//trim whitespace before we validate
    object_value = object_value.replace(/^\s+/,'').replace(/\s+$/,'');
	object_value = object_value = object_value.replace(/{d \'/, '').replace(/'}/, '');

    if( required )
    {
        if( object_value.length == 0 )
        {
            return false;
        }
    }else{
        if( object_value.length == 0 )
        {
            return true;
        }
    }

	isplit = object_value.indexOf('/');
	splitchr = "/";

	if (isplit == -1)
	{
		isplit = object_value.indexOf('.');
		splitchr = ".";
	}
		
	if (isplit == -1)
	{
		isplit = object_value.indexOf('-');
		splitchr = "-";
	}

	if (isplit == -1 || isplit == object_value.length)
		return false;

     var element1 = object_value.substring(0, isplit);
     // check for yyyy-mm-dd format
     if( element1.length == 4 )
     {
         sYear = object_value.substring(0, isplit);

         isplit = object_value.indexOf(splitchr, isplit + 1);
         if (isplit == -1 || (isplit + 1 ) == object_value.length)
                 return false;

         sMonth = object_value.substring((sYear.length + 1), isplit);
         sDay = object_value.substring(isplit + 1);

     }
     else
     {
         sDay = object_value.substring(0, isplit);
         isplit = object_value.indexOf(splitchr, isplit + 1);

         if (isplit == -1 || (isplit + 1 ) == object_value.length)
                 return false;

         sMonth = object_value.substring((sDay.length + 1), isplit);
         sYear = object_value.substring(isplit + 1);

      }

	if (!_CF_checkinteger(sMonth))
		return false;
	else
	if (!_CF_checkrange(sMonth, 1, 12))
		return false;
	else
	if (!_CF_checkinteger(sYear))
		return false;
	else
	if (!_CF_checkrange(sYear, 0, null))
		return false;
	else
	if (!_CF_checkinteger(sDay))
		return false;
	else
	if (!_CF_checkday(sYear, sMonth, sDay))
		return false;
	else
		return true;
}


_CF_checkday = function(checkYear, checkMonth, checkDay)
{
	maxDay = 31;

	if (checkMonth == 4 || checkMonth == 6 ||
		checkMonth == 9 || checkMonth == 11)
		maxDay = 30;
	else if (checkMonth == 2)
	{
		if (checkYear % 4 > 0)
			maxDay =28;
		else if (checkYear % 100 == 0 && checkYear % 400 > 0)
			maxDay = 28;
		else
			maxDay = 29;
	}

	return _CF_checkrange(checkDay, 1, maxDay);
}


_CF_checkinteger = function(object_value, required)
{
	//trim whitespace before we validate
    object_value = object_value.replace(/^\s+/,'').replace(/\s+$/,'');
	//remove numeric noise
	object_value = object_value.replace(/[$Â£Â¥â‚¬,~+]?/g, '');


    if( required )
    {
        if( object_value.length == 0 )
        {
            return false;
        }
    }else{
        if( object_value.length == 0 )
        {
            return true;
        }
    }


	var decimal_format = ".";
	var check_char = object_value.indexOf(decimal_format);

	if (check_char == -1)
		return _CF_checknumber(object_value);
	else
		return false;
}


_CF_numberrange = function(object_value, min_value, max_value, required)
{
    //trim whitespace before we validate
    //object_value = object_value.replace(/^\s+/,'').replace(/\s+$/,'');

    if( required )
    {
        if( object_value.length == 0 )
        {
            return false;
        }
    }else{
        if( object_value.length == 0 )
        {
            return true;
        }
    }


	if (min_value != null)
	{
		if (object_value < min_value)
			return false;
	}

	if (max_value != null)
	{
		if (object_value > max_value)
			return false;
	}

	return true;
}


_CF_checknumber = function(object_value, required)
{
	var start_format = " .+-0123456789";
	var number_format = " .0123456789";
	var check_char;
	var decimal = false;
	var trailing_blank = false;
	var digits = false;

	//trim whitespace before we validate
    object_value = object_value.replace(/^\s+/,'').replace(/\s+$/,'');
	//remove numeric noise
	object_value = object_value.replace(/[$Â£Â¥â‚¬,~+]?/g, '');


    if( required )
    {
        if( object_value.length == 0 )
        {
            return false;
        }
    }else{
        if( object_value.length == 0 )
        {
            return true;
        }
    }



	check_char = start_format.indexOf(object_value.charAt(0));

	if (check_char == 1)
		decimal = true;
	else if (check_char < 1)
		return false;

	for (var i = 1; i < object_value.length; i++)
	{
		check_char = number_format.indexOf(object_value.charAt(i));
		if (check_char < 0)
			return false;
		else if (check_char == 1)
		{
			if (decimal)
				return false;
			else
				decimal = true;
		}
		else if (check_char == 0)
		{
			if (decimal || digits)	
				trailing_blank = true;
		}
		else if (trailing_blank)
			return false;
		else
			digits = true;
	}	

	return true
}


_CF_checkrange = function(object_value, min_value, max_value, required)
{
    object_value = object_value.replace(/^\s+/,'').replace(/\s+$/,'');

    if( required )
    {
        if( object_value.length == 0 )
        {
            return false;
        }
    }else{
        if( object_value.length == 0 )
        {
            return true;
        }
    }


	if (!_CF_checknumber(object_value))
		return false;
	else
		return (_CF_numberrange((eval(object_value)), min_value, max_value));

	return true;
}


_CF_checktime = function(object_value, required)
{
    object_value = object_value.replace(/^\s+/,'').replace(/\s+$/,''); //replace whitspaces before and after the time string
    object_value = object_value.replace(/\s+:\s+/,':'); //replace whitespaces around ':'
    // replace the {t'..'} format around the timestamp if it exists
    object_value = object_value = object_value.replace(/{t \'/, '').replace(/'}/, '');

    if( required )
    {
        if( object_value.length == 0 )
        {
            return false;
        }
    }else{
        if( object_value.length == 0 )
        {
            return true;
        }
    }


    var result = _CF_checkregex(object_value, /^((([0-1]?\d)|(2[0-3])):[0-5]?\d)?(:[0-5]?\d)? ?([AP]M|[AP]m|[ap]m|[ap]M)?$/, required);
	return result;
}

/**
 * validate that the value is formatted as a telephone correctly
 * This pattern matches any US Telephone Number.
 * This regular expression excludes the first number, after the area code,from being 0 or 1;
 * it also allows an extension to be added where it does not have to be prefixed by 'x'.
 *
 * Matches: 
 * 617.219.2000 
 * 219-2000
 * (617)283-3599 x234
 * 1(222)333-4444
 * 1 (222) 333-4444
 * 222-333-4444
 * 1-222-333-4444
 * Non-Matches: 
 * 44-1344-458606
 * +44-1344-458606
 * +34-91-397-6611
 * 7-095-940-2000
 * +7-095-940-2000
 * +49-(0)-889-748-5516
*/
_CF_checkphone = function(object_value, required)
{
	//trim whitespace before we validate
    object_value = object_value.replace(/^\s+/,'').replace(/\s+$/,'');

    if( required )
    {
        if( object_value.length == 0 )
        {
            return false;
        }
    }else{
        if( object_value.length == 0 )
        {
            return true;
        }
    }

	if (object_value.length == 0)
		return true;		

	return _CF_checkregex(object_value, /^(((1))?[ ,\-,\.]?([\\(]?([1-9][0-9]{2})[\\)]?))?[ ,\-,\.]?([^0-1]){1}([0-9]){2}[ ,\-,\.]?([0-9]){4}(( )((x){0,1}([0-9]){1,5}){0,1})?$/, required);
}

/**
 * validate that the value is formatted as a USA zipcode correctly
 *
 * This pattern will match any us zip code
 * matches: 12345, 12345-1234
 */
_CF_checkzip = function(object_value, required)
{
	//trim whitespace before we validate
    object_value = object_value.replace(/^\s+/,'').replace(/\s+$/,'');

    if( required )
    {
        if( object_value.length == 0 )
        {
            return false;
        }
    }else{
        if( object_value.length == 0 )
        {
            return true;
        }
    }

	return _CF_checkregex(object_value, /^([0-9]){5,5}$|(([0-9]){5,5}(-| ){1}([0-9]){4,4}$)/, required);
}


_CF_checkcreditcard = function(object_value, required)
{
	//trim whitespace before we validate
    object_value = object_value.replace(/^\s+/,'').replace(/\s+$/,'');

    if( required )
    {
        if( object_value.length == 0 )
        {
            return false;
        }
    }else{
        if( object_value.length == 0 )
        {
            return true;
        }
    }

	if (object_value.length == 0)
		return true;
	var white_space = " -";
	var creditcard_string="";
	var check_char;

	
	for (var i = 0; i < object_value.length; i++)
	{
		check_char = white_space.indexOf(object_value.charAt(i));
		if (check_char < 0)
			creditcard_string += object_value.substring(i, (i + 1));
	}	

	if (creditcard_string.length < 13 || creditcard_string.length > 19)
		return false;

	if (creditcard_string.charAt(0) == "+")
		return false;

	if (!_CF_checkinteger(creditcard_string))
		return false;

	var doubledigit = creditcard_string.length % 2 == 1 ? false : true;
	var checkdigit = 0;
	var tempdigit;

	for (var i = 0; i < creditcard_string.length; i++)
	{
		tempdigit = eval(creditcard_string.charAt(i));

		if (doubledigit)
		{
			tempdigit *= 2;
			checkdigit += (tempdigit % 10);

			if ((tempdigit / 10) >= 1.0)
				checkdigit++;

			doubledigit = false;
		}
		else
		{
			checkdigit += tempdigit;
			doubledigit = true;
		}
	}	

	return (checkdigit % 10) == 0 ? true : false;
}

/**
 * validate that the value is formatted as a SSN# correctly
 *
 * this Pattern that the SSN number matches the different formats. (X = [0-9])
 * matches: XXX-XX-XXXX, XXX XX XXXX, 
 * non-match: XXXXXXXXX
 */
_CF_checkssn = function(object_value, required)
{
    //trim whitespace before we validate
    object_value = object_value.replace(/^\s+/,'').replace(/\s+$/,'');

    if( required )
    {
        if( object_value.length == 0 )
        {
            return false;
        }
    }else{
        if( object_value.length == 0 )
        {
            return true;
        }
    }

	return _CF_checkregex(object_value, /^[0-9]{3}(-| )[0-9]{2}(-| )[0-9]{4}$/, required);
}

/**
 * validate that the value is formatted as an email address correctly
 *
 * this regex matches the majoriity of all email address.
 * example matches.
 * Matches:  [rick.jones@unit.army.mil], [john_doe@foobar.com], [foo99@foo.co.uk]  
 * Non-Matches:  [find_the_mistake.@foo.org], [.prefix.@some.net]
 *
 * _CF_checkURL mailto uses this same email regex - keep in sync.
 */
_CF_checkEmail = function(object_value, required)
{
	//trim whitespace before we validate
    object_value = object_value.replace(/^\s+/,'').replace(/\s+$/,'');

    if( required )
    {
        if( object_value.length == 0 )
        {
            return false;
        }
    }else{
        if( object_value.length == 0 )
        {
            return true;
        }
    }


	//return _CF_checkregex(object_value, /^[\w-]+(?:\.[\w-]+)*@(?:[\w-]+\.)+[a-zA-Z]{2,7}$/);
	//return _CF_checkregex(object_value, /^[a-zA-Z_0-9-]+(?:\.[a-zA-Z_0-9-]+)*@(?:[a-zA-Z_0-9-]+\.)+[a-zA-Z]{2,7}$/);
	return _CF_checkregex(object_value, /^[a-zA-Z_0-9-'\+~]+(\.[a-zA-Z_0-9-'\+~]+)*@([a-zA-Z_0-9-]+\.)+[a-zA-Z]*$/, required);
}

/**
 * validate that the value is formatted correctly for a http/https/ftp url
 * This pattern will match http/https/ftp urls.
 *
 * Matches: http://www.mm.com/index.cfm
 *          HTTP://WWW.MM.COM
 *          http://www.mm.com/index.cfm?userid=1&name=mike+nimer
 *          http://www.mm.com/index.cfm/userid/1/name/mike+nimer - trick used by cf developers so search engines can parse their sites (search engines ignore query strings)
 *          ftp://www.mm.com/
 *          ftp://uname:pass@www.mm.com/
 *          mailto:email@address.com
 *          news:rec.gardening
 *          news:rec.gardening
 *          http://a/
 *			file://ftp.yoyodyne.com/pub/files/foobar.txt
 * Non-Matches: www.yahoo.com
 *              http:www.mm.com
 *
 * _CF_checkEmail - the mailto email check is the same as the _CF_checkEmail regex (keep in sync)
 */
_CF_checkURL = function(object_value, required)
{
	//trim whitespace before we validate
    object_value = object_value.replace(/^\s+/,'').replace(/\s+$/,'');

    if( required )
    {
        if( object_value.length == 0 )
        {
            return false;
        }
    }else{
        if( object_value.length == 0 )
        {
            return true;
        }
    }

	//return _CF_checkregex(object_value.toLowerCase(), /^((http|https|ftp|file)\:\/\/([a-zA-Z0-0]*:[a-zA-Z0-0]*(@))?[a-zA-Z0-9-\.]+(\.[a-zA-Z]{2,3})?(:[a-zA-Z0-9]*)?\/?([a-zA-Z0-9-\._\?\,\'\/\+&amp;%\$#\=~])*)|((mailto)\:[\w-]+(?:\.[\w-]+)*@(?:[\w-]+\.)+[a-zA-Z0-9]{2,7})|((news)\:[a-zA-Z0-9\.]*)$/);
	return _CF_checkregex(object_value.toLowerCase(), /^((http|https|ftp|file)\:\/\/([a-zA-Z0-0]*:[a-zA-Z0-0]*(@))?[a-zA-Z0-9-\.]+(\.[a-zA-Z]{2,3})?(:[a-zA-Z0-9]*)?\/?([a-zA-Z0-9-\._\?\,\'\/\+&amp;%\$#\=~])*)|((mailto)\:[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z0-9]*)|((news)\:[a-zA-Z0-9\.]*)$/, required);
}

/**
 * A string UUID value is required. A UUID is a string
 * of length 35 formatted as XXXXXXXX-XXXX-XXXX-XXXXXXXXXXXXXXXX, where X is a
 * hexadecimal digit (0-9 or A-F).
 */
_CF_checkUUID = function(object_value, required)
{
	//trim whitespace before we validate
    object_value = object_value.replace(/^\s+/,'').replace(/\s+$/,'');

    if( required )
    {
        if( object_value.length == 0 )
        {
            return false;
        }
    }else{
        if( object_value.length == 0 )
        {
            return true;
        }
    }

	return _CF_checkregex(object_value, /[A-Fa-f0-9]{8,8}-[A-Fa-f0-9]{4,4}-[A-Fa-f0-9]{4,4}-[A-Fa-f0-9]{16,16}/, required);
}
/**
 * A string GUID value is required. A GUID is a string
 * of length 36 formatted as XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX, where X is a
 * hexadecimal digit (0-9 or A-F).
 */
_CF_checkGUID = function(object_value, required)
{
	//trim whitespace before we validate
    object_value = object_value.replace(/^\s+/,'').replace(/\s+$/,'');

    if( required )
    {
        if( object_value.length == 0 )
        {
            return false;
        }
    }else{
        if( object_value.length == 0 )
        {
            return true;
        }
    }

	return _CF_checkregex(object_value, /[A-Fa-f0-9]{8,8}-[A-Fa-f0-9]{4,4}-[A-Fa-f0-9]{4,4}-[A-Fa-f0-9]{4,4}-[A-Fa-f0-9]{12,12}/, required);
}

/**
 * checks CF boolean value
 * matches: true, false, 1, 0, yes, no
 */
_CF_checkBoolean = function(object_value, required)
{	
    //trim whitespace before we validate
    object_value = object_value.replace(/^\s+/,'').replace(/\s+$/,'');

    if( required )
    {
        if( object_value.length == 0 )
        {
            return false;
        }
    }else{
        if( object_value.length == 0 )
        {
            return true;
        }
    }

	if( object_value.toUpperCase() == "TRUE" || object_value.toUpperCase() == "YES" || (_CF_checknumber(object_value) && object_value != "0")   )
	{ 
		return true; 
	}else if( object_value.toUpperCase() == "FALSE" || object_value.toUpperCase() == "NO" || object_value == "0" ){
		return true;
	}else{
		return false;
	}
}

_CF_setFormParam = function( strFormName, strParamName, strParamValue )
{
	var strObjName = "document['" + strFormName + "']['" + strParamName +"']";
	var obj = eval( strObjName );
	if( obj == undefined )
	{
	    return false;
	}else{
	    obj.value = strParamValue;
	    return true;
    }
}


_CF_checkregex = function(object_value, regexPattern, required)
{
    if( required )
    {
        if( object_value.length == 0 )
        {
            return false;
        }
    }else{
        if( object_value.length == 0 )
        {
            return true;
        }
    }

	return regexPattern.test(object_value);
}
