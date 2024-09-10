<!--- <cfset temp = structDelete(session,'orderArray') /> --->
<table border = "0" width = "600" cellpadding = "5" cellspacing = "0" bgcolor="ffffff">
	<tr>
		<td align="center" valign="top">
			<span class="header">GALLART PRODUCT ORDER FORM</span><br><br>
			<span class="subheader">Enter your password to submit the order information.</span>
		</td>
	</tr>
</table>
<cfoutput>
<cfform action="index.cfm?event=orders.confirmInvoice" id="orderForm" name="orderForm">
<input type="hidden" name="invoiceNumber" id="invoiceNumber" value="0">
<input type="hidden" name="displayInvoiceNumber" id="displayInvoiceNumber" value="0">
<input type="hidden" name="assignedTo" id="assignedTo">
<table border = "0" width = "600" cellpadding = "5" cellspacing = "5" bgcolor="eeeeee">
	<tr>
		<td width="125">
			Search Existing Customers:
		</td>
		<td>
			<cfselect query="getCustomers" name="customerId" display="full_customer_name" value="id" selected="#form.customerId#" onChange="getCustomer(this.value);" queryPosition="below">
			<option value="">Please Select</option>
			</cfselect>
		</td>
	</tr>
	<tr>
		<td width="125">
			Search Leads:
		</td>
		<td>
			<cfselect query="getLeads" name="leadId" display="full_lead_name" value="pk_leads" selected="#form.leadId#" onChange="getLead(this.value);" queryPosition="below">
			<option value="">Please Select</option>
			</cfselect>
		</td>
	</tr>
	<tr>
		<td valign="top" colspan="2">
			<input type="Button" value="Search All Contacts" onclick="openSearchAllContactsWindow();" />
		</td>
	</tr>
	<tr>
		<td>
			First Name:
		</td>
		<td>
			<!--- <cfinput name="fname" id="fname" autosuggest="cfc:admin.models.leads.searchLeadsByFname({cfautosuggestvalue})" maxResultsDisplay="10"  size="50" align="left" style="z-index:1000;" tabindex="0"  value="#form.fname#"> --->
			<input type="text" name="fname" id="fname"  size="50"  value="#form.fname#">
		</td>
	</tr>
	<tr>
		<td>
			Last Name:
		</td>
		<td>
			<cfinput name="lname" id="lname" autosuggest="cfc:admin.models.all_contacts.getAllContactsFromLname({cfautosuggestvalue})" maxResultsDisplay="10"  size="50" align="left" style="z-index:1000;" tabindex="0" value="#form.lname#">
&nbsp;
<input type="Button" value="Fill" onclick="fillLname('orderform',document.getElementById('lname').value)">
			<!--- <input type="text" name="lname" id="lname"  size="50"  value="#form.lname#"> --->
		</td>
	</tr>
	<tr>
		<td valign="top">
			Email Address:
		</td>
		<td>
			<cfinput name="Email" id="Email" autosuggest="cfc:admin.models.all_contacts.getAllContactsFromEmail({cfautosuggestvalue})" maxResultsDisplay="10"  size="50" align="left" style="z-index:1000;" tabindex="0" value="#form.Email#">&nbsp;
