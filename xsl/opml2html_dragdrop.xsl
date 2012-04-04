<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output
    method="html"
    encoding="ISO-8859-1"
    indent="yes"
    omit-xml-declaration="yes"
/>
  <xsl:template match="/" mode="dragdrop">
    <html>
      <head>
  		<xsl:call-template name="dragdrophead">
			<xsl:with-param name="content" />
		</xsl:call-template>
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

  <xsl:template name="dragdrophead">
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
	.dragdropcontainer {
  }
  .ui-draggable {
		cursor: move;
	}
	.ui-draggable-dragging {
    display: block;
	}
	.ui-droppable {
	}
	.ui-droppable:hover {
	}
	.dropactive {
    border: 1px dashed rgba(0, 0, 0, 0.10);
  }	
  .drophover {
		border: 1px solid rgba(0, 0, 0, 1);
	}
	</style>
	<xsl:copy-of select="$content"/>
  </xsl:template>
  
  <xsl:template name="dragdropbody">
      <xsl:param name="content" />
	  <div id="dragdropcontent" class="level level-1">
	  	<xsl:copy-of select="$content"/>
	  </div>
    <!--
		<xsl:call-template name="dropscript">
			<xsl:with-param name="id">dragdropcontent</xsl:with-param>
	  </xsl:call-template>
    -->
  </xsl:template>
 
  <xsl:template match="outline" mode="cascade">
	<xsl:call-template name="dragdropoutlinecascade">
		<xsl:with-param name="content">
			<xsl:apply-templates select="outline" mode="cascade"/>
		</xsl:with-param>
	</xsl:call-template>
  </xsl:template>
  
  <xsl:template name="dragdropoutlinecascade">
    <xsl:param name="content"/>
    <xsl:variable name="id">dragdrop<xsl:value-of select="generate-id()"/></xsl:variable>
    <xsl:variable name="level" select="count(ancestor::outline)"/>
    <div id="{$id}">
      <xsl:attribute name="class">dragdropcontainer</xsl:attribute>
      <xsl:copy-of select="$content"/>
    </div>
	  <xsl:call-template name="dragscript">
		  <xsl:with-param name="id" select="$id"/>
	  </xsl:call-template>
  </xsl:template>
  
  <xsl:template match="outline" mode="stack">
	<xsl:call-template name="dragdropoutlinestack">
		<xsl:with-param name="content">
			<xsl:apply-templates select="outline" mode="stack"/>
		</xsl:with-param>
	</xsl:call-template>
  </xsl:template>
  
  <xsl:template name="dragdropoutlinestack">
    <xsl:variable name="id">dragdrop<xsl:value-of select="generate-id()"/></xsl:variable>
    <xsl:variable name="level" select="count(ancestor::outline)"/>
    <div id="{$id}">
      <xsl:attribute name="class">level<xsl:if test="count(/opml/head/rules/rule[@level=$level]) != 0"> level<xsl:value-of select="$level"/></xsl:if> <xsl:if test="count(@type) != 0"><xsl:text> </xsl:text><xsl:value-of select="@type"/></xsl:if><xsl:for-each select="/opml/head/rules/rule[@level=$level]/*"><xsl:choose><xsl:when test="local-name()='expanded' and text()='false'"> collapse</xsl:when></xsl:choose></xsl:for-each></xsl:attribute>
      <p>
        <xsl:value-of select="@text"/>
      </p>
    </div>
	<xsl:call-template name="dragscript">
		<xsl:with-param name="id" select="$id"/>
	</xsl:call-template>
	<xsl:apply-templates select="outline" mode="stack" />
  </xsl:template>
  
  <xsl:template name="dragscript">
	<xsl:param name="id" select="generate-id()"/>
	  <script>
	$(document).ready(function() {
		$('#<xsl:value-of select="$id"/>').draggable({axis:'y', revert: true, opacity: 0.35});
	});
	</script>
	<xsl:call-template name="dropscript">
		<xsl:with-param name="id" select="$id"/>
	</xsl:call-template>
  </xsl:template>
  <xsl:template name="dropscript">
  	<xsl:param name="id" select="generate-id()"/>
	<xsl:variable name="max-depth">
		<xsl:for-each select="//outline">
			<xsl:sort select="count(ancestor::outline)" data-type="number"/>
			<xsl:if test="position()=last()">
				<xsl:copy-of select="count(ancestor::outline)"/>
			</xsl:if>
		</xsl:for-each>
	</xsl:variable>
	  <script>
	$(document).ready(function() {
		$('#<xsl:value-of select="$id"/>').droppable({
			tolerance: 'pointer',
      activeClass: 'dropactive',
			hoverClass: 'drophover',
			greedy: true,
			drop: function(event, ui) { 
				ui.draggable.removeAttr('style');
/*				var oldClass = ui.draggable.attr('class').split(' ')[1];
				var newClass = 'level'+(1 + parseInt(this.attributes['class'].value.split(' ')[1].substr(5)));
				var oldValue = ui.draggable.attr('class');
				var newValue = oldValue.replace(oldClass, newClass);
				ui.draggable.attr('class', newValue);
*/
				$('#'+this.id).append(ui.draggable);
			}
		});
	});
	</script>
  </xsl:template>
</xsl:stylesheet>