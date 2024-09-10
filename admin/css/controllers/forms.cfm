<!--- include main top layout --->
<cfinclude template="../views/layout.top.cfm" />

<!--- get the Action from the event --->
<cfset Action = listlast(URL.event, '.') />
<!--- remove url string --->
<cfset Action = listfirst(action,'&') />

<cfset ViewPath = "../views/forms" />

<cfif session.loggedin EQ false AND listFirst(event,'.') eq "forms">
	<cflocation url="index.cfm?logout=1" addtoken="No">
</cfif>

<script src="scripts/functions.js" type="text/javascript"></script>
	
<cfswitch expression="#Action#">

	<cfcase value="coa">
	
		<!--- from listings module --->
		<cfif isDefined('url.listingId')>
		
			<cfscript>
				getListing = application.objectFactoryAdmin.getInstance('art').getListingFromId(url.listingId);
				getImagePathByTitle = application.objectFactoryAdmin.getInstance('art').getImagePathByTitle(getListing['NAME']);
				
			</cfscript>
			
			<cfset form.artist 	= getListing['MANUFACTURER'] />
			<cfset form.title 	= getListing['NAME'] />
			<cfset form.medium 	= getListing['PATH'] />
			<cfset form.size 	= getListing['SIZE'] />
			<cfset form.edition = getListing['EDITION'] />
			<cfset form.year 	= getListing['YEAR'] />
			<cfset form.artist 	= getListing['MANUFACTURER'] />
            
            <script type="text/javascript">
				document.getElementById('imageDisplay').src = '<cfoutput>#getImagePathByTitle#</cfoutput>';
				document.getElementById('imagePath').value = '<cfoutput>#getImagePathByTitle#</cfoutput>';
			
			</script>
		
		<cfelse>
			
			<cfset form.artist 	= "" />
			<cfset form.title 	= "" />
			<cfset form.medium 	= "" />
			<cfset form.size 	= "" />
			<cfset form.edition = "" />
			<cfset form.year 	= "" />
			<cfset form.artist 	= "" />
		
		</cfif>
	
		<cfinclude template="#ViewPath#/coa.cfm">

		
	
	</cfcase>
	
	<cfcase value="coaPdf">
	
		<cfif isDefined('form.imagePath') and form.imagePath NEQ "">

		        
	        <cfimage 
	        	action="read" 
	        	source="#expandpath('..')#\img\#ListLast(form.imagePath,"/")#" 
	        	name="oImage" 
	        />
	
			<cfimage
				action="resize"
				source="#oImage#"
				width="130"
				height=""
				name="oImageSmall"
			/>
	       
	       	<cfimage
				action="WRITE"
				source="#oImageSmall#"
				destination="#expandpath('.')#\images\forms\coa.jpg"
				overwrite="true"
			/>
			
		<cfelseif isDefined('form.coa_image') and form.coa_image NEQ "">
		
			<cffile action="upload" nameconflict="OVERWRITE" filefield="coa_image" destination="#expandpath('.')#\images\forms\coa.jpg" result="fileupload">
	
			<cfif fileupload.fileWasSaved>
		        
		        <cfimage 
		        	action="read" 
		        	source="#expandpath('.')#\images\forms\coa.jpg" 
		        	name="oImage" 
		        />
		
				<cfimage
					action="resize"
					source="#oImage#"
					width="130"
					height=""
					name="oImageSmall"
				/>
		       
		       	<cfimage
					action="WRITE"
					source="#oImageSmall#"
					destination="#expandpath('.')#\images\forms\coa.jpg"
					overwrite="true"
				/>
			
			</cfif>
						
		</cfif>
	
		<cfinclude template="#ViewPath#/coa_pdf.cfm">
	
	</cfcase>
	
	<cfcase value="coa_generic">
	
		<cfinclude template="#ViewPath#/coa_generic.cfm">
	
	</cfcase>
	
	<cfcase value="coa_generic_Pdf">
	
		<cfif isDefined('form.imagePath') and form.imagePath NEQ "">
		        
	        <cfimage 
	        	action="read" 
	        	source="#expandpath('..')#\img\#ListLast(form.imagePath,"/")#" 
	        	name="oImage" 
	        />
	
			<cfimage
				action="resize"
				source="#oImage#"
				width="130"
				height=""
				name="oImageSmall"
			/>
	       
	       	<cfimage
				action="WRITE"
				source="#oImageSmall#"
				destination="#expandpath('.')#\images\forms\coa.jpg"
				overwrite="true"
			/>
			
		<cfelseif isDefined('form.coa_image') and form.coa_image NEQ "">
		
			<cffile action="upload" nameconflict="OVERWRITE" filefield="coa_image" destination="#expandpath('.')#\images\forms\coa.jpg" result="fileupload">
	
			<cfif fileupload.fileWasSaved>
		        
		        <cfimage 
		        	action="read" 
		        	source="#expandpath('.')#\images\forms\coa.jpg" 
		        	name="oImage" 
		        />
		
				<cfimage
					action="resize"
					source="#oImage#"
					width="130"
					height=""
					name="oImageSmall"
				/>
		       
		       	<cfimage
					action="WRITE"
					source="#oImageSmall#"
					destination="#expandpath('.')#\images\forms\coa.jpg"
					overwrite="true"
				/>
			
			</cfif>
						
		</cfif>
	
		<cfinclude template="#ViewPath#/coa_generic_pdf.cfm">
	
	</cfcase>
	
		
	<cfcase value="appraisal">
	
		<cfinclude template="#ViewPath#/appraisal.cfm">
	
	</cfcase>
	
	<cfcase value="appraisalPdf">
	
		<cfif isDefined('form.imagePath') and form.imagePath NEQ "">
		        
	        <cfimage 
	        	action="read" 
	        	source="#expandpath('..')#\img\#ListLast(form.imagePath,"/")#"
	        	name="oImage" 
	        />
	
			<cfimage
				action="resize"
				source="#oImage#"
				width="130"
				height=""
				name="oImageSmall"
			/>
	       
	       	<cfimage
				action="WRITE"
				source="#oImageSmall#"
				destination="#expandpath('.')#\images\forms\appraisal.jpg"
				overwrite="true"
			/>
			
		<cfelseif isDefined('form.appraisal_image') and form.appraisal_image NEQ "">
				
			<cffile action="upload" nameconflict="OVERWRITE" filefield="appraisal_image" destination="#expandpath('.')#\images\forms\appraisal.jpg" result="fileupload">
	
			<cfif fileupload.fileWasSaved>
		        
		        <cfimage 
		        	action="read" 
		        	source="#expandpath('.')#\images\forms\appraisal.jpg" 
		        	name="oImage" 
		        />
		
				<cfimage
					action="resize"
					source="#oImage#"
					width="130"
					height=""
					name="oImageSmall"
				/>
		       
		       	<cfimage
					action="WRITE"
					source="#oImageSmall#"
					destination="#expandpath('.')#\images\forms\appraisal.jpg"
					overwrite="true"
				/>
			
			</cfif>
						
		</cfif>
	
		<cfinclude template="#ViewPath#/appraisal_pdf.cfm">
	
	</cfcase>
	
	<cfcase value="appraisal_generic">
	
		<cfinclude template="#ViewPath#/appraisal_generic.cfm">
	
	</cfcase>
	
	<cfcase value="appraisal_generic_Pdf">
	
		<cfif isDefined('form.imagePath') and form.imagePath NEQ "">
		        
	        <cfimage 
	        	action="read" 
	        	source="#expandpath('..')#\img\#ListLast(form.imagePath,"/")#"
	        	name="oImage" 
	        />
	
			<cfimage
				action="resize"
				source="#oImage#"
				width="130"
				height=""
				name="oImageSmall"
			/>
	       
	       	<cfimage
				action="WRITE"
				source="#oImageSmall#"
				destination="#expandpath('.')#\images\forms\appraisal.jpg"
				overwrite="true"
			/>
			
		<cfelseif isDefined('form.appraisal_image') and form.appraisal_image NEQ "">
				
			<cffile action="upload" nameconflict="OVERWRITE" filefield="appraisal_image" destination="#expandpath('.')#\images\forms\appraisal.jpg" result="fileupload">
	
			<cfif fileupload.fileWasSaved>
		        
		        <cfimage 
		        	action="read" 
		        	source="#expandpath('.')#\images\forms\appraisal.jpg" 
		        	name="oImage" 
		        />
		
				<cfimage
					action="resize"
					source="#oImage#"
					width="130"
					height=""
					name="oImageSmall"
				/>
		       
		       	<cfimage
					action="WRITE"
					source="#oImageSmall#"
					destination="#expandpath('.')#\images\forms\appraisal.jpg"
					overwrite="true"
				/>
			
			</cfif>
						
		</cfif>
	
		<cfinclude template="#ViewPath#/appraisal_generic_Pdf.cfm">
	
	</cfcase>
	
	<cfcase value="framing">
	
		<cfinclude template="#ViewPath#/framing.cfm">
	
	</cfcase>
	
	<cfcase value="framingPdf">
	
		<cfinclude template="#ViewPath#/framing_pdf.cfm">
	
	</cfcase>
	
</cfswitch>

<!--- include main bottom layout --->
<cfinclude template="../views/layout.bottom.cfm" />