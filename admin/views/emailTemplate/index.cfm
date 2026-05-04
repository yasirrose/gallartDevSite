<cfajaxproxy cfc="admin.models.customers" />
<cfhtmlhead text='<script type="text/javascript" src="/admin/scripts/customers.js.cfm" language="JavaScript"></script>'>

<tr>
<td valign="top">

    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CKEditor 5 Integration</title>
        <script src="https://cdn.ckeditor.com/ckeditor5/39.0.1/classic/ckeditor.js"></script>
        <!--- <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-u7e5khyithlIdTpu22PHhENmPcRdFiHRjhAuHcs05RI=" crossorigin="anonymous"></script> --->

        <style>
            body {
                font-family: Arial, sans-serif;
                line-height: 1.6;
                background-color: #f4f4f4;
                padding: 20px;
            }
            .container {
                max-width: 800px;
                margin: auto;
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            form {
                margin-bottom: 20px;
            }
            label {
                font-weight: bold;
            }
            input[type=text],
            textarea {
                width: 100%;
                padding: 10px;
                margin-top: 5px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
                resize: vertical;
            }
            button {
                background-color: #4CAF50;
                color: white;
                padding: 12px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                float: right;
            }
            button:hover {
                background-color: #45a049;
            }
            textarea {
                min-height: 200px;
            }
            .select-container {
                margin-bottom: 20px;
            }
            .custom-select-wrapper {
                position: relative;
                display: inline-block;
                width: 100%;
            }
            .custom-select {
                display: block;
                width: 100%;
                padding: 10px;
                font-size: 16px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
                appearance: none;
                -webkit-appearance: none;
                -moz-appearance: none;
                background-color: #fff;
                cursor: pointer;
            }
            .custom-select:focus {
                outline: none;
            }
            .select-arrow {
                position: absolute;
                top: 50%;
                right: 10px;
                transform: translateY(-50%);
                color: #555;
            }
        </style>
    </head>
    <body>
    
    
        <cfquery name="getTemplates" datasource="#application.dsource#">
            SELECT *
            FROM emailTemplateDesign           
        </cfquery>
    <div class="container mt-4">
        <!-- Select dropdown outside the form -->

        <cfif isDefined("form.templateNameSelect")>
            <cfset templateName = form.templateNameSelect>
            <cftry>
                <cfquery name="getData" datasource="#application.dsource#">
                    SELECT *
                    FROM emailTemplateDesign
                    WHERE NAME = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#templateName#">
                </cfquery>             
                <!--- <cfdump var="#getData#" abort="true"> --->
            <cfcatch>
                <cfdump var="#cfcatch#" abort="true">
            </cfcatch>
            </cftry>
        </cfif>
        
        <div class="select-container">
            <form id="templateForm" action="" method="POST">
                <label for="templateNameSelect">Select Template:</label>
                <div class="custom-select-wrapper">
                    <cfoutput>
                        <select name="templateNameSelect" id="templateNameSelect" class="custom-select">
                            <option value="">Select Template</option>
                            <cfloop query="getTemplates">
                                <option value="#getTemplates.name#" <cfif isDefined('getData') and getTemplates.name eq getData.name>Selected</cfif>>#getTemplates.name#</option>
                            </cfloop>
                        </select>
                    </cfoutput>
                    <div class="select-arrow">&#9660;</div>
                </div>
            </form>
            
        </div>
        </div>
        <br>

      
        
        <cfif isDefined("form.submit")>
            <cfset templateName = form.templateName>
            <cfset content = form.content>
            <cftry>
                <cfif isDefined("form.id") AND form.id neq ''>
                    <!-- Update existing record -->
                    <cfquery name="updateListing" datasource="#application.dsource#">
                        UPDATE emailTemplateDesign
                        SET
                            Name = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#templateName#">,
                            emailtemplate = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#content#">
                        WHERE id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.id#">
                    </cfquery>
                    <cfoutput>
                        <script>alert("Content has been successfully Updated!");</script>
                    </cfoutput>
                <cfelse>
                    <!-- Insert new record -->
                    <cfquery name="addListing" datasource="#application.dsource#">
                        INSERT INTO emailTemplateDesign (NAME, emailtemplate)
                        VALUES (
                            <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#templateName#">,
                            <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#content#">
                        )
                    </cfquery>
                    <cfoutput>
                        <script>alert("Content has been successfully saved!");</script>
                    </cfoutput>
                </cfif>
                <cfcatch>
                    <cfdump var="#cfcatch#" abort="true">
                </cfcatch>
            </cftry>
        </cfif>
        
     
        <div class="container">
        <!-- Form for template name and content -->
        <form action="" method="POST">
            <input type="hidden" name="id" value="<cfoutput><cfif isDefined('getData')>#getData.id#</cfif></cfoutput>">
            <label for="customTemplateName">Custom Template Name:</label>
            <input type="text" name="templateName" value="<cfoutput><cfif isDefined('getData')>#getData.name#</cfif></cfoutput>" id="customTemplateName" required>
            <br><br>
            <label for="editor">Email Template Content:</label>
            <textarea name="content" id="editor">
                <cfif isDefined('getData')>
                    <cfoutput>#getData.emailtemplate#</cfoutput>
                <cfelse>
                    <p>Welcome to CKEditor 5!</p>
                </cfif>
            </textarea>
            <br><br>
            <button type="submit" name="submit">Submit</button>
        </form>
              
    </div>


    <script>
        ClassicEditor
            .create(document.querySelector('#editor'), {
                ckfinder: {
                    uploadUrl: 'http://23.20.226.157/admin/views/emailTemplate/uploadImage.cfm'
                },
                toolbar: {
                    items: [
                        'heading', '|',
                        'bold', 'italic', '|',
                        'link', 'bulletedList', 'numberedList', 'blockQuote', '|',
                        'insertTable', '|',
                        'undo', 'redo', '|',
                        'imageUpload', '|',
                        'resizeImage:25', 'resizeImage:50', 'resizeImage:75', 'resizeImage:original' // Resize buttons
                    ]
                },
                image: {
                    resizeUnit: '%', // or 'px'
                    resizeOptions: [
                        {
                            name: 'resizeImage:original',
                            value: null,
                            label: 'Original size',
                            icon: 'original'
                        },
                        {
                            name: 'resizeImage:25',
                            value: '25',
                            label: 'Small size',
                            icon: 'small'
                        },
                        {
                            name: 'resizeImage:50',
                            value: '50',
                            label: 'Medium size',
                            icon: 'medium'
                        },
                        {
                            name: 'resizeImage:75',
                            value: '75',
                            label: 'Large size',
                            icon: 'large'
                        }
                    ],
                    toolbar: [
                        'resizeImage:25', 'resizeImage:50', 'resizeImage:75', 'resizeImage:original', '|',
                        'imageTextAlternative', '|',
                        'toggleImageCaption', '|',
                        'imageStyle:inline', 'imageStyle:alignLeft', 'imageStyle:alignRight', 'imageStyle:alignCenter', 'imageStyle:alignBlockLeft', 'imageStyle:alignBlockRight', 'imageStyle:block', 'imageStyle:side', 'imageStyle:wrapText', 'imageStyle:breakText'
                    ]
                },
                language: 'en',
                removePlugins: [ 'EasyImage' ]
            })
            .catch(error => {
                console.error(error);
            });
    </script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var templateSelect = document.getElementById('templateNameSelect');
            
            templateSelect.addEventListener('change', function() {
                document.getElementById('templateForm').submit(); // Submit the form when template changes
            });
        });
    </script>
    
    </body>
    </html>
    
    
    
    
    

    
    
    