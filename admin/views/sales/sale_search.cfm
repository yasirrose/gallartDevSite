
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

	<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
	<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

	<style>

		.sales-table-content input:not([type="checkbox"]):not([type="radio"]) {
			width: 100%;
		}
		.sales-table-content .select2-container {
    		width: 100% !important;
		}
		.sales-table-content .calendar-field > div {
			width: 100%;
		}
		.sales-table-content .calendar-field > div > div:first-child {
			width: calc(100% - 20px);
		}
		.sales-table-content .form-row {
			display: flex;
			flex-wrap: wrap;
			gap: 2px;
		}
		.sales-table-content .form-group {
			width: max-content;
			display: flex;
			align-items: center;
			gap: 2px;
		}
	</style>

<div style="text-align: center"><input type="Button" value="Back To Sales Menu" onclick="location.href='index.cfm?event=sales'"></div>
<table cellspacing="0" cellpadding="0" border="0" width="700" align="left">
    <tr>
		<td colspan="2">
			<cfform method="post" action="index.cfm?event=sales.saleSearchResults" onsubmit="return disableSubmitBtn()">
				<table cellspacing="0" cellpadding="0" border="0" width="100%" align="left">
					<tr>
						<td colspan="2" style="font-size: 13px;"><strong>SET SALE PRICES</strong><br /><br />
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<input type="button" value="SET SALE PRICES FOR ENTIRE DATABASE" onclick="location.href='index.cfm?event=sales.setAllSalePrices'" /><br /><br />
						</td>
					</tr>
					<tr>
						<td colspan="2" style="font-size: 11px;">
							<strong>
								Use fields below to search for listings for which sale prices are to be set:
							</strong>
							<br/><br/>
						</td>
					</tr>
					<tr>
						<td valign="top" colspan="2">
							<table cellspacing="0" cellpadding="3" border="0" width="100%" class="sales-table-content">
								<tr>
									<td width="100" style="font-size: 10px;">
										<strong>Art ID:</strong>
										<br>
										<cfinput name="modelno" size="10" maxlength="10"/>
									</td>
									<td width="100" style="font-size: 10px;">
										<strong>Title:</strong>
										<br>
										<cfinput name="title" size="30" maxlength="30"/>
									</td>
				
								</tr>
								<!--- <tr>
									<td style="font-size: 10px;">
										<strong>Title:</strong>
									</td>
									<td>
										<cfinput name="title" size="30" maxlength="30"/>
									</td>
				
								</tr> --->
								<tr>
									<td style="font-size: 10px;">
										<strong>Artist:</strong>
										<select name="artist" class="select2">
											<option value="">All</option>
											<cfoutput query="getAllArtists" group="manufacturer">
											<cfif not isnumeric(manufacturer) and len(manufacturer) gt 1>
												<option value="#HTMLEditFormat(manufacturer)#">#HTMLEditFormat(manufacturer)#</option>
											</cfif>
											</cfoutput>
										</select>
									</td>
									<td>
										<strong>Exclude Artist:</strong>
										<br>
										<select name="exclude_artist" class="select2">
											<option value="">All</option>
											<cfoutput query="getAllArtists" group="manufacturer">
											<cfif not isnumeric(manufacturer) and len(manufacturer) gt 1>
												<option value="#HTMLEditFormat(manufacturer)#">#HTMLEditFormat(manufacturer)#</option>
											</cfif>
											</cfoutput>
										</select>

									</td>
				
								</tr>
								<!--- <tr>
									<td style="font-size: 10px;">
										<strong>Exclude Artist:</strong>
									</td>
									<td>
										<select name="exclude_artist" class="select2">
											<option value="">All</option>
											<cfoutput query="getAllArtists" group="manufacturer">
											<cfif not isnumeric(manufacturer) and len(manufacturer) gt 1>
												<option value="#HTMLEditFormat(manufacturer)#">#HTMLEditFormat(manufacturer)#</option>
											</cfif>
											</cfoutput>
										</select>
									</td>
				
								</tr> --->
								<tr>
									<!-- <td style="font-size: 10px;">
										<strong>Medium:</strong>
									</td> -->
									<td style="font-size: 10px;">
										<strong>Medium:</strong>
										<br>
										<select name="path" class="select2">
											<option value="">All</option>
											<cfoutput query="getAllMedium">
												<option value="#path#">#path#</option>
											</cfoutput>
										</select>
									</td>
									<td style="font-size: 10px;">
										<strong>Seller:</strong>
										<br>
										<select name="SellerId" class="select2">
											<option value="">All
											<option value="0">Only Seller Listings
											<cfoutput query="getAllSellers">
												<option value="#pk_users#">#full_seller_name#
											
										</cfoutput></select>
									</td>
								</tr>
								<!--- <tr>
									<td colspan="2">
										<table cellspacing="0" cellpadding="0" border="0" width="100%">
											<tr>
												<td width="106" style="font-size: 10px;">
													<strong>Year:</strong>
												</td>
												<td width="100">
													<cfinput name="Year" size="10" />
												</td>
												<td width="50" style="font-size: 10px;">
													<strong>Size:</strong>
												</td>
												<td>
													<cfinput type="Text" name="Height" style="width: 50px;">&nbsp;x&nbsp;<cfinput type="Text" name="Width" style="width: 50px;"> (HEIGHT X WIDTH)
												</td>
											</tr>
										</table>					
									</td>
								</tr> --->
								<tr>
									
									<!--- <td>
										<cfinput name="caption" size="30" maxlength="30"/>
									</td> --->
									<td width="106" style="font-size: 10px;">
										<strong>Gallery Price from:$</strong>
										<br>
										<cfinput name="FromPrice" size="10" maxlength="10"/>
									</td>
									<td width="106" style="font-size: 10px;">
										<strong>to:$</strong>
										<br>
										<cfinput name="ToPrice" size="10" maxlength="10"/>
									</td>
				
								</tr>
								<tr>
									<td colspan="2">
										<table cellspacing="0" cellpadding="0" border="0" width="100%">
											<tr>
												<!--- <td width="106" style="font-size: 10px;">
													<strong>Gallery Price from:</strong>
													$<cfinput name="FromPrice" size="10" maxlength="10"/>
													<strong>to:</strong>
													$<cfinput name="ToPrice" size="10" maxlength="10"/>
												</td> --->
												<!--- <td width="100">
													
												</td> --->
												<!--- <td width="25" style="font-size: 10px;">
													<strong>to:</strong>
													$<cfinput name="ToPrice" size="10" maxlength="10"/>
												</td> --->
												<!--- <td nowrap>
													
												</td> --->
											</tr>
										</table>					
									</td>
								</tr>
								<tr>
									<!-- <td colspan="2">
										<table cellspacing="0" cellpadding="0" border="0" width="100%">
											<tr> -->
												<!-- <td width="106" style="font-size: 10px;">
													<strong>Date from:</strong>
												</td>
												<td width="100">
													<cfinput name="FromDate" type="datefield" validate="date" size="10" maxlength="10"/>
												</td>
												<td width="25" style="font-size: 10px;">
													<strong>to:</strong>
												</td>
												<td nowrap>
													<cfinput name="ToDate" type="datefield" validate="date" size="10" maxlength="10"/>
												</td> -->
												
											<!-- </tr>
										</table>					
									</td> -->
									<td class="calendar-field" style="font-size: 10px;">
										<strong>Date from:</strong>
										<br>
										<cfinput name="FromDate" type="datefield" validate="date" size="10" maxlength="10"/>
									</td>
									<td class="calendar-field" style="font-size: 10px;">
										<strong>Date to:</strong>
										<br>
										<cfinput name="ToDate" type="datefield" validate="date" size="10" maxlength="10"/>
									</td>
								</tr>
								<tr>
									<td class="calendar-field" style="font-size: 10px;">
										<strong>Last Edit from:</strong>
										<br>
										<cfinput name="FromLastedit" type="datefield" validate="date" size="10" maxlength="10"/>
									</td>
									<td class="calendar-field" style="font-size: 10px;">
										<strong>Last Edit to:</strong>
										<br>
										<cfinput name="ToLastedit" type="datefield" validate="date" size="10" maxlength="10"/>
									</td>
								</tr>
								<tr>
									<td style="font-size: 10px;">
										<strong>Description:</strong> (keywords)
										<br>
										<cfinput name="caption" size="30" maxlength="30"/>
									</td>
									<td style="font-size: 10px;" colspan="2">
										<div class="form-row">
											<div class="form-group">
												<strong>Gallery Listings Only:</strong>
												<input type="checkbox" name="gallery_only" value="1" checked>
											</div>
	
											<div class="form-group">
												<strong>On Sale</strong>
												<input type="Checkbox" name="OnSale" value="1"> 
												<input type="Hidden" name="OnSale" value="">
											</div>
										</div>
										
									</td>
				
								</tr>
								<tr>
									
									<!--- <td style="font-size: 10px;" colspan="2">
										<input type="Checkbox" name="OnSale" value="1"> 
										<input type="Hidden" name="OnSale" value="">
										On Sale
									</td> --->
				
								</tr>
								
								<tr>
									<td colspan="2">
										<table cellspacing="0" cellpadding="0" border="0" width="100%">
											<tr>
												<td width="106" style="font-size: 10px;">&nbsp;
													
												</td>
												<!--- <td width="20">
													<input type="Checkbox" name="OnSale" value="1">
													<input type="Hidden" name="OnSale" value="">
												</td>
												<td width="75" style="font-size: 10px;">
													On Sale
												</td> --->
												<!--- <td width="20">
													<input type="Checkbox" name="Trump" value="1">
													<input type="Hidden" name="Trump" value="">
												</td>
												<td width="75" style="font-size: 10px;">
													Trump Site
												</td>
												<td width="20">
													<input type="Checkbox" name="Auction" value="1">
													<input type="Hidden" name="Auction" value="">
												</td>
												<td>
													Auction Site
												</td> --->
											</tr>
										</table>					
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td colspan="2" style="padding: 10px 0;" align="right">
							<input type="Submit" id="submitBtn" value="View Results">
								&nbsp;&nbsp;
							<input type="reset" value="Reset Values">
						</td>
					</tr>
				</table>
			</cfform>
		</td>
	</tr>
