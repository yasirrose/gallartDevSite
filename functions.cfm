<!--- Alters stypes of rows --->
<cfscript>
/**
	returns a different row number every time its called.
*/
	this_row_count = 0;
	function this_row() {
		this_row_count = (this_row_count + 1) mod 2;
		return iif(this_row_count mod 2 eq 0,DE('row1'),DE('row2'));
	}
	
/**
 * Capitalizes the first letter in each word.
 * 
 * @param string 	 String to be modified. 
 * @return Returns a string. 
 */
function CapFirst(str) {
	var newstr = "";
	var word = "";
	var i = 1;
	var strlen = listlen(str," ");
	for(i=1;i lte strlen;i=i+1) {
		word = LCase(ListGetAt(str,i," "));
		newstr = newstr & UCase(Left(word,1));
		if(len(word) gt 1) newstr = newstr & Right(word,Len(word)-1);
		if(i lt strlen) newstr = newstr & " ";
	}
	return newstr;
}
</cfscript>

<!--- <cffunction name="MoneyFormat" output="No" returntype="numeric">
	<cfargument name="n" default="">
	<cfreturn trim(NumberFormat(n,'99999999999999999999999999999999999.99')) />
</cffunction> --->