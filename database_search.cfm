<cfquery name="data" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#" cachedwithin="#createTimespan(0,1,0,0)#">
	SELECT distinct manufacturer from products
	where active = 1
	<!--- AND fk_users is null --->
	order by manufacturer
</cfquery>
<!--- <cfset temp = QueryAddRow(data)>
<cfset Temp = QuerySetCell(data, "manufacturer", "MAX, PETER")>  --->
<cfquery dbtype="query" name="artistinfo">
	select *
	from data
	ORDER BY manufacturer
</cfquery>

<div class="search-form-group">
	<!--- <cfoutput>
		<form name="db_search" method="post" action="database.cfm?xss=#xss#">
	</cfoutput>
		<div class="top-content">
			<label>Database View</label>
			<a href="#TB_inline?height=200&width=300&inlineId=databaseview_help&modal=true">
				<span>What's this <span class="question-span">?</span></span>
			</a>
		</div>
		<div class="select-option">
			<select name="manufact" onchange="db_search.submit();" style="font-family: arial; font-size: 7pt;">
				<option value="" selected>PLEASE SELECT ARTIST
					<cfoutput query="artistinfo">
						<cfif manufacturer EQ 'MAX, PETER'>
							<option value="#manufacturer#">MAX, PETER (ALL)
						<cfelseif not isnumeric(manufacturer) and len(manufacturer) gt 1>
							<option value="#manufacturer#" <cfif parameterexists(manufact) and manufact eq '#manufacturer#'>Selected</cfif>>#ucase(manufacturer)#
						</cfif>
					</cfoutput>
			</select>
		</div>
	</form> --->
	
</div>
<cfoutput>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

	<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
	<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

<form name="db_search" method="post" action="database/">
</cfoutput>
<div class="row input-form">
	<div class="col-lg-8 col-md-8 col-sm-8 col-12 mt-0 mb-2">
		<div class="select-option input-field mt-0">
			<select name="manufact" onchange="db_search.submit();" class="select2" style="margin: 0;appearance: none;">
				<option value="" selected>Please Select Artist
					<cfoutput query="artistinfo">
						<cfif manufacturer EQ 'MAX, PETER'>
							<option value="#HTMLEditFormat(manufacturer)#">MAX, PETER (ALL)
						<cfelseif not isnumeric(manufacturer) and len(manufacturer) gt 1>
							<option value="#HTMLEditFormat(manufacturer)#" <cfif parameterexists(manufact) and manufact eq '#HTMLEditFormat(manufacturer)#'>Selected</cfif>>#HTMLEditFormat(manufacturer)#
						</cfif>
					</cfoutput>
			</select>
		</div>
	</div>
	<div class="col-lg-3 col-md-4 col-sm-6 col-12 mt-2 mb-2 d-flex align-items-center">
		<a href="#TB_inline?height=200&width=300&inlineId=databaseview_help&modal=true" class="thickbox" style="color: ##dd3a7d; text-decoration: underline;"><img src="images/question.jpg" border="0"></a>
	</div>
</div>
</form>

<script>
    $(document).ready(function() {
        $('.select2').select2();
    });
</script>


<style>

	body{
		overflow-x: hidden;
	}

	.select2-container--default .select2-selection--single {
        /* background-color: #fff;
		border: 1px solid #bbbbbb;
		border-radius: 0;
		height: 40px;
		padding: 5px 10px;
		font-size: 14px;
		font-family: inherit;
		box-sizing: border-box;
		margin-bottom: 10px; */

		background-color: #fff;
        border: 1px solid #bbbbbb;
        border-radius: 0px;
        height: 40px;
        color: #5E5E5E;
        font-size: 14px;
        /* line-height: 20px; */
        /* font-weight: 800; */
        width: 100%;
        padding: 5px 10px;
        appearance: none;
		box-sizing: border-box;

    }

    .select2-container--default .select2-selection--single .select2-selection__rendered {
        line-height: 28px;
        color: #333;
    }

    .select2-container--default .select2-selection--single .select2-selection__arrow {
        /* height: 36px;
        top: 1px;
        right: 10px;
        width: 20px; */
		display:none;
    }

    /* Ensure full width */
    .select2-container {
        width: 100% !important;
    }


    .select2-container--default .select2-search--dropdown .select2-search__field {
        border: 1px solid #aaa;
        height: 30px;
        font-size: 14px;
    }

    /* Styleing of Select2 dropdown end */
</style>
	
