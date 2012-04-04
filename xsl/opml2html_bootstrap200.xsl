<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet  [
  <!ENTITY nbsp   "&#160;">
  <!ENTITY copy   "&#169;">
  <!ENTITY reg    "&#174;">
  <!ENTITY trade  "&#8482;">
  <!ENTITY mdash  "&#8212;">
  <!ENTITY ldquo  "&#8220;">
  <!ENTITY rdquo  "&#8221;">
  <!ENTITY pound  "&#163;">
  <!ENTITY yen    "&#165;">
  <!ENTITY euro   "&#8364;">
  <!ENTITY lsaquo "&#8249;">
  <!ENTITY rsaquo "&#8250;">
]>
<xsl:stylesheet
	version="1.0"
	extension-element-prefixes="yaslt"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:yaslt="http://www.mod-xslt2.com/ns/1.0"
	xmlns:my="my:namespace"
	xmlns:g="google"
	exclude-result-prefixes="my g"
>
<xsl:output 
	method="html" 
	media-type="text/html"
    doctype-system="about:legacy-compat"
	/>
	<!-- Include the rules template -->
	<xsl:include href="opml2html_rules.xsl" />
  <!-- Include the actions template -->
	<xsl:include href="opml2html_actions.xsl" />
  <!-- Include the dragdrop template -->
	<xsl:include href="opml2html_dragdrop.xsl" />  
  <!-- Include the gchart template -->
	<xsl:include href="opml2html_gchart.xsl" />  

