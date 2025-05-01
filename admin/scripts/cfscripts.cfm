<!---
	
	This library is part of the Common Function Library Project. An open source
	collection of UDF libraries designed for ColdFusion 5.0. For more information,
	please see the web site at:
		
		http://www.cflib.org
		
	Warning:
	You may not need all the functions in this library. If speed
	is _extremely_ important, you may want to consider deleting
	functions you do not plan on using. Normally you should not
	have to worry about the size of the library.
		
	License:
	This code may be used freely. 
	You may modify this code as you see fit, however, this header, and the header
	for the functions must remain intact.
	
	This code is provided as is.  We make no warranty or guarantee.  Use of this code is at your own risk.
--->

<cfscript>
/**
 * Tests passed value to see if it is a valid e-mail address (supports subdomain nesting and new top-level domains).
 * Update by David Kearns to support '
 * &#83;&#66;&#114;&#111;&#119;&#110;&#64;&#120;&#97;&#99;&#116;&#105;&#110;&#103;&#46;&#99;&#111;&#109; pointing out regex still wasn't accepting ' correctly.
 * More TLDs
 * Version 4 by P Farrel, supports limits on u/h
 * 
 * @param str 	 The string to check. (Required)
 * @return Returns a boolean. 
 * @author Jeff Guillaume (&#83;&#66;&#114;&#111;&#119;&#110;&#64;&#120;&#97;&#99;&#116;&#105;&#110;&#103;&#46;&#99;&#111;&#109;&#106;&#101;&#102;&#102;&#64;&#107;&#97;&#122;&#111;&#111;&#109;&#105;&#115;&#46;&#99;&#111;&#109;) 
 * @version 4, December 30, 2005 
 */
function isEmail(str) {
    return (REFindNoCase("^['_a-z0-9-]+(\.['_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*\.(([a-z]{2,3})|(aero|coop|info|museum|name|jobs|travel))$",
str) AND len(listGetAt(str, 1, "@")) LTE 64 AND
len(listGetAt(str, 2, "@")) LTE 255) IS 1;
}
</cfscript>
