<cfcomponent>

	<!--- initializes the component --->
		<cffunction name="init" access="public" output="No" returntype="art">
			<cfscript>
					return this;
			</cfscript>
		</cffunction>

	<!--- /////////////  FOR LISTING MANAGMENT ///////////////// --->

		<cffunction name="getListings" access="remote">

			  <cfargument name="page" required="yes">
			  <cfargument name="pageSize" required="yes">
			  <cfargument name="gridsortcolumn" required="yes">
			  <cfargument name="gridsortdirection" required="yes">
			<cfargument name="sellerId" required="no" type="string" default="">
			<cfargument name="imageName" required="no" type="string" default="">
			<cfargument name="modelno" required="no" type="string" default="">
			<cfargument name="name" required="no" type="string" default="">
			<cfargument name="manufacturer" required="no" type="string" default="">
			<cfargument name="path" required="no" type="string" default="">
			<cfargument name="year" required="no" type="string" default="">
			<cfargument name="height" required="no" type="string" default="">
			<cfargument name="width" required="no" type="string" default="">
			<cfargument name="caption" required="no" type="string" default="">
			<cfargument name="fromPrice" required="no" type="string" default="">
			<cfargument name="toPrice" required="no" type="string" default="">
			<cfargument name="fromDate" required="no" type="string" default="">
			<cfargument name="toDate" required="no" type="string" default="">
			<cfargument name="fromLastEdit" required="no" type="string" default="">
			<cfargument name="toLastEdit" required="no" type="string" default="">
			<cfargument name="onSale" required="no" type="string" default="">
			<cfargument name="trump" required="no" type="string" default="">
			<cfargument name="auction" required="no" type="string" default="">
			<cfargument name="slideshow" required="no" type="string" default="">
			<cfargument name="frontShow" required="no" type="string" default="">
			<cfargument name="bottomHome" required="no" type="string" default="">
			<cfargument name="active" required="no" type="string" default="">
			<cfargument name="showResults" required="no" type="string" default="1">

			<cfset var qListings='' />

			<cfif isDefined('arguments.fromPrice') AND arguments.fromPrice neq ''>
				<cfset arguments.fromPrice 	= rereplace(arguments.fromPrice, "[^0-9|.]", "", "all")>
			</cfif>
			<cfif isDefined('arguments.toPrice') AND arguments.toPrice neq ''>
				<cfset arguments.toPrice 	= rereplace(arguments.toPrice, "[^0-9|.]", "", "all")>
			</cfif>

			   <cfquery name="qListings" datasource="#application.dsource#">
				  SELECT CONVERT(CHAR(9),datestamp,6) as listingDate,CONVERT(CHAR(9),lastedit,6) as lasteditDate,'<a href="http://gallart.com/img/'+CAST(uid AS varchar(50))+'.jpg" target="_blank"><img src="http://gallart.com/img/thumbnails/'+CAST(uid AS varchar(50))+'.jpg" border="0" height="50" />' as 'Thumbnail',
				UPPER(U.lname)+', '+UPPER(U.fname) as full_seller_name,
				CASE WHEN active = '0' THEN 'Inactive' ELSE 'Active' END AS Status,*
				  FROM products P
				LEFT OUTER JOIN users U on P.fk_users = U.pk_users
				WHERE 0=0
				<cfif isDefined('arguments.modelno') AND arguments.modelno neq ''>
					  AND modelno like '#arguments.modelno#%'
				  </cfif>
				<cfif isDefined('arguments.name') AND arguments.name neq ''>
					  AND name like '#arguments.name#%'
				  </cfif>
				<cfif isDefined('arguments.manufacturer') AND arguments.manufacturer neq ''>
					  AND manufacturer like '#arguments.manufacturer#%'
				  </cfif>
				<cfif isDefined('arguments.path') AND arguments.path neq ''>
					  AND path = '#arguments.path#'
				  </cfif>
				<cfif isDefined('arguments.year') AND arguments.year neq ''>
					  AND year = '#arguments.year#'
				  </cfif>
				<cfif isDefined('arguments.height') and len(trim(arguments.height))>
					AND (patindex('%x%',size) > 1 AND substring(size,1,patindex('%x%',size)-1) like '#arguments.height#')
				</cfif>
				<cfif isDefined('arguments.width') and len(trim(arguments.width))>
					AND (patindex('%x%',size) > 1 AND replace(substring(size,patindex('%x%',size)+1,10),' ','') like '#arguments.width#%')
				</cfif>
				<cfif isDefined('arguments.caption') AND arguments.caption neq ''>
					  AND caption like '%#arguments.caption#%'
				  </cfif>
				<cfif isDefined('arguments.fromPrice') AND arguments.fromPrice neq ''>
					AND gallery_price >= #arguments.fromPrice#
				</cfif>
				<cfif isDefined('arguments.toPrice') AND arguments.toPrice neq ''>
					AND gallery_price <= #arguments.toPrice#
				</cfif>
				<cfif isDefined('arguments.fromDate') AND arguments.fromDate neq ''>
					AND datestamp >= '#dateFormat(arguments.fromDate)#'
				</cfif>
				<cfif isDefined('arguments.toDate') AND arguments.toDate neq ''>
					AND datestamp <= '#dateFormat(arguments.toDate)#'
				</cfif>
				<cfif isDefined('arguments.fromLastedit') AND arguments.fromLastedit neq ''>
					AND lastedit >= '#dateFormat(arguments.fromLastedit)#'
				</cfif>
				<cfif isDefined('arguments.toLastedit') AND arguments.toLastedit neq ''>
					AND lastedit <= '#dateFormat(arguments.toLastedit)#'
				</cfif>
				<cfif isDefined('arguments.sellerId') and len(trim(arguments.sellerId))>
					<cfif arguments.sellerId eq 0>
						 AND fk_users is not null
					<cfelseif arguments.sellerId gt 0>
						AND fk_users = #arguments.sellerId#
					</cfif>
				</cfif>
				<cfif isDefined('arguments.onSale') AND arguments.onSale EQ 1>
					AND closeout = 1
				</cfif>
				<cfif isDefined('arguments.imageName') AND arguments.imageName neq ''>
					AND uid = '#arguments.imageName#'
				</cfif>
				<cfif isDefined('arguments.trump') AND arguments.trump EQ 2>
					AND location = 2
				</cfif>
				<cfif isDefined('arguments.auction') AND arguments.auction EQ 1>
					AND auction = 1
				</cfif>
				<cfif isDefined('arguments.slideshow') AND arguments.slideshow EQ 1>
					AND slideshow = 1
				</cfif>
				<cfif isDefined('arguments.frontShow') AND arguments.frontShow EQ 1>
					AND frontshow > 0
				</cfif>
				<cfif isDefined('arguments.bottomHome') AND arguments.bottomHome EQ 1>
					AND family > 0
				</cfif>
				<cfif isDefined('arguments.active')>
					<cfif arguments.active EQ 1>
						AND P.active = 1
					<cfelseif arguments.active EQ 0>
						AND P.active = 0
					</cfif>
				</cfif>
				<cfif isDefined('arguments.showResults') AND arguments.showResults EQ 0>
					  AND 0=1
				  </cfif>
				  <cfif gridsortcolumn neq ''>
					  ORDER BY #gridsortcolumn# #gridsortdirection#
				<cfelse>
					ORDER BY datestamp desc
				  </cfif>
			   </cfquery>

			<cfif qListings.recordcount EQ 0><cfset pagesize = 0 /></cfif>

			   <cfreturn queryconvertforgrid(qListings,page,pagesize)/>

		</cffunction>


		<cffunction name="getListingFromId" access="remote" returntype="struct">

			  <cfargument name="uid" type="string" default="">

			<cfset var returnStruct = structNew() />

			<cfset var qListing='' />

			   <cfquery name="qListing" datasource="#application.dsource#">
				  SELECT U.email as seller_email,*
				  FROM products P
				LEFT OUTER JOIN users U on P.fk_users = U.pk_users
				WHERE uid = '#arguments.uid#'
			   </cfquery>

			 <cfloop list="#qListing.ColumnList#" index="idx">
				<cfset returnStruct[idx] = evaluate("qListing."&idx) />
			</cfloop>

			<cfreturn returnStruct />

		   </cffunction>

		<!--- /////////////  EDIT FROM SEPARATE FORM //////////////// --->

		<cffunction name="editListingsFromForm" access="remote" output="false" returntype="boolean">
			<cfargument name="uid" type="numeric" default="0">
			<cfargument name="NAME" type="string" default="">
			<cfargument name="MANUFACTURER" type="string" default="">
			<cfargument name="PATH" type="string" default="">
			<cfargument name="NEWMODELNO" type="string" default="">
			<cfargument name="NEWMODELNO_NUMERIC" type="string" default="">
			<cfargument name="thisImage" type="string" default="">
			<cfargument name="YEAR" type="string" default="">
			<cfargument name="SIZE" type="string" default="">
			<cfargument name="EDITION" type="string" default="">
			<cfargument name="RETAIL_PRICE" type="string" default="">
			<cfargument name="GALLERY_PRICE" type="string" default="">
			<cfargument name="SPECIAL_PRICE" type="string" default="">
			<cfargument name="CLOSEOUT" type="string" default="">
			<cfargument name="LOW_ESTIMATE" type="string" default="">
			<cfargument name="HIGH_ESTIMATE" type="string" default="">
			<cfargument name="QUANTITY" type="string" default="">
			<cfargument name="CAPTION" type="string" default="">
			<cfargument name="ACTIVE" type="string" default="">
			<cfargument name="FRONTSHOW" type="string" default="">
			<cfargument name="FAMILY" type="string" default="">
			<cfargument name="SLIDESHOW" type="string" default="">
			<cfargument name="LASTEDIT" type="string" default="">
			<cfargument name="LOCATION" type="string" default="">
			<cfargument name="LOCATION_PRICE" type="string" default="">
			<cfargument name="LOCATION_FLOOR" type="string" default="">
			<cfargument name="LOCATION_WALL" type="string" default="">
			<cfargument name="LOCATION_NOTES" type="string" default="">
			<cfargument name="AUCTION" type="string" default="">
			<cfargument name="DEACTIVATED" type="string" default="0">
			<!---<cfargument name="addImage" type="string" default="">--->

			<cfset var success = true />

				<cfset arguments.RETAIL_PRICE 	= rereplace(arguments.RETAIL_PRICE, "[^0-9|.]", "", "all")>
				<cfset arguments.GALLERY_PRICE 	= rereplace(arguments.GALLERY_PRICE, "[^0-9|.]", "", "all")>
				<cfset arguments.SPECIAL_PRICE 	= rereplace(arguments.SPECIAL_PRICE, "[^0-9|.]", "", "all")>
				<cfset arguments.LOCATION_PRICE = rereplace(arguments.LOCATION_PRICE, "[^0-9|.]", "", "all")>

				<cfif NOT len(arguments.RETAIL_PRICE)><cfset arguments.RETAIL_PRICE = 0 /></cfif>
				<cfif NOT len(arguments.GALLERY_PRICE)><cfset arguments.GALLERY_PRICE = 0 /></cfif>
				<cfif NOT len(arguments.SPECIAL_PRICE)><cfset arguments.SPECIAL_PRICE = 0 /></cfif>
				<cfif NOT len(arguments.LOCATION_PRICE)><cfset arguments.LOCATION_PRICE = 0 /></cfif>

				<cfif arguments.uid EQ 0>

					<cfquery name="addListing" datasource="#application.dsource#">
					   INSERT into products
						(
							NAME,
							MANUFACTURER,
							PATH,
							MODELNO,
							MODELNO_NUMERIC,
							YEAR,
							SIZE,
							EDITION,
							RETAIL_PRICE,
							GALLERY_PRICE,
							SPECIAL_PRICE,
							CLOSEOUT,
							LOW_ESTIMATE,
							HIGH_ESTIMATE,
							QUANTITY,
							CAPTION,
							ACTIVE,
							FRONTSHOW,
							FAMILY,
							SLIDESHOW,
							LASTEDIT,
							LOCATION,
							LOCATION_PRICE,
							LOCATION_FLOOR,
							LOCATION_WALL,
							LOCATION_NOTES,
							AUCTION
						)
						values
						(
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.NAME#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.MANUFACTURER#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.PATH#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.NEWMODELNO#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.NEWMODELNO_NUMERIC#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.YEAR#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.SIZE#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.EDITION#">,
							<cfqueryparam cfsqltype="CF_SQL_MONEY" value="#iif(arguments.RETAIL_PRICE NEQ '', DE(arguments.RETAIL_PRICE), DE('0'))#">,
							<cfqueryparam cfsqltype="CF_SQL_MONEY" value="#iif(arguments.GALLERY_PRICE NEQ '', DE(arguments.GALLERY_PRICE), DE('0'))#">,
							<cfqueryparam cfsqltype="CF_SQL_MONEY" value="#iif(arguments.SPECIAL_PRICE NEQ '', DE(arguments.SPECIAL_PRICE), DE('0'))#">,
							<cfqueryparam cfsqltype="CF_SQL_BIT" value="#iif(len(arguments.CLOSEOUT),DE(arguments.CLOSEOUT),DE(0))#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.LOW_ESTIMATE#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.HIGH_ESTIMATE#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.QUANTITY#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.CAPTION#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.ACTIVE#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.FRONTSHOW#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.FAMILY#">,
							<cfqueryparam cfsqltype="CF_SQL_TINYINT" value="#iif(len(arguments.SLIDESHOW),DE(arguments.SLIDESHOW),DE(0))#">,
							<cfqueryparam cfsqltype="CF_SQL_DATE" value="#createodbcdate(now())#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.LOCATION#">,
							<cfqueryparam cfsqltype="CF_SQL_MONEY" value="#arguments.LOCATION_PRICE#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.LOCATION_FLOOR#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.LOCATION_WALL#">,
							<cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#arguments.LOCATION_NOTES#">,
							<cfqueryparam cfsqltype="CF_SQL_TINYINT"value="#iif(len(arguments.AUCTION),DE(arguments.AUCTION),DE(0))#">
						)
						SELECT @@identity as newId
					</cfquery>

					<cfset thisId = addListing.newId />

				<cfelse>

					<cfquery name="editListing" datasource="#application.dsource#">
						UPDATE products SET
							NAME 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.NAME#">,
							MANUFACTURER 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.MANUFACTURER#">,
							PATH 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.PATH#">,
							YEAR 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.YEAR#">,
							SIZE 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.SIZE#">,
							EDITION			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.EDITION#">,
							RETAIL_PRICE 	= <cfqueryparam cfsqltype="CF_SQL_MONEY" value="#iif(arguments.RETAIL_PRICE NEQ '', DE(arguments.RETAIL_PRICE), DE('0'))#">,
							GALLERY_PRICE	= <cfqueryparam cfsqltype="CF_SQL_MONEY" value="#iif(arguments.GALLERY_PRICE NEQ '', DE(arguments.GALLERY_PRICE), DE('0'))#">,
							SPECIAL_PRICE	= <cfqueryparam cfsqltype="CF_SQL_MONEY" value="#iif(arguments.SPECIAL_PRICE NEQ '', DE(arguments.SPECIAL_PRICE), DE('0'))#">,
							CLOSEOUT		= <cfqueryparam cfsqltype="CF_SQL_BIT"value="#iif(len(arguments.CLOSEOUT),DE(arguments.CLOSEOUT),DE(0))#">,
							LOW_ESTIMATE 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.LOW_ESTIMATE#">,
							HIGH_ESTIMATE 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.HIGH_ESTIMATE#">,
							QUANTITY 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.QUANTITY#">,
							CAPTION 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.CAPTION#">,
							ACTIVE 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.ACTIVE#">,
							FRONTSHOW 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.FRONTSHOW#">,
							FAMILY 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.FAMILY#">,
							SLIDESHOW		= <cfqueryparam cfsqltype="CF_SQL_BIT"value="#iif(len(arguments.SLIDESHOW),DE(arguments.SLIDESHOW),DE(0))#">,
							LASTEDIT		= <cfqueryparam cfsqltype="CF_SQL_DATE" value="#createodbcdate(now())#">,
							LOCATION		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.LOCATION#">,
							LOCATION_PRICE	= <cfqueryparam cfsqltype="CF_SQL_MONEY" value="#arguments.LOCATION_PRICE#">,
							LOCATION_FLOOR	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.LOCATION_FLOOR#">,
							LOCATION_WALL	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.LOCATION_WALL#">,
							LOCATION_NOTES	= <cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#arguments.LOCATION_NOTES#">,
							AUCTION		= <cfqueryparam cfsqltype="CF_SQL_TINYINT"value="#iif(len(arguments.AUCTION),DE(arguments.AUCTION),DE(0))#">
							<cfif form.deactivated EQ 1 AND form.active EQ 1>
								,ACTIVE_DATE = <cfqueryparam cfsqltype="CF_SQL_DATE" value="#createodbcdate(now())#">
							</cfif>
						WHERE uid = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.uid#">
					</cfquery>

					<cfset thisId = arguments.uid />

				</cfif>

				<cfif len(arguments.thisImage)>

					<cffile action="upload" nameconflict="overwrite" filefield="thisImage" destination="#application.uploaddir#/#thisId#.jpg" result="fileupload">


					<cfdump var='#application.uploaddir#' label='application.uploaddir' expand=1 abort=0>

					<cfdump var='#thisId#' label='thisId' expand=1 abort=0>

