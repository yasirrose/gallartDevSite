<?xml version="1.0" encoding="UTF-8"?>
<!-- Copyright (c) 1995-2005 Macromedia, Inc. All rights reserved. -->

<xsl:stylesheet version="1.0"
xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:cf="http://www.macromedia.com/2004/cfform" 
xmlns:xf="http://www.w3.org/2002/xforms" 
xmlns:html="http://www.w3.org/1999/xhtml" 
exclude-result-prefixes="xsi cf xsl xf html">
 
	<!-- <cfformgroup type="vertical">-->
	<xsl:template match="xf:group[@appearance='vertical']">
		<xsl:param name="attribs"/> <!-- string of attribute to be added to all children elements -->
		<xsl:call-template name="vertical">
			<xsl:with-param name="attribs" select="$attribs"/>
		</xsl:call-template> 
	</xsl:template>
	
	
	
	<!-- default vertical align group -->
	<xsl:template name="vertical">
		<xsl:param name="attribs"/> <!-- string of attribute to be added to all children elements -->
				
		<xsl:element name="table">
		<xsl:attribute name="border">0</xsl:attribute>
		<xsl:attribute name="cellpadding">2</xsl:attribute>
		<xsl:attribute name="cellspacing">0</xsl:attribute>
		<xsl:attribute name="width">100%</xsl:attribute>
		<xsl:attribute name="class">vertical</xsl:attribute>
		
		<xsl:if test="xf:label/text()">
			<xsl:element name="tr">
				<xsl:element name="td">
					<!-- align nested groups -->
					<xsl:if test="xf:extension/cf:attribute[@name='align']">
						<xsl:attribute name="align"><xsl:value-of select="xf:extension/cf:attribute[@name='align']"/>							</xsl:attribute>
					</xsl:if>											
					<xsl:attribute name="colspan">2</xsl:attribute>
					<xsl:attribute name="class">cfHeaderTitle</xsl:attribute>
					<xsl:value-of select="xf:label/text()"/>
				</xsl:element>
			</xsl:element>							
		</xsl:if>

				<xsl:for-each select="*[not(self::xf:label)][not(self::xf:extension)][not(self::xf:model)]">
					<xsl:choose>
						<!-- textarea controls -->
						<xsl:when test="self::xf:textarea and xf:label/text()">
							<xsl:element name="tr">
								<xsl:attribute name="class">cfElementRow</xsl:attribute>
								<xsl:element name="td">
									<xsl:attribute name="colspan">2</xsl:attribute>
									<xsl:attribute name="valign">top</xsl:attribute>
									<xsl:attribute name="align">left</xsl:attribute>									
									<xsl:attribute name="class">cfLabelTitle cfLabelPosTop</xsl:attribute>
									<xsl:attribute name="nowrap">nowrap</xsl:attribute>
									<xsl:call-template name="label"/>
								</xsl:element>
							</xsl:element>
							<xsl:element name="tr">
								<xsl:element name="td">
									<xsl:attribute name="colspan">2</xsl:attribute>
									<xsl:attribute name="width">100%</xsl:attribute>
									<xsl:attribute name="align">left</xsl:attribute>
									<xsl:apply-templates select=".">
										<xsl:with-param name="attribs" select="$attribs"/>
									</xsl:apply-templates>
								</xsl:element>
							</xsl:element>
						</xsl:when>
						
						<!-- radio buttons -->
						<xsl:when test="self::xf:select1[@appearance='full']">
							<xsl:for-each select="xf:choices/xf:item">
								<xsl:element name="tr">
									<xsl:attribute name="class">cfElementRow</xsl:attribute>
									<xsl:element name="td">
										<xsl:attribute name="valign">top</xsl:attribute>
										<xsl:attribute name="align">right</xsl:attribute>
										<xsl:attribute name="width">100</xsl:attribute>
										<xsl:attribute name="class">cfLabelTitle cfLabelPosRight cfFirstChild</xsl:attribute>
										<xsl:attribute name="nowrap">nowrap</xsl:attribute>
									</xsl:element>
									<xsl:element name="td">
										<xsl:attribute name="width">1000</xsl:attribute>
										<xsl:element name="p">
										
											<xsl:call-template name="radio">
												<xsl:with-param name="attribs" select="$attribs"/>
											</xsl:call-template>
	
										</xsl:element>
									</xsl:element>
								</xsl:element>
							</xsl:for-each>
						</xsl:when>		
						
						<xsl:when test="self::cf:grid">
							<xsl:element name="tr">
								<xsl:attribute name="class">cfElementRow</xsl:attribute>
								<xsl:element name="td">
									<xsl:attribute name="colspan">2</xsl:attribute>
									<xsl:attribute name="valign">top</xsl:attribute>
									<xsl:attribute name="align">center</xsl:attribute>	
	
									<xsl:apply-templates select="."/>
								</xsl:element>
							</xsl:element>
						</xsl:when>
						
						<!-- checkbox buttons -->
						<xsl:when test="self::xf:select[@appearance='full']">
							<!-- group label, if it exists -->
							<xsl:if test="xf:label/text()  and count(xf:select[@appearance='full']/xf:choices/xf:item) > 1">
								<xsl:element name="tr">
									<xsl:element name="td">
										<xsl:attribute name="colspan">2</xsl:attribute>
										<xsl:attribute name="width">100%</xsl:attribute>
										<xsl:attribute name="class">cfHeaderTitle</xsl:attribute>
										<xsl:value-of select="xf:label/text()"/>
									</xsl:element>									
								</xsl:element>
							</xsl:if>
						
						
							<xsl:for-each select="xf:choices/xf:item">
							<xsl:element name="tr">
								<xsl:attribute name="class">cfElementRow</xsl:attribute>
								<xsl:element name="td">
									<xsl:attribute name="valign">top</xsl:attribute>
									<xsl:attribute name="align">right</xsl:attribute>
									<xsl:attribute name="width">100</xsl:attribute>
									<xsl:attribute name="class">cfLabelTitle cfLabelPosRight cfFirstChild</xsl:attribute>
									<xsl:attribute name="nowrap">nowrap</xsl:attribute>
									<xsl:if test="count(parent::*/parent::*/parent::*/xf:select[@appearance='full']) = 1">
										<!--<xsl:value-of select="xf:label/text()"/>-->
									</xsl:if>
								</xsl:element>								
								<xsl:element name="td">
									<xsl:attribute name="width">1000</xsl:attribute>
									<xsl:element name="p">
										<xsl:call-template name="checkbox">
											<xsl:with-param name="attribs" select="$attribs"/>										
										</xsl:call-template>
									</xsl:element>
								</xsl:element>
							</xsl:element>
							</xsl:for-each>
						</xsl:when>										
											

						<!-- other form controls -->
						<xsl:when test="not(self::xf:group) and not(self::xf:output) and not(self::xf:submit) and not(self::xf:trigger)">
							<xsl:element name="tr">
								<xsl:attribute name="class">cfElementRow</xsl:attribute>
							<!-- replace with cfHeaderTitle in separate row 
								<xsl:if test="position() = 1 and parent::*/xf:label/text()">
									<xsl:element name="td">
										<xsl:attribute name="valign">top</xsl:attribute>
										<xsl:attribute name="rowspan">99</xsl:attribute>
										<xsl:attribute name="width">100</xsl:attribute>
										<xsl:attribute name="class">cfLabelTitle cfLabelPosRight cfFirstChild</xsl:attribute>
										<xsl:attribute name="nowrap">nowrap</xsl:attribute>
										<xsl:value-of select="parent::*/xf:label/text()"/>
									</xsl:element>
								</xsl:if>
							-->
								<xsl:element name="td">
									<xsl:attribute name="valign">top</xsl:attribute>
									<xsl:attribute name="align">right</xsl:attribute>
									<xsl:attribute name="width">100</xsl:attribute>
									<xsl:attribute name="class">cfLabelTitle cfLabelPosRight cfFirstChild</xsl:attribute>
									<xsl:attribute name="nowrap">nowrap</xsl:attribute>
									<xsl:call-template name="label"/>
								</xsl:element>
								<xsl:element name="td">
									<xsl:attribute name="width">1000</xsl:attribute>
									<xsl:attribute name="align">left</xsl:attribute>
									<!-- <xsl:element name="p"> -->
									<xsl:apply-templates select=".">
										<xsl:with-param name="attribs" select="$attribs"/>
									</xsl:apply-templates>
									<!-- </xsl:element> -->
								</xsl:element>
							</xsl:element>
						</xsl:when>
			
															
						
						<!-- follow nested groups -->
						<xsl:otherwise>
							<xsl:element name="tr">
								<xsl:element name="td">
									<!-- align nested groups -->
									<xsl:if test="xf:extension/cf:attribute[@name='align']">
										<xsl:attribute name="align"><xsl:value-of select="xf:extension/cf:attribute[@name='align']"/></xsl:attribute>
									</xsl:if>		
									
									<xsl:attribute name="colspan">2</xsl:attribute>
									<xsl:apply-templates select=".">
										<xsl:with-param name="attribs" select="$attribs"/>
									</xsl:apply-templates>
								</xsl:element>
							</xsl:element>
						</xsl:otherwise>
					</xsl:choose>
				
			</xsl:for-each>
			<xsl:element name="tr">
				<xsl:element name="td">
					<xsl:element name="br"/>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	


</xsl:stylesheet>
