<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0" >
    <xsl:output method="xml" indent="yes" version='1.0' encoding="UTF-8"/>
    <xsl:param name="var" select="document('NAM.xml')" />
    
    <xsl:variable name="test" select="$var/descendant::w" />
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="/*">
        <gpx xmlns="http://www.topografix.com/GPX/1/1" 
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
            xsi:schemaLocation="http://www.topografix.com/GPX/1/1 http://www.topografix.com/GPX/1/1/gpx.xsd">
            <xsl:attribute name="version">1.1</xsl:attribute>
            <xsl:attribute name="creator">user</xsl:attribute>
            <metadata>
                <name>Cussac</name>
                <link href="file:///instance1.xml">
                    <text>fr_cussac.txt</text>
                </link>
            </metadata>
            <xsl:for-each select="entite_nom">
                <xsl:if test="node() = $test">
                    <wpt lat="{@lat}" lon="{@lng}" >
                        <ele>
                            <xsl:value-of  select="@alt"/>
                        </ele>
                        <name>
                            <xsl:apply-templates select="node()"/>
                        </name>
                        
                    </wpt> 
                </xsl:if>
            </xsl:for-each>
            <trk>
                <name>Cussac</name>
                <trkseg>
                    <xsl:for-each select="entite_nom">
                        <xsl:if test="node() = $test">
                            <trkpt lat="{@lat}" lon="{@lng}" > 
                                
                                <ele>
                                    <xsl:value-of  select="@alt"/>
                                </ele>
                                <xsl:element name="time">
                                    <xsl:value-of  select="xs:dateTime('2020-04-29T01:00:00') + position() * xs:dayTimeDuration('P0DT1H')" />
                                </xsl:element>
                                <name>
                                    <xsl:apply-templates select="node()"/>
                                </name>
                            </trkpt> 
                        </xsl:if>
                    </xsl:for-each>
                </trkseg>
            </trk>
        </gpx>
    </xsl:template>
    
</xsl:stylesheet>