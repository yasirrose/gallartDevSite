<style>
	#videoCloseLink{
		background: url("css/closelabel.gif") no-repeat scroll center center transparent;
		display: block;
		float: right;
		height: 22px;
		margin: 5px 0;
		outline: medium none;
		width: 66px;
	}
	#videoContentContainerIE{
		/*display:none;	*/
	}
</style>

<div style="position:relative">

    
    <cfquery name="getPages" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
        SELECT * from pages
        WHERE pk_pages = 1
    </cfquery>
    <cfoutput>
        <div>
            <div class="top-heading">
                <p>Please sign our <a href="guests.cfm?xss=#xss#" class="company">Guest Book</a> for upcoming shows and information.</p>
            </div>
            <div class="bottom-heading">
                <p>#getPages.page_content#</p>
            </div>
        </div>
    <!---     <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td style="padding-top: 20px; padding-left: 15px; padding-bottom: 20px;" class="homepage" align="center">
                <table border="0" cellpadding="0" cellspacing="0" width="700">
                    <tr>
                        <td align="center" style="padding-bottom: 20px;">
                            Please sign our <a href="guests.cfm?xss=#xss#" class="company">Guest Book</a> for upcoming shows and information.
                        </td>
                    </tr>
                    <tr>
                        <td>
                            #getPages.page_content#
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>--->
    </cfoutput>
    
    <div  style="position:absolute; top:0px; left:0px; width:640px; height:380px; background-color:#FFF; padding:10px; border:2px solid #000; display:none;" id="gallartVideo">
    	<div id="videoContentContainer"></div>
        <a id="videoCloseLink" href="javascript: void(0)" onclick"hideVideo()"></a>
    </div>
</div>


<script>
	showVideo = function(){
		if (navigator.appVersion.indexOf("Win")!=-1){
			$('#videoContentContainer').append($('#videoContent').html());
		} 
		$('#gallartVideo').show();
	}
	$(document).ready(function(){
		if (navigator.appVersion.indexOf("Win") == -1){
			$('#videoContentContainer').append($('#videoContent').html());
		}
		$('#videoCloseLink').click(function(){
			if (navigator.appVersion.indexOf("Win")!=-1){
				$('#videoContentContainer').html('');
			}
			$('#gallartVideo').hide();
		});
		
	});
</script>


<div id="videoContent" style="display:none; height:1px; margin: 0 auto;">
		<script src="http://videoplayer.turnhere.com/player.js?width=640&height=360&embedCode=YyODQxMjqSgaLHPP1dqhuQlSktXILEIV&autoplay=1"></script>
        <noscript><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
                      id="ooyalaPlayer_72c6_gjet6vjx" width="640" height="360"
                      codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">
        <param name="movie" value="http://videoplayer.turnhere.com/player.swf?embedCode=YyODQxMjqSgaLHPP1dqhuQlSktXILEIV=2" />
        <param name="bgcolor" value="#000000" />
        <param name="allowScriptAccess" value="always" />
        <param name="allowFullScreen" value="true" />
        <param name="flashvars" value="embedType=noscriptObjectTag&embedCode=YyODQxMjqSgaLHPP1dqhuQlSktXILEIV&autoplay=0" />
          <embed
              src="http://videoplayer.turnhere.com/player.swf/player.swf?embedCode=YyODQxMjqSgaLHPP1dqhuQlSktXILEIV&version=2"
              bgcolor="#000000" width="640" height="360"
              name="ooyalaPlayer_72c6_gjet6vjx" align="middle" play="true"
              loop="false" allowscriptaccess="always" allowfullscreen="true"
              type="application/x-shockwave-flash"
              flashvars="&embedCode=YyODQxMjqSgaLHPP1dqhuQlSktXILEIV&autoplay=0"
              pluginspage="http://www.adobe.com/go/getflashplayer"></embed>
        </object></noscript>
</div>