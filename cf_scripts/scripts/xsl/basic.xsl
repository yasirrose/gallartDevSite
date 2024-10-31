<?xml version="1.0" encoding="UTF-8"?>
<!-- Copyright (c) 1995-2005 Macromedia, Inc. All rights reserved. -->

<xsl:stylesheet version="1.0" xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance" xmlns:cf="http://www.macromedia.com/2004/cfform" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xf="http://www.w3.org/2002/xforms" xmlns:html="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xsi cf xsl xf html">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:output omit-xml-declaration="yes"/>
	
	<xsl:param name="HTTP_USER_AGENT"/>
	<xsl:param name="SCRIPTSRC"/>
	<xsl:param name="CONTEXTPATH"/>
	
	<!-- include cfform javascript generation -->
	<xsl:include href="_cfformvalidation.xsl" />
	
	<!-- start form -->
	<xsl:template match="/">
		<xsl:variable name="formName" select="//form/@cf:name"/>
		<!-- generate the correct javascript, based on xf:bind, to validate onSubmit -->
		<xsl:call-template name="onSubmitValidation" />
		
		
		
		<xsl:element name="link">
			<xsl:attribute name="href"><xsl:value-of select="$SCRIPTSRC"/>css/basic_style.css</xsl:attribute>
			<xsl:attribute name="rel">stylesheet</xsl:attribute>
			<xsl:attribute name="type">text/css</xsl:attribute>
			<xsl:attribute name="media">all</xsl:attribute>
		</xsl:element>
		
		
		<xsl:element name="div">
			<xsl:attribute name="class">cfform</xsl:attribute>
			<xsl:if test="/form/@html:width or /form/@html:height or /form/@html:style">
				<xsl:attribute name="style"><xsl:if test="/form/@html:width">width: <xsl:value-of select="/form/@html:width"/>;</xsl:if><xsl:if test="/form/@html:height">height: <xsl:value-of select="/form/@html:height"/>;</xsl:if> <xsl:if test="/form/@html:style"><xsl:value-of select="/form/@html:style"/></xsl:if>  </xsl:attribute>
			</xsl:if>

			<!--	generate the correct root form tag, based on the submission definition in the model. -->
			<xsl:element name="form">
				<xsl:attribute name="id"><xsl:value-of select="$formName"/></xsl:attribute>
				<xsl:attribute name="action"><xsl:value-of select="/form/xf:model/xf:submission/@action"/></xsl:attribute>
				<xsl:attribute name="method"><xsl:value-of select="/form/xf:model/xf:submission/@method"/></xsl:attribute>
                <xsl:choose>
                    <xsl:when test="/form/@html:onsubmit">
                        <xsl:attribute name="onsubmit"><xsl:value-of select="/form/@html:onsubmit"/>;<xsl:value-of select="concat(concat('return _CF_check', $formName), '(this);')"/></xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:attribute name="onsubmit"><xsl:value-of select="concat(concat('return _CF_check', $formName), '(this);')"/></xsl:attribute>
                    </xsl:otherwise>
                </xsl:choose>

	
				<!-- loop over the form children elements -->
				<xsl:for-each select="//form/@html:*">
	                <xsl:if test="local-name() != 'width' and local-name() != 'height' and local-name() != 'validate' and local-name() != 'validation' and local-name() != 'type' and local-name() != 'onsubmit' and local-name() != 'style'">
					<xsl:attribute name="{local-name()}"><xsl:value-of select="."/></xsl:attribute>
	                </xsl:if>
				</xsl:for-each>
				
					<!-- loop over the form children elements -->
					<xsl:for-each select="*[not(self::xf:model)]">
						<xsl:call-template name="vertical"/>
					</xsl:for-each>
	
				<!-- generate the correct hidden fields, based on xf:bind, to trigger server side validation -->
				<xsl:call-template name="onServerValidation" />
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template match="xf:model"/>
	<xsl:template match="xf:extension"/>
	
	
	
<!-- **************************************************************************************************
	*	Supported Groups
	************************************************************************************************** -->
	
	<!-- passthrough match for any groups not defined -->
	<xsl:template match="xf:group">
		<xsl:apply-templates select="*"/>
	</xsl:template>
	
	<!-- include groups that will be supported for this skin-->
	<xsl:include href="_group_vertical_table.xsl" />
	<xsl:include href="_group_horizontal_table.xsl" />
    <xsl:include href="_group_fieldset.xsl"/>
	
    	<!-- 
		bsahlas 5/26/05: 
		commenting out the superfluous include reference to _fcktextarea.xsl for now. 	
		Not sure what *samples/* folder we're referencing.  Since this file cannot be found it's throughing errors.
	-->
	<!-- <xsl:include href="samples/_fcktextarea.xsl"/>	-->




<!-- **************************************************************************************************
	*	Form Elements
	************************************************************************************************** -->

	
	<!-- include the default rules for form elements.-->
	<xsl:include href="_formelements.xsl" />	

	
	
</xsl:stylesheet>