<input type="Button" value="Fill" onclick="fillEmail('orderform',document.getElementById('Email').value)">
			<!--- <input type="text" name="Email" id="Email" size="50" value="#form.Email#"> --->
		</td>
	</tr>
	<tr>
		<td>
			<span style="color: ##ff0000;">Cell Phone</span>
		</td>
		<td>
			<cfinput type="text" name="CellPhone" id="CellPhone"  size="50"  value="#form.CellPhone#" validate="regular_expression" pattern="^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$" mask="(999) 999-9999" message="Please enter the home cell number in the format (xxx) xxx-xxxx"> (xxx) xxx-xxxx
		</td>
	</tr>
	<tr>
		<td width="125">
			Home Phone:
		</td>
		<td>
			<cfinput type="text" name="Phone" id="Phone"  size="50"  value="#form.Phone#" validate="regular_expression" pattern="^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$" mask="(999) 999-9999" message="Please enter the home phone number in the format (xxx) xxx-xxxx"> (xxx) xxx-xxxx
		</td>
	</tr>
	<tr>
		<td>
			Business Phone
		</td>
		<td>
			<cfinput type="text" name="BusinessPhone" id="BusinessPhone"  size="50"  value="#form.BusinessPhone#" validate="regular_expression" pattern="^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$" mask="(999) 999-9999" message="Please enter the business phone number in the format (xxx) xxx-xxxx"> (xxx) xxx-xxxx
		</td>
	</tr>
	<tr>
		<td>
			Phone Outside the US
		</td>
		<td>
			<input type="text" name="OtherPhone" id="OtherPhone"  size="50"  value="#form.OtherPhone#">
		</td>
	</tr>
	<tr>
		<td>
			Fax:
		</td>
		<td>
			<input type="text" name="Fax" id="Fax" size="50"  value="#form.Fax#">
		</td>
	</tr>
	<tr>
		<td>
			Consultant:
		</td>
		<td>
			<input type="text" name="Consultant" id="Consultant"  size="50"  value="#form.Consultant#">
		</td>
	</tr>
	<tr>
		<td>
			Company Name:
		</td>
		<td>
			<input type="text" name="Company" id="Company"  size="50"  value="#form.Company#">
		</td>
	</tr>
	<tr>
		<td>
			Address:
		</td>
		<td>
			<input type="text" name="Address1" id="Address1" size="50" value="#form.Address1#">
		</td>
	</tr>
	<tr>
		<td>
			City:
		</td>
		<td>
			<input type="text" name="City" id="City" size="50" value="#form.City#">
		</td>
	</tr>
	<tr>
		<td>
			State:
		</td>
		<td>
        	<select name="State" id="State">
            <option value="">Please Select</option>
            <cfloop query="getStates">
                <option value="#stateAbb#" <cfif form.State EQ stateAbb>selected</cfif>>#state#</option>
            </cfloop>
            </select>
			<!---<input type="text" name="State" id="State" size="50" value="#form.State#">--->
		</td>
	</tr>
	<tr>
		<td>
			Country:
		</td>
		<td>
			<input type="text" name="Country" id="Country" size="50" value="#form.Country#">
		</td>
	</tr>
	<tr>
		<td>
			Zip Code:
		</td>
		<td>
			<input type="text" name="Zip" id="Zip" size="50" value="#form.Zip#">
		</td>
	</tr>
	<tr>
		<td>
			Website:
		</td>
		<td>
			<input type="text" name="website" id="website" size="50" value="#form.website#">
		</td>
	</tr>
	<tr>
		<td valign="top">
			Method of Payment:
		</td>
		<td>
			<cfset paymentOptions = "VISA/MC,AMEX,CHECK,CASH,OTHER" />
			<select name="Payment_Method">
				<option value="">Please Select</option>
				<cfloop list="#paymentOptions#" index="idx">
					<option value="#idx#" <cfif idx EQ form.Payment_Method>selected</cfif>>#idx#</option>
				</cfloop>
			</select>
		</td>
	</tr>
	<tr>
		<td valign="top">
			Credit Card Number:
		</td>
		<td>
			<input type="text" name="CardNumber" id="CardNumber" size="50" value="#form.CardNumber#">
		</td>
	</tr>
	<tr>
		<td valign="top">
			Expiration Date:
		</td>
		<td>
			MM&nbsp;
			<select name="cardexpm">
			<cfloop from="1" to="12" index="monthis">
			<cfif len(monthis) EQ 1>
			<option value="0#monthis#" <cfif monthis EQ form.cardexpm>selected</cfif>>0#monthis#</option>
			<cfelse>
			<option value="#monthis#" <cfif monthis EQ form.cardexpm>selected</cfif>>#monthis#</option>
			</cfif>
			</cfloop>
			</select>
			YY&nbsp;
			<select name="cardexpy">
			<cfset toyear = #Year(Now())# + 10>
			<cfloop from="#Year(Now())#" to="#toyear#" index="yearis">
			<option value="#right(yearis,2)#" <cfif right(yearis,2) EQ form.cardexpy>selected</cfif>>#right(yearis,2)#</option>

		</cfloop></td>
	</tr>
	<tr>
		<td valign="top">
			Auth Code:
		</td>
		<td>
			<input type="text" name="authcode" id="authcode" size="50" value="#form.authcode#">
		</td>
	</tr>
	<tr>
		<td valign="top">
			Driver's License Number:
		</td>
		<td>
			<input type="text" name="DriversLicense" id="DriversLicense" size="50" value="#form.DriversLicense#">
		</td>
	</tr>
	<tr>
		<td valign="bottom">
			TO BE SHIPPED:
		</td>
		<td valign="top">
			<input type="checkbox" name="tobeshipped" align="texttop" id="tobeshipped" <cfif form.tobeshipped EQ 1>checked</cfif> >
			<input type="Hidden" name="tobeshipped">
		</td>
	</tr>
	<tr>
		<td valign="bottom">
			ESTIMATE:
		</td>
		<td valign="top">
			<input type="checkbox" name="estimate" align="texttop" id="estimate" value="1" <cfif form.estimate EQ 1>checked</cfif> >
			<input type="Hidden" name="estimate">
		</td>
	</tr>
	<tr>
		<td valign="top" colspan="2">
			<input type="Button" value="Add Product By Art ID" onclick="openProductIdWindow();" />
		</td>
	</tr>
	<tr>
		<td valign="top" colspan="2">
			<input type="Button" value="Add Product By Product Title" onclick="openProductTitleWindow();" />
		</td>
	</tr>

