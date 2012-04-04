<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output
    method="html"
    encoding="ISO-8859-1"
    indent="yes"
    omit-xml-declaration="yes"
/>
  <xsl:template match="/" mode="debug">
    <html>
      <head>
  		<xsl:call-template name="actionshead">
			<xsl:with-param name="content" />
		</xsl:call-template>
 		<xsl:apply-templates select="/opml/head/rules"/>
     </head>
      <body>

	  <h1>Cascading</h1>
	  <div id="content1" class="level level-1">
        <xsl:apply-templates select="/opml/body/outline" mode="cascade"/>
	  </div>
		<xsl:call-template name="dropscript">
			<xsl:with-param name="id">content1</xsl:with-param>
		</xsl:call-template>
	  <h1>Stacking</h1>
	  <div id="content2" class="level level-1">
		<xsl:apply-templates select="/opml/body/outline" mode="stack"/>
	  </div>
		<xsl:call-template name="dropscript">
			<xsl:with-param name="id">content2</xsl:with-param>
		</xsl:call-template>
		<div id="trash" style="background-color:#cccccc; min-height:50px;" class="level level-1">
			<i class="icon-trash"></i>
		</div>
		<xsl:call-template name="dropscript">
			<xsl:with-param name="id">trash</xsl:with-param>
		</xsl:call-template>
      </body>

    </html>
  </xsl:template>

  <xsl:template name="actionshead">
    <xsl:param name="content" />
	  <script src="lib/jquery/jquery-1.7.1.js" type="text/javascript"></script>
	  <script src="lib/jquery/jquery.cookie.js" type="text/javascript"></script>
	  <script src="lib/jquery/jquery.treeview.js" type="text/javascript"></script>
	  <link rel="stylesheet" href="lib/jquery/jquery.treeview.css" />
	  <link rel="stylesheet" href="lib/bootstrap/2.0/css/bootstrap.css" />
	  <script src="lib/jquery/ui/js/jquery-ui-1.8.18.custom.min.js" type="text/javascript"></script>
	  <script type="text/javascript" src="lib/bootstrap/2.0/js/bootstrap.js"></script>
	  <script type="text/javascript" src="lib/bootstrap/2.0/js/bootstrap-modal.js"></script>
	  <script type="text/javascript" src="lib/bootstrap/2.0/js/bootstrap-carousel.js"></script>
	  <script type="text/javascript" src="lib/bootstrap/2.0/js/bootstrap-tab.js"></script>
	  <script type="text/javascript" src="lib/bootstrap/2.0/js/bootstrap-tooltip.js"></script>
	  <style type="text/css">
	  .actions {
		  cursor: pointer;
	  }
    .actionscontainer {
      display: inline;
    }
	  </style>
  </xsl:template>
  
  <xsl:template name="actionsbody">
    <xsl:param name="content" />
	  <div id="actionscontent" class="level level-1">
 		  <xsl:call-template name="actions">
			  <xsl:with-param name="id" select="generate-id()"/>
			  <xsl:with-param name="xpath">/opml/body</xsl:with-param>
        <xsl:with-param name="type">root</xsl:with-param>
		  </xsl:call-template>
	  	<xsl:copy-of select="$content"/>
	  </div>
  </xsl:template>
 
  <xsl:template match="outline" mode="cascade">
	<xsl:call-template name="actionsoutlinecascade">
		<xsl:with-param name="content" />
	</xsl:call-template>
  </xsl:template>
  
  <xsl:template name="actionsoutlinecascade">
    <xsl:param name="content"/>
    <xsl:variable name="id">actions<xsl:value-of select="generate-id()"/></xsl:variable>
    <xsl:variable name="level" select="count(ancestor::outline)"/>
	  <xsl:variable name="xpath">
		<xsl:for-each select="ancestor-or-self::*">
		  <xsl:text>/</xsl:text>
		  <xsl:value-of select="name()" />
		  <xsl:if test="name()='outline'">[@text='<xsl:value-of select="@text" />']</xsl:if>
		</xsl:for-each>
	</xsl:variable>
    <div id="{$id}">
      <xsl:attribute name="class">actionscontainer</xsl:attribute>
		  <xsl:call-template name="actions">
			  <xsl:with-param name="id" select="$id"/>
			  <xsl:with-param name="xpath" select="$xpath"/>
		  </xsl:call-template>
      <xsl:copy-of select="$content"/>
    </div>
  </xsl:template>
  
  <xsl:template match="outline" mode="stack">
    <xsl:param name="content" />
    <xsl:variable name="id">stack<xsl:value-of select="generate-id()"/></xsl:variable>
    <xsl:variable name="level" select="count(ancestor::outline)"/>
    <xsl:variable name="xpath">
      <xsl:for-each select="ancestor-or-self::*">
        <xsl:text>/</xsl:text>
        <xsl:value-of select="name()" />
        <xsl:if test="name()='outline'">[@text='<xsl:value-of select="@text" />']</xsl:if>
      </xsl:for-each>
    </xsl:variable>
    <div id="{$id}">
      <xsl:attribute name="class">level<xsl:if test="count(/opml/head/rules/rule[@level=$level]) != 0"> level<xsl:value-of select="$level"/></xsl:if> <xsl:if test="count(@type) != 0"><xsl:text> </xsl:text><xsl:value-of select="@type"/><xsl:if test="count(@class) != 0"><xsl:text> </xsl:text><xsl:value-of select="@class"/></xsl:if></xsl:if><xsl:for-each select="/opml/head/rules/rule[@level=$level]/*"><xsl:choose><xsl:when test="local-name()='expanded' and text()='false'"> collapse</xsl:when></xsl:choose></xsl:for-each></xsl:attribute>
		<xsl:call-template name="actions">
			<xsl:with-param name="id" select="$id"/>
			<xsl:with-param name="xpath" select="$xpath"/>
		</xsl:call-template>
      <xsl:copy-of select="$content"/>
    </div>
	<xsl:apply-templates select="outline" mode="stack" />
  </xsl:template>

  <xsl:template name="actions">
	<xsl:param name="id" select="generate-id()"/>
	<xsl:param name="xpath"/>
	<xsl:param name="type" select="@type"/>
	<div class="actions pull-right">
		<i class="icon-edit" onclick="alert('edit({{id:'+this.attributes['data-id'].value+', xpath:'+this.attributes['data-xpath'].value+', type:'+this.attributes['data-type'].value+'}})')" data-id="{$id}" data-xpath="{$xpath}" data-type="{$type}"></i>
	</div>

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