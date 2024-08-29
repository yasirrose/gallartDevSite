	<cfif (#taxst# is not "") and  (#billstate# eq #taxst#)>
	<cfset tax = (taxamount*0.01)*subtotal>
	</cfif>