<script>
	function openArtInfo() {
		window.open('index.cfm?event=orders.artInfo', 'artInfo', 'width=500,height=250,left=0,top=0,resizable=yes,scrollbars=yes');
	}

	function openFramingInfo() {
		window.open('index.cfm?event=orders.framingInfo', 'framingInfo', 'width=500,height=250,left=0,top=0,resizable=yes,scrollbars=yes');
	}
</script>

	<tr>
		<td valign="top" colspan="2">
			<input type="Button" value="Add Product Not In Database" onclick="openArtInfo();" />
		</td>
	</tr>
	<tr>
		<td valign="top" colspan="2">
			<input type="Button" value="Add Framing Order" onclick="openFramingInfo();" />
		</td>
	</tr>
	<tr>
		<td colspan="2" id="artListings">
		</td>
	</tr>
	<tr>
		<td valign="top" colspan="2">
			Special Instructions:
		</td>
	</tr>
	<tr>
		<td valign="top" colspan="2">
			<textarea name="special_instructions" cols="50" rows="3">#form.special_instructions#</textarea>
		</td>
	</tr>
	<tr>
		<td valign="top">
			Origin:
		</td>
		<td>
			<cfset originValues = "WALK-IN,WEBSITE,PHONE,HOUSE,OTHER" />
			<select name="origin">
				<option value="">Please Select</option>
				<cfloop list="#originValues#" index="idx">
					<option value="#idx#" <cfif idx EQ form.origin>selected</cfif>>#idx#</option>
				</cfloop>
			</select>
		</td>
	</tr>
	<cfif session.loggedin EQ true AND (listFindNoCase(session.userinfo.roles,'orders') OR session.userinfo.sa EQ 1)>
		<cfinput type="hidden" name="password" value="#session.userinfo.password#">
	<cfelse>
	<tr>
		<td>
			Employee password:
		</td>
		<td>
			<cfinput type="password" name="password" id="password" size="30" required="Yes" message="You must enter your password.">
		</td>
	</tr>
	</cfif>
	<tr>
		<td colspan="2">
			<input type="Reset" value="Reset">
			<input type="Button" value="Submit" onClick="checkPasswordOrder(); return false;" >
		</td>
	</tr>
</table>
</cfform>

</cfoutput>
<script language="JavaScript">
	displayArtListings();
</script>

