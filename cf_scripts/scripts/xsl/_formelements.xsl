<?xml version="1.0" encoding="UTF-8"?>
<!-- Copyright (c) 1995-2005 Macromedia, Inc. All rights reserved. -->
<xsl:stylesheet version="1.0" 
xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:cf="http://www.macromedia.com/2004/cfform" 
xmlns:xf="http://www.w3.org/2002/xforms" 
xmlns:html="http://www.w3.org/1999/xhtml" 
exclude-result-prefixes="xsi cf xsl xf html">


	<!-- <CFFORMITEM type="text"..> -->
    	<xsl:template match="xf:output">
   		<xsl:element name="div">
   			<xsl:attribute name="class">cfText</xsl:attribute>
            <xsl:for-each select="xf:extension/cf:attribute">
				<xsl:attribute name="{@name}"><xsl:value-of select="text()"/></xsl:attribute>
			</xsl:for-each>	
		<xsl:value-of select="text()" disable-output-escaping="yes"/>
   		</xsl:element>
	</xsl:template>
	
	<!-- used by other rules to output <label> </label> tags for element -->
	<xsl:template name="label">
		<xsl:variable name="id" select="@id"/>
		
		<xsl:element name="label">
			<xsl:attribute name="for"><xsl:value-of select="@id"/></xsl:attribute>
			<xsl:choose>
				<xsl:when test="//form/xf:model/xf:bind[@id = $id]/@required = 'true()'">
					<xsl:attribute name="class">cfRequiredLabel</xsl:attribute>
					<span class="cfRequiredLabelIndicator">* </span>
					<xsl:value-of select="xf:label/text()"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="xf:label/text()"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	
	<!-- <cfformitem type="hrule" or type="hr"..> -->
	<xsl:template match="xf:group[@appearance='hrule'] | xf:group[@appearance='hr']">
		<xsl:element name="hr">
			<xsl:for-each select="xf:extension/cf:attribute">
				<xsl:attribute name="{@name}"><xsl:value-of select="text()"/></xsl:attribute>
			</xsl:for-each>			
		</xsl:element>
	</xsl:template>
	

	
	
	<!-- <cfinput type="text|hidden|password|file" > -->
	<xsl:template match="xf:input | xf:secret | xf:upload | xf:submit | xf:trigger">

		<xsl:variable name="bind" select="@bind"/>
		<xsl:variable name="id" select="@id"/>
		
		<xsl:element name="input">
			<xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
			<xsl:attribute name="name"><xsl:value-of select="@id"/></xsl:attribute>
			<xsl:attribute name="class">cfInput <xsl:if test="//form/xf:model/xf:bind[@id = $id]/@required = 'true()'">cfRequiredElement</xsl:if></xsl:attribute>
			<xsl:attribute name="value"><xsl:value-of select="//form/xf:model/xf:instance/cf:data/*[name() = $bind]/text()"/></xsl:attribute>
			
			<xsl:for-each select="xf:extension/cf:attribute">
                <xsl:if test="@name != 'width' and @name != 'validate' and @name != 'validation' ">
				    <xsl:attribute name="{@name}"><xsl:value-of select="text()"/></xsl:attribute>
                </xsl:if>
			</xsl:for-each>
			
			<xsl:for-each select="//form/xf:model/xf:bind[@id = $bind]">
				<xsl:call-template name="onBlurValidation"/>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>
	
	
	<!-- <cfinput type="submit|button|image|reset" > -->
	<xsl:template match="xf:submit | xf:trigger">
		<xsl:variable name="id" select="@id"/>	

		<xsl:element name="input">
			<xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
			<xsl:attribute name="name"><xsl:value-of select="@id"/></xsl:attribute>
			<xsl:attribute name="class">cfButton <xsl:if test="//form/xf:model/xf:bind[@id = $id]/@required = 'true()'">cfRequiredElement</xsl:if></xsl:attribute>
			
			<xsl:choose>
				<xsl:when test="xf:label/html:img">
					<xsl:attribute name="src"><xsl:value-of select="xf:label/html:img/@src" /></xsl:attribute>
					<xsl:attribute name="type">image</xsl:attribute>
				</xsl:when>
				<xsl:when test="reset">
					<xsl:attribute name="type">reset</xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="xf:label/text()" /></xsl:attribute>			
					<xsl:for-each select="xf:extension/cf:attribute">
                <xsl:if test="@name != 'width' and @name != 'validate' and @name != 'validation' and @name != 'type'">
				    <xsl:attribute name="{@name}"><xsl:value-of select="text()"/></xsl:attribute>
                </xsl:if>
			</xsl:for-each>
				</xsl:when>
				<xsl:when test="name() = 'xf:trigger'">
					<xsl:attribute name="type">button</xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="xf:label"/></xsl:attribute>
					<xsl:for-each select="xf:extension/cf:attribute">
                <xsl:if test="@name != 'width' and @name != 'validate' and @name != 'validation' and @name != 'type'">
				    <xsl:attribute name="{@name}"><xsl:value-of select="text()"/></xsl:attribute>
                </xsl:if>
			</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="value"><xsl:value-of select="xf:label/text()" /></xsl:attribute>				
					<xsl:for-each select="xf:extension/cf:attribute">
                <xsl:if test="@name != 'width' and @name != 'validate' and @name != 'validation' ">
				    <xsl:attribute name="{@name}"><xsl:value-of select="text()"/></xsl:attribute>
                </xsl:if>
			</xsl:for-each>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
				
	</xsl:template>
	

	
	
	<!-- <cfinput type="radio" > -->
	<xsl:template match="xf:select1[@appearance='full']">
		<xsl:for-each select="xf:choices/xf:item">
			<xsl:call-template name="radio"></xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="radio">	
		
		<xsl:variable name="id" select="parent::*/parent::*/@id"/>
		<xsl:element name="input">
			<xsl:attribute name="type">radio</xsl:attribute>
			<xsl:attribute name="id"><xsl:value-of select="concat(parent::*/parent::*/@id, position())"/></xsl:attribute>
			<xsl:attribute name="name"><xsl:value-of select="parent::*/parent::*/@id"/></xsl:attribute>
			<xsl:attribute name="class">cfRadio <xsl:if test="//form/xf:model/xf:bind[@id = $id]/@required = 'true()'">cfRequiredElement</xsl:if></xsl:attribute>
			<xsl:for-each select="xf:extension/cf:attribute">
                   		<xsl:if test="@name != 'width' and @name != 'validate' and @name != 'validation' and @name != 'type'">
   				    		<xsl:attribute name="{@name}"><xsl:value-of select="text()"/></xsl:attribute>
                   		</xsl:if>
		    	</xsl:for-each>
			
			<xsl:attribute name="value"><xsl:value-of select="xf:value/text()" /></xsl:attribute>

			<!-- checked? -->
			<xsl:if test="//form/xf:model/xf:instance/cf:data/*[name() =  $id]/text() = xf:value/text()">
				<xsl:attribute name="checked">checked</xsl:attribute>
			</xsl:if>
		</xsl:element>

		<xsl:element name="label">
			<xsl:attribute name="for"><xsl:value-of select="concat(parent::*/parent::*/@id, position())"/></xsl:attribute>
			<xsl:if test="//form/xf:model/xf:bind[@id = $id]/@required = 'true()'">
				<xsl:attribute name="class">cfRequiredLabel</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="xf:label/text()"/>
		</xsl:element>
	</xsl:template>	
	
	
	<!-- <cfinput type="checkbox" > -->
	<xsl:template match="xf:select[@appearance='full']">
		<xsl:for-each select="xf:choices/xf:item">
			<xsl:call-template name="checkbox"></xsl:call-template>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="checkbox">
		<xsl:variable name="id" select="parent::*/parent::*/@id"/>
		<xsl:element name="input">
			<xsl:attribute name="type">checkbox</xsl:attribute>
			<xsl:attribute name="id"><xsl:value-of select="parent::*/parent::*/@id"/></xsl:attribute>
			<xsl:attribute name="name"><xsl:value-of select="parent::*/parent::*/@id"/></xsl:attribute>
			<xsl:attribute name="class">cfCheckbox <xsl:if test="//form/xf:model/xf:bind[@id = $id]/@required = 'true()'">cfRequiredElement</xsl:if></xsl:attribute>
			<xsl:for-each select="xf:extension/cf:attribute">
              			<xsl:if test="@name != 'width' and @name != 'validate' and @name != 'validation' and @name != 'type'">
			    		<xsl:attribute name="{@name}"><xsl:value-of select="text()"/></xsl:attribute>
               			</xsl:if>
   			</xsl:for-each>
   			
		
			<xsl:attribute name="value"><xsl:value-of select="xf:value/text()" /></xsl:attribute>
		</xsl:element>				
	
		<!-- label -->
		<xsl:element name="label">
			<xsl:attribute name="for"><xsl:value-of select="parent::*/parent::*/@id"/></xsl:attribute>
			<xsl:if test="//form/xf:model/xf:bind[@id = $id]/@required = 'true()'">
				<xsl:attribute name="class">cfRequiredLabel</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="xf:label/text()"/>
		</xsl:element>
	</xsl:template>	
	
	
	
	<!-- <cfselect size="1"> </cfselect> -->
	<xsl:template match="xf:select1[@appearance='minimal'] | xf:select1[@appearance='compact']">

		<xsl:variable name="id" select="@id"/>
		<xsl:element name="select">
            <xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
			<xsl:attribute name="name"><xsl:value-of select="@id"/></xsl:attribute>
			<xsl:attribute name="class">cfSelect <xsl:if test="//form/xf:model/xf:bind[@id = $id]/@required = 'true()'">cfRequiredElement</xsl:if></xsl:attribute>
			
            <xsl:for-each select="xf:extension/cf:attribute">
                <xsl:if test="@name != 'width' and @name != 'validate' and @name != 'validation' and @name != 'type'">
				    <xsl:attribute name="{@name}"><xsl:value-of select="text()"/></xsl:attribute>
                </xsl:if>
			</xsl:for-each>

			<xsl:for-each select="xf:choices">
				<xsl:choose>
					<xsl:when test="xf:label">
						<xsl:element name="optgroup">
							<xsl:attribute name="label"><xsl:value-of select="xf:label"/></xsl:attribute>
							<xsl:apply-templates select="xf:item" mode="select"/>
						</xsl:element>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="xf:item" mode="select"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>
	
	<!-- <cfselect size="2+" > </cfselect> -->
	<xsl:template match="xf:select[@appearance='compact'] | xf:select[@appearance='minimal']">
		<xsl:variable name="id" select="@id"/>
		<xsl:element name="select">
             <xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
			<xsl:attribute name="name"><xsl:value-of select="@id"/></xsl:attribute>
			<xsl:attribute name="class">cfSelect <xsl:if test="//form/xf:model/xf:bind[@id = $id]/@required = 'true()'">cfRequiredElement</xsl:if></xsl:attribute>

			<xsl:if test="@appearance = 'compact'">
				<xsl:attribute name="multiple">multiple</xsl:attribute>
			</xsl:if>
						
			<xsl:for-each select="xf:extension/cf:attribute">
               		 <xsl:if test="@name != 'width' and @name != 'validate' and @name != 'validation' and @name != 'type'">
				    <xsl:attribute name="{@name}"><xsl:value-of select="text()"/></xsl:attribute>
               		 </xsl:if>
			</xsl:for-each>
			
			<xsl:for-each select="xf:choices">
				<xsl:choose>
					<xsl:when test="xf:label">
						<xsl:element name="optgroup">
							<xsl:attribute name="label"><xsl:value-of select="xf:label"/></xsl:attribute>
							<xsl:apply-templates select="xf:item" mode="select"/>
						</xsl:element>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="xf:item" mode="select"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>
	
	<!-- utility rule used by both xf:select and xf:select1 elements -->
	<xsl:template match="xf:item" mode="select">
		<xsl:variable name="id" select="parent::*/parent::*/@id"/>
		<!-- lowercase selected values and value, so it's a case insensitive check for selected -->
		<xsl:variable name="selectedValues" select="translate(//form/xf:model/xf:instance/cf:data/*[name() = $id], 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
		<xsl:variable name="lowervalue" select="translate(xf:value, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
		<xsl:variable name="value" select="xf:value"/>
		
			<xsl:element name="option">
				<xsl:attribute name="value"><xsl:value-of select="$value"/>	</xsl:attribute>

				<xsl:if test="string-length($selectedValues) != 0 and contains(concat(',',$selectedValues,','),concat(',',$lowervalue,','))">
					<xsl:attribute name="selected">selected</xsl:attribute>
				</xsl:if>

				<xsl:value-of select="xf:label"/>
			</xsl:element>
		

	</xsl:template>
	
	


	
	
	<!-- <cftextarea></cftextarea> -->
	<xsl:template match="xf:textarea">
		<xsl:variable name="id" select="@id"/>
		<xsl:variable name="bind" select="@bind"/>
		<xsl:element name="textarea">
			<xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
			<xsl:attribute name="name"><xsl:value-of select="@id"/></xsl:attribute>
			<xsl:attribute name="class">cfTextarea <xsl:if test="//form/xf:model/xf:bind[@id = $id]/@required = 'true()'">cfRequiredElement</xsl:if></xsl:attribute>
			
           		 <xsl:for-each select="xf:extension/cf:attribute">
              		  <xsl:if test="@name != 'width' and @name != 'validate' and @name != 'validation' and @name != 'type'">
				    <xsl:attribute name="{@name}"><xsl:value-of select="text()"/></xsl:attribute>
               		 </xsl:if>
			</xsl:for-each>

			<xsl:for-each select="//form/xf:model/xf:bind[@id = $bind]">
				<xsl:call-template name="onBlurValidation"/>
			</xsl:for-each>
			
			<xsl:value-of select="//form/xf:model/xf:instance/cf:data/*[name() = $id]"/>
			<xsl:text> </xsl:text><!-- extra space at end, in case no value is defined -->
		</xsl:element>
	</xsl:template>
	
		
	
	
	<!-- <cfslider></cfslider> -->
	<xsl:template match="xf:range">

