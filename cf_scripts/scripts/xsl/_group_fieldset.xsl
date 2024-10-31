<?xml version="1.0" encoding="UTF-8"?>
<!-- Copyright (c) 1995-2005 Macromedia, Inc. All rights reserved. -->
<xsl:stylesheet version="1.0"
xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:cf="http://www.macromedia.com/2004/cfform" 
xmlns:xf="http://www.w3.org/2002/xforms" 
xmlns:html="http://www.w3.org/1999/xhtml" 
exclude-result-prefixes="xsi cf xsl xf html">
 
	<!-- <cfformgroup type="vertical"> -->
	<xsl:template match="xf:group[@appearance='fieldset']">
		<xsl:element name="fieldset">
           		 <xsl:for-each select="xf:extension/cf:attribute">
                		<xsl:if test="@name != 'width' and @name != 'validate' and @name != 'validation' ">
					<xsl:attribute name="{@name}"><xsl:value-of select="text()"/></xsl:attribute>
				</xsl:if>
			</xsl:for-each>

			<xsl:element name="legend">
				<xsl:value-of select="xf:label/text()"/>
			</xsl:element>

			<xsl:for-each select="*[not(self::xf:extension)][not(self::xf:label)]">
				<xsl:apply-templates select="."/>	
			</xsl:for-each>
			
		</xsl:element>
	</xsl:template>
	
</xsl:stylesheet>