<div id="cfWindows">
<cfwindow name="artIdWindow" center="true" modal="true" resizable="false" closable="false" title="Enter Art ID" width="250" height="200" headerStyle="background-color:##dd3a7d;">
	<table cellspacing="0" cellpadding="0" border="0" width="100%" bgcolor="#ffffff">
		<tr>
			<td align="center" style="font-family: Arial; font-size: 11px;">
				Enter Art ID:<br><br>
			</td>
		</tr>

		<tr>
			<td align="center" style="font-family: Arial; font-size: 11px;">
				<input type="text" name="modelno" id="modelno" size="20" value="">&nbsp;&nbsp;<input type="Button" value="ADD" onclick="findArt(document.getElementById('modelno').value);" />
			</td>
		</tr>
		<tr>
			<td align="center" style="padding-top: 10px;">
				<input type="Button" value="Close" onclick="ColdFusion.Window.hide('artIdWindow');" style="font-size: 10px;">
			</td>
		</tr>
	</table>
</cfwindow>

<style>
	div.autosuggestcontainer .yui-ac-content {
		*left: -5;
	}
</style>

<cfwindow name="artTitleWindow" center="true" modal="true" resizable="false" closable="false" title="Enter Product Title" width="400" height="400" headerStyle="background-color:##dd3a7d;">
	<table cellspacing="0" cellpadding="0" border="0" width="100%" bgcolor="#ffffff">
		<tr>
			<td align="center" style="font-family: Arial; font-size: 11px;">
				As you enter the title, the system will try to find the listing that you are looking for:<br><br>
			</td>
		</tr>
		<tr>
			<td align="center">
				<input list="artTitles" name="artTitle" id="artTitle" size="50" align="left" style="z-index:1000;" tabindex="0">

				<cfquery name="data" datasource="#application.dsource#">
					SELECT name FROM products
					WHERE active = 1
					AND name <> ''
				</cfquery>

				<datalist id="artTitles">
					<cfoutput query="data">
						<option value="#data.name#">
					</cfoutput>
				</datalist>
			</td>
		</tr>
		<tr>
			<td align="center" style="font-family: Arial; font-size: 11px; padding-top: 15px;">
				<input type="Button" value="ADD" onclick="findArtTitle(document.getElementById('artTitle').value);" />
			</td>
		</tr>
		<tr>
			<td align="center" style="padding-top: 10px;">
				<input type="Button" value="Close" onclick="ColdFusion.Window.hide('artTitleWindow');" style="font-size: 10px;">
			</td>
		</tr>
	</table>
</cfwindow>

<!--- <script language="JavaScript">
	function formatPrice(){
		document.artInfoForm.price.value = decimalFormat(document.artInfoForm.priceInput.value);
	}
	function formatFramingPrice(){
		document.framingInfoForm.price.value = decimalFormat(document.framingInfoForm.priceInput.value);
	}
</script> --->

<!--- <cfwindow name="artInfoWindow" center="true" modal="true" resizable="false" closable="false" title="Enter Product Info" width="400" height="300" headerStyle="background-color:##dd3a7d;">
	<table cellspacing="0" cellpadding="3" border="0" width="100%" bgcolor="#ffffff">
		<cfform method="post" action="" onsubmit="submitArtInfo(); return false;" name="artInfoForm">
		<input type="Hidden" name="price">
		<tr>
			<td align="center" colspan="2" style="font-family: Arial; font-size: 11px;">
				Enter Product Info:<br><br>
			</td>
		</tr>
		<tr>
			<td>Title:</td>
			<td>
				<input type="text" name="title" id="title" size="40" value="">
			</td>
		</tr>
		<tr>
			<td>Artist:</td>
			<td>
				<input type="text" name="artist" id="artist" size="40" value="">
			</td>
		</tr>
		<tr>
			<td>Short Description:</td>
			<td>
				<input type="text" name="desc" id="desc" size="40" value="">
			</td>
		</tr>
		<tr>
			<td>Price:</td>
			<td>
				$<cfinput type="text" name="priceInput" id="priceInput" size="10" value="" validate="float" message="Please enter a numeric value for the price with no dollar sign." onkeyup="formatPrice();">
			</td>
		</tr>
		<tr>
			<td align="center" colspan="2" style="font-family: Arial; font-size: 11px;">
				<input type="Submit" value="ADD" />
			</td>
		</tr>
		<tr>
			<td align="center" colspan="2" style="padding-top: 10px;">
				<input type="Button" value="Close" onclick="ColdFusion.Window.hide('artInfoWindow');" style="font-size: 10px;">
			</td>
		</tr>
		</cfform>
	</table>
