<cfcomponent>
	<!--- initializes the component --->
	<cffunction name="init" access="public" output="No" returntype="sales">
		<cfscript>
				return this;
		</cfscript>
	</cffunction>
	

	<cffunction name="getSales" access="remote" returntype="query">
	
		<cfset var qSales='' />

	   	<cfquery name="qSales" datasource="#application.dsource#">
	      	SELECT *
	      	FROM sales
	   	</cfquery>
	   	
   		<cfreturn qSales />
	
   	</cffunction>
	
	<cffunction name="getSalesFromId" access="remote" returntype="query">
		<cfargument name="pk_sales" type="string" default="">
	
		<cfset var qSales='' />

	   	<cfquery name="qSales" datasource="#application.dsource#">
	      	SELECT *
	      	FROM sales
			WHERE pk_sales = #arguments.pk_sales#
	   	</cfquery>
	   	
   		<cfreturn qSales />
	
   	</cffunction>
	
	<cffunction name="getSaleCodeInfo" access="remote" returntype="query">
		<cfargument name="SaleCode" type="string" default="">
	
		<cfset var qSales='' />

	   	<cfquery name="qSales" datasource="#application.dsource#">
	      	SELECT *
	      	FROM SaleCode_ProductId
			WHERE SaleCode = '#arguments.SaleCode#'
	   	</cfquery>
	   	
   		<cfreturn qSales />
	
   	</cffunction>
	
	<cffunction name="editSales" access="remote" output="false" returntype="boolean">
	    <cfargument name="form" type="struct">
	    
	    <cfset var success = true />
		
	    	<cftry>
	    
	    	<cfif arguments.form.pk_sales eq ''>
		    	
		    	<cfquery name="addAppraisal" datasource="#application.dsource#"> 
	               INSERT into sales
					(	
						SaleCode,
						queryString,
						percentMarkdown
					)
					values
					(
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.form.SaleCode#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.form.queryString#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.form.percentMarkdown#">
					)
	            </cfquery>
				
				<cfloop collection="#arguments.form#" item="idx">
					<cfif left(idx,9) eq 'SALELINK_'>
						<cfset this_keyval = right(idx,len(idx)-9)>
						<cfquery datasource="#application.dsource#">
						    INSERT into saleCode_ProductId
							(
								SaleCode,
								ProductId
							)
							values
							(
								'#arguments.form.SaleCode#',
								#this_keyval#
							)
						</cfquery>
					</cfif>
				</cfloop>
		
			
			<cfelse>
			
				<cfquery name="editSales" datasource="#application.dsource#"> 
	            	UPDATE sales set
					percentMarkdown = '#arguments.form.percentMarkdown#'
					WHERE pk_sales = #arguments.form.pk_sales#
	            </cfquery>
				
				<cfquery name="qSalesCode" datasource="#application.dsource#">
				    DELETE from saleCode_ProductId
					WHERE SaleCode = '#arguments.form.SaleCode#'
				</cfquery>
				
				<cfloop collection="#arguments.form#" item="idx">
					<cfif left(idx,9) eq 'SALELINK_'>
						<cfset this_keyval = right(idx,len(idx)-9)>
						<cfquery datasource="#application.dsource#">
						    INSERT into saleCode_ProductId
							(
								SaleCode,
								ProductId
							)
							values
							(
								'#arguments.form.SaleCode#',
								#this_keyval#
							)
						</cfquery>
					</cfif>
				</cfloop>
			
			</cfif>
	    
	    			
			<cfcatch type="any"><cfset success = false /></cfcatch>
			</cftry>
			
		<cfreturn success> 
	        
	</cffunction>
	
	<cffunction name="deleteSales" access="remote">
		<cfargument name="pk_sales" type="numeric" default="0">
		<cfargument name="SaleCode" type="string" default="">
		
		<cfset var success = true />
		
		<cftry>
	
			<cfquery datasource="#application.dsource#">
			    DELETE from sales
				WHERE pk_sales = #arguments.pk_sales#
			</cfquery>
			
			<cfquery datasource="#application.dsource#">
			    DELETE from saleCode_ProductId
				WHERE SaleCode = '#arguments.SaleCode#'
			</cfquery>
		
		<cfcatch type="any"><cfset success = false /></cfcatch>
		</cftry>
	
		<cfreturn success />
	
	</cffunction>
	
	<cffunction name="createQueryString" access="remote" returntype="string">
		<cfargument name="form" type="struct">
		
		<cfset var queryString = '' />
		
		<cfsavecontent variable="queryString">
	
		<cfoutput>
			active = 1
			<cfif isDefined('arguments.form.modelno') AND arguments.form.modelno neq ''>
	      		AND modelno like '#arguments.form.modelno#%'
	      	</cfif>
			<cfif isDefined('arguments.form.title') AND arguments.form.title neq ''>
	      		AND name like '#arguments.form.title#%'
	      	</cfif>
			<cfif isDefined('arguments.form.artist') AND arguments.form.artist neq ''>
	      		AND manufacturer like '#arguments.form.artist#%'
	      	</cfif>
			<cfif isDefined('arguments.form.medium') AND arguments.form.medium neq ''>
	      		AND path = '#arguments.form.medium#'
	      	</cfif>
			<cfif isDefined('arguments.form.year') AND arguments.form.year neq ''>
	      		AND year = '#arguments.form.year#'
	      	</cfif>
			<cfif isDefined('arguments.form.height') and len(trim(arguments.form.height))>
				AND (patindex('%x%',size) > 1 AND substring(size,1,patindex('%x%',size)-1) like '#arguments.form.height#')
			</cfif>
			<cfif isDefined('arguments.form.width') and len(trim(arguments.form.width))>
				AND (patindex('%x%',size) > 1 AND replace(substring(size,patindex('%x%',size)+1,10),' ','') like '#arguments.form.width#%')
			</cfif>
			<cfif isDefined('arguments.form.description') AND arguments.form.description neq ''>
	      		AND caption like '%#arguments.form.description#%'
	      	</cfif>
			<cfif isDefined('arguments.form.fromPrice') AND arguments.form.fromPrice neq ''>
				AND gallery_price >= #arguments.form.fromPrice#
			</cfif>
			<cfif isDefined('arguments.form.toPrice') AND arguments.form.toPrice neq ''>
				AND gallery_price <= #arguments.form.toPrice#
			</cfif>
			<cfif isDefined('arguments.form.fromDate') AND arguments.form.fromDate neq ''>
				AND datestamp >= '#dateFormat(arguments.form.fromDate)#'
			</cfif>
			<cfif isDefined('arguments.form.toDate') AND arguments.form.toDate neq ''>
				AND datestamp <= '#dateFormat(arguments.form.toDate)#'
			</cfif>
			<cfif isDefined('arguments.form.fromLastedit') AND arguments.form.fromLastedit neq ''>
				AND lastedit >= '#dateFormat(arguments.form.fromLastedit)#'
			</cfif>
			<cfif isDefined('arguments.form.toLastedit') AND arguments.form.toLastedit neq ''>
				AND lastedit <= '#dateFormat(arguments.form.toLastedit)#'
			</cfif>
			<cfif isDefined('arguments.form.sellerId') and len(trim(arguments.form.sellerId))>
				<cfif arguments.form.sellerId eq 0>
				 	AND fk_users is not null
				<cfelseif argumentsv.sellerId gt 0>
					AND fk_users = #arguments.form.sellerId#
				</cfif>
			</cfif>
			<cfif isDefined('arguments.form.onSale') AND arguments.form.onSale EQ 1>
				AND closeout = 1
			</cfif>
			<cfif isDefined('arguments.form.trump') AND arguments.form.trump EQ 2>
				AND location = 2
			</cfif>
			<cfif isDefined('arguments.form.auction') AND arguments.form.auction EQ 1>
				AND auction = 1
			</cfif>
		</cfoutput>
		
		</cfsavecontent>
	
		<cfreturn queryString />
	
	</cffunction>
	
	
</cfcomponent>