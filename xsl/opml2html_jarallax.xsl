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
	<xsl:template match="/">
	<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml">
		<xsl:apply-templates select="opml" />
	</html>
	</xsl:template>
	<xsl:template match="opml">
		<xsl:apply-templates select="head" />
		<xsl:apply-templates select="body" />
	</xsl:template>
	<xsl:template match="head">
	  <head>
		<xsl:copy-of select="title" />
		<xsl:copy-of select="meta" />
		<script type="text/javascript" src="lib/jquery/js/jquery.js"></script>
		<script type="text/javascript" src="lib/jarallax/js/jarallax-0.2.js"></script>
		<style type="text/css">
.jarallax_background {
	margin-left:-650px;
	width:1280px;
	height:1024px;
	position:fixed;
	left:50%;
	background: url(photos/construction_v.jpg);
	display:block;
	z-index:-1;
	top:0px;
}
.jarallax_item {
	position:fixed;
	display:block;
	z-index:1;
	top:98%;
	color: white;
}
h1 {
	width:60%;
	margin-left: 30%;
	color: white;
}
p {
	width:60%;
	margin-left: 30%;
	background-color: white;
}
body {
	font-size: 150px;
	width:60%;
	margin-left: 30%;
	background-color: white;
	overflow: scroll;
}
		</style>
	  </head>
	</xsl:template>
	<xsl:template match="body">
		<body>
			<span class="jarallax_background"></span>
			<div style="height:204800px"></div>
			<script type="text/javascript">
var jarallax = new Jarallax()
jarallax.addAnimation('.jarallax_background', 
			  [{progress:'0%', top:'0px'},
			   {progress:'100%', top:'-100px'}]);
			</script>
			<xsl:apply-templates select="//outline" />
			<script type="text/javascript">
$('html, body').animate({ 
   scrollTop: $(document).height()-$(window).height()}, 
   100000
);
			</script>
		</body>
	</xsl:template>
	<xsl:template match="outline">
	<xsl:variable name="id" select="generate-id()"/>
<span id="{$id}" style="position:fixed;display:block;z-index:{count(ancestor-or-self::outline)};top:{(position()*1000) div count(ancestor-or-self::outline)}%;font-size:{100 div (count(ancestor::outline))}%;opacity: 0.5;">
	<xsl:value-of select="@text" />
</span>
<script type="text/javascript">
jarallax.addAnimation('#<xsl:value-of select="$id"/>',[
	{progress:'0%', top:'<xsl:value-of select="(position()*100) * count(ancestor-or-self::outline)"/>px'},
	{progress:'<xsl:value-of select="(position() + (count(ancestor-or-self::outline) * 0.1) * 10)"/>%',top:'-<xsl:value-of select="(position()*100) * count(ancestor-or-self::outline)"/>px'}
]);
</script>
	</xsl:template>

</xsl:stylesheet>
