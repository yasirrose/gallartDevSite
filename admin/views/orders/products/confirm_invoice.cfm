<form method="post" action="index.cfm?event=orders.createPdf" name="confirmForm">
<cfinclude template="print_invoice_template.cfm">
<br><br>

<input type="Hidden" name="amountSaleValue">
<input type="Hidden" name="totalSaleValue">
<input type="Hidden" name="balanceDueValue">
<input type="submit" name="print" value="CREATE INVOICE FOR PRINTING" onClick="javascript:return confirm('MAKE SURE THAT ALL OF THE INFORMATION IS CORRECT ON THIS PAGE - YOU CANNOT GO BACK AFTER YOU REACH THE PRINT PAGE')">
<input type="submit" name="sendemail" value="CREATE INVOICE FOR PRINTING AND EMAIL TO CUSTOMER" onClick="javascript:return confirm('MAKE SURE THAT ALL OF THE INFORMATION IS CORRECT ON THIS PAGE - YOU CANNOT GO BACK AFTER YOU REACH THE PRINT PAGE')">
<input type="submit" name="incomplete" value="SAVE AS INCOMPLETE" onClick="javascript:return confirm('MAKE SURE THAT ALL OF THE INFORMATION IS CORRECT ON THIS PAGE - YOU CANNOT GO BACK AFTER YOU REACH THE PRINT PAGE')">
<input type="Button" value="GO BACK AND MAKE CHANGES" onclick="location.href='index.cfm?event=orders.productForm'">

</form>

<cfoutput>
<script language="JavaScript">
	document.getElementById('amountSale').innerHTML = formatAsDollars(#amountSale#);
	document.confirmForm.amountSaleValue.value = '#amountSale#';
	computeAmount();

</script>
</cfoutput>

<!--- <cfinclude template="mailer_test.cfm"> --->
