
<cfoutput>
    <!--- <input type="button" value="Back" onclick="location.href='index.cfm?event=orders.productForm'"> --->
<iframe src="/admin/uploads/products/#session.invoiceinfo.invoiceNumber#.pdf" id="printFrame" name="printFrame" width="1000" height="1000" frameborder="0" scrolling="No"></iframe>
</cfoutput>

<cfset temp = structDelete(session,'orderArray') />
<cfset temp = structDelete(session,'invoiceInfo') />