</table>


<script>
	$(document).ready(function () {
		function keepDigitsOnly(value) {
			return value.replace(/\D+/g, '');
		}

		function keepDecimalOnly(value) {
			var sanitizedValue = value.replace(/[^0-9.]/g, '');
			var decimalParts = sanitizedValue.split('.');

			if (decimalParts.length <= 1) {
				return sanitizedValue;
			}

			return decimalParts.shift() + '.' + decimalParts.join('');
		}

		function keepDateOnly(value) {
			return value.replace(/[^0-9\/-]/g, '');
		}

		function bindInputSanitizer(selector, sanitizer, inputMode) {
			$(selector).attr('inputmode', inputMode);

			$(document).on('input blur', selector, function () {
				var sanitizedValue = sanitizer(this.value);

				if (this.value !== sanitizedValue) {
					this.value = sanitizedValue;
				}
			});
		}

		function isInsideElement(element, target) {
			return !!(element && target && (element === target || element.contains(target)));
		}

		function getDomElement(extElement) {
			return extElement && extElement.dom ? extElement.dom : null;
		}

		function hideOpenColdFusionCalendar(event) {
			var calendarApi;
			var calendarInstance;
			var clickTarget = event.target;
			var fieldElement;
			var buttonElement;
			var containerElement;

			if (
				typeof ColdFusion === 'undefined' ||
				!ColdFusion.Calendar ||
				!ColdFusion.Calendar.openedCalendarInstance
			) {
				return false;
			}

			calendarApi = ColdFusion.Calendar;
			calendarInstance = calendarApi.openedCalendarInstance;
			fieldElement = calendarInstance.calendarinput || document.getElementById(calendarInstance.calendarinputid);
			buttonElement = document.getElementById(calendarInstance.calendarinputid + calendarInstance.formname + '_cf_button');
			containerElement = document.getElementById(calendarInstance.calendarinputid + calendarInstance.formname + '_cf_container');

			if (
				isInsideElement(fieldElement, clickTarget) ||
				isInsideElement(buttonElement, clickTarget) ||
				isInsideElement(containerElement, clickTarget)
			) {
				return true;
			}

			if (calendarInstance.hide) {
				calendarInstance.hide();
			}

			calendarApi.openedCalendarInstance = null;
			return true;
		}

		function isDateFieldComponent(component) {
			if (typeof Ext === 'undefined' || !component) {
				return false;
			}

			return !!(
				(Ext.form && Ext.form.DateField && component instanceof Ext.form.DateField) ||
				(Ext.form && Ext.form.Date && component instanceof Ext.form.Date) ||
				(Ext.form && Ext.form.field && Ext.form.field.Date && component instanceof Ext.form.field.Date)
			);
		}

		function getDatePopup(component) {
			if (component.menu && component.menu.hide) {
				return component.menu;
			}

			if (component.picker && component.picker.hide) {
				return component.picker;
			}

			if (component.getPicker) {
				try {
					return component.getPicker();
				} catch (error) {
					return null;
				}
			}

			return null;
		}

		function hideOpenDateMenus(event) {
			var componentManager;
			var components;
			var componentIndex;

			if (hideOpenColdFusionCalendar(event)) {
				return;
			}

			if (
				typeof Ext === 'undefined' ||
				!(Ext.ComponentMgr || Ext.ComponentManager)
			) {
				return;
			}

			componentManager = Ext.ComponentMgr || Ext.ComponentManager;
			components = componentManager.getAll ? componentManager.getAll() : [];

			var clickTarget = event.target;

			for (componentIndex = 0; componentIndex < components.length; componentIndex++) {
				var component = components[componentIndex];
				var popup = getDatePopup(component);
				var hasVisiblePopup = isDateFieldComponent(component) && popup && popup.isVisible && popup.isVisible();

				if (!hasVisiblePopup) {
					continue;
				}

				var componentElement = component.getEl ? component.getEl() : null;
				var popupWrapperElement = popup.getEl ? popup.getEl() : null;
				var fieldElement = getDomElement(component.inputEl) || getDomElement(component.el) || getDomElement(componentElement);
				var wrapElement = getDomElement(component.triggerWrap) || getDomElement(component.wrap);
				var triggerElement = getDomElement(component.triggerWrap) || getDomElement(component.trigger);
				var popupElement = getDomElement(popup.el) || getDomElement(popupWrapperElement);

				if (
					isInsideElement(fieldElement, clickTarget) ||
					isInsideElement(wrapElement, clickTarget) ||
					isInsideElement(triggerElement, clickTarget) ||
					isInsideElement(popupElement, clickTarget)
				) {
					continue;
				}

				if (component.collapse) {
					component.collapse();
					continue;
				}

				popup.hide();
			}
		}

		bindInputSanitizer('input[name="modelno"], input[id="modelno"]', keepDigitsOnly, 'numeric');
		bindInputSanitizer('input[name="FromPrice"], input[id="FromPrice"], input[name="ToPrice"], input[id="ToPrice"]', keepDecimalOnly, 'decimal');
		bindInputSanitizer('input[name="FromDate"], input[id="FromDate"], input[name="ToDate"], input[id="ToDate"], input[name="FromLastedit"], input[id="FromLastedit"], input[name="ToLastedit"], input[id="ToLastedit"]', keepDateOnly, 'numeric');

		$('.select2').select2({
			matcher: function (params, data) {
				if ($.trim(params.term) === '') {
					return data;
				}

				// Prevent matching placeholder during search
				if (data.id === '') {
					return null;
				}

				var term = params.term.toLowerCase();
				var text = data.text.toLowerCase();

				// Starts with match
				if (text.startsWith(term)) {
					return data;
				}

				// Contains match (less priority)
				if (text.indexOf(term) > -1) {
					var modifiedData = $.extend({}, data, true);
					modifiedData.text = data.text + ' ';
					return modifiedData;
				}

				return null;
			},

			sorter: function (data) {
				var term = $('.select2-search__field').val().toLowerCase();
				return data.sort(function (a, b) {
					var aStarts = a.text.toLowerCase().startsWith(term);
					var bStarts = b.text.toLowerCase().startsWith(term);

					if (aStarts && !bStarts) return -1;
					if (!aStarts && bStarts) return 1;
					return 0;
				});
			}
		});

		$(document).on('mousedown', hideOpenDateMenus);
	});


	

</script>

<script>
	function disableSubmitBtn() {
		// get the button directly by ID (works reliably)
		var btn = document.getElementById('submitBtn');
		if (btn) {
			btn.disabled = true;        // disable button to prevent double-submit
			btn.value = 'Loading...';   // give user feedback
		}
		return true; // allow the form to submit
	}
</script>
