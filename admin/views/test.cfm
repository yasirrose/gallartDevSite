<!---<cfquery name="customers" datasource="#application.dsource#"> 
	SELECT count(emp_lname) as employee_count,emp_lname from orders O
	INNER JOIN employees E on O.fk_employees = E.pk_employees
	group by emp_lname
</cfquery>

<cfquery name="leads" datasource="#application.dsource#"> 
	SELECT count(emp_lname) as employee_count,emp_lname from leads L
	INNER JOIN employees E on L.fk_employees = E.pk_employees
	group by emp_lname
</cfquery>


EMPLOYEE_COUNT 	PK_EMPLOYEES
1 	3306 	9
2 	61 	3
3 	9 	6
4 	503 	1
5 	524 	24
6 	546 	4
7 	19 	25
8 	198 	5
9 	1 	22
10 	31 	2
11 	9 	17
12 	1 	28
13 	430 	14 

--->
<cfset empId = 1 />
<!---<cfquery name="data" datasource="#application.dsource#"> 
SELECT DISTINCT email, lname, fname from
	(
		SELECT lname,fname,email from orders O
		INNER JOIN employees E on O.fk_employees = E.pk_employees
		WHERE E.pk_employees = #empId#
		AND email is not null
		AND email <> ''
		UNION
		SELECT lname,fname,email from leads L
		INNER JOIN employees E on L.fk_employees = E.pk_employees
		WHERE E.pk_employees = #empId#
		AND email is not null
		AND email <> ''
	)E
</cfquery>--->

<!---<cfquery name="data" datasource="#application.dsource#"> 
	update orders set 
	customerID = 
	where orderuid = 1748
</cfquery>--->

<cfquery name="qArtists" datasource="#application.dsource#"> 
   	SELECT distinct manufacturer FROM products
	ORDER BY manufacturer
</cfquery>

<cfloop query="qArtists">

	<cfquery name="data" datasource="#application.dsource#" maxrows="1"> 
	   	SELECT bio from bios
	   	WHERE bios.artist = '#manufacturer#'
	</cfquery>

	<cfoutput>
		#manufacturer#</br>
		#data.bio#
	</cfoutput>
	
</cfloop>


