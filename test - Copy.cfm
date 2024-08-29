

<!--- <CFQUERY NAME="test" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
insert into users
(fname,lname,email,password)
values
('Steve','Rucker','steve@rekal.net','1234')
</CFQUERY> --->

<!--- <CFQUERY NAME="test"  datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
CREATE TABLE [dbo].[users] (
	[pk_users] [int] IDENTITY (1, 1) NOT NULL ,
	[fname] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[lname] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]


</CFQUERY> --->

<!--- <CFQUERY NAME="test"  datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
CREATE TABLE users
(
	fname varchar(255),
	lname varchar(255),
	email varchar(255),
	password varchar(255),
	pk_users int IDENTITY (1, 1) NOT NULL 

)
</CFQUERY> --->

<!--- <CFQUERY NAME="test" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
insert into users
(fname,lname,email,password)
values
('Steve','Rucker','steve@rekal.net','1234')
</CFQUERY>

<CFQUERY NAME="test" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
select * from users
</CFQUERY>
<cfdump var="#test#"><cfabort>  --->

<!--- <CFQUERY NAME="test" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
ALTER TABLE products ADD fk_users INT
</CFQUERY> --->

<!--- <CFQUERY NAME="test" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
delete from users
where pk_users = 13
</CFQUERY> --->

<!--- <CFQUERY NAME="test" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
ALTER TABLE products ADD quantity INT
</CFQUERY> --->

<!--- <CFQUERY NAME="test" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
ALTER TABLE products ADD 
high_estimate VARCHAR(255)
</CFQUERY> --->

<!--- <CFQUERY NAME="test" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
select TOP 5 * from products
</CFQUERY>

<cfdump var="#test#"><cfabort> --->

<!--- <cfmail server="#servername#" from="steve@rekal.net" to="steve@rekal.net"  type="html" subject="New Test Placed">
<br><br>
<img src="http://www.onlinegalleryart.com/WOLFRYDEXHIBITON.jpg">
An order was placed on #DateFormat(createodbcdate(now()),"mmm dd, yyyy")#.

</cfmail> --->

<!--- <cfquery name="productinfo" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	delete from tracker
	where createdon < #dateadd('m',-1,createodbcdate(now()))#
</cfquery> --->

<!--- <cfquery name="productinfo" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	select * from tracker
</cfquery>

<cfdump var="#productinfo.recordcount#"><cfabort> --->


<!--- <CFQUERY NAME="test" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
ALTER TABLE products ADD 
turbolister_desc TEXT
</CFQUERY>
 --->
 
<!--- <CFQUERY NAME="test"  datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
CREATE TABLE optout
(
	pk_optout int IDENTITY (1, 1) NOT NULL,
	datestamp DATETIME DEFAULT (getdate()),
	email varchar(1000)

)
</CFQUERY>--->
 
<!--- <cfmail server="#application.email_server#" username="#application.email_username#"
password="#application.email_password#" to="ruckerstev@hotmail.com" from="info@gallart.com" subject="Gallery Art" type="HTML">
test #createodbcdatetime(now())#
</cfmail>	

<!--- mail sent --->

<CFQUERY NAME="data" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT * from products
	order by uid desc
</CFQUERY>
<cfoutput>
<cfloop query="data">
	<cfif len(fk_users)>
	
		<CFQUERY datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
			UPDATE products SET
			modelno = '#replacenocase(modelno,'G','S')#'
			WHERE uid = #uid#
		</CFQUERY>
	
	</cfif>

</cfloop>
</cfoutput> --->

<!--- 


<CFQUERY name="data" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT * from guests
	order by entrynumber
</CFQUERY>

<cfloop query="data">

<CFQUERY name="data" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	INSERT into leads
	(
	pk_leads,
	fk_employees,
	datestamp,
	fname,
	lname,
	email,
	phone,
	address,
	city,
	state,
	country,
	zip,
	artists,
	titles,
	notes,
	maillist,
	optout
	
	)
	values
	(
	#EntryNumber#,
	'0',
	'#dateFormat(Date)# #timeFormat(Date)#',
	'#fname#',
	'#lname#',
	'#email#',
	'',
	'',
	'',
	'',
	'',
	'',
	'',
	'',
	'#notes#',
	'#maillist#',
	<cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" null="Yes" value="#optout#">
	)	
