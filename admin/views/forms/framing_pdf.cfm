<cfheader name="Content-Disposition" value="inline; filename=document.pdf"> 
<cfcontent type="application/x-pdf"> 
<cfdocument format="pdf" localUrl="true">
<style>
	td {
		font-family: Arial;
		font-size: 11px;
	}
	p {
		margin: 0;
		padding: 0;
	}
	h1 {
		font-size: 18px;
	}
	td.box {
		width: 120px;
	}
	.box {
		border: 1px solid #000;
		padding: 3px 0;
		text-align: center;
		font-size: 11px;
		font-weight: bold;
	}
	.wideCell {
		width: 175px;
	}
	.wideCell input {
		width: 170px;
	}
	.narrowCell {
		width: 65px;
	}
	.narrowCell input {
		width: 60px;
	}
	.label {
		font-weight: bold;
		font-size: 8px;
	}
	.spacer {
		width: 10px;
	}
</style>
<cfoutput>
<table cellspacing="0" cellpadding="0" border="0" width="100%">
    <tr>
        <td>
            <table cellspacing="0" cellpadding="0" border="0" width="612">
                <tr>
                    <td>
                        <img src="images/gallart_letterhead_logo.jpg">
                    </td>
                </tr>
                <tr>
                    <td style="padding: 5px 0 0 10px;">
                        <table cellspacing="0" cellpadding="0" border="0" width="100%">
                            <tr>
                                <td width="400">
                                    <h1>FRAMING ORDER</h1>
                                </td>
                                <td width="212" style="padding-bottom: 5px; line-height: 25px;">
                                    <span style="font-size: 10px; font-weight: bold;">Invoice ##:</span>&nbsp;&nbsp;&nbsp;&nbsp;#form.invoice_number#<br>
                                    <span style="font-size: 10px; font-weight: bold;">Consultant:</span>&nbsp;#form.consultant#
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <table cellspacing="0" cellpadding="0" border="0" width="100%">
                                        <tr>
                                            <td class="box">
                                                CLIENT
                                            </td>
                                            <td class="spacer">&nbsp;
                                                
                                            </td>
                                            <td class="wideCell">
                                                #form.client_last_name#
                                            </td>
                                            <td class="wideCell">
                                                #form.client_first_name#
                                            </td>
                                            <td class="narrowCell">
                                                #form.client_date_in#
                                            </td>
                                            <td class="narrowCell">
                                                #form.client_date_due#
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>

                                            </td>
                                            <td class="spacer">&nbsp;
                                                
                                            </td>
                                            <td class="wideCell label">
                                                LAST NAME
                                            </td>
                                            <td class="wideCell label">
                                                FIRST NAME
                                            </td>
                                            <td class="narrowCell label">
                                                DATE IN
                                            </td>
                                            <td class="narrowCell label">
                                                DATE DUE
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="5">
                                                <div>&nbsp;</div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="box">
                                                PHONE
                                            </td>
                                            <td class="spacer">&nbsp;
                                                
                                            </td>
                                            <td class="wideCell">
                                                #form.home_phone#
                                            </td>
                                            <td class="wideCell">
                                                #form.business_phone#
                                            </td>
                                            <td class="narrowCell label">&nbsp;
                                                
                                            </td>
                                            <td class="narrowCell label">&nbsp;
                                                
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>

                                            </td>
                                            <td class="spacer">&nbsp;
                                                
                                            </td>
                                            <td class="wideCell label">
                                                HOME PHONE
                                            </td>
                                            <td class="wideCell label">
                                                BUSINESS PHONE
                                            </td>
                                            <td class="narrowCell label">&nbsp;
                                                
                                            </td>
                                            <td class="narrowCell label">&nbsp;
                                                
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="5">
                                                <div>&nbsp;</div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="box">
                                                ART
                                            </td>
                                            <td class="spacer">&nbsp;
                                                
                                            </td>
                                            <td class="wideCell" colspan="2">
                                                #form.description#
                                            </td>
                                            <td class="narrowCell" nowrap="nowrap">
                                                #form.size1#&nbsp;x&nbsp;#form.size2#
                                            </td>
                                            <td class="narrowCell">
                                                #form.condition#
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>

                                            </td>
                                            <td class="spacer">&nbsp;
                                                
                                            </td>
                                            <td class="wideCell label" colspan="2">
                                                DESCRIPTION (BE SPECIFIC)
                                            </td>
                                            <td class="narrowCell label">
                                                SIZE
                                            </td>
                                            <td class="narrowCell label">
                                                CONDITION
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="5">
                                                <div>&nbsp;</div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="box">
                                                FRAME
                                            </td>
                                            <td class="spacer">&nbsp;
                                                
                                            </td>
                                            <td class="wideCell">
                                                #form.stock#
                                            </td>
                                            <td class="wideCell">
                                                #form.frame_no#
                                            </td>
                                            <td class="wideCell" colspan="2">
                                                #form.color#
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>

                                            </td>
                                            <td class="spacer">&nbsp;
                                                
                                            </td>
                                            <td class="wideCell label">
                                                STOCK OR CO. NAME
                                            </td>
                                            <td class="wideCell label">
                                                NO.
                                            </td>
                                            <td colspan="2" class="wideCell label">
                                                COLOR
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="5">
                                                <div>&nbsp;</div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="box">
                                                LINER
                                            </td>
                                            <td class="spacer">&nbsp;
                                                
                                            </td>
                                            <td class="wideCell">
                                                #form.liner_co_name#
                                            </td>
                                            <td class="wideCell">
                                                #form.liner_no#
                                            </td>
                                            <td class="narrowCell label">&nbsp;
                                                
                                            </td>
                                            <td class="narrowCell label">&nbsp;
                                                
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>

                                            </td>
                                            <td class="spacer">&nbsp;
                                                
                                            </td>
                                            <td class="wideCell label">
                                                CO. NAME
                                            </td>
                                            <td class="wideCell label">
                                                NO.
                                            </td>
                                            <td class="narrowCell label">&nbsp;
                                                
                                            </td>
                                            <td class="narrowCell label">&nbsp;
                                                
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="5">
                                                <div>&nbsp;</div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="box">
                                                LINEN
                                            </td>
                                            <td class="spacer">&nbsp;
                                                
                                            </td>
                                            <td class="wideCell">
                                                #form.linen_size#
                                            </td>
                                            <td class="wideCell">
                                                #form.linen_color#
                                            </td>
                                            <td class="wideCell" colspan="2">
                                                #form.linen_float#
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>

                                            </td>
                                            <td class="spacer">&nbsp;
                                                
                                            </td>
                                            <td class="wideCell label">
                                                SIZE
                                            </td>
                                            <td class="wideCell label">
                                                COLOR
                                            </td>
                                            <td colspan="2" class="wideCell label">
                                                FLOAT
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="5">
                                                <div>&nbsp;</div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="box">
                                                FILLET
                                            </td>
                                            <td class="spacer">&nbsp;
                                                
                                            </td>
                                            <td class="wideCell">
                                                #form.fillet_co#
                                            </td>
                                            <td class="wideCell">
                                                #form.fillet_no#
                                            </td>
                                            <td class="wideCell label" colspan="2">
                                                HPF
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>

                                            </td>
                                            <td class="spacer">&nbsp;
                                                
                                            </td>
                                            <td class="wideCell label">
                                                CO. NAME
                                            </td>
                                            <td class="wideCell label">
                                                NO.
                                            </td>
                                            <td colspan="2" class="wideCell label">&nbsp;
                                                
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="5">
                                                <div>&nbsp;</div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="box">
                                                MATS
                                            </td>
                                            <td class="spacer">&nbsp;
                                                
                                            </td>
                                            <td class="wideCell">
                                                #form.mats_innercolor1#
                                            </td>
                                            <td class="wideCell">
                                                #form.mats_innercolor1#
                                            </td>
                                            <td class="wideCell" colspan="2">
                                                #form.mats_outercolor#
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>

                                            </td>
                                            <td class="spacer">&nbsp;
                                                
                                            </td>
                                            <td class="wideCell label">
                                                1ST INNER - COLOR
                                            </td>
                                            <td class="wideCell label">
                                                2ND INNER - COLOR
                                            </td>
                                            <td colspan="2" class="wideCell label">
                                                OUTER - COLOR
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="5">
                                                <div>&nbsp;</div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>&nbsp;
                                                
                                            </td>
                                            <td class="spacer">&nbsp;
                                                
                                            </td>
                                            <td class="wideCell">
                                                #form.blank1#
                                            </td>
                                            <td class="wideCell">
                                                #form.blank2#
                                            </td>
                                            <td class="wideCell label" colspan="2">&nbsp;
                                                
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="5">
                                                <div>&nbsp;</div>
                                            </td>
                                        </tr>
                                    </table>		
                                </td>	
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <table cellspacing="0" cellpadding="0" border="0" width="100%">
                                        <tr>
                                            <td class="box" style="width: 125px;">
                                                MOUNTING
                                            </td>
                                            <td class="spacer">&nbsp;
                                                
                                            </td>
                                            <td class="label">
                                                DRY MOUNT:
                                            </td>
                                            <td class="label">
                                                YES&nbsp;<cfif isDefined('form.drymount_yes') AND len(form.drymount_yes)><img src="http://#server_name#/admin/images/checkmark.jpg"></cfif>
                                            </td>
                                            <td class="label">
                                                NO&nbsp;<cfif isDefined('form.drymount_no') AND len(form.drymount_no)><img src="http://#server_name#/admin/images/checkmark.jpg"></cfif>
                                            </td>
                                            <td class="label">
                                                ARCHIVAL&nbsp;<cfif isDefined('form.drymount_archival') AND len(form.drymount_archival)><img src="http://#server_name#/admin/images/checkmark.jpg"></cfif>
                                            </td>
                                            <td class="label">
                                                SPRAY&nbsp;<cfif isDefined('form.drymount_spray') AND len(form.drymount_spray)><img src="http://#server_name#/admin/images/checkmark.jpg"></cfif>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="7">&nbsp;
                                                <div>&nbsp;</div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="box" style="width: 125px;">
                                                GLAZING
                                            </td>
                                            <td class="spacer">&nbsp;
                                                
                                            </td>
                                            <td class="label">
                                                PLEXI&nbsp;&nbsp;&nbsp;<cfif isDefined('form.plexi') AND len(form.plexi)><img src="http://#server_name#/admin/images/checkmark.jpg"></cfif>
                                            </td>
                                            <td class="label" colspan="2">
                                                NON-GLARE PLEXI&nbsp;&nbsp;&nbsp;<cfif isDefined('form.nonglare_plexi') AND len(form.nonglare_plexi)><img src="http://#server_name#/admin/images/checkmark.jpg"></cfif>
                                            </td>
                                            <td class="label" colspan="2">
                                                U.V. PLEXI&nbsp;<cfif isDefined('form.uv_plexi') AND len(form.uv_plexi)><img src="http://#server_name#/admin/images/checkmark.jpg"></cfif>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>&nbsp;
                                                
                                            </td>
                                            <td class="spacer">&nbsp;
                                                
                                            </td>
                                            <td class="label">
                                                GLASS&nbsp;<cfif isDefined('form.glass') AND len(form.glass)><img src="http://#server_name#/admin/images/checkmark.jpg"></cfif>
                                            </td>
                                            <td class="label" colspan="2">
                                                NON-GLARE GLASS&nbsp;<cfif isDefined('form.nonglare_glass') AND len(form.nonglare_glass)><img src="http://#server_name#/admin/images/checkmark.jpg"></cfif>
                                            </td>
                                            <td class="label" colspan="2">
                                                NONE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<cfif isDefined('form.none') AND len(form.none)><img src="http://#server_name#/admin/images/checkmark.jpg"></cfif>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="7">&nbsp;
                                                <div>&nbsp;</div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="box" style="width: 125px;">
                                                CANVASES
                                            </td>
                                            <td class="spacer">&nbsp;
                                                
                                            </td>
                                            <td class="label" colspan="2">
                                                STRETCHER BARS&nbsp;&nbsp;&nbsp;<cfif isDefined('form.stretcher_bars') AND len(form.stretcher_bars)><img src="http://#server_name#/admin/images/checkmark.jpg"></cfif>
                                            </td>
                                            <td class="label" colspan="3">
                                                STRETCH ON FOAMCORE&nbsp;&nbsp;&nbsp;<cfif isDefined('form.stretch_on_foamcore') AND len(form.stretch_on_foamcore)><img src="http://#server_name#/admin/images/checkmark.jpg"></cfif>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="7">&nbsp;
                                                <div>&nbsp;</div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" valign="top">
                                                <div class="box" style="width: 250px;">SPECIAL INSTRUCTIONS</div>
                                            </td>
                                            <td colspan="4" valign="top" style="padding-left: 5px;">
                                                #form.special_instructions#
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="7">
												<div style="padding-top: 10px;">&nbsp;</div>
                                                <table cellspacing="0" cellpadding="2" border="0" width="100%">
                                                    <tr>
                                                        <td class="box" style="width: 150px; height: 20px;">
                                                            TOTAL SALE
                                                        </td>
                                                        <td style="width: 130px; text-align: center;">
                                                            #form.toal_sale#
                                                        </td>
                                                        <td class="box" style="width: 150px; height: 20px;">
                                                            BALANCE DUE
                                                        </td>
                                                        <td style="width: 130px; text-align: center;">
                                                            #form.balance_due#
                                                        </td>
                                                        <td class="box" style="width: 150px; height: 20px;">
                                                            QUANTITY
                                                        </td>
                                                        <td style="width: 85px; text-align: center;">
                                                            #form.quantity#
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="7">&nbsp;
                                                <table cellspacing="0" cellpadding="2" border="0" width="100%">
                                                    <tr>
                                                        <td class="box" style="width: 150px; height: 20px;">
                                                            INSPECTED BY
                                                        </td>
                                                        <td style="width: 250px; text-align: center;">
                                                            #form.inspected_by#
                                                        </td>
                                                        <td class="box" style="width: 150px; height: 20px;">
                                                            DATE
                                                        </td>
                                                        <td style="width: 130px; text-align: center;">
                                                            #form.date#
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="7">&nbsp;
                                                <div>&nbsp;</div>
                                            </td>
                                        </tr>
                                    </table>											
                                </td>							
                            </tr>
                        </table>								
                    </td>
                </tr>
                <tr>
                    <td align="center" style="padding-top: 5px;">
                        <img src="images/letterhead_footer.jpg">
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</cfoutput>
</cfdocument>