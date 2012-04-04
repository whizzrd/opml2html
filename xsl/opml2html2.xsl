<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	extension-element-prefixes="yaslt"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:yaslt="http://www.mod-xslt2.com/ns/1.0"
	xmlns:my="my:namespace"
	xmlns:g="google"
	xmlns="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="my"
>
<xsl:output 
	method="html" 
	doctype-system="http://www.w3.org/TR/html4/strict.dtd" 
	doctype-public="-//W3C//DTD HTML 4.01//EN" 
	media-type="text/html" />

	<!-- Include the Twitter Bootstrap based template -->
	<xsl:include href="opml2html_bootstrap200.xsl" />
	
	<!-- The root node; entrypoint: transform starts here -->
	<xsl:template match="/">
		<html>
			<xsl:apply-templates select="opml" />
		</html>
	</xsl:template>

	<!-- Define the Opml Content -->
	<xsl:template match="opml">
		<xsl:apply-templates select="head" />
		<xsl:apply-templates select="body" />
	</xsl:template>

	
	<!-- Define the Head Content -->
	<xsl:template match="head">
		<xsl:call-template name="head">
			<xsl:with-param name="content">
				<!--<xsl:apply-templates select="rules"/>-->
				<xsl:call-template name="actionshead"/>
				<xsl:call-template name="dragdrophead"/>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!-- Define the Site Layout -->
	<xsl:template match="body">
		<xsl:call-template name="body">
			<xsl:with-param name="content">
	      <xsl:call-template name="dragdropbody">
	      <xsl:with-param name="content">
	      <xsl:call-template name="actionsbody">
	      <xsl:with-param name="content">
				  <xsl:apply-templates select="outline" />
        </xsl:with-param>
        </xsl:call-template>
        </xsl:with-param>
        </xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!-- nodeType template dispatcher with wrappers -->
	<xsl:template match="outline">
	<xsl:call-template name="dragdropoutlinecascade">
	<xsl:with-param name="content">
	<xsl:call-template name="actionsoutlinecascade">
	<xsl:with-param name="content">
	<xsl:call-template name="rulesoutlinecascade">
	<xsl:with-param name="content">
	<xsl:call-template name="outlineitem">
	<xsl:with-param name="content">
	<xsl:choose>
		<xsl:when test="@type='link'">
			<xsl:call-template name="link">
				<xsl:with-param name="content">
					<xsl:apply-templates select="*" />
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="@type='rss'">
			<xsl:call-template name="rss">
				<xsl:with-param name="content">
					<xsl:apply-templates select="*" />
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="@type='outline'">
			<xsl:call-template name="tree">
				<xsl:with-param name="content">
					<xsl:apply-templates select="outline" />
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="@type='thumblist'">
			<xsl:call-template name="thumblist">
				<xsl:with-param name="content">
					<xsl:apply-templates select="outline[@type='photo']"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="@type='carousel'">
			<xsl:call-template name="carousel">
				<xsl:with-param name="content">
					<xsl:apply-templates select="outline" mode="carousel" /> 
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="@type='photo'">
			<xsl:call-template name="photo">
				<xsl:with-param name="content">
					<xsl:apply-templates select="outline" /> 
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="@type='button'">
			<xsl:call-template name="button">
				<xsl:with-param name="content">
					<xsl:apply-templates select="outline" /> 
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="@type='script'">
			<xsl:call-template name="script">
				<xsl:with-param name="content">
					<xsl:apply-templates select="outline" /> 
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="@type='include'">
			<xsl:call-template name="include">
				<xsl:with-param name="content">
					<xsl:apply-templates select="outline" /> 
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="@type='footer'">
			<xsl:call-template name="footer">
				<xsl:with-param name="content">
					<xsl:apply-templates select="outline" /> 
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="@type='html'">
			<xsl:call-template name="html">
				<xsl:with-param name="content">
					<xsl:apply-templates select="outline" /> 
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="@type='input'">
			<xsl:call-template name="input">
				<xsl:with-param name="content">
					<xsl:apply-templates select="outline" /> 
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="@type='modal'">
			<xsl:call-template name="modal">
				<xsl:with-param name="content">
					<xsl:apply-templates select="outline[@type!='footer']" /> 
				</xsl:with-param>
				<xsl:with-param name="footer">
					<xsl:apply-templates select="outline[@type='footer']" /> 
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>

		<xsl:when test="@type='header'">
			<xsl:call-template name="heading">
				<xsl:with-param name="content">
					<xsl:apply-templates select="outline" /> 
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>

		<xsl:when test="@type='heading'">
			<xsl:call-template name="heading">
				<xsl:with-param name="content">
					<xsl:apply-templates select="outline" /> 
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>

		<xsl:when test="@type='tabs'">
			<xsl:call-template name="tabs">
				<xsl:with-param name="content">
					<xsl:apply-templates select="outline" /> 
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="@type='accordion'">
			<xsl:call-template name="accordion">
				<xsl:with-param name="content">
					<xsl:apply-templates select="outline" /> 
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		
		<xsl:when test="@type='tooltip'">
			<xsl:call-template name="tooltip">
				<xsl:with-param name="content">
					<xsl:apply-templates select="outline" /> 
				</xsl:with-param>
			</xsl:call-template>
			</xsl:when>
	
		<xsl:otherwise>
			<xsl:choose>
				<xsl:when test="@class">
					<div class="{@class}">
						<xsl:apply-templates select="@icon" /><xsl:call-template name="outline">
							<xsl:with-param name="content">
								<xsl:apply-templates select="outline" /> 
							</xsl:with-param>
						</xsl:call-template>
					</div>
				</xsl:when>
				
				<xsl:otherwise>
					<xsl:apply-templates select="@icon" /><xsl:call-template name="outline">
						<xsl:with-param name="content">
							<xsl:apply-templates select="outline" /> 
						</xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:otherwise>
    </xsl:choose>
  </xsl:with-param>
  </xsl:call-template>
  </xsl:with-param>
  </xsl:call-template>
  </xsl:with-param>
  </xsl:call-template>
  </xsl:with-param>
  </xsl:call-template>
  </xsl:template>

	
</xsl:stylesheet>
