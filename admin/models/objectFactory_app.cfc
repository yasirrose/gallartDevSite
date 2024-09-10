<cfcomponent displayname="objectFactory_app" hint="I manage application objects" extends="objectFactory">

	<!--- 
		function getObject
		in:		name of object
		out:	object
		notes:	
	 --->
	<cffunction name="createObj" access="public" output="No" returntype="any">
		<cfargument name="objName" required="Yes" />
		
		<cfscript>
			switch(arguments.objName) {
			
				case "configBean":
					return createObject('component','configBean').init(this);
				break;
				
				case "orders":
					return createObject('component','orders').init(this);
				break;
				
				case "employees":
					return createObject('component','employees').init(this);
				break;
				
				case "roles":
					return createObject('component','roles').init(this);
				break;
				
				case "customers":
					return createObject('component','customers').init(this);
				break;
				
				case "leads":
					return createObject('component','leads').init(this);
				break;
				
				case "quotes":
					return createObject('component','quotes').init(this);
				break;
				
				case "events":
					return createObject('component','events').init(this);
				break;
				
				case "appraisals":
					return createObject('component','appraisals').init(this);
				break;
				
				case "art":
					return createObject('component','art').init(this);
				break;
				
				case "makeoffer":
					return createObject('component','makeoffer').init(this);
				break;
				
				case "mailer":
					return createObject('component','mailer').init(this);
				break;
				
				case "users":
					return createObject('component','users').init(this);
				break;
				
				case "pages":
					return createObject('component','pages').init(this);
				break;
				
				case "email":
					return createObject('component','email').init(this);
				break;
				
				case "artists":
					return createObject('component','artists').init(this);
				break;
				
				case "requests":
					return createObject('component','requests').init(this);
				break;
				
				case "sales":
					return createObject('component','sales').init(this);
				break;
				
				case "mail_log":
					return createObject('component','mail_log').init(this);
				break;
				
				case "reports":
					return createObject('component','reports').init(this);
				break;
				
				case "all_contacts":
					return createObject('component','all_contacts').init(this);
				break;
				
				case "bios":
					return createObject('component','bios').init(this);
				break;
				
				case "ebay":
					return createObject('component','ebay').init(this);
				break;

				case "campaign":
					return createObject('component','campaign').init(this);
				break;

				case "epricing":
					return createObject('component','epricing').init(this);
				break;

				case "phoneformat":
					return createObject('component','phoneformat').init(this);
				break;

				case "cameras":
					return createObject('component','cameras').init(this);
				break;

				case "purchases_consignments":
					return createObject('component','purchases_consignments').init(this);
				break;

				case "email_imports":
					return createObject('component','email_imports').init(this);
				break;
			}
		</cfscript>
		
	</cffunction>

</cfcomponent>