</CFQUERY>

</cfloop> --->

<!---<CFQUERY NAME="test"  datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
CREATE TABLE ebay
(
	fname varchar(255),
	lname varchar(255),
	email varchar(255),
	artist varchar(255),
	datestamp datetime,
	comments varchar(2000),
	pk_ebay int IDENTITY (1, 1) NOT NULL 

)
</CFQUERY>--->

<!---<CFQUERY NAME="test"  datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
CREATE TABLE ebay_uploads
(
	fk_ebay int,
	serverfile varchar(255),
	pk_ebay_uploads int IDENTITY (1, 1) NOT NULL 

)
</CFQUERY>--->

<!---<CFQUERY NAME="test"  datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	UPDATE orders SET employee_email = ''
</CFQUERY><cfdump var="#test#" /><cfabort>--->

<!---<CFQUERY NAME="test"  datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
CREATE TABLE employee_email
(
	pk_employee_email int IDENTITY (1, 1) NOT NULL,
	fk_employee int,
	datestamp datetime,
	emailContent varchar(5000)

)
</CFQUERY>--->

<!---<CFQUERY NAME="test" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
ALTER TABLE orders ADD 
fk_employee_email int
</CFQUERY>

<CFQUERY NAME="test" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
ALTER TABLE leads ADD 
fk_employee_email int
</CFQUERY>--->


<!---<CFQUERY NAME="data"  datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	UPDATE orders SET
	fk_employee_email = null,
	employee_email = null
	WHERE fk_employees = #session.userinfo.pk_employees#
		
</CFQUERY>--->

<!---<CFQUERY NAME="data"  datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
drop table optout
</CFQUERY>--->

<!---<CFQUERY NAME="test"  datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
CREATE TABLE optout
(
	pk_optout int IDENTITY(1,1)PRIMARY KEY,
	datestamp DATETIME DEFAULT (getdate()),
	email varchar(1000)

)
</CFQUERY>--->

<!---<CFQUERY NAME="test"  datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
CREATE TABLE sellers_archive
(
	pk_sellers_archive int IDENTITY(1,1)PRIMARY KEY,
	fname varchar(500),
    lname varchar(500),
    email varchar(1000),
    password varchar(500),
    phone varchar(500),
    cellPhone varchar(500),
    businessPhone varchar(500),
    website varchar(500),
    maillist varchar(500),
    optout varchar(500)
)
</CFQUERY>--->

<!--- <CFQUERY NAME="test"  datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
CREATE TABLE epricing
(
	pk_epricing int IDENTITY(1,1)PRIMARY KEY,
	fk_customers varchar(255),
	fk_products varchar(255),
    epricing_phone varchar(500),
    email varchar(1000),
    comments varchar(4000),
    best_time varchar(500),
    email_only tinyint,
    datestamp DATETIME DEFAULT (getdate())
)
</CFQUERY> --->



<!--- <CFQUERY NAME="test" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
ALTER TABLE customers ADD 
otherphone VARCHAR(255)
</CFQUERY> --->

<!--- <CFQUERY NAME="test" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
ALTER TABLE epricing ADD 
otherphone VARCHAR(255)
</CFQUERY> --->

<!--- <CFQUERY NAME="test" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
ALTER TABLE customers ADD 
cellphone_formatted tinyint,
businessphone_formatted tinyint
</CFQUERY> 

<CFQUERY NAME="test" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
ALTER TABLE users ADD 
cellphone_formatted tinyint,
businessphone_formatted tinyint
</CFQUERY> 

<CFQUERY NAME="test" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
ALTER TABLE leads ADD 
cellphone_formatted tinyint,
businessphone_formatted tinyint
</CFQUERY> 

