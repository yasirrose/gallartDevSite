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
		<td style="padding-left: 40px; padding-top: 50px;">
			<img src="images/gallart_letterhead_logo.jpg">
			<table cellspacing="0" cellpadding="0" border="0" width="574">
				<tr>
					<td background="images/appraisal_bkg2.jpg" width="574" height="800" style="background-repeat: no-repeat;" valign="top">
						<table cellspacing="0" cellpadding="0" border="0" width="100%">
							<tr>
								<td style="padding-top: 180px; padding-left: 74px;">
						
								
									<table cellspacing="0" cellpadding="0" border="0" width="100%">
										<tr>
											<td valign="top">
												<table cellspacing="0" cellpadding="2" border="0" width="275">
													<tr>
														<td class="infoText">
															Date:&nbsp;#form.date#
														</td>
													</tr>
													<tr>
														<td class="infoText">
															Client Name:&nbsp;#form.client#
														</td>
													</tr>
													<cfif isDefined('form.address') AND len(form.address)>
													<tr>
														<td class="infoText">
															#form.address#
														</td>
													</tr>
													</cfif>
													<tr>
														<td class="infoText">
															<cfif isDefined('form.city') AND len(form.city)>#form.city#,</cfif> <cfif isDefined('form.state') AND len(form.state)>#form.state#</cfif> <cfif isDefined('form.zip') AND len(form.zip)>#form.zip#</cfif>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td class="infoText" style="padding-top: 10px;">
												Objective:&nbsp;#form.objective#
											</td>
										</tr>
										<tr>
											<td style="padding-top: 44px;" valign="top">
												<table cellspacing="0" cellpadding="0" border="0" width="100%" height="325">
													<tr>
														<td width="348" valign="top">
															<table cellspacing="2" cellpadding="0" border="0" width="250">
																<cfif isDefined('form.artist') AND len(form.artist)>
																<tr>
																	<td class="infoText">
																		Artist:&nbsp;
																		#form.artist#
																	</td>
																</tr>
																</cfif>
																<cfif isDefined('form.title') AND len(form.title)>
																<tr>
																	<td class="infoText">
																		Title:&nbsp;
																		#form.title#
																	</td>
																</tr>
																</cfif>
																<cfif isDefined('form.medium') AND len(form.medium)>
																<tr>
																	<td class="infoText">
																		Medium:&nbsp;
																		#form.medium#
																	</td>
																</tr>
																</cfif>
																<cfif isDefined('form.condition') AND len(form.condition)>
																<tr>
																	<td class="infoText">
																		Condition:&nbsp;
																		#form.condition#
																	</td>
																</tr>
																</cfif>
																<cfif isDefined('form.value') AND len(form.value)>
																<tr>
																	<td class="infoText">
																		Suggested Retail Value:&nbsp;
																		$#form.value#
																	</td>
																</tr>
																</cfif>
															</table>
														</td>
														<td width="226" valign="top">
															<img src="images/forms/appraisal.jpg">
														</td>
													</tr>
												</table>	
											</td>
										</tr>
									</table>
									<table cellspacing="0" cellpadding="0" border="0" width="100%">
										<tr>
											<td width="370">&nbsp;</td>
											<td width="130" align="center" style="border-top: 2px solid ##000; font-style: italic; font-size: 11px;">
												&nbsp;Ken Hendel, Gallery Art
											</td>
											<td width="74">&nbsp;</td>
										</tr>
									</table>	
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td align="center">
						<img src="images/letterhead_footer.jpg">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</cfoutput>
</cfdocument>