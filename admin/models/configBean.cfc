<cfcomponent displayname="configBean" hint="I store config data">

	<!--- 
		function init
		in:		OF
		out:	this
		notes:	scope usually points to session
	 --->
	<cffunction name="init" access="public" output="No" returntype="configBean">
		<cfargument name="objectFactory" required="Yes" />
	
		<cfscript>
			// hold components
			variables.com = structNew();
			
			// objectFactory
			variables.com.objectFactory = arguments.objectFactory;

			// initialize database variables
			setdsource( application.dsource );
			setdbuname( application.dbuname );
			setdbpword( application.dbpword );
			setrootpath( application.rootpath );
			setvmap( application.vmap );
			setmailserver( application.mailserver );
		</cfscript>

		<cfreturn this />
	</cffunction>
	
	<cffunction name="setdsource" returntype="void">
		<cfargument name="dsource">
		<cfset variables.instance.dsource = arguments.dsource />
	</cffunction>

	<cffunction name="getdsource" returntype="string">
		<cfreturn variables.instance.dsource />
	</cffunction>

	<cffunction name="setdbuname" returntype="void">
		<cfargument name="dbuname">
		<cfset variables.instance.dbuname = arguments.dbuname />
	</cffunction>

	<cffunction name="getdbuname" returntype="string">
		<cfreturn variables.instance.dbuname />
	</cffunction>

	<cffunction name="setdbpword" returntype="void">
		<cfargument name="dbpword">
		<cfset variables.instance.dbpword = arguments.dbpword />
	</cffunction>

	<cffunction name="getdbpword" returntype="string">
		<cfreturn variables.instance.dbpword />
	</cffunction>

	<cffunction name="setrootpath" returntype="void">
		<cfargument name="rootpath">
		<cfset variables.instance.rootpath = arguments.rootpath />
	</cffunction>

	<cffunction name="getrootpath" returntype="string">
		<cfreturn variables.instance.rootpath />
	</cffunction>

	<cffunction name="setvmap" returntype="void">
		<cfargument name="vmap">
		<cfset variables.instance.vmap = arguments.vmap />
	</cffunction>

	<cffunction name="getvmap" returntype="string">
		<cfreturn variables.instance.vmap />
	</cffunction>
	
	<cffunction name="setmailserver" returntype="void">
		<cfargument name="mailserver">
		<cfset variables.instance.mailserver = arguments.mailserver />
	</cffunction>

	<cffunction name="getmailserver" returntype="string">
		<cfreturn variables.instance.mailserver />
	</cffunction>
	
	
	
</cfcomponent>