<CFQUERY NAME="data1" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
select top 1 * from customers
</CFQUERY> 

<CFQUERY NAME="data2" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
select top 1 * from users
</CFQUERY> 

<CFQUERY NAME="data3" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
select top 1 * from leads
</CFQUERY> 

<cfdump var="#data1#">
<cfdump var="#data2#">
<cfdump var="#data3#"> --->

<!--- <CFQUERY NAME="data3" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
update leads SET
phone_formatted = 1
where phone = ''	
</CFQUERY> 
<CFQUERY NAME="data3" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
update leads SET
cellphone_formatted = 1
where cellphone = ''	
</CFQUERY> 
<CFQUERY NAME="data3" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
update leads SET
businessphone_formatted = 1
where businessphone = ''	
</CFQUERY> 

<CFQUERY NAME="data2" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
select top 100  phone, phone_formatted, cellphone, cellphone_formatted, businessphone, businessphone_formatted  from leads
order by pk_leads desc
</CFQUERY> 

<cfdump var="#data2#"> --->

<!--- <CFQUERY NAME="test"  datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
CREATE TABLE users_test
(
	phone varchar(255),
	cellphone varchar(255),
	businessphone varchar(255),
	phone_formatted tinyint,
	cellphone_formatted tinyint,
	businessphone_formatted tinyint,
	pk_users int IDENTITY (1, 1) NOT NULL 

)
</CFQUERY> --->

<!--- <CFQUERY NAME="test"  datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
CREATE TABLE customers_test
(
	phone varchar(255),
	cellphone varchar(255),
	businessphone varchar(255),
	phone_formatted tinyint,
	cellphone_formatted tinyint,
	businessphone_formatted tinyint,
	id int IDENTITY (1, 1) NOT NULL 

)
</CFQUERY>

<CFQUERY NAME="test"  datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
CREATE TABLE users_test
(
	phone varchar(255),
	cellphone varchar(255),
	businessphone varchar(255),
	phone_formatted tinyint,
	cellphone_formatted tinyint,
	businessphone_formatted tinyint,
	pk_leads int IDENTITY (1, 1) NOT NULL 

)
</CFQUERY> --->

<!--- <CFQUERY NAME="data3" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
delete from users_test	
</CFQUERY> 

<cfloop from="1" to="5" index="idx">

	<CFQUERY NAME="insert" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	INSERT INTO users_test
	(phone,cellphone)
	values
	('98987987','381273948721')
	</CFQUERY>

	<CFQUERY NAME="insert" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	INSERT INTO users_test
	(cellphone, businessphone)
	values
	('2222222222','872348712634')
	</CFQUERY>

	<CFQUERY NAME="insert" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	INSERT INTO users_test
	(businessphone,phone)
	values
	('11111111','')
	</CFQUERY>

</cfloop> --->

<!--- <CFQUERY NAME="data3" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
update customers SET
phone_formatted = 1
where phone = ''
or phone is null	
</CFQUERY> 
<CFQUERY NAME="data3" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
update customers SET
cellphone_formatted = 1
where cellphone = ''
or cellphone is null		
</CFQUERY> 
<CFQUERY NAME="data3" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
update customers SET
businessphone_formatted = 1
where businessphone = ''
or businessphone is null		
</CFQUERY>

<CFQUERY NAME="data3" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
update leads SET
phone_formatted = 1
where phone = ''
or phone is null	
</CFQUERY> 
<CFQUERY NAME="data3" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
update leads SET
cellphone_formatted = 1
where cellphone = ''
or cellphone is null		
</CFQUERY> 
<CFQUERY NAME="data3" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
update leads SET
businessphone_formatted = 1
where businessphone = ''
or businessphone is null		
</CFQUERY>


<CFQUERY NAME="data3" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
update users SET
phone_formatted = 1
where phone = ''
or phone is null	
</CFQUERY> 
<CFQUERY NAME="data3" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
update users SET
cellphone_formatted = 1
where cellphone = ''
or cellphone is null		
</CFQUERY> 
<CFQUERY NAME="data3" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
update users SET
businessphone_formatted = 1
where businessphone = ''
or businessphone is null		
</CFQUERY> --->



