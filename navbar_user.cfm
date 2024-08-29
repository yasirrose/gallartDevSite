<cfif isDefined('session.sellerinfo.fname')>

<cfoutput>
<table border="0" cellpadding="0" cellspacing="0" width="100%" height="37" style="border-bottom: solid 4px ##db3a7d;">
	<tr>
		<td width="800">
			<table width="800">
				<tr>
					<td valign="middle" width="40%">	
						<strong>Welcome Member: #UCASE(session.sellerinfo.fname)# #UCASE(session.sellerinfo.lname)#</strong>
					</td>
					<td>
						<input type="image" src="images/home_button.gif" onclick="javascript:goxss('index.cfm?xss=#xss#')" style="border: none;">
					</td>
					<td>
						<input type="Button" style="background:url(images/enter_new_listing_button.gif) no-repeat; width: 150px; height: 30px; border: none; cursor: pointer;" onclick="javascript: window.location.href='user_listing_detail.cfm?xss=#xss#'" value="" />
					</td>
					
					<td>
						<input type="image" src="images/search_your_listings_button.gif" onclick="javascript:goxss('user_listing_search.cfm?xss=#xss#')" style="border: none;">
					</td>
					
					<td valign="middle" width="40%" align="right">
						<input type="image" src="images/log_out_button.gif" onclick="window.location.href='logout.cfm<cfif parameterexists(xss)>?xss=#xss#</cfif>'" style="border: none;">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</cfoutput>

<cfelse>

<cflocation url="user_login_page.cfm" addtoken="No">

</cfif>