<xsl:choose>
	<xsl:when test="contains($HTTP_USER_AGENT, 'MSIE')">
	
		<xsl:text disable-output-escaping="yes">&lt;object classid='clsid:8AD9C840-044E-11D1-B3E9-00805F499D93'  
			codebase='http://java.sun.com/products/plugin/1.3/jinstall-13-win32.cab#Version=1,3,0,0'</xsl:text>
		<xsl:text>width="</xsl:text><xsl:value-of select="xf:extension/cf:attribute[@name='width']/text()"/><xsl:text>"</xsl:text>
		<xsl:text>height="</xsl:text><xsl:value-of select="xf:extension/cf:attribute[@name='height']/text()"/><xsl:text>"</xsl:text>
		<xsl:text disable-output-escaping="yes">&gt;
		    &lt;param name='code' value='coldfusion.applets.CFSliderApplet.class' /&gt;
		    &lt;param name='archive' value='</xsl:text><xsl:value-of select="$CONTEXTPATH"/><xsl:text disable-output-escaping="yes">/CFIDE/classes/cfapplets.jar' /&gt;
		    &lt;param name='mayscript' value='true' /&gt;
		</xsl:text>
		
		<xsl:for-each select="xf:extension/cf:attributes/*">
			<xsl:text disable-output-escaping="yes">  &lt;param name="</xsl:text><xsl:value-of select="@name"/><xsl:text>" value="t</xsl:text><xsl:value-of select="text()"/><xsl:text disable-output-escaping="yes">" /&gt;</xsl:text>
		</xsl:for-each>
		
		<xsl:text disable-output-escaping="yes">   &lt;param name="cf_form_name" value="</xsl:text><xsl:value-of select="//form/@cf:name"/><xsl:text disable-output-escaping="yes">" /&gt;
		</xsl:text>
		<xsl:text disable-output-escaping="yes">   &lt;param name="cf_param_name" value="__CFSLIDER__</xsl:text><xsl:value-of select="//form/@cf:name"/><xsl:text>__</xsl:text>			<xsl:value-of select="@bind"/> <xsl:text disable-output-escaping="yes">" /&gt;</xsl:text> 
		
		<xsl:text disable-output-escaping="yes">
		&lt;/object&gt;
		</xsl:text>
	
	</xsl:when>
	<xsl:otherwise>

		<xsl:text disable-output-escaping="yes">
		&lt;embed type="application/x-java-applet;version=1.3" pluginspage="http://java.sun.com/j2se/1.3/jre/index.html" code="coldfusion.applets.CFSliderApplet.class" archive="</xsl:text>		<xsl:value-of select="$CONTEXTPATH"/><xsl:text>/CFIDE/classes/cfapplets.jar" mayscript="true"
		</xsl:text>
			<xsl:for-each select="xf:extension/cf:attributes/*">
				<xsl:text> </xsl:text><xsl:value-of select="@name"/><xsl:text>="</xsl:text><xsl:value-of select="text()"/><xsl:text>"</xsl:text>
			</xsl:for-each>
			
			<xsl:text> width="</xsl:text><xsl:value-of select="xf:extension/cf:attribute[@name='width']/text()"/><xsl:text>"</xsl:text>
			<xsl:text> height="</xsl:text><xsl:value-of select="xf:extension/cf:attribute[@name='height']/text()"/><xsl:text>"</xsl:text>

			<xsl:text> cf_form_name="</xsl:text><xsl:value-of select="//form/@cf:name"/><xsl:text>"</xsl:text>
			<xsl:text> cf_param_name="__CFSLIDER__</xsl:text><xsl:value-of select="//form/@cf:name"/><xsl:text>__</xsl:text><xsl:value-of select="@bind"/><xsl:text disable-output-escaping="yes">"&gt;</xsl:text>
		    
		    <xsl:text disable-output-escaping="yes">&lt;noembed&gt;</xsl:text>
		        	<xsl:value-of select="xf:extension/cf:attribute[@name='notsupported']"/>
		    <xsl:text disable-output-escaping="yes">&lt;/noembed&gt;</xsl:text>
		
		<xsl:text disable-output-escaping="yes">
		&lt;/embed&gt;
		</xsl:text>
	
	</xsl:otherwise>
</xsl:choose>


	</xsl:template>
	
	
	<!-- <CFTREE></CFTREE> -->
	<xsl:template match="cf:tree">
		<xsl:value-of select="text()" disable-output-escaping="yes"/>
	</xsl:template>
	
	<!-- <CFGRID></CFGRID> -->
	<xsl:template match="cf:grid">
		<xsl:value-of select="text()" disable-output-escaping="yes"/>
	</xsl:template>

    <!-- <CFCALENDAR></CFCALENDAR> -->
    <xsl:template match="cf:calendar">
        <xsl:value-of select="text()" disable-output-escaping="yes"/>
        <xsl:element name="input">
		<xsl:attribute name="type">hidden</xsl:attribute>
		<xsl:attribute name="name"><xsl:value-of select="@id"/></xsl:attribute>
		<xsl:attribute name="value"></xsl:attribute>
	</xsl:element>

    </xsl:template>


</xsl:stylesheet>


