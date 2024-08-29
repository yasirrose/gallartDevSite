
	<cfif isDefined('form.create')>
	
		<!--- Get fields from db --->
		<CFQUERY NAME="data"  datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
			SELECT * FROM INFORMATION_SCHEMA.Columns where TABLE_NAME = '#form.dbTable#'
		</CFQUERY>

		<cfset fieldListVals	= 	valuelist(data.column_name) />
		<!--- sort fields alphabetically --->
		<cfset fieldListSorted 	=	listsort(fieldListVals,'textnocase') />
		
		<CFQUERY name="data" dataSource="#dsource#" username="#uname#" password="#pword#">
		    SELECT <cfif len(form.records)>Top #form.records# </cfif>* from #form.dbTable#
		</CFQUERY>

		<cfif data.recordcount GTE 66000>
		
		    <!--- Excel can only handle 66000 rows --->
		    Too many records<cfabort>
		
		<cfelse>
		
		       <cffile action="write"
		             file="#expandPath('.')#\data\export.csv"
		             output="#fieldListSorted#"
		             addnewline="yes">
		
		    <cfoutput>
				
		        <cfloop query="data">
				
					<cfset dataList = '' />
					
					<cfset num = 1 />
					
					<cfloop list="#fieldListSorted#" index="idx">
					
						<cfset idxVal = evaluate(idx) />
						
						
						<cfif not len(idxVal) and idx eq 'fk_users'>
							<!--- workaround for empty int field --->
							<cfset idxVal = 0 />
						<cfelseif not len(idxVal)>
							<!--- replace empty cells with ||  --->
							<cfset idxVal = '||' />
						</cfif>
						
						<!--- replace double quotes --->
						<cfset idxVal = replace(idxVal, """","""""", "all")>
								
						<cfset dataList = listappend(dataList,'"#idxVal#"')>
					
					</cfloop>
	    
		        <cffile action="append"
		                 file="#expandPath('.')#\data\export.csv"
		                  output='#dataList#' 
		                 addnewline="yes"> 
				
		        </cfloop>
		    </cfoutput>
		
		   <cflocation url="http://#server_name#/data/export.csv">
		
		</cfif>
		<cfabort>
		
	<cfelse>
	<cfoutput>
		<form method="post" action="#script_name#" name="searchfrm">
		<table cellspacing="0" cellpadding="4" border="0" width="300" align="center">
			<tr>
				<td colspan="2">
					<strong>Export - All</strong>
				</td>
			</tr>
			<tr>
				<td>
					Export from table:
				</td>
				<td>
					<input type="Text" name="dbTable">
				</td>
			</tr>
			<tr>
				<td>
					Number of records:
				</td>
				<td>
					<input type="Text" name="records">
				</td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="Submit" name="create" value="Export">
				</td>
			</tr>
		</table>
		</form>
	</cfoutput>
	
	</cfif>	
							
