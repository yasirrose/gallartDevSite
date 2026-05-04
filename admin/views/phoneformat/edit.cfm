
<cfhtmlhead text='<script type="text/javascript" src="/admin/scripts/jquery.min.js" language="JavaScript"></script>'>
<cfhtmlhead text='<script type="text/javascript" src="/admin/scripts/jquery.mask.min.js" language="JavaScript"></script>'>

<cftry>
	<cfparam name="FORM.submitted"	type="numeric"	default="0"	/>
	<cfcatch>
		<cfset FORM.submitted = 0 />
	</cfcatch>
</cftry>
<cfparam name="url.db" default="">
<cfparam name="form.db" default="#url.db#">
<cfif form.submitted>
	<cfloop collection="#form#" item="idx">

		<cfset tableName = listFirst(form.tableName) />
		<cfset tableKey = listFirst(form.tableKey) />
		<cfset phonetype  = listFirst(form.phonetype) />
		<cfset formatted = phonetype & "_formatted" />
		<cfif left(idx,4) eq 'NUM_'>
			<cfset this_key = right(idx,len(idx)-4)>
			<cfquery name="update" datasource="#application.dsource#">
				UPDATE #tableName# SET 
				<cfif isDefined('form.NUM_'&this_key)>
					#phonetype# = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#evaluate('form.NUM_'&this_key)#">,
					<cfif evaluate('form.NUM_'&this_key) EQ "" AND evaluate('form.DELETE_'&this_key) NEQ "delete">
						otherphone = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#evaluate('form.OTHERNUM_'&this_key)#">,
					</cfif>
					#formatted# = <cfqueryparam cfsqltype="CF_SQL_INT" value="1">
				</cfif>
				WHERE #tableKey# = #this_key#
			</cfquery>
		</cfif>
	</cfloop>

	<cfscript>
		getNumbers = application.objectFactoryAdmin.getInstance('phoneformat').getNumbers(form.db);
	</cfscript>

</cfif>


<style>
	#phoneform {
		width: 580px;
		border: 1px solid rgb(204, 204, 204);
	}
	#phoneform th {
		font-size: 14px;
		text-align: left;
		font-weight: bold;
		text-transform: uppercase;
		border: 1px solid rgb(204, 204, 204);
	}
	#phoneform td {
		font-size: 13px;
		padding: 5px;
	}
	.trow0 {
		background-color: #e0e0e0;
	}
	.trow1 {
		background-color: #FFFFFF;
	}
	#phoneform .submit {
		font-size: 13px;
		padding: 2px;
	}
</style>


<cfoutput>

<a href="http://gallart.com/admin/index.cfm?event=phoneformat">BACK TO MENU</a>
<br /><br />
<cfif getNumbers.recordcount>

<form method="post" action="">
	<input type="hidden" name="submitted" value="1" />
	<input type="hidden" name="db" value="#form.db#" />
	<input type="hidden" name="tableName" value="#getNumbers.tableName#">
	<input type="hidden" name="tableKey" value="#getNumbers.tableKey#">
	<input type="hidden" name="phonetype" value="#getNumbers.phonetype#">
	<table id="phoneform" class="display">
		<tr>
            <td colspan="2">Format:  (xxx) xxx-xxxx</th>
        </tr>
		<thead>
			
            <tr>
                <th>Existing Phone Number</th>
                <th>Formatted Phone Number</th>
                <th align="center">Outside US</th>
                <th align="center">DELETE</th>
            </tr>
        </thead>
        <cfset tRow = "trow0" />
		<cfloop query="getNumbers">
			<tr class="phone-rows #tRow#">
				<td>
					#phone#
				</td>
				<td style="position: relative;">
					<input type="hidden" name="othernum_#primaryKey#" value="#phone#" />
					<input type="hidden" name="delete_#primaryKey#" id="delete_#primaryKey#" />
					<input type="text" name="num_#primaryKey#" id="num_#primaryKey#" class="phone_us" id="num_#primaryKey#" size="35" pattern="^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$" required>
				</td>
				<td style="position: relative;" align="center">
					<input type="checkbox" name="othernumber" class="othernumber" other="num_#primaryKey#" />
				</td>
				<td style="position: relative;" align="center">
					<input type="checkbox" name="deletenumber" class="deletenumber" delete="num_#primaryKey#" value="#primaryKey#" />
				</td>
			</tr>
			<cfif tRow EQ "trow0">
				<cfset tRow = "trow1" />
			<cfelse>
				<cfset tRow = "trow0" />
			</cfif>
		</cfloop>
		<tr>
			<td colspan="4" align="center">
				<input type="submit" value="EDIT" class="submit">
			</td>
		</tr>
	</table>

</form>

<cfelse>
	NO RECORDS FOUND
</cfif>
</cfoutput>

<script type="text/javascript">
	$(function() {
		$('.othernumber').click(function(){
			var targetElemId = $(this).attr('other');
			if ($("#" + targetElemId).attr('required')) {
				$("#" + targetElemId)
					.removeAttr('required')
					.val('')
					.prop('readOnly', true);
			} else {
				$("#" + targetElemId)
					.attr('required',true)
					.prop('readOnly', false);
			}
		});
		$('.deletenumber').click(function(){
			var thisKey = $(this).val();
			var targetElemId = $(this).attr('delete');
			if ($("#" + targetElemId).attr('required')) {
				$("#" + targetElemId)
					.removeAttr('required')
					.val('')
					.prop('readOnly', true);
				$("#delete_" + thisKey).val('delete');
			} else {
				$("#" + targetElemId)
					.attr('required',true)
					.prop('readOnly', false);
			}
		});
		$('.phone_us').mask('(000) 000-0000');
		$('.phone-rows input:first').focus();
	});
</script>