<cfdump var='expandPath("/"): #expandPath("/")#' label='expandPath("/")' expand=1 abort=0>
<cfdump var='expandPath("."): #expandPath(".")#' label='expandPath("/")' expand=1 abort=0>
<cfdump var='#getTempDirectory()#' label='getTempDirectory()' expand=1 abort=0>
<cfdump var='#fileupload#' label='fileupload' expand=1 abort=0>
<cfdump var='#arguments#' label='arguments' expand=1 abort=0>


<cfscript>
	writeoutput("Temp Dir : " & createobject("java","java.lang.System").getProperty("java.io.tmpdir") );
</cfscript>


					<cfif fileupload.fileWasSaved>

						<cftry>
							<cfimage
								action="read"
								source="#application.uploaddir#/#thisId#.jpg"
								<!--- source="D:\inetpub\cf\img\3.jpg" --->
								name="oImage"
							/>

							<!--- <cfimage source="#oImage#" action="writeToBrowser"> --->

							<cfimage
								action="resize"
								<!--- source="#application.uploaddir#/#thisId#.jpg" --->
								source="#oImage#"
								width="100"
								height=""
								name="oImageSmall"
							/>

							<!--- <cfimage source="#oImage#" action="writeToBrowser"> --->

							<!--- <cfscript>
								fileWrite( "#application.uploaddir#/rdh/#thisId#.jpg", oImage );
							</cfscript> --->

							<cfimage
								action="WRITE"
								source="#oImageSmall#"
								destination="#application.uploaddir#/thumbnails/#thisId#.jpg"
								overwrite="true"
							/>

							<!--- <cfimage
								action="write"
								<!--- source="#oImageSmall#" --->
								<!--- destination="#application.uploaddir#/rdh/#thisId#.jpg" --->
								source="#arguments.thisImage#"
								destination="D:\inetpub\cf\img\thumbnails\rdh.jpg"
								overwrite="yes"
							/> --->

							<!--- <cfscript>
								binaryFile = fileReadBinary( "#application.uploaddir#/#thisId#.jpg" );

								fileWrite( "#application.uploaddir#/rdh/#thisId#.jpg", binaryFile );

