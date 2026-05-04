<cfparam name="form.email" default="" />

<cfscript>
	getOptouts	= application.objectFactoryAdmin.getInstance('email').getOptouts(form.email);
</cfscript>

<div id="editOptoutContainer">
	<form method="post" action="">
		Search by email:  <input type="text" name="email" /><input type="submit" value="Search" />
	</form>
	<div style="width: 400px; height: 600px; overflow:auto;">
		<cfif IsDefined("form.optoutsGridEntered") AND IsDefined('form.OPTOUTSGRID.ORIGINAL.PK_OPTOUT')> 
            <cfgridupdate 
            grid = "optoutsGrid" 
            dataSource = "#application.dsource#" 
            tableName = "optout" 
            keyOnly = "yes"> 
            <cfobjectcache action="clear">
            <cflocation url="index.cfm?event=optouts"  addtoken="no"> 
        </cfif>
        <cfform name="optoutsGridForm">
            <cfgrid format="html" name="optoutsGrid" stripeRows="true" sort="no" query="getOptouts" selectmode="edit" width="350" insert="true" delete="yes" deletebutton="DELETE OPTOUT ENTRY" insertbutton="NEW OPTOUT ENTRY">
            	<cfgridcolumn name="pk_optout" display="no">
                <cfgridcolumn name="email" header="Email" width="200">
                <cfgridcolumn name="datestamp" header="Datestamp" width="150">
            </cfgrid>
            <br>
            <cfinput type="submit" name="optoutsGridEntered" value="Save Changes"> 
        </cfform>
    </div>
</div>