<!--- <CFQUERY NAME="data" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
UPDATE customers_test SET
phone_formatted = null,
cellphone_formatted = null,
businessphone_formatted = null
</CFQUERY>  --->
<!--- <CFQUERY NAME="data3" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
update customers_test SET
phone_formatted = 1
where phone = ''
or phone is null	
</CFQUERY>  --->

<!--- <CFQUERY NAME="insert" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	INSERT INTO leads
	(fname, lname, email, phone, cellphone, businessphone, otherphone)
	values
	('Test','Person','test@test.com','98987987','+44 987987987','89985454','')
</CFQUERY> --->

<!--- <CFQUERY NAME="data" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
UPDATE leads SET
phone_formatted = null,
cellphone_formatted = null,
businessphone_formatted = null
where email = 'test@test.com'
</CFQUERY> --->

<!--- <cfsetting requestTimeout="10000" />

<!--- 1069751 --->

<!--- <cfquery name="data" datasource="#dsource#">
	delete from mailer
</cfquery> --->

<cfquery name="data" datasource="#dsource#">
	select * from mailer
	order by id desc
</cfquery>

<cfoutput>#data.recordcount#</cfoutput> --->

<!--- <cfdump var="#data#"> --->

<!--- <cfquery name="qListings" datasource="#application.dsource#" timeout="60000">
	SELECT top 10 uid, modelno as ModelNo, manufacturer as Artist, path as Medium, gallery_price as GalleryPrice, name as Title FROM products P
	WHERE fk_users is null
	AND P.active = 1
	ORDER by P.manufacturer
</cfquery>

<cfoutput>
#SerializeJSON(qListings,true)#
</cfoutput> --->

<!--- <cfquery name="data" datasource="#dsource#">
	delete from mailer
</cfquery> --->

<!--- <CFQUERY NAME="test"  datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
CREATE TABLE camera
(
	location varchar(255),
	camera_name varchar(255),
	camera_number int,
	pk_camera int IDENTITY (1, 1) NOT NULL 

)
</CFQUERY> --->

<!--- <CFQUERY datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
insert into camera 
	(camera_name,camera_number,location)
	values
	('center',7,'')
</CFQUERY> --->

<!--- <CFQUERY datasource='#dsource#' dbtype='ODBC' username='#uname#' password='#pword#'>
update employees SET
	roles = 'sa,international',
	sa = 1
where pk_employees = 38
</CFQUERY> --->

<!--- <CFQUERY name="data" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
insert into roles
	(Role)
	values
	('b orders')
</CFQUERY> --->

<!--- <CFQUERY NAME="test"  datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
CREATE TABLE purchases_consignments
(
	fname varchar(255),
	lname varchar(255),
	phone varchar(255),
	email varchar(255),
	image_name varchar(255),
	artist varchar(255),
	title varchar(255),
	medium varchar(255),
	size varchar(255),
	additional_details varchar(5000),
	pk_purchases_consignments int IDENTITY (1, 1) NOT NULL 
)
</CFQUERY> --->

<!--- <CFQUERY NAME="test" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
ALTER TABLE purchases_consignments ADD 
count tinyint,
datestamp DATETIME NOT NULL DEFAULT (GETDATE())
</CFQUERY>  --->

<CFSET this_id = 65 />

<CFQUERY NAME="import_name" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT top 1 * from email_imports_list
	WHERE pk_email_imports_list = #this_id#
</CFQUERY> 



<!--- <CFQUERY NAME="ml_export" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT top 5 * from mailinglist_export
</CFQUERY>  --->

<CFQUERY NAME="imports" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT * from email_imports where email = 'abelled012@yahoo.com'
</CFQUERY> 

<!--- <CFQUERY NAME="import_list" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT * from email_imports_list where email = "abelled012@yahoo.com"
</CFQUERY>  --->


<!--- <cfdump var="#imports#"> --->

<cfdump var="#imports#">





	
















	


















