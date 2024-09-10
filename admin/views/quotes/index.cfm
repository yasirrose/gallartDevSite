<cfajaxproxy cfc="admin.models.quotes" />
<cfajaxproxy bind="javascript:gridChange({data.pk_quotes})">
<cfhtmlhead text='<script type="text/javascript" src="/admin/scripts/quotes.js.cfm" language="JavaScript"></script>'>
<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
<tr>
<td valign="top">
<table border = "0" width = "100%" cellpadding = "5" cellspacing = "0">
	<tr>
    	<td colspan="2" style="font-size: 11px;"><strong>SEARCH BY:</strong></td>
  	</tr>
	<tr>
		<td valign="top" width="400">
			<cfform name="gridForm">
			<table cellspacing="0" cellpadding="1" border="0" width="100%">
				<tr>
					<td align="right">
						<strong>Last Name:</strong>
					</td>
					<td>
						<cfinput name="searchLname" size="30" />
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td align="right">
						<strong>Email:</strong>
					</td>
					<td>
						<cfinput name="searchEmail" size="30" />

					</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td align="right">
						<strong>Title:</strong>
					</td>
					<td>
						<cfinput name="searchTitle" size="30" />
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td align="right">
						<strong>Date from:</strong>
					</td>
					<td nowrap>
						<cfinput name="searchFromDate" type="datefield" validate="date" size="10" />
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td align="right">
						<strong>Date to:</strong>
					</td>
					<td nowrap>
						<cfinput name="searchToDate" type="datefield" validate="date" size="10" />
					</td>
					<td>
						<input type="Reset"><cfinput type="button" name="searchBtn" value="Search" onclick="ColdFusion.Grid.refresh('data', false);" />
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<cfgrid format="html" name="data" pagesize="15" stripeRows="true" stripeRowColor="##e0e0e0" bind="cfc:admin.models.quotes.getQuotes({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{searchLname},{searchEmail},{searchTitle}, {searchFromDate},{searchToDate})">
						    <cfgridcolumn name="title" header="Title" width="175">
							<cfgridcolumn name="lname" header="Last Name" width="80">
							<cfgridcolumn name="quote_email" header="Email" width="175">
							<cfgridcolumn name="quoteDate" header="Date" width="125">
						</cfgrid>
					</td>
				</tr>
			</table>
			</cfform>
		</td>
		<td valign="top">
			<div  id="showEditArea">
			<cfform name="editForm">
			<cfinput type="hidden" name="pk_quotes" id="pk_quotes" bind="{data.pk_quotes}">
			<table border = "0" width = "500" cellpadding = "5" cellspacing = "0" class="editBox">
				<tr>
					<td width="100">
						First Name:
					</td>
					<td>
						<cfinput type="text" name="fname" id="fname"  bind="{data.fname}" size="30">
					</td>
				</tr>
				<tr>
					<td>
						Last Name:
					</td>
					<td>
						<cfinput type="text" name="lname" id="lname"  bind="{data.lname}" size="30">
					</td>
				</tr>
				<tr>
					<td>
						Email:
					</td>
					<td>
						<cfinput type="text" name="quote_email" id="quote_email"  bind="{data.quote_email}" size="30">&nbsp;
						<span  id="emailLink"></span>
					</td>
				</tr>
				<tr>
					<td>
						Phone:
					</td>
					<td>
						<cfinput type="text" name="phone" id="phone"  bind="{data.phone}" size="30">
					</td>
				</tr>
				<tr>
					<td>
						Cell:
					</td>
					<td>
						<cfinput type="text" name="cell" id="cell"  bind="{data.cell}" size="30">
					</td>
				</tr>
				<tr>
					<td>
						Artist:
					</td>
					<td>
						$<cfinput type="text" name="artist" id="artist"  bind="{data.artist}" size="30">
					</td>
				</tr>
				<tr>
					<td>
						Title:
					</td>
					<td>
						$<cfinput type="text" name="title" id="title"  bind="{data.title}" size="30">
					</td>
				</tr>
				<tr>
					<td valign="top">
						Medium:
					</td>
					<td>
						<cfinput type="text" name="medium" id="medium"  bind="{data.medium}" size="30">
					</td>
				</tr>
				<tr>
					<td valign="top">
						Graphics/Prints:
					</td>
					<td>
						<cfinput type="Text" name="graphics" bind="{data.graphics}" size="40" required="No" message="Please enter Graphics/Prints." />&nbsp;<cfinput type="text" name="edition" id="edition"  bind="{data.edition}" size="5">&nbsp;Edition
					</td>
				</tr>
				<tr>
					<td valign="top">
						Signature:
					</td>
					<td>
						<input type="radio" name="signature" value="Hand Signed">&nbsp;hand signed&nbsp;&nbsp;<input type="radio" name="signature" value="Plate Signed">&nbsp;plate signed
					</td>
				</tr>
				<tr>
					<td valign="top">
						Unframed Size:
					</td>
					<td>
						<cfinput type="text" name="size" id="size"  bind="{data.size}" size="30">
					</td>
				</tr>
				<tr>
					<td valign="top">
						Sculpture:
					</td>
					<td>
						<cfinput type="text" name="sculpture" id="sculpture"  bind="{data.sculpture}" size="30">
					</td>
				</tr>
				<tr>
					<td valign="top">
						Year:
					</td>
					<td>
						<cfinput type="text" name="year" id="year"  bind="{data.year}" size="30">
					</td>
				</tr>
				<tr>
					<td valign="top">
						Asking Price:
					</td>
					<td>
						<cfinput type="text" name="asking_price" id="asking_price"  bind="{data.asking_price}" size="30">
					</td>
				</tr>
				<tr>
					<td valign="top">
						Description:
					</td>
					<td>
						<cftextarea name="description" cols="40" rows="2" bind="{data.description}" style="height: 75px;"></cftextarea>
					</td>
				</tr>
				<tr>
					<td colspan="2"><img src="" id="artImg" width="300"></td>
				</tr>
				<tr>
					<td colspan="2" >
						<cfinput type="button" name="delete" id="delete" value="Delete" onclick="if (confirm('DELETE -- ARE YOU SURE?')){ doEdit('delete');}" />
					</td>
				</tr>
			</table>
			</cfform>
			</div>
		</td>
	</tr>
</table>

<cfset ajaxOnLoad("init")>
