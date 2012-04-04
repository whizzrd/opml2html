<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output
    method="html"
    encoding="ISO-8859-1"
    indent="yes"
    omit-xml-declaration="yes"
/>
  <xsl:template match="outline" mode="qrcode">
 		<xsl:call-template name="qrcode">
			<xsl:with-param name="content">
				<xsl:value-of select="@text"/>
			</xsl:with-param>
		</xsl:call-template>
  </xsl:template>

  <xsl:template match="outline[@type='qrcode']">
 		<xsl:call-template name="qrcode">
			<xsl:with-param name="content">
				<xsl:value-of select="@text"/>
			</xsl:with-param>
		</xsl:call-template>
  </xsl:template>

  <xsl:template match="outline[@type='formula']">
 		<xsl:call-template name="formula">
			<xsl:with-param name="content">
				<xsl:value-of select="@text"/>
			</xsl:with-param>
		</xsl:call-template>
  </xsl:template>

  
  <xsl:template name="qrcode">
    <xsl:param name="content"/>
 		<xsl:call-template name="googlechart">
			<xsl:with-param name="width">150</xsl:with-param>
			<xsl:with-param name="height">150</xsl:with-param>
			<xsl:with-param name="type">qr</xsl:with-param>
			<xsl:with-param name="content" select="$content" />
		</xsl:call-template>
  </xsl:template>

  <xsl:template name="formula">
    <xsl:param name="content"/>
 		<xsl:call-template name="googlechart">
			<xsl:with-param name="width">0</xsl:with-param>
			<xsl:with-param name="height">0</xsl:with-param>
			<xsl:with-param name="type">tx</xsl:with-param>
			<xsl:with-param name="content" select="$content" />
		</xsl:call-template>
  </xsl:template>
  
  <xsl:template name="googlechart">
    <xsl:param name="width"/>
	  <xsl:param name="height"/>
	  <xsl:param name="type"/>
	  <xsl:param name="content"/>
    <xsl:choose>
      <xsl:when test="$type='qr'">
        <img>
          <xsl:attribute name="src">https://chart.googleapis.com/chart?<xsl:if test="$width!=0 and $height!=0">chs=<xsl:value-of select="$width"/>x<xsl:value-of select="$height"/>&amp;</xsl:if>cht=<xsl:value-of select="$type"/>&amp;chl=<xsl:value-of select="$content"/></xsl:attribute>
        </img>      
      </xsl:when>
      <xsl:when test="$type='tx'">
        <img>
          <xsl:attribute name="src">https://chart.googleapis.com/chart?<xsl:if test="$width!=0 and $height!=0">chs=<xsl:value-of select="$width"/>x<xsl:value-of select="$height"/>&amp;</xsl:if>cht=<xsl:value-of select="$type"/>&amp;chl=<xsl:value-of select="$content"/></xsl:attribute>
        </img>
      </xsl:when>
      <xsl:otherwise>
        <img>
          <xsl:attribute name="src">https://chart.googleapis.com/chart?<xsl:if test="$width!=0 and $height!=0">chs=<xsl:value-of select="$width"/>x<xsl:value-of select="$height"/>&amp;</xsl:if>cht=<xsl:value-of select="$type"/>&amp;chl=<xsl:value-of select="$content"/></xsl:attribute>
        </img>
      </xsl:otherwise>
    </xsl:choose>
    <!--
	  <script>
      
      document.write();
    </script>
    -->
  </xsl:template>
  
</xsl:stylesheet>