<cfheader name="Content-Disposition" value="inline; filename=document.pdf"> 
<cfcontent type="application/x-pdf"> 
<cfdocument format="pdf" localUrl="true">
<style>
	.infoText{
		font-family: Times New Roman;
		font-size: 13px;
	}
	p {
		margin: 0;
		padding: 0;
	}
</style>
<cfoutput>
<table cellspacing="0" cellpadding="0" border="0" width="100%">
	<tr>
		<td style="padding-top: 40px; padding-left: 40px;" valign="top">
			<table cellspacing="0" cellpadding="0" border="0" width="612">
				<tr>
					<td background="images/forms/coa_generic_bkg.jpg" width="612" height="792" style="background-repeat: no-repeat;" valign="top">
						<table cellspacing="0" cellpadding="0" border="0" width="100%">
							<tr>
								<td colspan="3" align="center"  style="padding: 250px 80px 20px 80px; font-size: 11px;">
									<cfif isDefined('form.coa_desc') AND len(form.coa_desc)>
										#form.coa_desc#
									</cfif>
								</td>
							</tr>
							<tr>
								<td width="350">
									<table cellspacing="0" cellpadding="0" border="0" width="100%">
										<tr>
											<td align="center" style="padding-left: 60px;">
												<img src="images/forms/coa.jpg">
											</td>
										</tr>
									</table>
								</td>
								<td width="250" valign="top">
									<table cellspacing="0" cellpadding="6" border="0" width="100%">
										<cfif isDefined('form.artist') AND len(form.artist)>
										<tr>
											<td class="infoText" width="75">
												ARTIST:&nbsp;
											</td>
											<td class="infoText">
												#form.artist#
											</td>
										</tr>
										</cfif>
										<cfif isDefined('form.title') AND len(form.title)>
										<tr>
											<td class="infoText">
												TITLE:&nbsp;
											</td>
											<td class="infoText">
												#form.title#
											</td>
										</tr>
										</cfif>
										<cfif isDefined('form.medium') AND len(form.medium)>
										<tr>
											<td class="infoText">
												MEDIUM:&nbsp;
											</td>
											<td class="infoText">
												#form.medium#
											</td>
										</tr>
										</cfif>
										<cfif isDefined('form.size') AND len(form.size)>
										<tr>
											<td class="infoText">
												SIZE:&nbsp;
											</td>
											<td class="infoText">
												#form.size#
											</td>
										</tr>
										</cfif>
										<cfif isDefined('form.edition') AND len(form.edition)>
										<tr>
											<td class="infoText">
												EDITION:&nbsp;
											</td>
											<td class="infoText">
												#form.edition#
											</td>
										</tr>
										</cfif>
										<cfif isDefined('form.year') AND len(form.year)>
										<tr>
											<td class="infoText">
												YEAR:&nbsp;
											</td>
											<td class="infoText">
												#form.year#
											</td>
										</tr>
										</cfif>
									</table>
								</td>
								<td width="62">&nbsp;
									
								</td>
							</tr>
							<tr>
								<td colspan="3" align="center" style="padding-top: 200px;">
									<table cellspacing="0" cellpadding="2" border="0" width="100%">
										<cfif isDefined('form.signature_name') AND len(form.signature_name)>
										<tr>
											<td align="center" class="infoText" style="font-size: 22px; font-style: italic;">
												#form.signature_name#
											</td>
										</tr>
										</cfif>
										<cfif isDefined('form.signature_title') AND len(form.signature_title)>
										<tr>
											<td align="center" class="infoText">
												#form.signature_title#
											</td>
										</tr>
										</cfif>
										<cfif isDefined('form.signature_address') AND len(form.signature_address)>
										<tr>
											<td align="center" class="infoText">
												#form.signature_address#
											</td>
										</tr>
										</cfif>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</cfoutput>
</cfdocument>