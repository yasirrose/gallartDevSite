<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">
<cfquery name="GetuserInfo" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT * FROM tracker WHERE sessionid = '#session.xss#'
</cfquery>
<html>
<head>
	<cfoutput>
		<title>#companyname# - #titletext#</title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
		<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
	</cfoutput>

<cfinclude template="meta.cfm">

<style>
	body {
		background: white;
		color: black;
		font-family: 'Arial', sans-serif;
		min-height: 100vh;
		display: flex;
		flex-direction: column;
	}
	.error-wrapper {
		flex: 1;
		display: flex;
		align-items: center;
		justify-content: center;
		text-align: center;
		padding: 20px;
	}
	.error-box {
		background: rgba(255,255,255,0.1);
		padding: 40px;
		border-radius: 15px;
		box-shadow: 0 4px 20px rgba(0,0,0,0.3);
		animation: fadeIn 1s ease;
	}
	.error-box h1 {
		font-size: 5rem;
		font-weight: bold;
		margin-bottom: 10px;
		color: lightgray;
	}
	.error-box p {
		font-size: 1.5rem;
		color: lightgray;
		margin-bottom: 35px;
	}
	.goback {
		text-decoration: none;
		color: #fff;
		background-color: #ec008c;
		padding: 12px 25px;
		border-radius: 5px;
		transition: all 0.3s ease;
		font-size: 1.1rem;
	}
	.goback:hover {
		background-color: white;
		color: #ec008c;
	}
	@keyframes fadeIn {
		from { opacity: 0; transform: translateY(-20px); }
		to { opacity: 1; transform: translateY(0); }
	}
</style>

<cfoutput>
<script language="JavaScript" src="/js/utils.js"></script>
</cfoutput>

<link href="/stylesheet_.css" rel="stylesheet" type="text/css">

</head>
<body>
	<div class="main-container registration-page">
		<div class="header-section">
			<div class="top-header">
				<cfinclude template="top_.cfm">
			</div>
			<div class="navbar-section">
				<cfinclude template="navbar_.cfm">
			</div>
		</div>

		<cfoutput>
			<cfparam name="url.referrer" default="/">

			<div class="error-wrapper">
				<div class="error-box">
					<i class="fas fa-exclamation-triangle fa-4x mb-3" style="color:lightgray;"></i>
					<h1>404</h1>
					<p>Oops.. Somethings Went Wrong</p>
					<!--- <p><cfoutput>#session.errmsg#</cfoutput></p> --->
					<a href="/" class="goback"><i class="fas fa-home"></i> Go to Homepage</a>

					<button onclick="history.back()" class="goback" style="margin-left:10px;">
						<i class="fas fa-arrow-left"></i> Go Back
					</button>

					<!--- <cfif len(trim(url.referrer))>
						<a href="#url.referrer#" class="goback" style="margin-left:10px;">
							<i class="fas fa-arrow-left"></i> Go Back
						</a>
					</cfif> --->

				</div>
			</div>
		</cfoutput>

		

		<!--- <cfset structDelete(session, "errorMessage", false)> --->

		<cfinclude template="footer_.cfm">
	</div>
</body>
</html>
