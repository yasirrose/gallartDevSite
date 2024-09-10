<cfform name="emailForm">

<cfgrid format="html" name="data" pagesize="25" stripeRows="true" stripeRowColor="##e0e0e0"bind="cfc:admin.models.email.popEmail({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection})">
	<cfgridcolumn name="date" header="Date" width="200">
    <cfgridcolumn name="from" header="Title" width="500">
	
</cfgrid>


</cfform>