</cfwindow> --->

<!--- <cfwindow name="framingInfoWindow" center="true" modal="true" resizable="false" closable="false" title="Enter Framing Info" width="350" height="250" headerStyle="background-color:##dd3a7d;">
	<table cellspacing="0" cellpadding="3" border="0" width="100%" bgcolor="#ffffff">
		<cfform method="post" action="" onsubmit="submitFramingInfo(); return false;" name="framingInfoForm">
		<input type="Hidden" name="price">
		<tr>
			<td align="center" colspan="2" style="font-family: Arial; font-size: 11px;">
				Enter Framing Info:<br><br>
			</td>
		</tr>
		<tr>
			<td>Title:</td>
			<td>
				<input type="text" name="title" id="title" size="40" value="">
			</td>
		</tr>
		<tr>
			<td>Artist:</td>
			<td>
				<input type="text" name="artist" id="artist" size="40" value="">
			</td>
		</tr>
		<tr>
			<td>Short Description:</td>
			<td>
				<input type="text" name="desc" id="desc" size="40" value="">
			</td>
		</tr>
		<tr>
			<td>Price:</td>
			<td>
				$<cfinput type="text" name="priceInput" id="priceInput" size="10" value="" validate="float" message="Please enter a numeric value for the price with no dollar sign." onkeyup="formatFramingPrice();">
			</td>
		</tr>
		<tr>
			<td align="center" colspan="2" style="font-family: Arial; font-size: 11px;">
				<input type="Submit" value="ADD" />
			</td>
		</tr>
		<tr>
			<td align="center" colspan="2" style="padding-top: 10px;">
				<input type="Button" value="Close" onclick="ColdFusion.Window.hide('framingInfoWindow');" style="font-size: 10px;">
			</td>
		</tr>
		</cfform>
	</table>
</cfwindow> --->

<cfwindow name="searchAllContactsWindow" center="true" modal="true" resizable="false" closable="false" title="Search All Contacts" width="500" height="500" headerStyle="background-color:##dd3a7d;">
	<table cellspacing="0" cellpadding="3" border="0" width="100%" bgcolor="#ffffff">
		<cfform method="post" action="" onsubmit="submitSearchAllContacts(document.getElementById('allcontacts_lname').value,document.getElementById('allcontacts_email').value); return false;" name="searchAllContactsForm">
		<tr>
			<td align="center" colspan="2" style="font-family: Arial; font-size: 11px;">
				Use the following to search all contacts in the database:<br><br>
			</td>
		</tr>
		<tr>
			<td>Last Name:</td>
			<td>
				<input type="text" name="allcontacts_lname" id="allcontacts_lname" size="40" value="">
			</td>
		</tr>
		<tr>
			<td>Email:</td>
			<td>
				<input type="text" name="allcontacts_email" id="allcontacts_email" size="40" value="">
			</td>
		</tr>
		<tr>
			<td align="center" colspan="2" style="font-family: Arial; font-size: 11px;">
				<input type="Reset" value="RESET" /> <input type="Submit" value="SEARCH" />
			</td>
		</tr>
		<tr>
			<td align="center" colspan="2" style="padding-top: 10px;">
				<input type="Button" value="Close" onclick="ColdFusion.Window.hide('searchAllContactsWindow');" style="font-size: 10px;">
			</td>
		</tr>
		</cfform>
		<tr>
			<td colspan="2" id="displayAllContacts">
			</td>
		</tr>
	</table>
</cfwindow>
</div>

