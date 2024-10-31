<?xml version="1.0" encoding="UTF-8"?>
<!-- Copyright (c) 1995-2005 Macromedia, Inc. All rights reserved. -->

<xsl:stylesheet version="1.0" 
xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:cf="http://www.macromedia.com/2004/cfform" 
xmlns:xf="http://www.w3.org/2002/xforms" 
xmlns:html="http://www.w3.org/1999/xhtml" 
exclude-result-prefixes="xsi cf xsl xf html">

	<xsl:template name="checkRequiredChildrenClass">
		<xsl:for-each select="*[not(self::xf:extension)][not(self::xf:label)]">
			<xsl:variable name="id" select="@id"/>
				<xsl:if test="//form/xf:model/xf:bind[@id = $id]/@required = 'true()'">
					<xsl:text> cfRequiredlabel</xsl:text>
				</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="checkRequiredChildren">
		<xsl:for-each select="*[not(self::xf:extension)][not(self::xf:label)]">
			<xsl:variable name="id" select="@id"/>
				<xsl:if test="//form/xf:model/xf:bind[@id = $id]/@required = 'true()'">
					<span class="cfRequiredLabelIndicator">&#160;* </span>
				</xsl:if>
		</xsl:for-each>
	</xsl:template>
	
	
	
	
	<!-- <cfformitem type="buttonbar" > -->
	<xsl:template match="xf:group[@appearance='buttonbar']">
		<xsl:element name="table">
			<xsl:attribute name="border">0</xsl:attribute>
			<xsl:attribute name="cellspacing">0</xsl:attribute>
			<xsl:attribute name="cellpadding">0</xsl:attribute>
			<xsl:attribute name="class">cfButtonBar</xsl:attribute>

			<xsl:element name="tr">
				<xsl:element name="td">
					<xsl:attribute name="class">cfFirstChild</xsl:attribute>
					<xsl:text> </xsl:text>
				</xsl:element>
				<xsl:element name="td">
					<xsl:apply-templates select="*[not(self::xf:extension)][not(self::xf:label)]"/>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>		
	
	
	<!-- <cfformgroup type="horizontal"> -->
	<xsl:template match="xf:group[@appearance='horizontal']">
		<xsl:element name="table">
			<xsl:attribute name="border">0</xsl:attribute>
			<xsl:attribute name="cellspacing">0</xsl:attribute>
			<xsl:attribute name="cellpadding">0</xsl:attribute>
			<xsl:attribute name="class">horizontal</xsl:attribute>


			<xsl:element name="tr">
				<xsl:attribute name="class">cfElementRow</xsl:attribute>
				<!-- place group label in left column if one is defined -->
				<xsl:if test="position() = 1 and xf:label/text()">
					<xsl:element name="td">
						<xsl:attribute name="valign">top</xsl:attribute>
						<xsl:attribute name="rowspan">99</xsl:attribute>
						<xsl:attribute name="nowrap">nowrap</xsl:attribute>
						<xsl:attribute name="class">cfLabelTitle cfLabelPosRight cfFirstChild <xsl:call-template name="checkRequiredChildrenClass"/></xsl:attribute>	

						<xsl:call-template name="checkRequiredChildren"/>
						<xsl:value-of select="xf:label/text()"/>
					</xsl:element>
				</xsl:if>
				
				<xsl:for-each select="*[not(self::xf:extension)][not(self::xf:label)]">
					<xsl:choose>
						<!-- radio buttons -->
						<xsl:when test="xf:select1[@appearance='full']">
							<xsl:element name="tr">
								<xsl:attribute name="class">cfElementRow</xsl:attribute>
								
								
								
								<xsl:element name="td">
									<xsl:attribute name="colspan">2</xsl:attribute>
									<xsl:attribute name="nowrap">nowrap</xsl:attribute>

									<xsl:element name="span">
									<xsl:choose>
										<xsl:when test="not( parent::*/xf:label/text() ) and position() = 1">		
											<xsl:attribute name="class">cfLabelTitle cfLabelPosRight cfFirstChild</xsl:attribute>		
										</xsl:when>
										<xsl:otherwise>
											<xsl:attribute name="class">cfLabelTitle cfLabelPosRight</xsl:attribute>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:call-template name="label"/>
									</xsl:element>
									
									<xsl:for-each select="xf:select1[@appearance='full']/xf:choices/xf:item">
									<xsl:element name="p">
										<xsl:call-template name="radio"/>
									</xsl:element>
									</xsl:for-each>

								</xsl:element>
							</xsl:element>
						</xsl:when>		
						
						
						<!-- checkbox -->
						<xsl:when test="xf:select1[@appearance='full']">
							<xsl:element name="tr">
								<xsl:attribute name="class">cfElementRow</xsl:attribute>
								
								<xsl:element name="td">
									<xsl:attribute name="colspan">2</xsl:attribute>
									<xsl:attribute name="nowrap">nowrap</xsl:attribute>

									<xsl:element name="span">
									<xsl:choose>
										<xsl:when test="not( parent::*/xf:label/text() ) and position() = 1">		
											<xsl:attribute name="class">cfLabelTitle cfLabelPosRight cfFirstChild</xsl:attribute>		
										</xsl:when>
										<xsl:otherwise>
											<xsl:attribute name="class">cfLabelTitle cfLabelPosRight</xsl:attribute>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:call-template name="label"/>
									</xsl:element>
									
									<xsl:element name="p">
									<xsl:for-each select="xf:select1[@appearance='full']/xf:choices/xf:item">
										<xsl:call-template name="checkbox"/>
									</xsl:for-each>
									</xsl:element>
								</xsl:element>
							</xsl:element>
						</xsl:when>	
						
			
						<xsl:otherwise>
							<xsl:if test="xf:label/text() and not(self::xf:group) and not(self::xf:submit) and not(self::xf:trigger)">
								<xsl:element name="td">
									<xsl:attribute name="valign">top</xsl:attribute>
									<xsl:attribute name="nowrap">nowrap</xsl:attribute>
									<xsl:choose>
										<xsl:when test="not( parent::*/xf:label/text() ) and position() = 1">		
											<xsl:attribute name="class">cfLabelTitle cfLabelPosRight cfFirstChild</xsl:attribute>		
										</xsl:when>
										<xsl:otherwise>
											<xsl:attribute name="class">cfLabelTitle cfLabelPosRight</xsl:attribute>
										</xsl:otherwise>
									</xsl:choose>
		
									<xsl:call-template name="label"/>
								</xsl:element>
							</xsl:if>
							<xsl:element name="td">
								<xsl:apply-templates select="."/>
							</xsl:element>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	
</xsl:stylesheet>
