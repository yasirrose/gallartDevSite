<cfoutput>
    <table border="0" cellpadding="0" cellspacing="0" width="90%">
        <tr>
            <td valign="top"><br>
                <h3>EXPORT INVENTORY TO CSV</h3>
                <br>
                <cfif isDefined('form.artists')>
    
                    <cfparam name="form.displayFields" default="" />
            
                     <iframe src="index.cfm?event=exports.createCSVFile&artists=#form.artists#&displayFields=#form.displayFields#" frameborder="0"></iframe>
        
                 <cfelse>
                
                    <form method="post" action="index.cfm?event=exports.artistsCsv" onsubmit="return validateAndDisable(this)">
                        <table>
                            <tr>
                                <td valign="top">
                                    <table cellspacing="0" cellpadding="0" border="0" width="100%">
                                        <tr>
                                            <td>
                                                <strong>ENTER LIST OF ARTIST NAMES:</strong>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <textarea name="artists" cols="40" rows="5"></textarea>
                                            </td>                                            
                                        </tr>
                                         <tr>
                                            <td>
                                                <input type="Submit" value="CREATE CSV LISTING" name="create">
                                                &nbsp;&nbsp;&nbsp;
                                                <input type="Button" value="Back" onclick="location.href='index.cfm?event=exports.artistsCsv'" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <!--- <td>
                                    <table cellspacing="0" cellpadding="0" border="0" width="100%">
                                        <tr>
                                            <td>
                                                <input type="Submit" value="CREATE CSV LISTING" name="create">
                                            </td>
                                        </tr>
                                    </table>
                                </td> --->
                            </tr>
                        </table>
                    </form>
                </cfif>
            </td>
        </tr>
        <!--- <tr>
            <td valign="top">
                <input type="Button" value="Back" onclick="location.href='index.cfm?event=exports.artistsCsv'" />
            </td>
        </tr> --->
        
    </table>
       
    <script>

        function validateAndDisable(frm) {

			// ----------- Validation -----------
			var artists = frm.artists.value.trim();
			// var checkboxes = frm.querySelectorAll("input[name='displayFields']:checked");

			if (artists === "") {
				alert("Please add artist.");
				return false;
			}

			
			// if (checkboxes.length === 0) {
			// 	alert("Please check at least one field name.");
			// 	return false;
			// }

			// ----------- If valid → disable button -----------
			disableSubmit(frm);
			return true; // submit form
		}

        function disableSubmit(form) {
            const button = form.querySelector('input[type="submit"]');
            button.disabled = true;
            button.value = "Processing...";
        }
    </script>
    
</cfoutput>