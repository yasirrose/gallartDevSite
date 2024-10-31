// ADOBE SYSTEMS INCORPORATED Copyright 2007 Adobe Systems Incorporated All Rights Reserved. 
// NOTICE: Adobe permits you to use, modify, and distribute this file in accordance with the
// terms of the Adobe license agreement accompanying it. If you have received this file from 
// a source other than Adobe, then your use, modification, or distribution of it requires the 
// prior written permission of Adobe.

	var KT_focusedEl = null;

	/********** 
	KT_validateSingle function
		description:
			Validates single character agains single mask component
		params: 
			ascchar: character
				single character, to test if it is correct in the context of the mask character 
			maskchar: character
				single mask character, see below for meaning
		returns: 
			boolean
	 **********/
	KT_validateSingle = function(ascchar, maskchar) {
		var cchar = ascchar.charCodeAt(0);
		switch (maskchar) {
			case "9": //numeric
				if (cchar < 58 && cchar > 47) {
					return true;
				}
				break;
			case "A": //letter
				if ((cchar < 91 && cchar > 64) || (cchar < 123 && cchar > 96)) {
					return true;
				}
				break;
			case "X": //letter or numeric
				if ((cchar < 91 && cchar > 64) || (cchar < 123 && cchar > 96) || (cchar < 58 && cchar > 47)) {
					return true;
				}
				break;
			case "?": //any character
				return true;
				break;
			default:
				return true;
				break;
		}
	}
	
	/********** 
	KT_maskDefaultValue function
		description:
			Called with a special mask character, returns the default value for that type of mask
		params:
			maskchar: character
				single mask character, see below for meaning
		returns:
			character
	**********/
	KT_maskDefaultValue = function(maskchar) {
		switch (maskchar) {
			case "9": //numeric
				return '0';
				break;
			case "A": //letter
				return 'a';
				break;
			case "X": //letter or numeric
				return '0';
				break;
			case "?": //any character
				return '0';
				break;
			default:
				return '0';
				break;
		}
	}

	/********** 
	KT_isSpecialChar function
		description:
			Checks if the parameter is a special mask character
		params:
			ascchar: character
				Special mask characters: 
				9 - numeric
				A - letters
				X - letter or number
				? - any character
		returns:
			boolean
	**********/
	KT_isSpecialChar = function(ascchar) {
		if (ascchar == '9' || ascchar == 'A' || ascchar == 'X' || ascchar == '?')  {
			return true;
		} else {
			return false;
		}
	}

	/**********
	mask_onValueChanged function
		description:
			Called when 
				- the user types something in the input
				- the input loses the focus
			It validates the input's value against the input's mask
		params: 
			none
		returns:
			none
	**********/
	mask_onValueChanged = function() {
		if ((typeof window.getSelection == 'undefined' && typeof document.selection == 'undefined')) {
			// if the current browser is not compatible, do nothing
			return;
		}
		
		if (KT_focusedEl == null || KT_focusedEl.mask == null || KT_focusedEl.mask == '') {
			return;
		}

		var mask = KT_focusedEl.mask;
		var val = KT_focusedEl.value;
		var i = 0;
		var moveCursor = false;

		if (val == KT_focusedEl.oldText) {
			// if the field content did not change since the last update, do nothing
			return;
		}
		if (val.length > mask.length) {
			// strip trailing characters if text length is bigger than mask length
			val = val.substr(0, mask.length);
			moveCursor = true;
		}
		for (; i < mask.length ; i++) {
			if (val.charCodeAt(i).toString() != 'NaN') {
				//if the char is inserted
				if (KT_isSpecialChar(mask.charAt(i))) {
					if (KT_validateSingle(val.charAt(i), mask.charAt(i))) {
						//character is correct, go to next
						continue;
					} else {
						//revert to the last known good value, increase index to break loop
						val = KT_focusedEl.oldText;
						i = mask.length;
						break;
					}
				} else {
					//normal character in the mask
					if (val.charAt(i) != mask.charAt(i)) {
						//if the character is different from the mask
						if (i == val.length - 1) {
							//append last character and move cursor to the end
							var lastChar = val.substr(val.length -1, val.length);
							val = val.substr(0, val.length -1) + mask.charAt(i) + lastChar;
							moveCursor = true;
							continue;
						} else {
							//revert to the last known good value, increase index to break loop
							val = KT_focusedEl.oldText;
							i = mask.length;
						}
						break;
					}
				}
			} else {
				//if the current char is not inserted
				if (val.length < KT_focusedEl.oldText.length) {
					//deleted character
					break;
				}
				for (;i<mask.length;i++) {
					if (!KT_isSpecialChar(mask.charAt(i))) {
						//re-enter the mask characters if it has been deleted
						val += mask.charAt(i);
						moveCursor = true;
					} else {
						break;
					}
				}
				break;
			}
		}
		if (val.length > mask.length) {
			// strip trailing characters if text length is bigger than mask length
			val = val.substr(0, mask.length);
			moveCursor = true;
		}
		if (KT_focusedEl.value != val) {
			KT_focusedEl.value = val; //last calculated correct value
		}
		KT_focusedEl.oldText = val; //update so we can check on next character
		if (moveCursor) {
			// no need to move the cursor, it is automatically moved at the end of the sellection by IE and Mozilla
		}
	}

	/********** 
	mask_parseFirstTime function
		description:
			Called from mask_onSetFocus, only the first time ( when obj.mask is undefined)
			Tries to parse the initial value into a valid format, with the following algorithm:
			- normalizes the string adding non special mask characters if they do not exist
			- it strips the mask of all non special characters
			- rebuilds the string using the stripped mask
			- compares the string with the stripped mask and changes the values if they are invalid
			- rebuild the string and returns
		params:
			none
		returns:
			none
	**********/
	mask_parseFirstTime = function(value, mask) {
		var strippedmask = ''; var strippedvalue = '';
		cond = 1;imask = 0; ival = 0;cnt = 0;

		//NORMALIZE VALUE: add non special characters
		while (cond == 1) {
			cond = 1;
			if (!KT_isSpecialChar(mask.charAt(imask))) {
				if (value.charCodeAt(ival).toString() != 'NaN') {
					if (mask.charAt(imask) == value.charAt(ival)) {
						imask++;ival++;
					} else {
						value = value.substr(0, ival) + mask.charAt(imask) + value.substr(ival, value.length);
						imask = 0; ival = 0; cond = 1;
					}
				} else {
					value += KT_maskDefaultValue(mask.charAt(imask));
				}
			} else {
				imask++;ival++;
			}
			if (imask >= mask.length || ival >= value.length) {
				cond = 0;
			}
		}

		//save only the special chars in a mask
		for (i=0;i<mask.length;i++) {
			if (KT_isSpecialChar(mask.charAt(i))) {
				strippedmask += mask.charAt(i);
				if (value.charCodeAt(i).toString() != 'NaN') {
					strippedvalue += value.charAt(i);
				} else {
					strippedvalue += KT_maskDefaultValue(mask.charAt(i));
				}
			}
		}

		oldvalue = value; //save the old value for reference
		value = strippedvalue;
		var newvalue = '';

		//rebuild the string removing invalid values and replacing them with defaults
		for (i=0;i<strippedmask.length;i++) {
				if (!KT_validateSingle(value.charAt(i), strippedmask.charAt(i))) {
					newvalue += KT_maskDefaultValue(strippedmask.charAt(i));
				} else {
					newvalue += value.charAt(i);
				}
		}

		//rebuild the value,by adding the initial non special mask characters
		var toret = ''; var j = 0; //j holds the index in the stripped mask
		for (i=0;i<mask.length;i++) {
			if (KT_isSpecialChar(mask.charAt(i))) {
				toret += newvalue.charAt(j++);
			} else {
				toret += mask.charAt(i);
			}
		}
		return toret;
	}

	/********** 
	mask_onSetFocus function
		description:
			Called when the input gets the focus
			Saved the current input in a global variable and also the current value
		params:
			none
		returns:
			none
	**********/
	mask_onSetFocus = function(obj, mask) {
		if ((typeof window.getSelection == 'undefined' && typeof document.selection == 'undefined')) {
			// if the current browser is not compatible, do nothing
			return;
		}
		if (typeof obj.mask == 'undefined') {
			ret = '';
			if (obj.value != '') {
				ret = mask_parseFirstTime(obj.value, mask);
			}
			obj.value = ret;
			obj.mask = mask;
		}
		KT_focusedEl = obj; // store the current input object in a global variable
		if (typeof KT_focusedEl.oldText == 'undefined') {
			KT_focusedEl.oldText = obj.value; // save the input current value
			mask_onValueChanged(); // validates the current input value
		}
	}

	/********** 
	mask_onKillFocus function
		description:
			Called when the input loses the focus
			Verifies the input's value
		params:
			none
		returns:
			none
	**********/
	mask_onKillFocus = function() {
		if ((typeof window.getSelection == 'undefined' && typeof document.selection == 'undefined')) {
			// if the current browser is not compatible, do nothing
			return;
		}
		mask_onValueChanged(); // validates the current input value
		KT_focusedEl = null;
	}
