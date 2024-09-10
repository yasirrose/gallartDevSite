<cfcomponent displayname="objectFactory" hint="I manage objects">

	<!--- 
		function init
		in:		
		out:	this
		notes:	scope usually points to session
	 --->
	<cffunction name="init" access="public" output="No" returntype="objectFactory">
		<cfscript>
			// persistance of objects
			variables.com = structNew();
		</cfscript>

		<cfreturn this />
	</cffunction>

	<!--- 
		function createObj
		in:		name of object
		out:	object
		notes:	abstact. to be extended
	 --->
	<cffunction name="createObj" access="public" output="No" returntype="any">
		<cfargument name="objName" required="Yes" />
	</cffunction>
	
	
	<!--- 
		function getInstance
		in:		name of object
		out:	object
		notes:	create a persistant object if doen not previously exists
	 --->
	<cffunction name="getInstance" access="public" output="No" returntype="any">
		<cfargument name="objName" required="Yes" />
		
		<cfscript>
			if ( not StructKeyExists(variables.com, arguments.objName) ){
				variables.com[arguments.objName] = createObj(arguments.objName);
			}
			
			return variables.com[arguments.objName];
		</cfscript>
	</cffunction>

	<cffunction name="removeInstance" access="public" output="No" returntype="void">
		<cfargument name="objName" required="Yes" />
	
		<cfscript>
			if ( StructKeyExists(variables.com, arguments.objName) ){
				structDelete(variables.com, arguments.objName);
			}
		</cfscript>
	</cffunction>

</cfcomponent>