abort;




								uploadedImage = imageRead( "#application.uploaddir#/#thisId#.jpg" );
								writedump( var='is image file: #isImageFile("#application.uploaddir#/#thisId#.jpg")#', label='isImageFile(uploadedImage)', expand=0, abort=0 );
								writedump( var='is image: #isImage(uploadedImage)#', label='isImageFile(uploadedImage)', expand=0, abort=0 );

								writedump( var='directoryExists(): #directoryExists(expandPath("."))#', label='directoryExists()', expand=1, abort=0 );

								fileWrite( "#application.uploaddir#/rdh/#thisId#.jpg", uploadedImage );

								imageWrite( uploadedImage, "#expandPath('.')#\rdh.jpg", 1, true );
							</cfscript> --->

							<cfcatch type="any">
								<cfdump var='#cfcatch#' label='cfcatch' expand=1 abort=1>
							</cfcatch>
						</cftry>

					</cfif>

				</cfif>

				<!--- additional images --->
				<cfset additionalImages = "" />
				<cfset uploaddir = "#application.uploaddir#" />
				<cfset addImageIdx = 1 />
				<cfif arguments.uid NEQ 0>

					<cfquery name="getAdditional" datasource="#application.dsource#">
						SELECT ADDITIONAL_IMAGES from products
						WHERE uid = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#thisId#">
					</cfquery>
					<cfif getAdditional.ADDITIONAL_IMAGES NEQ "">
						<cfset addImageIdx = listFirst(listLast(listLast(getAdditional.ADDITIONAL_IMAGES),'_'),'.') + 1 />
						<cfset additionalImages = getAdditional.ADDITIONAL_IMAGES />
					</cfif>
				</cfif>

				<cfloop collection="#form#" item="idx">
					<cfif left(idx,9) EQ "addImage_">
						<cfset currImage = evaluate("form." & idx) />
						<cfset thisFilefield = idx />
						<cfset thisImageId = "#thisId#_#addImageIdx#.jpg" />
						<cfset additionalImages = listAppend(additionalImages,thisImageId) />
						<cffile action="upload" nameconflict="overwrite" filefield="#thisFilefield#" destination="#uploaddir#/#thisImageId#" result="fileupload">
						<cfset addImageIdx = addImageIdx + 1 />
					</cfif>

				</cfloop>

				<cfif additionalImages NEQ "">
					<cfquery name="editListing" datasource="#application.dsource#">
						UPDATE products SET
							ADDITIONAL_IMAGES 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#additionalImages#">
						WHERE uid = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#thisId#">
					</cfquery>
				   </cfif>

			<cfreturn success>

		</cffunction>

		<cffunction name="editListingsFromFormDev" access="remote" output="false" returntype="boolean">
			<cfargument name="uid" type="numeric" default="0">
			<cfargument name="NAME" type="string" default="">
			<cfargument name="MANUFACTURER" type="string" default="">
			<cfargument name="PATH" type="string" default="">
			<cfargument name="NEWMODELNO" type="string" default="">
			<cfargument name="NEWMODELNO_NUMERIC" type="string" default="">
			<cfargument name="thisImage" type="string" default="">
			<cfargument name="YEAR" type="string" default="">
			<cfargument name="SIZE" type="string" default="">
			<cfargument name="EDITION" type="string" default="">
			<cfargument name="RETAIL_PRICE" type="string" default="">
			<cfargument name="GALLERY_PRICE" type="string" default="">
			<cfargument name="SPECIAL_PRICE" type="string" default="">
			<cfargument name="CLOSEOUT" type="string" default="">
			<cfargument name="LOW_ESTIMATE" type="string" default="">
			<cfargument name="HIGH_ESTIMATE" type="string" default="">
			<cfargument name="QUANTITY" type="string" default="">
			<cfargument name="CAPTION" type="string" default="">
			<cfargument name="ACTIVE" type="string" default="">
			<cfargument name="FRONTSHOW" type="string" default="">
			<cfargument name="FAMILY" type="string" default="">
			<cfargument name="SLIDESHOW" type="string" default="">
			<cfargument name="LASTEDIT" type="string" default="">
			<cfargument name="LOCATION" type="string" default="">
			<cfargument name="LOCATION_PRICE" type="string" default="">
			<cfargument name="LOCATION_FLOOR" type="string" default="">
			<cfargument name="LOCATION_WALL" type="string" default="">
			<cfargument name="LOCATION_NOTES" type="string" default="">
			<cfargument name="AUCTION" type="string" default="">
			<cfargument name="DEACTIVATED" type="string" default="0">
			<!---<cfargument name="addImage" type="string" default="">--->

			<cfset var success = true />

				<cfset arguments.RETAIL_PRICE 	= rereplace(arguments.RETAIL_PRICE, "[^0-9|.]", "", "all")>
				<cfset arguments.GALLERY_PRICE 	= rereplace(arguments.GALLERY_PRICE, "[^0-9|.]", "", "all")>
				<cfset arguments.SPECIAL_PRICE 	= rereplace(arguments.SPECIAL_PRICE, "[^0-9|.]", "", "all")>
				<cfset arguments.LOCATION_PRICE = rereplace(arguments.LOCATION_PRICE, "[^0-9|.]", "", "all")>

				<cfif NOT len(arguments.RETAIL_PRICE)><cfset arguments.RETAIL_PRICE = 0 /></cfif>
				<cfif NOT len(arguments.GALLERY_PRICE)><cfset arguments.GALLERY_PRICE = 0 /></cfif>
				<cfif NOT len(arguments.SPECIAL_PRICE)><cfset arguments.SPECIAL_PRICE = 0 /></cfif>
				<cfif NOT len(arguments.LOCATION_PRICE)><cfset arguments.LOCATION_PRICE = 0 /></cfif>

				<cfif arguments.uid EQ 0>

					<cfquery name="addListing" datasource="#application.dsource#">
					   INSERT into products
						(
							NAME,
							MANUFACTURER,
							PATH,
							MODELNO,
							MODELNO_NUMERIC,
							YEAR,
							SIZE,
							EDITION,
							RETAIL_PRICE,
							GALLERY_PRICE,
							SPECIAL_PRICE,
							CLOSEOUT,
							LOW_ESTIMATE,
							HIGH_ESTIMATE,
							QUANTITY,
							CAPTION,
							ACTIVE,
							FRONTSHOW,
							FAMILY,
							SLIDESHOW,
							LASTEDIT,
							LOCATION,
							LOCATION_PRICE,
							LOCATION_FLOOR,
							LOCATION_WALL,
							LOCATION_NOTES,
							AUCTION
						)
						values
						(
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.NAME#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.MANUFACTURER#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.PATH#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.NEWMODELNO#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.NEWMODELNO_NUMERIC#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.YEAR#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.SIZE#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.EDITION#">,
							<cfqueryparam cfsqltype="CF_SQL_MONEY" value="#iif(arguments.RETAIL_PRICE NEQ '', DE(arguments.RETAIL_PRICE), DE('0'))#">,
							<cfqueryparam cfsqltype="CF_SQL_MONEY" value="#iif(arguments.GALLERY_PRICE NEQ '', DE(arguments.GALLERY_PRICE), DE('0'))#">,
							<cfqueryparam cfsqltype="CF_SQL_MONEY" value="#iif(arguments.SPECIAL_PRICE NEQ '', DE(arguments.SPECIAL_PRICE), DE('0'))#">,
							<cfqueryparam cfsqltype="CF_SQL_BIT" value="#iif(len(arguments.CLOSEOUT),DE(arguments.CLOSEOUT),DE(0))#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.LOW_ESTIMATE#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.HIGH_ESTIMATE#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.QUANTITY#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.CAPTION#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.ACTIVE#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.FRONTSHOW#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.FAMILY#">,
							<cfqueryparam cfsqltype="CF_SQL_TINYINT" value="#iif(len(arguments.SLIDESHOW),DE(arguments.SLIDESHOW),DE(0))#">,
							<cfqueryparam cfsqltype="CF_SQL_DATE" value="#createodbcdate(now())#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.LOCATION#">,
							<cfqueryparam cfsqltype="CF_SQL_MONEY" value="#arguments.LOCATION_PRICE#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.LOCATION_FLOOR#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.LOCATION_WALL#">,
							<cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#arguments.LOCATION_NOTES#">,
							<cfqueryparam cfsqltype="CF_SQL_TINYINT"value="#iif(len(arguments.AUCTION),DE(arguments.AUCTION),DE(0))#">
						)
						SELECT @@identity as newId
					</cfquery>

					<cfset thisId = addListing.newId />

				<cfelse>

					<cfquery name="editListing" datasource="#application.dsource#">
						UPDATE products SET
							NAME 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.NAME#">,
							MANUFACTURER 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.MANUFACTURER#">,
							PATH 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.PATH#">,
							YEAR 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.YEAR#">,
							SIZE 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.SIZE#">,
							EDITION			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.EDITION#">,
							RETAIL_PRICE 	= <cfqueryparam cfsqltype="CF_SQL_MONEY" value="#iif(arguments.RETAIL_PRICE NEQ '', DE(arguments.RETAIL_PRICE), DE('0'))#">,
							GALLERY_PRICE	= <cfqueryparam cfsqltype="CF_SQL_MONEY" value="#iif(arguments.GALLERY_PRICE NEQ '', DE(arguments.GALLERY_PRICE), DE('0'))#">,
							SPECIAL_PRICE	= <cfqueryparam cfsqltype="CF_SQL_MONEY" value="#iif(arguments.SPECIAL_PRICE NEQ '', DE(arguments.SPECIAL_PRICE), DE('0'))#">,
							CLOSEOUT		= <cfqueryparam cfsqltype="CF_SQL_BIT"value="#iif(len(arguments.CLOSEOUT),DE(arguments.CLOSEOUT),DE(0))#">,
							LOW_ESTIMATE 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.LOW_ESTIMATE#">,
							HIGH_ESTIMATE 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.HIGH_ESTIMATE#">,
							QUANTITY 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.QUANTITY#">,
							CAPTION 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.CAPTION#">,
							ACTIVE 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.ACTIVE#">,
							FRONTSHOW 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.FRONTSHOW#">,
							FAMILY 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.FAMILY#">,
							SLIDESHOW		= <cfqueryparam cfsqltype="CF_SQL_BIT"value="#iif(len(arguments.SLIDESHOW),DE(arguments.SLIDESHOW),DE(0))#">,
							LASTEDIT		= <cfqueryparam cfsqltype="CF_SQL_DATE" value="#createodbcdate(now())#">,
							LOCATION		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.LOCATION#">,
							LOCATION_PRICE	= <cfqueryparam cfsqltype="CF_SQL_MONEY" value="#arguments.LOCATION_PRICE#">,
							LOCATION_FLOOR	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.LOCATION_FLOOR#">,
							LOCATION_WALL	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.LOCATION_WALL#">,
							LOCATION_NOTES	= <cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#arguments.LOCATION_NOTES#">,
							AUCTION		= <cfqueryparam cfsqltype="CF_SQL_TINYINT"value="#iif(len(arguments.AUCTION),DE(arguments.AUCTION),DE(0))#">
							<cfif form.deactivated EQ 1 AND form.active EQ 1>
								,ACTIVE_DATE = <cfqueryparam cfsqltype="CF_SQL_DATE" value="#createodbcdate(now())#">
							</cfif>
						WHERE uid = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.uid#">
					</cfquery>

					<cfset thisId = arguments.uid />

				</cfif>

				<cfif len(arguments.thisImage)>

					<cffile action="upload" nameconflict="overwrite" filefield="thisImage" destination="#application.uploaddir#/#thisId#.jpg" result="fileupload">

					<cfif fileupload.fileWasSaved>

						<cfimage
							action="read"
							source="#application.uploaddir#/#thisId#.jpg"
							name="oImage"
						/>

						<cfimage
							action="resize"
							source="#oImage#"
							width="100"
							height=""
							name="oImageSmall"
						/>

						<cfimage
							action="WRITE"
							source="#oImageSmall#"
							destination="#application.uploaddir#/thumbnails/#thisId#.jpg"
							overwrite="true"
						/>

					</cfif>

				</cfif>

				<!--- additional images --->
				<cfset additionalImages = "" />
				<cfset uploaddir = "#application.uploaddir#" />
				<cfset addImageIdx = 1 />
				<cfif arguments.uid NEQ 0>

					<cfquery name="getAdditional" datasource="#application.dsource#">
						SELECT ADDITIONAL_IMAGES from products
						WHERE uid = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#thisId#">
					</cfquery>
					<cfif getAdditional.ADDITIONAL_IMAGES NEQ "">
						<cfset addImageIdx = listFirst(listLast(listLast(getAdditional.ADDITIONAL_IMAGES),'_'),'.') + 1 />
						<cfset additionalImages = getAdditional.ADDITIONAL_IMAGES />
					</cfif>
				</cfif>

				<cfloop collection="#form#" item="idx">
					<cfif left(idx,9) EQ "addImage_">
						<cfset currImage = evaluate("form." & idx) />
						<cfif currImage NEQ "">
							<cfset thisFilefield = idx />
							<cfset thisImageId = "#thisId#_#addImageIdx#.jpg" />
							<cfset additionalImages = listAppend(additionalImages,thisImageId) />
							<cffile action="upload" nameconflict="overwrite" filefield="#thisFilefield#" destination="#uploaddir#/#thisImageId#" result="fileupload">
							<cfset addImageIdx = addImageIdx + 1 />
						  </cfif>
					</cfif>

				</cfloop>

				<cfif additionalImages NEQ "">
					<cfquery name="editListing" datasource="#application.dsource#">
						UPDATE products SET
							ADDITIONAL_IMAGES 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#additionalImages#">
						WHERE uid = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#thisId#">
					</cfquery>
				   </cfif>

			<cfreturn success>

		</cffunction>


		<!--- /////////////  EDIT FROM GRID //////////////// --->
		<cffunction name="editListingsFromGrid" access="remote">
			<cfargument name="gridaction" type="string" required="yes">
			<cfargument name="gridrow" type="struct" required="yes">
			<cfargument name="gridchanged" type="struct" required="yes">
			<cfargument name="sellerName" type="string" required="yes">
			<cfargument name="sellerEmail" type="string" required="yes">

			<!--- Local variables --->
			<cfset var colname="">
			<cfset var value="">

			<!--- Process gridaction --->
			<cfswitch expression="#ARGUMENTS.gridaction#">
				<!--- Process updates --->
				<cfcase value="U">
					<!--- Get column name and value --->
					<cfset colname=StructKeyList(ARGUMENTS.gridchanged)>
					<cfset value=ARGUMENTS.gridchanged[colname]>
					<!--- make exception for showActive --->
					<cfif colname EQ "STATUS">
						<cfif ARGUMENTS.gridchanged[colname] EQ 'Inactive'>
							<cfset value = 0 />
						<cfelseif ARGUMENTS.gridchanged[colname] EQ 'Active'>
							<cfset value = 1 />
						</cfif>
						<cfset colname = "active" />
					</cfif>

					<!--- Perform actual update --->
					<cfquery datasource="#application.dsource#">
						UPDATE products
						SET #colname# = '#value#'
						WHERE uid = #ARGUMENTS.gridrow.uid#
					</cfquery>

					<cfif value EQ 1>
						<cfsavecontent variable="emailBody">
							<cfoutput>
							Dear #arguments.sellerName#,<br><br>
							  Your listing, #gridrow.name# by "#gridrow.manufacturer#",
							   was accepted by www.gallart.com and is now viewable on the website.<br><br>
							  Thank you,<br> WWW.GALLART.COM
							</cfoutput>
						</cfsavecontent>

						<cfset sender = "info@gallart.com" />
						<cfset recipient = arguments.sellerEmail />
						<cfset subject = "Your listing was accepted" />
						<cfset body = emailBody />

						<cfscript>
							emailSender = application.objectFactoryAdmin.getInstance('mailer').sendMail(sender,recipient,subject,body );
						</cfscript>

					</cfif>

			   </cfcase>
				<!--- Process deletes --->
				<cfcase value="D">
					<!--- Perform actual delete --->
					<cfquery datasource="#application.dsource#">
					DELETE FROM products
					where uid = #ARGUMENTS.gridrow.uid#
					</cfquery>
				</cfcase>
			</cfswitch>
		</cffunction>

		<cffunction name="deleteListing" access="remote">
			<cfargument name="uid" type="string" default="">

			<cfset var success = true />

			<cftry>

				<cfquery name="deleteListing" datasource="#application.dsource#">
					   DELETE from products
					WHERE uid = #arguments.uid#
				</cfquery>

				<cffile action="delete" file="#application.uploaddir#/#arguments.uid#.jpg">

				<cfcatch type="any"><cfset success = false /></cfcatch>
			</cftry>

			<cfreturn success />

		</cffunction>

		<cffunction name="getAllMedium" access="remote" returntype="query">

			<cfset var success = true />
			<cfset var qMedium = '' />

			<cftry>

			<cfquery name="qMedium" datasource="#application.dsource#">
				   SELECT path from products
				GROUP BY path
				ORDER BY path
			</cfquery>

			<cfcatch type="any"><cfset success = false /></cfcatch>
			</cftry>

			<cfreturn qMedium />

		</cffunction>

		<cffunction name="getAllArtists" access="remote" returntype="query">

			<cfset var success = true />
			<cfset var qArtists = '' />

			<cftry>

			<cfquery name="qArtists" datasource="#application.dsource#">
				   SELECT distinct manufacturer FROM products
				ORDER BY manufacturer
			</cfquery>

			<cfcatch type="any"><cfset success = false /></cfcatch>
			</cftry>

			<cfreturn qArtists />

		</cffunction>

		<cffunction name="getNewModelno" access="remote" returntype="struct">

			<cfset var returnStruct = structNew() />

			<!--- Create Model No --->
			<cfquery name="qModelno" datasource="#application.dsource#">
				SELECT top 1 modelno_numeric FROM products
				order by modelno_numeric desc
			</cfquery>

			<cfset returnStruct.new_modelno_numeric= qModelno.modelno_numeric + 1 />

			<cfset returnStruct.modelno = "G" & returnStruct.new_modelno_numeric />

			<cfreturn returnStruct />

		</cffunction>

	<!--- /////////////  END LISTING MANAGEMENT ///////////////// --->

	<!--- /////////////  FOR ORDER PROCESSING ///////////////// --->

	<cffunction name="getArt" access="remote" output="false" returntype="any">
		   <cfargument name="modelno">

		<cfset var qGetArt = "" />

		<cfset var thisReturn = false />

		<cfif NOT structKeyExists(session,'orderArray')>
			<cfset session.orderArray= arrayNew(1) />
		</cfif>

			<cftry>

				<cfquery name="qGetArt" datasource="#application.dsource#">
					SELECT *
					FROM products P
					WHERE active = 1
					<cfif arguments.modelno neq ''>
						  AND modelno =  '#trim(arguments.modelno)#'
					<cfelse>
						AND 0=1
					  </cfif>
				</cfquery>


				<cfif qGetArt.recordcount>
					<cfset session.orderArray[arrayLen(session.orderArray)+1][1] = qGetArt.uid />
					<cfset session.orderArray[arrayLen(session.orderArray)][2] = qGetArt.name />
					<cfset session.orderArray[arrayLen(session.orderArray)][3] = qGetArt.manufacturer />
					<cfset session.orderArray[arrayLen(session.orderArray)][4] = left(qGetArt.caption,25)&'...' />
					<cfset session.orderArray[arrayLen(session.orderArray)][5] = qGetArt.modelno />
					<cfset session.orderArray[arrayLen(session.orderArray)][6] = qGetArt.gallery_price />
					<cfset session.orderArray[arrayLen(session.orderArray)][7] = 1 />
					<cfset session.orderArray[arrayLen(session.orderArray)][8] = 0 />
					<cfset thisReturn = true />
				</cfif>

			<cfcatch type="Any"><cfset thisReturn = false /></cfcatch>

			</cftry>

		<cfreturn thisReturn>

	</cffunction>


	<cffunction name="getArtByTitle" access="remote" returntype="string">
		<cfargument name="name" type="string">

		<cfset var qGetArt = "" />

		<cfset var thisReturn = false />

		<cfif NOT structKeyExists(session,'orderArray')>
			<cfset session.orderArray= arrayNew(1) />
		</cfif>

			<cftry>

				<cfquery name="qGetArt" datasource="#application.dsource#">
					SELECT * FROM products
					WHERE active = 1
					AND name <> ''
					<cfif arguments.name neq ''>
						  AND name = '#arguments.name#'
					<cfelse>
						AND 0=1
					  </cfif>
				</cfquery>


				<cfif qGetArt.recordcount>
					<cfset session.orderArray[arrayLen(session.orderArray)+1][1] = qGetArt.uid />
					<cfset session.orderArray[arrayLen(session.orderArray)][2] = qGetArt.name />
					<cfset session.orderArray[arrayLen(session.orderArray)][3] = qGetArt.manufacturer />
					<cfset session.orderArray[arrayLen(session.orderArray)][4] = left(qGetArt.caption,25)&'...' />
					<cfset session.orderArray[arrayLen(session.orderArray)][5] = qGetArt.modelno />
					<cfset session.orderArray[arrayLen(session.orderArray)][6] = qGetArt.sale_price />
					<cfset session.orderArray[arrayLen(session.orderArray)][7] = 1 />
					<cfset session.orderArray[arrayLen(session.orderArray)][8] = 0 />
					<cfset thisReturn = true />
				</cfif>

			<cfcatch type="Any"><cfset thisReturn = false /></cfcatch>

			</cftry>

		<cfreturn thisReturn>

	</cffunction>

	<!--- /////////////  FOR AUTOSUGGEST ///////////////// --->

	<cffunction name="searchArtByTitle" access="remote" returntype="string">
		<cfargument name="cfautosuggestvalue" type="string">

				  <cfquery name="qListings" datasource="#application.dsource#">
				SELECT top 100 name FROM products
				WHERE active = 1
				AND name <> ''
				AND upper(name) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%')
				ORDER BY name
			   </cfquery>

		<cfreturn valueList(qListings.name) />

	</cffunction>

	<cffunction name="saveArtInfo" access="remote" output="false" returntype="any" returnformat="JSON">
		<cfargument name="form" type="struct">

		<cfset var success = true />

		<cfif NOT structKeyExists(session,'orderArray')>
			<cfset session.orderArray= arrayNew(1) />
		</cfif>

		<cftry>

			<cfset session.orderArray[arrayLen(session.orderArray)+1][1] = '0000' />
			<cfset session.orderArray[arrayLen(session.orderArray)][2] = ucase(form.title) />
			<cfset session.orderArray[arrayLen(session.orderArray)][3] = ucase(form.artist) />
			<cfset session.orderArray[arrayLen(session.orderArray)][4] = form.desc />
			<cfset session.orderArray[arrayLen(session.orderArray)][5] = '0000' />
			<cfset session.orderArray[arrayLen(session.orderArray)][6] = form.price />
			<cfset session.orderArray[arrayLen(session.orderArray)][7] = 1 />
			<cfset session.orderArray[arrayLen(session.orderArray)][8] = 0 />

			<cfcatch type="Any"><cfset success = false /></cfcatch>

		</cftry>

		<cfreturn success>

	</cffunction>

	<cffunction name="saveFramingInfo" access="remote" output="false" returntype="any" returnformat="JSON">
		<cfargument name="form" type="struct">

		<cfset var success = true />

		<cfif NOT structKeyExists(session,'orderArray')>
			<cfset session.orderArray= arrayNew(1) />
		</cfif>

		<cftry>

			<cfset session.orderArray[arrayLen(session.orderArray)+1][1] = '0000' />
			<cfset session.orderArray[arrayLen(session.orderArray)][2] = ucase(form.title) />
			<cfset session.orderArray[arrayLen(session.orderArray)][3] = ucase(form.artist) />
			<cfset session.orderArray[arrayLen(session.orderArray)][4] = form.desc />
			<cfset session.orderArray[arrayLen(session.orderArray)][5] = '0000' />
			<cfset session.orderArray[arrayLen(session.orderArray)][6] = form.price />
			<cfset session.orderArray[arrayLen(session.orderArray)][7] = 1 />
			<cfset session.orderArray[arrayLen(session.orderArray)][8] = 1 />

			<cfcatch type="Any"><cfset success = false /></cfcatch>

		</cftry>

		<cfreturn success>

	</cffunction>

	<cffunction name="setItemQuantity" access="remote" output="false" returntype="void">
		   <cfargument name="thisIndex">
		<cfargument name="thisValue">

			<cfset session.orderArray[arguments.thisIndex][7] = arguments.thisValue />

	</cffunction>

	<cffunction name="setItemPrice" access="remote" output="false" returntype="void">
		   <cfargument name="thisIndex">
		<cfargument name="thisValue">

			<cfset session.orderArray[arguments.thisIndex][6] = arguments.thisValue />

	</cffunction>


	<cffunction name="createArtDisplay" access="remote" output="false" returntype="any">

		<cfsavecontent variable="artDisplay">
			<cfif structKeyExists(session,'orderArray') AND arrayLen(session.orderArray)>
			   <table width="100%" border="1" bgcolor="#ffffff">
				<tr>
					<td width="5%">Quantity</td>
					<td width="30%">Title</td>
					<td width="20%">Artist</td>
					<td width="25%">Description</td>
					<td width="5%" align="center">Art ID</td>
					<td width="5%">Framing</td>
					<td width="5%">Price</td>
					<td width="5%">Delete</td>
				</tr>
				<cfoutput>
					<cfloop from="1" to="#arrayLen(session.orderArray)#" index="idx">
						<tr>
							<td>
								<input type="Text" id="quantity_#idx#" name="quantity_#idx#" size="4" value="#session.orderArray[idx][7]#" onkeyup="addQuantity('#idx#',this.value)" />
							</td>
							<td>
								<input type="Hidden" name="title_#idx#" value="#session.orderArray[idx][2]#">
								#session.orderArray[idx][2]#
							</td>
							<td>
								<input type="Hidden" name="artist_#idx#" value="#session.orderArray[idx][3]#">
								#session.orderArray[idx][3]#
							</td>
							<td>
								<input type="Hidden" name="desc_#idx#" value="#session.orderArray[idx][4]#">
								#session.orderArray[idx][4]#
							</td>
							<td align="center">
								<input type="Hidden" name="modelno_#idx#" value="#session.orderArray[idx][5]#">
								#session.orderArray[idx][5]#
							</td>
							<td align="center">
								<input type="Hidden" name="framing_#idx#" value="#session.orderArray[idx][8]#">
								<cfif session.orderArray[idx][8] EQ 1>YES</cfif>
							</td>
							<td align="right">
								<input type="Text" id="price_#idx#" name="price_#idx#" value="#session.orderArray[idx][6]#" onkeyup="addPrice('#idx#',this.value)" />
							</td>
							<td align="center">
								<a onclick="delArt('#idx#');return false;" style="cursor: pointer;"><img src="http://#server_name#/images/trash.gif" border="0" /></a>
							</td>
						</tr>
					</cfloop>
				</cfoutput>
			</table>
			</cfif>
		</cfsavecontent>

		<cfreturn artDisplay>

	</cffunction>

	<cffunction name="deleteArtListing" access="remote" output="false" returntype="any">

		<cfargument name="rowNum">

		<cfset var thisReturn = true />

		<cftry>

			<cfset temp = ArrayDeleteAt( session.orderArray, arguments.rowNum ) />

			<cfcatch type="Any"><cfset thisReturn = false /></cfcatch>

		</cftry>

		<cfreturn thisReturn>

	</cffunction>

	 <!--- /////////////  END ORDER PROCESSING ///////////////// --->

	 <!--- /////////////  FOR SELLER MANAGMENT ///////////////// --->

		<cffunction name="getListingsBySeller" access="remote">

			  <cfargument name="page" required="yes">
			  <cfargument name="pageSize" required="yes">
			  <cfargument name="gridsortcolumn" required="yes">
			  <cfargument name="gridsortdirection" required="yes">
			<cfargument name="sellerId" required="yes" type="string" default="">
			<cfargument name="title" required="yes" type="string" default="">
			<cfargument name="artist" required="yes" type="string" default="">

			<cfset var qListings='' />


			   <cfquery name="qListings" datasource="#application.dsource#">
				  SELECT CONVERT(CHAR(9),datestamp,6) as listingDate,'<a href="http://gallart.com/img/'+CAST(uid AS varchar(50))+'.jpg" target="_blank"><img src="http://gallart.com/img/thumbnails/'+CAST(uid AS varchar(50))+'.jpg" border="0" height="50" />' as 'Thumbnail',
				CASE WHEN active = '0' THEN 'Inactive' ELSE 'Active' END AS Status,*
				  FROM products
				WHERE fk_users = '#arguments.sellerId#'
				<cfif arguments.title neq ''>
					  AND name like '#arguments.title#%'
				  </cfif>
				<cfif arguments.artist neq ''>
					  AND manufacturer like '#arguments.artist#%'
				  </cfif>
				  <cfif gridsortcolumn neq ''>
					  ORDER BY #gridsortcolumn# #gridsortdirection#
				<cfelse>
					ORDER BY datestamp desc
				  </cfif>
			   </cfquery>

			   <cfreturn queryconvertforgrid(qListings,page,pagesize)/>

		</cffunction>

		<cffunction name="getLatestListings" access="remote">

			  <cfargument name="page" required="yes">
			  <cfargument name="pageSize" required="yes">
			  <cfargument name="gridsortcolumn" required="yes">
			  <cfargument name="gridsortdirection" required="yes">
			<cfargument name="active" required="no" type="string" default="">
			<cfargument name="timeframe" required="no" type="string" default="">


			<cfset var qListings='' />


			   <cfquery name="qListings" datasource="#application.dsource#">
				  SELECT CONVERT(CHAR(9),datestamp,6) as listingDate,*
				FROM products P
				INNER JOIN users U on P.fk_users = U.pk_users
				WHERE P.fk_users is not null
				<cfif IsDefined('arguments.active') and len(trim(arguments.active))>
					<cfif arguments.active eq 1>
						AND active = 1
					<cfelse>
						AND active = 0
					</cfif>
				</cfif>
				<cfif IsDefined('arguments.timeframe') and len(trim(arguments.timeframe))>
					<cfif arguments.timeframe eq 'week'>
						AND datestamp >  #dateadd('ww',-1,now())#
					<cfelseif arguments.timeframe eq 'month'>
						AND datestamp >  #dateadd('m',-1,now())#
					<cfelseif arguments.timeframe eq 'twomonths'>
						AND datestamp >  #dateadd('m',-2,now())#
					</cfif>
				</cfif>
				  <cfif gridsortcolumn neq ''>
					  ORDER BY #gridsortcolumn# #gridsortdirection#
				<cfelse>
					ORDER BY datestamp desc
				  </cfif>
			   </cfquery>

			   <cfreturn queryconvertforgrid(qListings,page,pagesize)/>

		</cffunction>

		 <!--- /////////////  FOR EXPORTS ///////////////// --->

		<cffunction name="getExcelListingsByArtist" access="remote" returntype="query">
			<cfargument name="artists" type="string">

			<cfset var qListings = '' />

			<!--- <cftry> --->

			<cfquery name="qListings" datasource="#application.dsource#">
				   SELECT * FROM products P
				WHERE P.active = 1
				AND
				<cfloop list="#arguments.artists#" index="idx">
					P.manufacturer like '%#trim(listlast(idx,' '))#%' OR
				</cfloop>
				0=1
				AND fk_users is null
				ORDER by P.manufacturer
			</cfquery>


			<!--- <cfcatch type="any"><cfset success = false /></cfcatch>
			</cftry> --->

			<cfreturn qListings />

		</cffunction>

		<cffunction name="getExcelListingsBySelected" access="remote" returntype="query">
			<cfargument name="active" type="string">

			<cfset var qListings = '' />

			<cftry>

				   <cfquery name="qListings" datasource="#application.dsource#" timeout="60000">
					SELECT * FROM products P
					WHERE fk_users is null
					<cfif arguments.active EQ 1>
						AND P.active = 1
					</cfif>
					ORDER by P.manufacturer
				</cfquery>


			<cfcatch type="any"><cfset success = false /></cfcatch>
			</cftry>

			<cfreturn qListings />

		</cffunction>

		<!--- /////////////  FOR SALES ///////////////// --->

		<cffunction name="getListingsForSales" access="remote" returntype="query">

			<cfargument name="sellerId" required="no" type="string" default="">
			<cfargument name="modelno" required="no" type="string" default="">
			<cfargument name="title" required="no" type="string" default="">
			<cfargument name="artist" required="no" type="string" default="">
			<cfargument name="exclude_artist" required="no" type="string" default="">
			<cfargument name="medium" required="no" type="string" default="">
			<cfargument name="year" required="no" type="string" default="">
			<cfargument name="height" required="no" type="string" default="">
			<cfargument name="width" required="no" type="string" default="">
			<cfargument name="description" required="no" type="string" default="">
			<cfargument name="fromPrice" required="no" type="string" default="">
			<cfargument name="toPrice" required="no" type="string" default="">
			<cfargument name="fromDate" required="no" type="string" default="">
			<cfargument name="toDate" required="no" type="string" default="">
			<cfargument name="fromLastEdit" required="no" type="string" default="">
			<cfargument name="toLastEdit" required="no" type="string" default="">
			<cfargument name="gallery_only" required="no" type="string" default="">
			<cfargument name="onSale" required="no" type="string" default="">
			<cfargument name="trump" required="no" type="string" default="">
			<cfargument name="auction" required="no" type="string" default="">
			<cfargument name="active" required="no" type="string" default="">

			<cfset var qListings='' />

			<cfif isDefined('arguments.fromPrice') AND arguments.fromPrice neq ''>
				<cfset arguments.fromPrice 	= rereplace(arguments.fromPrice, "[^0-9|.]", "", "all")>
			</cfif>
			<cfif isDefined('arguments.toPrice') AND arguments.toPrice neq ''>
				<cfset arguments.toPrice 	= rereplace(arguments.toPrice, "[^0-9|.]", "", "all")>
			</cfif>

			   <cfquery name="qListings" datasource="#application.dsource#">
				  SELECT CONVERT(CHAR(9),datestamp,6) as listingDate,*
				  FROM products P
				LEFT OUTER JOIN users U on P.fk_users = U.pk_users
				WHERE active = 1
				<cfif isDefined('arguments.modelno') AND arguments.modelno neq ''>
					  AND modelno like '#arguments.modelno#%'
				  </cfif>
				<cfif isDefined('arguments.title') AND arguments.title neq ''>
					  AND name like '#arguments.title#%'
				  </cfif>
				<cfif isDefined('arguments.artist') AND arguments.artist neq ''>
					  AND manufacturer like '#arguments.artist#%'
				  </cfif>
				<cfif isDefined('arguments.exclude_artist') AND arguments.exclude_artist neq ''>
					  AND manufacturer <> '#arguments.exclude_artist#'
				  </cfif>
				<cfif isDefined('arguments.medium') AND arguments.medium neq ''>
					  AND path = '#arguments.medium#'
				  </cfif>
				<cfif isDefined('arguments.year') AND arguments.year neq ''>
					  AND year = '#arguments.year#'
				  </cfif>
				<cfif isDefined('arguments.height') and len(trim(arguments.height))>
					AND (patindex('%x%',size) > 1 AND substring(size,1,patindex('%x%',size)-1) like '#arguments.height#')
				</cfif>
				<cfif isDefined('arguments.width') and len(trim(arguments.width))>
					AND (patindex('%x%',size) > 1 AND replace(substring(size,patindex('%x%',size)+1,10),' ','') like '#arguments.width#%')
				</cfif>
				<cfif isDefined('arguments.description') AND arguments.description neq ''>
					  AND caption like '%#arguments.description#%'
				  </cfif>
				<cfif isDefined('arguments.fromPrice') AND arguments.fromPrice neq ''>
					AND gallery_price >= #arguments.fromPrice#
				</cfif>
				<cfif isDefined('arguments.toPrice') AND arguments.toPrice neq ''>
					AND gallery_price <= #arguments.toPrice#
				</cfif>
				<cfif isDefined('arguments.fromDate') AND arguments.fromDate neq ''>
					AND datestamp >= '#dateFormat(arguments.fromDate)#'
				</cfif>
				<cfif isDefined('arguments.toDate') AND arguments.toDate neq ''>
					AND datestamp <= '#dateFormat(arguments.toDate)#'
				</cfif>
				<cfif isDefined('arguments.fromLastedit') AND arguments.fromLastedit neq ''>
					AND lastedit >= '#dateFormat(arguments.fromLastedit)#'
				</cfif>
				<cfif isDefined('arguments.toLastedit') AND arguments.toLastedit neq ''>
					AND lastedit <= '#dateFormat(arguments.toLastedit)#'
				</cfif>
				<cfif isDefined('arguments.gallery_only') AND arguments.gallery_only EQ 1>
					AND fk_users is null
				</cfif>
				<cfif isDefined('arguments.sellerId') and len(trim(arguments.sellerId))>
					<cfif arguments.sellerId eq 0>
						 AND fk_users is not null
					<cfelseif arguments.sellerId gt 0>
						AND fk_users = #arguments.sellerId#
					</cfif>
				</cfif>
				<cfif isDefined('arguments.onSale') AND arguments.onSale EQ 1>
					AND closeout = 1
				</cfif>
				<cfif isDefined('arguments.trump') AND arguments.trump EQ 2>
					AND location = 2
				</cfif>
				<cfif isDefined('arguments.auction') AND arguments.auction EQ 1>
					AND auction = 1
				</cfif>
					  ORDER BY name
			   </cfquery>

			   <cfreturn qListings />

		</cffunction>

		<!--- /////////////  FOR PRICETAGS ///////////////// --->

		<cffunction name="getListingsForPricetags" access="remote" returntype="query">

			<cfargument name="artist" required="no" type="string" default="">

			<cfset var qListings='' />

			   <cfquery name="qListings" datasource="#application.dsource#">
				  SELECT CONVERT(CHAR(9),datestamp,6) as listingDate,*
				  FROM products P
				WHERE active = 1
				AND
				<cfif isDefined('arguments.artist') AND arguments.artist neq ''>
					<cfset count = 1>
					<cfloop list="#arguments.artist#" index="idx">
						manufacturer LIKE '#idx#%'
						<cfif count LT listLen(arguments.artist)>
							OR
						</cfif>
						<cfset count = count + 1 />
					</cfloop>

				  </cfif>

				  ORDER BY name
			   </cfquery>

			   <cfreturn qListings />

		</cffunction>

		<cffunction name="insertSalePrices" access="remote">
			<cfargument name="form" type="struct">

				   <cfloop collection="#arguments.form#" item="idx">
					<cfif left(idx,14) eq 'SPECIAL_PRICE_'>
						<cfset this_keyval = right(idx,len(idx)-14)>
						<cfquery name="update" datasource="#application.dsource#">
							UPDATE products
							SET
							special_price 	= '#evaluate('form.SPECIAL_PRICE_'&this_keyval)#'
							<cfif isDefined("form.add_to_sale_#this_keyval#")>
								,closeout		= '1'
							</cfif>
							<cfif isDefined("form.remove_from_sale_#this_keyval#") EQ 1>
								,closeout		= '0'
							</cfif>
							<cfif evaluate("form.usePrice_"&this_keyval) EQ "H">
								,use_highestimate = 1
							<cfelse>
								,use_highestimate = 0
							</cfif>
							WHERE uid = #this_keyval#
						</cfquery>
					</cfif>
				</cfloop>
		</cffunction>

		<cffunction name="getSalesiteCodeListings" access="remote">
			<cfargument name="query_string" type="string">

			<cfset var qListings = '' />

			   <cfquery name="qListings" datasource="#application.dsource#">
					SELECT *
					FROM products
					 WHERE #PreserveSingleQuotes(arguments.query_string)#
					AND active = 1
					order by name
				</cfquery>

			<cfreturn qListings />

		</cffunction>

		<!--- /////////////  FOR MASS UPDATES ///////////////// --->

		<cffunction name="getListingsMassUpdate" access="remote">

			<cfargument name="modelno" required="no" type="string" default="">
			<cfargument name="name" required="no" type="string" default="">
			<cfargument name="manufacturer" required="no" type="string" default="">
			<cfargument name="path" required="no" type="string" default="">
			<cfargument name="year" required="no" type="string" default="">
			<cfargument name="height" required="no" type="string" default="">
			<cfargument name="width" required="no" type="string" default="">
			<cfargument name="caption" required="no" type="string" default="">
			<cfargument name="fromPrice" required="no" type="string" default="">
			<cfargument name="toPrice" required="no" type="string" default="">
			<cfargument name="fromDate" required="no" type="string" default="">
			<cfargument name="toDate" required="no" type="string" default="">
			<cfargument name="fromLastEdit" required="no" type="string" default="">
			<cfargument name="toLastEdit" required="no" type="string" default="">
			<cfargument name="onSale" required="no" type="string" default="">
			<cfargument name="trump" required="no" type="string" default="">
			<cfargument name="auction" required="no" type="string" default="">
			<cfargument name="slideshow" required="no" type="string" default="">
			<cfargument name="frontShow" required="no" type="string" default="">
			<cfargument name="bottomHome" required="no" type="string" default="">
			<cfargument name="active" required="no" type="string" default="">
			<cfargument name="gallery_only" required="no" type="string" default="">
			<cfargument name="alphaChar" required="no" type="string" default="">
			<cfargument name="groups" required="no" type="string" default="0">
			<cfargument name="page" required="no" type="string" default="1">

			<cfset var returnStruct = structNew() />
			<cfset var qListings='' />
			<cfset var totalrecords = 0 />

			<cfif isDefined('arguments.fromPrice') AND arguments.fromPrice neq ''>
				<cfset arguments.fromPrice 	= rereplace(arguments.fromPrice, "[^0-9|.]", "", "all")>
			</cfif>
			<cfif isDefined('arguments.toPrice') AND arguments.toPrice neq ''>
				<cfset arguments.toPrice 	= rereplace(arguments.toPrice, "[^0-9|.]", "", "all")>
			</cfif>

			<cfif isDefined('arguments.groups') AND arguments.groups GT 0>

				<cfsavecontent variable="sql_where">
					<cfoutput>
						active = 1
						AND fk_users is null
						AND manufacturer like '#arguments.alphaChar#%'
						<cfif isDefined('arguments.fromPrice') AND arguments.fromPrice neq ''>
							AND gallery_price >= #arguments.fromPrice#
						</cfif>
						<cfif isDefined('arguments.toPrice') AND arguments.toPrice neq ''>
							AND gallery_price <= #arguments.toPrice#
						</cfif>
					</cfoutput>
				</cfsavecontent>

				<cfstoredproc procedure="sp_selectnextn" datasource="#application.dsource#">
					<cfprocparam type="In" dbvarname="@TableName" value="products" cfsqltype="CF_SQL_VARCHAR">
					<cfprocparam type="In" dbvarname="@Columns" value="*" cfsqltype="CF_SQL_VARCHAR">
					<cfprocparam type="In" dbvarname="@IdentityColumn" value="uid" cfsqltype="CF_SQL_VARCHAR">
					<cfprocparam type="In" dbvarname="@GroupNumber" value="#arguments.page#" cfsqltype="CF_SQL_INTEGER">
					<cfprocparam type="In" dbvarname="@GroupSize" value="#arguments.groups#" cfsqltype="CF_SQL_INTEGER">
					<cfprocparam type="In" dbvarname="@SqlWhere" value="#sql_where#" cfsqltype="CF_SQL_VARCHAR">
					<cfprocparam type="In" dbvarname="@SqlOrderBy" value="manufacturer" cfsqltype="CF_SQL_VARCHAR">
					<cfprocresult name="qListings" resultset="1">
					<cfprocresult name="totalrecords" resultset="2">
				</cfstoredproc>

			<cfelse>

			   <cfquery name="qListings" datasource="#application.dsource#">
				  SELECT UPPER(U.lname)+', '+UPPER(U.fname) as full_seller_name,*
				  FROM products P
				LEFT OUTER JOIN users U on P.fk_users = U.pk_users
				WHERE 0=0
				<cfif isDefined('arguments.modelno') AND arguments.modelno neq ''>
					  AND modelno like '#arguments.modelno#%'
				  </cfif>
				<cfif isDefined('arguments.name') AND arguments.name neq ''>
					  AND name like '#arguments.name#%'
				  </cfif>
				<cfif isDefined('arguments.manufacturer') AND arguments.manufacturer neq ''>
					  AND manufacturer like '#arguments.manufacturer#%'
				  </cfif>
				<cfif isDefined('arguments.path') AND arguments.path neq ''>
					  AND path = '#arguments.path#'
				  </cfif>
				<cfif isDefined('arguments.year') AND arguments.year neq ''>
					  AND year = '#arguments.year#'
				  </cfif>
				<cfif isDefined('arguments.height') and len(trim(arguments.height))>
					AND (patindex('%x%',size) > 1 AND substring(size,1,patindex('%x%',size)-1) like '#arguments.height#')
				</cfif>
				<cfif isDefined('arguments.width') and len(trim(arguments.width))>
					AND (patindex('%x%',size) > 1 AND replace(substring(size,patindex('%x%',size)+1,10),' ','') like '#arguments.width#%')
				</cfif>
				<cfif isDefined('arguments.caption') AND arguments.caption neq ''>
					  AND caption like '%#arguments.caption#%'
				  </cfif>
				<cfif isDefined('arguments.fromPrice') AND arguments.fromPrice neq ''>
					AND gallery_price >= #arguments.fromPrice#
				</cfif>
				<cfif isDefined('arguments.toPrice') AND arguments.toPrice neq ''>
					AND gallery_price <= #arguments.toPrice#
				</cfif>
				<cfif isDefined('arguments.fromDate') AND arguments.fromDate neq ''>
					AND datestamp >= '#dateFormat(arguments.fromDate)#'
				</cfif>
				<cfif isDefined('arguments.toDate') AND arguments.toDate neq ''>
					AND datestamp <= '#dateFormat(arguments.toDate)#'
				</cfif>
				<cfif isDefined('arguments.fromLastedit') AND arguments.fromLastedit neq ''>
					AND lastedit >= '#dateFormat(arguments.fromLastedit)#'
				</cfif>
				<cfif isDefined('arguments.toLastedit') AND arguments.toLastedit neq ''>
					AND lastedit <= '#dateFormat(arguments.toLastedit)#'
				</cfif>
				<cfif isDefined('arguments.sellerId') and len(trim(arguments.sellerId))>
					<cfif arguments.sellerId eq 0>
						 AND fk_users is not null
					<cfelseif arguments.sellerId gt 0>
						AND fk_users = #arguments.sellerId#
					</cfif>
				</cfif>
				<cfif isDefined('arguments.onSale') AND arguments.onSale EQ 1>
					AND closeout = 1
				</cfif>
				<cfif isDefined('arguments.trump') AND arguments.trump EQ 2>
					AND location = 2
				</cfif>
				<cfif isDefined('arguments.auction') AND arguments.auction EQ 1>
					AND auction = 1
				</cfif>
				<cfif isDefined('arguments.slideshow') AND arguments.slideshow EQ 1>
					AND slideshow = 1
				</cfif>
				<cfif isDefined('arguments.frontShow') AND arguments.frontShow EQ 1>
					AND frontshow = 1
				</cfif>
				<cfif isDefined('arguments.bottomHome') AND arguments.bottomHome EQ 1>
					AND family > 0
				</cfif>
				<cfif isDefined('arguments.active')>
					<cfif arguments.active EQ 1>
						AND P.active = 1
					<cfelseif arguments.active EQ 0>
						AND P.active = 0
					</cfif>
				</cfif>
				<cfif isDefined('arguments.gallery_only') AND arguments.gallery_only EQ 1>
					AND fk_users is null
				</cfif>
				<cfif isDefined('arguments.alphaChar') AND arguments.alphaChar neq ''>
					AND manufacturer like '#arguments.alphaChar#%'
				</cfif>
				<cfif isDefined('arguments.alphaChar') AND arguments.alphaChar neq ''>
					ORDER BY manufacturer
				<cfelse>
					ORDER BY name
				</cfif>
			   </cfquery>

			</cfif>

			<cfset returnStruct.qListings = qListings />
			<cfset returnStruct.totalrecords = totalrecords />

			   <cfreturn returnStruct />

		</cffunction>

		<cffunction name="massUpdateProc" access="remote">

			<cfloop collection="#form#" item="idx">

				<cfif left(idx,7) eq 'DELETE_'>
					<cfset this_deleteval = right(idx,len(idx)-7)>
					<cfquery name="update" datasource="#application.dsource#">
						DELETE from products
						WHERE uid = #this_deleteval#
					   </cfquery>
				<cfelseif left(idx,8) eq 'MODELNO_'>
					<cfset this_keyval = right(idx,len(idx)-8)>
					<cfquery name="update" datasource="#application.dsource#">
						UPDATE products
						SET
						modelno = '#evaluate('form.MODELNO_'&this_keyval)#'
						<cfif isDefined('form.ACTIVE_'&this_keyval)>
							,active = <cfqueryparam cfsqltype="CF_SQL_TINYINT" value="1">
						<cfelse>
							,active = 0
						</cfif>
						<cfif isDefined('form.MANUFACTURER_'&this_keyval)>
							,manufacturer = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#evaluate('form.MANUFACTURER_'&this_keyval)#">
						</cfif>
						<cfif isDefined('form.PATH_'&this_keyval)>
							,path = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#evaluate('form.PATH_'&this_keyval)#">
						</cfif>
						<cfif isDefined('form.NAME_'&this_keyval)>
							,name = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#evaluate('form.NAME_'&this_keyval)#">
						</cfif>
						<cfif isDefined('form.RETAIL_PRICE_'&this_keyval)>
							,retail_price = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#evaluate('form.RETAIL_PRICE_'&this_keyval)#">
						</cfif>
						<cfif isDefined('form.GALLERY_PRICE_'&this_keyval)>
							,gallery_price = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#evaluate('form.GALLERY_PRICE_'&this_keyval)#">
						</cfif>
						<cfif isDefined('form.SPECIAL_PRICE_'&this_keyval)>
							,special_price = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#evaluate('form.SPECIAL_PRICE_'&this_keyval)#">
							<!---<cfif evaluate('form.SPECIAL_PRICE_'&this_keyval) NEQ "" AND evaluate('form.SPECIAL_PRICE_'&this_keyval) GT 0>
								,closeout = 1
							<cfelse>
								,closeout = 0
							</cfif>--->
						</cfif>
						<cfif isDefined('form.SPECS_'&this_keyval)>
							,specs = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#evaluate('form.SPECS_'&this_keyval)#">
						</cfif>
						<cfif isDefined('form.OVERVIEW_'&this_keyval)>
							,overview = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#evaluate('form.OVERVIEW_'&this_keyval)#">
						</cfif>
						<cfif isDefined('form.EDITION_'&this_keyval)>
							,edition = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#evaluate('form.EDITION_'&this_keyval)#">
						</cfif>
						<cfif isDefined('form.LOW_ESTIMATE_'&this_keyval)>
							,low_estimate = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#evaluate('form.LOW_ESTIMATE_'&this_keyval)#">
						</cfif>
						<cfif isDefined('form.HIGH_ESTIMATE_'&this_keyval)>
							,high_estimate = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#evaluate('form.HIGH_ESTIMATE_'&this_keyval)#">
						</cfif>
						<cfif isDefined('form.CLOSEOUT_'&this_keyval)>
							,closeout = <cfqueryparam cfsqltype="CF_SQL_TINYINT" value="1">
						<cfelse>
							,closeout = 0
						</cfif>
						WHERE uid = #this_keyval#
					</cfquery>

				</cfif>

			</cfloop>

		</cffunction>

		<cffunction name="getDups" access="remote">

			<cfset qListings = '' />

			   <cfquery name="qListings" datasource="#application.dsource#">
					SELECT name, manufacturer,
					COUNT(name) AS NumOccurName,
					COUNT(manufacturer) as NumOccurManufacturer
					FROM products
					GROUP BY name, manufacturer
					HAVING ( COUNT(name) > 1 ) AND ( COUNT(manufacturer) > 1)
				</cfquery>

			<cfreturn qListings />

		</cffunction>

		<cffunction name="getNoimage" access="remote">

			<cfset qListings = '' />

			   <cfquery name="qListingsNoImage" datasource="#application.dsource#">
					SELECT uid
					FROM products
				</cfquery>
				<cfset noImgList = '' />
				<cfloop query="qListingsNoImage">
					<cfset imageFile = expandpath('..') & '\img\' & uid & '.jpg' />
					<cfif NOT fileExists(imageFile)>
						<cfset noImgList = listAppend(noImgList,uid)  />
					</cfif>
				</cfloop>

				 <cfquery name="qListings" datasource="#application.dsource#">
					SELECT *
					FROM products
					WHERE uid in(#noImgList#)
				</cfquery>

			<cfreturn qListings />

		</cffunction>

		<cffunction name="getImagesByArtist" access="remote" returntype="struct">
			<cfargument name="artist" required="no" type="string" default="">
			<cfargument name="gallery_only" required="no" type="string" default="">
			<cfargument name="active" required="no" type="string" default="">

			<cfset var returnStruct = structNew() />

			<cfset qImages = '' />

				 <cfquery name="qImages" datasource="#application.dsource#">
					SELECT *
					FROM products
					<cfif isDefined('arguments.artist') AND arguments.artist neq ''>
						WHERE manufacturer = '#arguments.artist#'
					<cfelse>
						WHERE 0=1
					</cfif>
					<cfif isDefined('arguments.gallery_only') AND arguments.gallery_only EQ 1>
						AND fk_users is null
					</cfif>
					<cfif isDefined('arguments.active')>
						<cfif arguments.active EQ 1>
							AND active = 1
						<cfelseif arguments.active EQ 0>
							AND active = 0
						</cfif>
					</cfif>
					ORDER BY name
				</cfquery>
			  <cfsavecontent variable="imageSheetTable">
				  <cfoutput>

				  <!--- set number of columns --->
					<cfset cols = 8>
					<cfset extracells = cols - (qImages.recordcount MOD cols)>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
						<cfloop query="qImages">
						<td align="center" valign="top" style="font-size: 7px;">
							<img src="http://#server_name#/img/thumbnails/#uid#.jpg" width="50" /><br>
							#name#<br><br>
						</td>
						<CFIF currentrow MOD cols IS "0"></tr>
							<CFIF currentrow LT recordcount><tr>
						</CFIF></CFIF></cfloop>

						<CFIF extracells LT cols>
							<cfloop index="noindex" from="1" to="#extracells#">
								   <tr  ><td> </td>

						</tr></cfloop>
						</CFIF>
					</table>
				  </cfoutput>
			  </cfsavecontent>

			<cfset returnStruct.imageSheetTable = imageSheetTable />
			<cfset returnStruct.recordcount = 'Records found: ' & qImages.recordcount />
			<cfreturn returnStruct />

		</cffunction>

		<!--- /////////////  FOR AUTOSUGGEST (COA) ///////////////// --->

		<cffunction name="searchArtDropdown" access="remote" returntype="string">
			<cfargument name="cfautosuggestvalue" type="string">

				  <cfquery name="qArt" datasource="#application.dsource#">
					SELECT top 200 name FROM products
					WHERE name <> ''
					AND upper(name) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%')
					ORDER BY name
				   </cfquery>

			<cfreturn valueList(qArt.name) />

		</cffunction>

		<cffunction name="getImagePathByTitle" access="remote" returntype="string">
			<cfargument name="name" type="string">

			<cfset var qGetImage = "" />

				<cfquery name="qGetImage" datasource="#application.dsource#">
					SELECT * FROM products
					<cfif arguments.name neq ''>
						  WHERE name like '%#arguments.name#%'
					<cfelse>
						WHERE 0=1
					  </cfif>
				   </cfquery>

				<cfset thisImagePath = "http://gallart.com/img/#qGetImage.uid#.jpg" />

			<cfreturn thisImagePath />

		</cffunction>

		<cffunction name="getListingsByIdList" access="remote">
			<cfargument name="idlist" type="string">

			<cfset qListings = '' />

				 <cfquery name="qListings" datasource="#application.dsource#">
					SELECT *
					FROM products
					WHERE uid in(#idlist#)
					ORDER BY name
				</cfquery>

			<cfreturn qListings />

		</cffunction>

		<cffunction name="setAllSalePrices" access="remote">
			<cfargument name="priceToReduce" type="string">
			<cfargument name="salePercent" type="string">
			<cfargument name="highEstimate" type="numeric" default="0">
			<cfargument name="removeSale" type="numeric" default="0">

			<cfif arguments.removeSale EQ 1>

				<cfquery name="qListings" datasource="#application.dsource#">
					UPDATE products SET
					closeout = 0
					WHERE active = 1
					AND fk_users is null
				</cfquery>

			<cfelse>

				<cfif arguments.highEstimate EQ 1>

					<cfquery name="qListings" datasource="#application.dsource#">
						UPDATE products SET
						closeout = 1
						WHERE active = 1
						AND fk_users is null
					</cfquery>

					<cfquery name="qListings" datasource="#application.dsource#">
						UPDATE products SET
						use_highestimate = 1
						WHERE active = 1
						AND fk_users is null
						AND high_estimate <> ''
						AND high_estimate is not null
					</cfquery>

				</cfif>

				<cfif arguments.highEstimate EQ 0>

					<cfquery name="qListings" datasource="#application.dsource#">
						UPDATE products SET
						use_highestimate = 0
						WHERE active = 1
						AND fk_users is null
						AND high_estimate <> ''
						AND high_estimate is not null
					</cfquery>

				</cfif>

				<cfif arguments.salePercent NEQ "" AND arguments.highEstimate EQ 0>

					<cfquery name="qListings" datasource="#application.dsource#">
						UPDATE products SET
						closeout = 1
						WHERE active = 1
						AND fk_users is null
					</cfquery>

					<cfquery name="qListings" datasource="#application.dsource#">
						SELECT *
						FROM products
						WHERE active = 1
						AND fk_users is null
						ORDER BY uid
					</cfquery>

					<cfoutput query="qListings">

						<cfif arguments.priceToReduce EQ 'retail'>
							<cfset newSaleVal = retail_price - ((arguments.salePercent*retail_price)/100) />
						   <cfelse>
							<cfset newSaleVal = gallery_price - ((arguments.salePercent*gallery_price)/100) />
						</cfif>

						<cfquery name="qListings" datasource="#application.dsource#">
							UPDATE products SET
							special_price = #newSaleVal#
							WHERE uid = #uid#
						</cfquery>

					</cfoutput>

				</cfif>

			</cfif>

		</cffunction>


	</cfcomponent>
