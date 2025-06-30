<cfoutput>
<footer>
	<div class="footer-container">
		<div class="footer-wrapper">
			<div class="top-footer">
				<a href="index.cfm<cfif parameterexists(xss)>?xss=#xss#</cfif>">HOME</a>
				<cfif NOT structKeyExists(session, 'sellerinfo')>
					<a href="user_login_page.cfm<cfif parameterexists(xss)>?xss=#xss#</cfif>">LOG IN</a>
				 <cfelse>
					<a href="logout.cfm<cfif parameterexists(xss)>?xss=#xss#</cfif>">LOG OUT</a>
				</cfif> 
				<!--- <a href="logout.cfm<cfif parameterexists(xss)>?xss=#xss#</cfif>">LOG OUT</a> --->
			</div>
			<div class="bottom-footer">
				<p>copyright #year(createodbcdate(now()))# www.gallart.com</p>
			</div>
		</div>
	</div>
</footer>
</cfoutput>
