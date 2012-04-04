<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output
    method="html"
    encoding="ISO-8859-1"
    indent="yes"
    omit-xml-declaration="yes"
/>
  <xsl:template match="/" mode="rules">
    <html>
      <head>
        <xsl:apply-templates select="/opml/head/rules"/>
      </head>
      <body>
	  <h1>Cascading</h1>
        <xsl:apply-templates select="/opml/body/outline" mode="cascade"/>
	  <h1>Stacking</h1>
		<xsl:apply-templates select="/opml/body/outline" mode="stack"/>

      </body>

    </html>
  </xsl:template>

  <xsl:template match="rules">
    <style type="text/css">
      .rulescontainer {
        display: inline;
      }
      <xsl:for-each select="rule">
        .level<xsl:value-of select="@level"/> * {
        <xsl:for-each select="*">
          <xsl:value-of select="local-name()"/>: <xsl:value-of select="."/>;
        </xsl:for-each>
        }

      </xsl:for-each>
    </style>
  </xsl:template>

  <xsl:template match="outline" mode="cascade">
 		<xsl:call-template name="rulesoutlinecascade">
			<xsl:with-param name="content">
        <xsl:apply-templates select="outline" />
      </xsl:with-param>
		</xsl:call-template>
  </xsl:template>
  <xsl:template name="rulesoutlinecascade">
    <xsl:param name="content"/>
    <xsl:variable name="level" select="count(ancestor::outline)"/>
    <div>
      <xsl:attribute name="class">rulescontainer level<xsl:if test="count(/opml/head/rules/rule[@level=$level]) != 0"> level<xsl:value-of select="$level"/></xsl:if> <xsl:if test="count(@type) != 0"><xsl:text> </xsl:text><xsl:value-of select="@type"/></xsl:if><xsl:for-each select="/opml/head/rules/rule[@level=$level]/*"><xsl:choose><xsl:when test="local-name()='expanded' and text()='false'"> collapse</xsl:when></xsl:choose></xsl:for-each></xsl:attribute>
      <xsl:copy-of select="$content"/>
    </div>
  </xsl:template>
  <xsl:template match="outline" mode="stack">
 		<xsl:call-template name="rulesoutlinestack">
			<xsl:with-param name="content">
        <xsl:apply-templates select="outline" />
      </xsl:with-param>
		</xsl:call-template>
  </xsl:template>

  <xsl:template name="rulesoutlinestack">
 		<xsl:param name="content"/>
    <xsl:variable name="level" select="count(ancestor::outline)"/>
    <div>
      <xsl:attribute name="class">level<xsl:if test="count(/opml/head/rules/rule[@level=$level]) != 0"> level<xsl:value-of select="$level"/></xsl:if> <xsl:if test="count(@type) != 0"><xsl:text> </xsl:text><xsl:value-of select="@type"/></xsl:if> <xsl:if test="count(@class) != 0"><xsl:text> </xsl:text><xsl:value-of select="@class"/></xsl:if><xsl:for-each select="/opml/head/rules/rule[@level=$level]/*"><xsl:choose><xsl:when test="local-name()='expanded' and text()='false'"> collapse</xsl:when></xsl:choose></xsl:for-each></xsl:attribute>
      <p>
        <xsl:value-of select="@text"/>
      </p>
    </div>
    <xsl:copy-of select="$content"/>
  </xsl:template>
<!--
  <xsl:template match="outline" mode="style">
    <div>
      <p>
        <xsl:attribute name="style">
          <xsl:for-each select="/opml/head/rules/rule[count(@level) = 0]/*">
            <xsl:value-of select="local-name()"/>:<xsl:value-of select="."/>;
          </xsl:for-each>
          <xsl:for-each select="/opml/head/rules/rule[@level=count(ancestor::outline)]/*">
            <xsl:value-of select="local-name()"/>:<xsl:value-of select="."/>;
          </xsl:for-each>
        </xsl:attribute>
        <xsl:value-of select="@text"/>
      </p>
      <xsl:apply-templates select="outline" mode="style" />
    </div>
  </xsl:template>
-->
  <xsl:template match="node()|@*|text()|comment()" />
</xsl:stylesheet>