<cfcomponent displayname ="filemanager" output ="yes">
<cfprocessingdirective pageencoding="utf-8">

<!--- ************************************************************************************ --->
<!--- Add User Authentication here                                                         --->
<!---<cfif not StructKeyExists(session,'userid')><cfabort></cfif>                          --->
<!--- ************************************************************************************ --->

<cfinclude template="/cf_scripts/scripts/ajax/ckeditor/settings.cfm">
<!--- ************************************************************************************ --->
<!--- File manager, get file list                                                          --->
<!--- ************************************************************************************ --->
<cffunction name="getfmfiles" access="remote" returntype="any" output="yes">
	<cfargument name="path" required="No" default="">
	<cfif settings.AllowDirectoryNavigation eq "false">
		<cfset text = "<b>Access is Denied.</b>">
		<cfreturn text>
	</cfif>
	
	<!--- ************************************************************ --->
	<!--- path first position is a friendly name, like [home]. ignore  --->
	<!--- ************************************************************ --->
	<cfset arguments.path	= "/#ListDeleteAt(arguments.path,1,'/\')#">
	<cfif listlen(arguments.path,'\/')>
		<cfset arguments.path	= "#arguments.path#/">
	</cfif>
	
	<!--- ************************************************************ --->
	<!--- Build the Three paths first keep handy                       --->
	<!--- ************************************************************ --->
	<cfset local.filepath	= "#arguments.path#">
	<cfset local.midpath	= "/_middle#arguments.path#">
	<cfset local.thumbpath	= "/_thumb#arguments.path#">
	
	<cfset fullPath = settings.UserFiles & local.filepath>
	<cfset canonicalPath = GetCanonicalPath(fullPath)>
	<cfif left(fullPath, len(settings.UserFiles) neq settings.UserFiles)>
		<cfset fullPath = settings.UserFiles>
	</cfif>
	
	<cfdirectory 
		directory	= "#settings.UserFiles##local.filepath#"
		action		= "list"
		sort		= "type asc, name asc"
		name		= "this.getall">

	<cfif not listlen(arguments.path,'/\')>
		<!--- remove two storage folders from the list --->
		<cfquery name="this.getall" dbtype="query">
			select * from this.getall where name not in ('_thumb','_middle','_recycle_bin')
		</cfquery>
	</cfif>
	
	<cfsavecontent variable="local.list">
	<!--- display folders                    --->
	<cfoutput query="this.getall">
	<cfswitch expression="#this.getall.type#">
		<cfcase value="dir">
			<div class="fmd">
				<cfdirectory directory = "#settings.UserFiles##local.filepath#/#this.getall.name#" action = "list" name = "local.thisdir">
				<cfif local.thisdir.recordCount>
					<img src="images/folder.gif">
				<cfelse>
					<img src="images/folder_empty.gif">
				</cfif>
				<span class="fmname">#EncodeForHTML('#this.getall.name#')#</span>
			</div>
		</cfcase>
	<!--- display files                     ---->
		<cfdefaultcase>
			<cfset local.thumb		= "No">
			<cfif FileExists('#settings.UserFiles##local.thumbpath#/#this.getall.name#')>
				<cfset local.thumb	= "Yes">
			</cfif>
			<cfset local.midle		= "No">
			<cfif FileExists('#settings.UserFiles##local.midpath#/#this.getall.name#')>
				<cfset local.midle	= "Yes">
			</cfif>
			
			<cfset cRoot = GetContextRoot()>
			<cfif cRoot neq "/">
				<cfset encodedUserFilesURL = EncodeForHTMLAttribute('#JSStringFormat('#cRoot&settings.UserFilesURL#')#')>	<!---		--->
			<cfelse>
				<cfset encodedUserFilesURL = EncodeForHTMLAttribute('#JSStringFormat('#settings.UserFilesURL#')#')>
			</cfif>
			
			<cfset encodedFileName = EncodeForHTMLAttribute('#JSStringFormat('#local.filepath##this.getall.name#')#')>
			
			<div class="fmi" data-size="#EncodeForHTMLAttribute('#JSStringFormat(fncFileSize(this.getall.size))#')#">
			<cfif YesNoFormat(local.thumb)>
				<img data-type="image" data-wh="#encodedUserFilesURL#" data-file="#encodedFileName#" class="fmimg" data-thumb="#local.thumb#" data-midle="#local.midle#" src="#encodedUserFilesURL##EncodeForHTMLAttribute('#local.thumbpath##this.getall.name#')#">
			<cfelse>
				<cfset local.fileext = listlast(this.getall.name,'.')>
				
				<cfswitch expression="#local.fileext#">
					<!--- No Thumb :: send the full image               --->
					<cfcase value="jpg,jpeg,png,gif">
						<img data-type="image" data-wh="#encodedUserFilesURL#" data-file="#encodedFileName#" class="fmimg" data-midle="#local.midle#" src="#encodedUserFilesURL##EncodeForHTMLAttribute('/#local.filepath##this.getall.name#')#">
					</cfcase>
					<!--- Not Images :: display icons base on file type --->
					<cfcase value="doc,docx,pdf,,txt,xls,xlsx,ppt,pptx">
						<img data-type="doc" data-wh="#encodedUserFilesURL#" data-file="#encodedFileName#" src="images/#lcase(local.fileext)#.png">
					</cfcase>
					<cfcase value="zip,rar">
						<img data-type="zip" data-wh="#encodedUserFilesURL#" data-file="#encodedFileName#" src="images/#lcase(local.fileext)#.png">
					</cfcase>
					<cfcase value="mp3,wav,avi,mov,wmv,flv,mpeg">
						<img data-type="media" data-wh="#encodedUserFilesURL#" data-file="#encodedFileName#" src="images/#lcase(local.fileext)#.png">
					</cfcase>
					<cfcase value="css,swf,js,php,cfm,cfc,eps,fla,ind,jsf,proj,psd,pst,xml">
						<img data-type="file" data-wh="#encodedUserFilesURL#" data-file="#encodedFileName#" src="images/#lcase(local.fileext)#.png">
					</cfcase>
					<cfdefaultcase>
						<img data-wh="#encodedUserFilesURL#" data-file="#encodedFileName#" src="images/un.png">
					</cfdefaultcase>
				</cfswitch>
			</cfif>
				<span class="fmname" title="#EncodeForHTMLAttribute('#this.getall.name#')#">#EncodeForHTML('#this.getall.name#')#</span>
			</div>
		</cfdefaultcase>
		</cfswitch>
	</cfoutput>
	</cfsavecontent>
	<!--- compress the string a bit --->
	<cfset local.list = reReplace( local.list, "[[:space:]]{2,}", " ", "all" )>
	<cfset local.list = replace( local.list, "> <", "><", "all" )>
	<cfset local.list = '<div id="fmdatalist">#local.list#</div>'>
<cfreturn local.list>
</cffunction>


<!--- ************************************************************************************ --->
<!--- Helpers                                                                              --->
<!--- ************************************************************************************ --->
<cfscript>
// http://cflib.org/udf/fncFileSize
function fncFileSize(size) {
	if ((size gte 1024) and (size lt 1048576)) {
		return round(size / 1024) & "Kb";
	} else if (size gte 1048576) {
		return decimalFormat(size/1048576) & "Mb";
	} else {
		return "#size# b";
	}
}
</cfscript>
</cfcomponent>