<xsl:template name="head">
  <xsl:param name="content" />
  <head>
	<xsl:copy-of select="title" />
	<xsl:copy-of select="meta" />
	<link rel="alternate" type="application/rss+xml" title="RSS" href="index.rss" />
	<link rel="alternate" type="application/opml+xml" title="OPML" href="index.opml" />
	<link rel="outline" type="text/x-opml" title="Outline" href="index.opml" />
	<script src="lib/jquery/js/jquery-1.4.3.min.js" type="text/javascript"></script>
	<script src="lib/jquery-treeview/js/jquery.cookie.js" type="text/javascript"></script>
	<script src="lib/jquery-treeview/js/jquery.treeview.js" type="text/javascript"></script>
	<link rel="stylesheet" href="lib/jquery-treeview/css/jquery.treeview.lib.css" />
	<link rel="stylesheet" href="lib/bootstrap/css/bootstrap.css" />
	<script type="text/javascript" src="lib/bootstrap/js/bootstrap-modal.js"></script>
	<script type="text/javascript" src="lib/bootstrap/js/bootstrap-carousel.js"></script>
	<script type="text/javascript" src="lib/bootstrap/js/bootstrap-tab.js"></script>
	<script type="text/javascript" src="lib/bootstrap/js/bootstrap-tooltip.js"></script>
	<!--base target="_blank" /-->
	<style type="text/css">
      /* Override some defaults */
      html, body {
        background-color: #eee;
      }
      body {
        padding-top: 40px; /* 40px to make the container go all the way to the bottom of the topbar */
		background-image: url("");
      }
	  .container {

	  }
      .container > footer p {
        text-align: center; /* center align it with the container */
      }
      /* The white background content wrapper */
      .content {
        background-color: #fff;
        padding: 20px;
        margin: 0 -20px; /* negative indent the amount of the padding to maintain the grid system */
        -webkit-border-radius: 0 0 6px 6px;
           -moz-border-radius: 0 0 6px 6px;
                border-radius: 0 0 6px 6px;
        -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.15);
           -moz-box-shadow: 0 1px 2px rgba(0,0,0,.15);
                box-shadow: 0 1px 2px rgba(0,0,0,.15);
      }
      /* Page header tweaks */
      .page-header {
        background-color: #f5f5f5;
        padding: 20px 20px 10px;
        margin: -20px -20px 20px;
      }
	  li{
		font-size: 15px;
	  }
	  li.collapsable {
		font-size: 15px;
		font-weight: bold;
	  }
	  li p {
		whitespace: pre;
	  }
	  .carousel .item img, .carousel .item a img {
          margin:auto;
      }
      .carousel-caption {
          position: relative; /* set to absolute for overlap /*
          top: 0px;
          bottom: auto;
          padding-top: 5px;
          padding-bottom: 15px;
      }
    </style>
	<xsl:copy-of select="$content"/>
  </head>
</xsl:template>

<xsl:template name="body">
<xsl:param name="content" />
<body>
    <div class="navbar navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container-fluid">
				<h2 class="brand"><xsl:value-of select="../head/title" /></h2>
				<ul class="nav">
					<li class="active"><a href="index.opml" target="_self">Outline</a></li>
				</ul>
			</div>
		</div>
    </div>

	<div class="container">
		<div class="row">
			<div class="sidebar span2"> 
				<div class="well">
					<a href="http://opml.org"><img src="/lib/opml2html/img/opml-icon-16x16.png" alt="OPML" /> About OPML</a>
				</div>

				<div class="well">
					<a href="http://artronics.nl/opml2html.opml">About OPML2HTML</a>
				</div>
			</div>
			<div class="content span8">

				<xsl:copy-of select="$content"/>

				<footer>
					<p>Outline by 
						<a> 
							<xsl:attribute name="href">
								<xsl:value-of select="../head/ownerId"/>
							</xsl:attribute>
							<xsl:value-of select="../head/ownerName"/>
						</a>
					</p>
				</footer>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	$('#topbar').dropdown();
	</script>
</body>
</xsl:template>
  
  <xsl:template match="outline" mode="carousel">
    <div id="item{generate-id()}">
      <xsl:attribute name="class">item<xsl:if test="position()=1"> active</xsl:if></xsl:attribute>
      <div class="carousel-caption">
        <h4>
          <a href="{@htmlUrl}"><xsl:value-of select="@text"/></a>
        </h4>
        <p>
			    <xsl:value-of select="@description"/>
        </p>
      </div>
	    <img src="{@thumbUrl}" />
		  <xsl:apply-templates select="outline" />
	  </div>
  </xsl:template>
  
	<xsl:template match="@style">
		<xsl:copy>
			<xsl:apply-templates />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="@styles">
		<style type="text/css">
			<xsl:value-of select="." />
		</style>
	</xsl:template>
	<xsl:template match="@stylesheet">
		<link rel="stylesheet">
			<xsl:attribute name="href">
				<xsl:value-of select="."/>
			</xsl:attribute>
		</link>
	</xsl:template>
	<xsl:template match="@icon">
		<xsl:choose>
			<xsl:when test="substring(., string-length(.)-2) = 'png' or substring(., string-length(.)-2) = 'gif' or substring(., string-length(.)-2) = 'jpg'">
				<img>
					<xsl:attribute name="src">
						<xsl:value-of select="."/>
					</xsl:attribute>
				</img>
			</xsl:when>
			<xsl:otherwise>
				<i class="icon-{.}"></i> 
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="outlineitem">
		<xsl:param name="content"/>
		<xsl:choose>
          <xsl:when test="ancestor::outline[@type='outline']">
			<li>
				<xsl:copy-of select="$content" />
			</li>
		  </xsl:when>
          <xsl:otherwise>
			<xsl:copy-of select="$content" />
          </xsl:otherwise>
        </xsl:choose>
	</xsl:template>
	
	<xsl:template name="outlinecontent">
		<xsl:param name="content"/>
		<xsl:choose>
          <xsl:when test="ancestor::outline[@type='outline']">
			<ul>
				<xsl:copy-of select="$content" />
			</ul>
		  </xsl:when>
          <xsl:otherwise>
            <xsl:copy-of select="$content" />
          </xsl:otherwise>
        </xsl:choose>
	</xsl:template>
	
	<xsl:template name="outline">
		<xsl:param name="content"/>
		<xsl:value-of select="@text" disable-output-escaping="yes"/>
		<xsl:if test="@type">
			[<xsl:value-of select="@type" />]
		</xsl:if>
		<xsl:copy-of select="node()[name()!='outline']" />
		<xsl:choose>
			<xsl:when test="ancestor::outline[@type='outline'] and count(outline) != 0">
				<ul>
					<xsl:apply-templates select="outline" />
				</ul>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="outline" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="link">
		<xsl:param name="content"/>
		<xsl:apply-templates select="@icon" />
		<a>
			<xsl:attribute name="href">
				<xsl:value-of select="@url"/>
			</xsl:attribute>
			<xsl:apply-templates select="./@icon" />
			<xsl:value-of select="@text" disable-output-escaping="yes"/>
		</a>
		<xsl:if test="@description">
			<p xml:space="preserve"><xsl:value-of select="@description" /></p>
		</xsl:if>
		<xsl:call-template name="outlinecontent">
			<xsl:with-param name="content">
				<xsl:copy-of select="$content"/>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="rss">
		<xsl:param name="content"/>
		<xsl:apply-templates select="@icon" /><a>
			<xsl:attribute name="href">
				<xsl:value-of select="@htmlUrl"/>
			</xsl:attribute>
			<xsl:value-of select="@text" disable-output-escaping="yes"/>
		</a>
		<a>
			<xsl:attribute name="href">
				<xsl:value-of select="@xmlUrl"/>
			</xsl:attribute>
			<img src="/lib/opml2html/img/rss-icon-16x16.png" alt="RSS" />
		</a>
		<xsl:if test="@description">
			<p xml:space="preserve"><xsl:value-of select="@description" /></p>
		</xsl:if>
		<xsl:call-template name="outlinecontent">
			<xsl:with-param name="content">
				<xsl:copy-of select="$content"/>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="tree">
		<xsl:param name="content"/>
		<xsl:variable name="id" select="generate-id()"/>
		<ul id="tree{$id}" class="treeview">
		  <li>
			<xsl:value-of select="@text"/>
				<xsl:if test="count(outline)">
					<ul>
						<xsl:copy-of select="$content" />
					</ul>
				</xsl:if>
				</li>
			</ul>
			<script type="text/javascript">
				$('#tree<xsl:value-of select="$id"/>').treeview({
					persist: "cookie",
					cookieId: "treeview",
					collapsed: true,
				});
			</script>
	</xsl:template>
	<xsl:template name="thumblist">
		<xsl:param name="content"/>
		<ul class="thumbnails">
			<xsl:copy-of select="$content"/>
		</ul>
	</xsl:template>
	<xsl:template name="carousel">
		<xsl:param name="content"/>
		<div class="carousel slide" id="carousel{generate-id()}">
		  <!-- Carousel items -->
		  <div class="carousel-inner">
			  <xsl:apply-templates select="outline" mode="carousel" />
		  </div>
		  <!-- Carousel nav -->
		  <a class="carousel-control left" href="#carousel{generate-id()}" onclick="$('#carousel{generate-id()}').carousel('prev');$('#carousel{generate-id()}').carousel('pause');return false">&lsaquo;</a>
		  <a class="carousel-control right" href="#carousel{generate-id()}" onclick="$('#carousel{generate-id()}').carousel('next');$('#carousel{generate-id()}').carousel('pause');return false">&rsaquo;</a>
		</div>
		<script type="text/javascript">
		  $('#carousel{generate-id()}').carousel({interval:1000});
		  $('#carousel{generate-id()}').carousel('pause');
		</script>
	</xsl:template>
	<xsl:template name="photo">
		<xsl:param name="content"/>
    <xsl:choose>
      <xsl:when test="../@type='carousel'">
        <div id="item{generate-id()}">
          <xsl:attribute name="class">item<xsl:if test="position()=1"> active</xsl:if></xsl:attribute>
          <div class="carousel-caption">
            <h4>
              <a href="{@htmlUrl}"><xsl:value-of select="@text"/></a>
            </h4>
            <p>
			        <xsl:value-of select="@description"/>
            </p>
          </div>
	        <img src="{@thumbUrl}" />
		      <xsl:apply-templates select="outline" />
	      </div>
      </xsl:when>
      <xsl:otherwise>
        <a class="thumbnail" href="{@htmlUrl}">
			    <img class="thumbnail" src="{@thumbUrl}" alt="{@text}" width="{@thumbWidth}" height="{@thumbHeight}" />
		    </a>
      </xsl:otherwise>
    </xsl:choose>
	</xsl:template>
	<xsl:template name="button">
		<xsl:param name="content"/>
		<a href="#" class="btn">
          <xsl:attribute name="href">
            <xsl:choose>
              <xsl:when test="@url"><xsl:value-of select="@url"/></xsl:when>
              <xsl:otherwise>#</xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:attribute name="onclick">
            <xsl:value-of select="@script"/>
            <xsl:if test="../@type='modal'">
				$('#modal<xsl:value-of select="generate-id(..)"/>').modal('hide');return false;
			</xsl:if>
		  </xsl:attribute>
          <xsl:if test="@image">
            <img src="{@image}" border="0">
              <xsl:if test="@imageHover">
                <xsl:attribute name="onmouseover">this.src='<xsl:value-of select="@imageHover"/>'</xsl:attribute>
                <xsl:attribute name="onmouseout">this.src='<xsl:value-of select="@image"/>'</xsl:attribute>
              </xsl:if>
            </img>
          </xsl:if>
		  <xsl:apply-templates select="@icon" />
		  <xsl:value-of select="@text"/>
		</a>

	</xsl:template>
	<xsl:template name="script">
		<xsl:param name="content"/>
		<script>
          <xsl:value-of select="@text" />
        </script>
	</xsl:template>
	<xsl:template name="include">
		<xsl:param name="content"/>
		<xsl:apply-templates select="document(@url)/opml/body/outline" />
	</xsl:template>
	<xsl:template name="footer">
		<xsl:param name="content"/>
		<footer>
			<p>
				<xsl:copy-of select="$content"/>
			</p>
		</footer>
	</xsl:template>
	<xsl:template name="html">
		<xsl:param name="content"/>
		<xsl:copy-of select="node()[name()!='outline']" />
		<xsl:copy-of select="$content" />
	</xsl:template>
	<xsl:template name="input">
		<xsl:param name="content"/>
		<xsl:choose>
			<xsl:when test="@mode='text'">
				<xsl:call-template name="inputtext">
					<xsl:with-param name="content">
						<xsl:copy-of select="$content" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="@mode='password'">
				<xsl:call-template name="inputpassword">
					<xsl:with-param name="content">
						<xsl:copy-of select="$content" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="@mode='checkbox'">
				<xsl:call-template name="inputcheckbox">
					<xsl:with-param name="content">
						<xsl:copy-of select="$content" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="@mode='radio'">
				<xsl:call-template name="inputradio">
					<xsl:with-param name="content">
						<xsl:copy-of select="$content" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="@mode='textarea'">
				<xsl:call-template name="inputtextarea">
					<xsl:with-param name="content">
						<xsl:copy-of select="$content" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="@mode='file'">
				<xsl:call-template name="inputfile">
					<xsl:with-param name="content">
						<xsl:copy-of select="$content" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="@mode='select'">
				<xsl:call-template name="inputselect">
					<xsl:with-param name="content">
						<xsl:copy-of select="$content" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>

			<xsl:otherwise>
				<xsl:call-template name="inputtext">
				<xsl:with-param name="content">
					<xsl:copy-of select="$content" />
				</xsl:with-param>
			</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="inputtext">
		<xsl:param name="content"/>
		<br/><xsl:value-of select="@title"/><input type="text" name="{@text}"/><xsl:value-of select="@description"/>
	</xsl:template>
	<xsl:template name="inputpassword">
		<xsl:param name="content"/>
		<br/><xsl:value-of select="@title"/><input type="password" name="{@text}"/><xsl:value-of select="@description"/>
	</xsl:template>
	<xsl:template name="inputcheckbox">
		<xsl:param name="content"/>
		<br/><xsl:value-of select="@title"/><input type="checkbox" name="{@text}"/><xsl:value-of select="@description"/>
	</xsl:template>
	<xsl:template name="inputradio">
		<xsl:param name="content"/>
		<br/><xsl:value-of select="@title"/><input type="radio" name="{@text}"/><xsl:value-of select="@description"/>
	</xsl:template>
	<xsl:template name="inputtextarea">
		<xsl:param name="content"/>
	</xsl:template>
	<xsl:template name="inputfile">
		<xsl:param name="content"/>
	</xsl:template>
	<xsl:template name="inputselect">
		<xsl:param name="content"/>
	</xsl:template>
	<xsl:template name="modal">
		<xsl:param name="content"/>
		<xsl:param name="footer"/>
		<xsl:variable name="id" select="generate-id()"/>

		        <a href="#" onclick="$('#modal{$id}').modal('show'); return false;">
          <xsl:value-of select="@text"/>
        </a>
			<div class="modal hide fade">
				<xsl:attribute name="id">modal<xsl:value-of select="$id"/></xsl:attribute>
				<div class="modal-header">
					<a href="#" class="close">X</a>
					<h3>
					  <xsl:value-of select="@title"/>
					</h3>
				</div>
				<div class="modal-body">
					<p>
					  <xsl:value-of select="@description"/>
					</p>
					<xsl:copy-of select="$content"/>
				</div>
				<div class="modal-footer">
					<xsl:copy-of select="$footer"/>
				</div>
			</div>
<!--
 			<script type="text/javascript" defer="defer">
				$('#modal<xsl:value-of select="$id"/>').modal({
					backdrop: true,
					keyboard: true
				});
			</script>
 -->
	</xsl:template>
	<xsl:template name="heading">
		<xsl:param name="content"/>
		<xsl:element name="h{count(ancestor-or-self::outline[@type='header'])}">
				<xsl:copy-of select="@class" />
				<xsl:apply-templates select="@icon" />
				<xsl:value-of select="@text"/>
			</xsl:element>
			<xsl:copy-of select="$content" />

	</xsl:template>
	<xsl:template name="tabs">
		<xsl:param name="content"/>
		<ul class="nav nav-tabs">
			<xsl:for-each select="outline">
			  <li><xsl:attribute name="class"><xsl:if test="position() = 1">active</xsl:if></xsl:attribute>
			  <a href="#tab{generate-id(.)}" data-toggle="tab"><xsl:apply-templates select="@icon" /><xsl:value-of select="@text"/></a></li>
			</xsl:for-each>
		</ul>
			 
		<div class="tab-content">
			<xsl:for-each select="outline">
			  <div id="tab{generate-id(.)}">
			  <xsl:attribute name="class">tab-pane <xsl:value-of select="@class"/> <xsl:if test="position() = 1"> active</xsl:if></xsl:attribute>
				<xsl:apply-templates select="outline" />
			  </div>
			</xsl:for-each>
		</div>
	</xsl:template>
	<xsl:template name="accordion">
		<xsl:param name="content"/>
		<xsl:variable name="id" select="generate-id()"/>

			<div class="accordion" id="accordion{$id}">
				<xsl:for-each select="outline">
					<div class="accordion-group">
					  <div class="accordion-heading">
						<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion{$id}" href="#collapse{generate-id(.)}">
						  <xsl:apply-templates select="@icon" />
						  <xsl:value-of select="@text"/>
						</a>
					  </div>
					  <div id="collapse{generate-id(.)}" class="accordion-body collapse" style="height: 0px; ">
						<div class="accordion-inner">
						  <xsl:apply-templates select="outline" />
						</div>
					  </div>
					</div>
				</xsl:for-each>
			</div>
	</xsl:template>
	<xsl:template name="tooltip">
		<xsl:param name="content"/>
		<a href="#" rel="tooltip" data-original-title="{@description}"><xsl:value-of select="@text"/></a>
	</xsl:template>
	<xsl:template name="social">
		<xsl:param name="url" />
		<xsl:param name="text" />
		<xsl:param name="via">garagememories</xsl:param>
		<xsl:if test="$url">
			<br/>
			<g:plusone size="small" href="{$url}"></g:plusone>
			<a href="https://twitter.com/share" class="twitter-share-button" data-text="{$text}" data-url="{$url}" data-via="{$via}" data-lang="en">Tweet</a>
			<div class="fb-like" data-href="{$url}" data-send="true" data-layout="button_count" data-show-faces="false" data-ref="{$via}"></div>
			<a title="Send to linkblog." onclick="sendToLinkblog(encodeURIComponent('{$text}'), encodeURIComponent('{$url}'), encodeURIComponent'{$text}'))">
				<img src="/lib/opml2html/img/opml-icon-16x16.png" alt="OPML" />
			</a>
		</xsl:if>
	</xsl:template>
	<xsl:template name="twitterfollow">
		<xsl:param name="username" />
		<a href="https://twitter.com/{$username}" class="twitter-follow-button" data-show-count="true" data-show-screen-name="false">Follow {$username}</a>
		<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
	</xsl:template>
	<xsl:template name="googleanalytics">
		<script type="text/javascript">

		var _gaq = _gaq || [];
		_gaq.push(['_setAccount', 'UA-21063256-4']);
		_gaq.push(['_trackPageview']);

		(function() {
		var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
		ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
		var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
		})();
		</script>
	</xsl:template>
	<xsl:template name="googleplusonescript">
		<script type="text/javascript">
		(function() {
		var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
		po.src = 'https://apis.google.com/js/plusone.js';
		var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
		})();
		</script>
	</xsl:template>
	<xsl:template name="twitterscript">
		<script type="text/javascript">!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
	</xsl:template>
	<xsl:template name="facebookscript">
		<div id="fb-root"></div>
		<script type="text/javascript">
			<xsl:attribute name="src">http://connect.facebook.net/en_US/all.js#xfbml=1<xsl:if test="/opml/head/meta[@property='fb:app_id']/@content">&amp;appId=<xsl:value-of select="/opml/head/meta[@property='fb:app_id']/@content"/></xsl:if></xsl:attribute>
		</script>
		<script type="text/javascript" src='/lib/facebook/facebook.js'></script>
	</xsl:template>
	<xsl:template name="credits">
		<xsl:for-each select="//outline[@type='include']">
			,<xsl:apply-templates select="document(@url)/opml/head/ownerName"/>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="ownerName">
		<a href="{../ownerId}"><xsl:value-of select="." /></a>
		<xsl:call-template name="credits" />
	</xsl:template>
</xsl:stylesheet>
