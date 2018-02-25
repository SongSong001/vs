<?xml version="1.0" encoding="utf-8" ?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:static-data='#' version="1.0" exclude-result-prefixes="static-data"><xsl:output method="html" version="4.0" encoding="UTF-8" omit-xml-declaration="yes" indent="no" doctype-public="-//W3C//DTD HTML 4.01//EN" doctype-system="http://www.w3.org/TR/html4/strict.dtd" media-type="text/html"></xsl:output>
<xsl:preserve-space elements="html value display abbr"></xsl:preserve-space>
<xsl:strip-space elements=""></xsl:strip-space>
<xsl:template name="common.replace"><xsl:param name="string"></xsl:param>
<xsl:param name="pattern"></xsl:param>
<xsl:param name="replacement"></xsl:param>
<xsl:choose><xsl:when test="contains($string, $pattern)"><xsl:value-of select="substring-before($string, $pattern)"></xsl:value-of>
<xsl:value-of select="$replacement"></xsl:value-of>
<xsl:call-template name="common.replace"><xsl:with-param name="string" select="substring-after($string, $pattern)"></xsl:with-param>
<xsl:with-param name="pattern" select="$pattern"></xsl:with-param>
<xsl:with-param name="replacement" select="$replacement"></xsl:with-param></xsl:call-template></xsl:when>
<xsl:otherwise><xsl:value-of select="$string"></xsl:value-of></xsl:otherwise></xsl:choose></xsl:template>
<xsl:template name="common.js-string"><xsl:param name="escapee"></xsl:param>
<xsl:text>&#39;</xsl:text>
<xsl:choose><xsl:when test="not(contains($escapee, &quot;&#39;&quot;) or                           contains($escapee, &#39;\&#39;))"><xsl:call-template name="common.escape-js-text"><xsl:with-param name="js-text" select="$escapee"></xsl:with-param></xsl:call-template></xsl:when>
<xsl:otherwise><xsl:call-template name="common.replace"><xsl:with-param name="pattern" select="&quot;&#39;&quot;"></xsl:with-param>
<xsl:with-param name="replacement" select="&quot;\&#39;&quot;"></xsl:with-param>
<xsl:with-param name="string"><xsl:call-template name="common.replace"><xsl:with-param name="pattern">&amp;#13;</xsl:with-param>
<xsl:with-param name="replacement"><xsl:text>\r</xsl:text></xsl:with-param>
<xsl:with-param name="string"><xsl:call-template name="common.replace"><xsl:with-param name="pattern">&amp;#10;</xsl:with-param>
<xsl:with-param name="replacement"><xsl:text>\n</xsl:text></xsl:with-param>
<xsl:with-param name="string"><xsl:call-template name="common.replace"><xsl:with-param name="pattern" select="&#39;\&#39;"></xsl:with-param>
<xsl:with-param name="replacement" select="&#39;\\&#39;"></xsl:with-param>
<xsl:with-param name="string"><xsl:call-template name="common.escape-js-text"><xsl:with-param name="js-text" select="$escapee"></xsl:with-param></xsl:call-template></xsl:with-param></xsl:call-template></xsl:with-param></xsl:call-template></xsl:with-param></xsl:call-template></xsl:with-param></xsl:call-template></xsl:otherwise></xsl:choose>
<xsl:text>&#39;</xsl:text></xsl:template>
<xsl:template name="common.email-to-nmtoken"><xsl:param name="email"></xsl:param>
<xsl:call-template name="common.replace"><xsl:with-param name="string" select="$email"></xsl:with-param>
<xsl:with-param name="pattern" select="&#39;@&#39;"></xsl:with-param>
<xsl:with-param name="replacement" select="&#39;:40&#39;"></xsl:with-param></xsl:call-template></xsl:template>
<xsl:template match="html" mode="common.inline-html"><xsl:for-each select="*|text()"><xsl:copy-of select="."></xsl:copy-of></xsl:for-each></xsl:template>
<xsl:template match="text()" mode="common.html-to-text"><xsl:value-of select="."></xsl:value-of></xsl:template>
<xsl:template match="br" mode="common.html-to-text"><xsl:text>
</xsl:text></xsl:template>
<xsl:template match="*" mode="common.html-to-text"><xsl:apply-templates select="*|text()" mode="common.html-to-text"></xsl:apply-templates></xsl:template>
<xsl:template match="text()" mode="common.escape-xml"><xsl:call-template name="common.escape-xml-text"><xsl:with-param name="xml-text" select="."></xsl:with-param></xsl:call-template></xsl:template>
<xsl:template match="*" mode="common.escape-xml"><xsl:text>&lt;</xsl:text> <xsl:value-of select="name(.)"></xsl:value-of> <xsl:for-each select="./@*"><xsl:text> </xsl:text> <xsl:value-of select="name(.)"></xsl:value-of> <xsl:text>=&quot;</xsl:text> <xsl:call-template name="common.escape-xml-value"><xsl:with-param name="attr-value" select="."></xsl:with-param></xsl:call-template> <xsl:text>&quot;</xsl:text></xsl:for-each> <xsl:choose><xsl:when test="count(*|text()) = 0"><xsl:text>/&gt;</xsl:text></xsl:when> <xsl:otherwise><xsl:text>&gt;</xsl:text> <xsl:apply-templates select="*|text()" mode="common.escape-xml"></xsl:apply-templates> <xsl:text>&lt;/</xsl:text> <xsl:value-of select="name(.)"></xsl:value-of> <xsl:text>&gt;</xsl:text></xsl:otherwise></xsl:choose></xsl:template>
<xsl:template name="common.escape-xml-value"><xsl:param name="attr-value"></xsl:param>
<xsl:call-template name="common.replace"><xsl:with-param name="string"><xsl:call-template name="common.escape-xml-text"><xsl:with-param name="xml-text" select="$attr-value"></xsl:with-param></xsl:call-template></xsl:with-param>
<xsl:with-param name="pattern" select="&#39;&quot;&#39;"></xsl:with-param>
<xsl:with-param name="replacement" select="&#39;&amp;quot;&#39;"></xsl:with-param></xsl:call-template></xsl:template>
<xsl:template name="common.escape-xml-text"><xsl:param name="xml-text"></xsl:param>
<xsl:call-template name="common.replace"><xsl:with-param name="string"><xsl:call-template name="common.replace"><xsl:with-param name="string"><xsl:call-template name="common.replace"><xsl:with-param name="string" select="$xml-text"></xsl:with-param>
<xsl:with-param name="pattern" select="&#39;&amp;&#39;"></xsl:with-param>
<xsl:with-param name="replacement" select="&#39;&amp;amp;&#39;"></xsl:with-param></xsl:call-template></xsl:with-param>
<xsl:with-param name="pattern" select="&#39;&lt;&#39;"></xsl:with-param>
<xsl:with-param name="replacement" select="&#39;&amp;lt;&#39;"></xsl:with-param></xsl:call-template></xsl:with-param>
<xsl:with-param name="pattern" select="&#39;&gt;&#39;"></xsl:with-param>
<xsl:with-param name="replacement" select="&#39;&amp;gt;&#39;"></xsl:with-param></xsl:call-template></xsl:template>
<xsl:template name="common.escape-js-text"><xsl:param name="js-text"></xsl:param>
<xsl:call-template name="common.replace"><xsl:with-param name="string"><xsl:call-template name="common.replace"><xsl:with-param name="string"><xsl:call-template name="common.replace"><xsl:with-param name="string" select="$js-text"></xsl:with-param>
<xsl:with-param name="pattern" select="&#39;&amp;&#39;"></xsl:with-param>
<xsl:with-param name="replacement" select="&#39;\x26&#39;"></xsl:with-param></xsl:call-template></xsl:with-param>
<xsl:with-param name="pattern" select="&#39;&lt;&#39;"></xsl:with-param>
<xsl:with-param name="replacement" select="&#39;\x3c&#39;"></xsl:with-param></xsl:call-template></xsl:with-param>
<xsl:with-param name="pattern" select="&#39;&gt;&#39;"></xsl:with-param>
<xsl:with-param name="replacement" select="&#39;\x3e&#39;"></xsl:with-param></xsl:call-template></xsl:template>
<xsl:template match="principal" mode="common.person"><span style="cursor: pointer"><xsl:if test="@type = 0"><xsl:attribute name="onmouseout"><xsl:text>_TT_HidePhoto()</xsl:text></xsl:attribute>
<xsl:attribute name="onmouseover"><xsl:text>_TT_ShowPhoto(this, event, </xsl:text>
<xsl:choose><xsl:when test="contains(value, &#39;@&#39;)"><xsl:call-template name="common.js-string"><xsl:with-param name="escapee"><xsl:call-template name="common.full-email"></xsl:call-template></xsl:with-param></xsl:call-template>
<xsl:text>, </xsl:text>
<xsl:call-template name="common.js-string"><xsl:with-param name="escapee" select="value"></xsl:with-param></xsl:call-template></xsl:when>
<xsl:otherwise><xsl:call-template name="common.js-string"><xsl:with-param name="escapee" select="display"></xsl:with-param></xsl:call-template>
<xsl:text>, &#39;unknown&#39;</xsl:text></xsl:otherwise></xsl:choose>
<xsl:text>)</xsl:text></xsl:attribute></xsl:if>
<xsl:attribute name="onclick"><xsl:text>_TT_LC(</xsl:text>
<xsl:call-template name="common.js-string"><xsl:with-param name="escapee" select="@id"></xsl:with-param></xsl:call-template>
<xsl:text>,false)</xsl:text></xsl:attribute>
<xsl:choose><xsl:when test="abbr != &#39;&#39;"><xsl:value-of select="abbr"></xsl:value-of></xsl:when>
<xsl:otherwise><xsl:value-of select="display"></xsl:value-of></xsl:otherwise></xsl:choose></span></xsl:template>
<xsl:template name="common.full-email"><xsl:call-template name="common.render-mailbox"><xsl:with-param name="common-name" select="display"></xsl:with-param>
<xsl:with-param name="addr-spec" select="value"></xsl:with-param></xsl:call-template></xsl:template>
<xsl:template name="common.render-mailbox"><xsl:param name="common-name"></xsl:param>
<xsl:param name="addr-spec"></xsl:param>
<xsl:choose><xsl:when test="($common-name != &#39;&#39; or $addr-spec = &#39;&#39;)                       and $common-name != $addr-spec"><xsl:choose><xsl:when test="contains($common-name, &#39;(&#39;) or                           contains($common-name, &#39;)&#39;) or                           contains($common-name, &#39;&lt;&#39;) or                           contains($common-name, &#39;&gt;&#39;) or                           contains($common-name, &#39;@&#39;) or                           contains($common-name, &#39;,&#39;) or                           contains($common-name, &#39;;&#39;) or                           contains($common-name, &#39;:&#39;) or                           contains($common-name, &#39;&quot;&#39;) or                           contains($common-name, &#39;.&#39;) or                           contains($common-name, &#39;[&#39;) or                           contains($common-name, &#39;]&#39;)"><xsl:text>&quot;</xsl:text>
<xsl:call-template name="common.replace"><xsl:with-param name="string"><xsl:call-template name="common.replace"><xsl:with-param name="string" select="$common-name"></xsl:with-param>
<xsl:with-param name="pattern"><xsl:text>\</xsl:text></xsl:with-param>
<xsl:with-param name="replacement"><xsl:text>\\</xsl:text></xsl:with-param></xsl:call-template></xsl:with-param>
<xsl:with-param name="pattern"><xsl:text>&quot;</xsl:text></xsl:with-param>
<xsl:with-param name="replacement"><xsl:text>\&quot;</xsl:text></xsl:with-param></xsl:call-template>
<xsl:text>&quot;</xsl:text></xsl:when>
<xsl:otherwise><xsl:value-of select="$common-name"></xsl:value-of></xsl:otherwise></xsl:choose>
<xsl:text> &lt;</xsl:text>
<xsl:value-of select="$addr-spec"></xsl:value-of>
<xsl:text>&gt;</xsl:text></xsl:when>
<xsl:otherwise><xsl:value-of select="$addr-spec"></xsl:value-of></xsl:otherwise></xsl:choose></xsl:template>
<xsl:template name="common.toggle"><xsl:param name="module-id"></xsl:param>
<xsl:param name="expanded"></xsl:param>
<xsl:value-of select="/eventpage/@url"></xsl:value-of>
<xsl:if test="not(contains(/eventpage/@url, &#39;?&#39;))"><xsl:text>?</xsl:text></xsl:if>
<xsl:for-each select="/eventpage/modules/module[@module-id != $module-id]"><xsl:if test="position() != 1 or contains(/eventpage/@url, &#39;?&#39;)"><xsl:text>&amp;</xsl:text></xsl:if>
<xsl:text>emid=</xsl:text>
<xsl:value-of select="@module-id"></xsl:value-of></xsl:for-each>
<xsl:if test="$expanded = &#39;true&#39; or                   ($expanded != &#39;false&#39; and                    count(/eventpage/modules/module[@module-id = $module-id]) = 0                    )"><xsl:if test="count(/eventpage/modules/module[@module-id != $module-id])                    != 0 or contains(/eventpage/@url, &#39;?&#39;)"><xsl:text>&amp;</xsl:text></xsl:if>
<xsl:text>emid=</xsl:text>
<xsl:value-of select="$module-id"></xsl:value-of></xsl:if></xsl:template>
<xsl:template name="common.module-expanded"><xsl:param name="module-id"></xsl:param>
<xsl:choose><xsl:when test="count(/eventpage/modules/module[@module-id = $module-id]) != 0"><xsl:text>expanded</xsl:text></xsl:when>
<xsl:otherwise><xsl:text>collapsed</xsl:text></xsl:otherwise></xsl:choose></xsl:template>
<xsl:template name="common.calendar-list"><xsl:param name="selected_value"></xsl:param>
<xsl:for-each select="/eventpage/calendars/principal"><option><xsl:attribute name="value"><xsl:value-of select="@id"></xsl:value-of></xsl:attribute>
<xsl:if test="$selected_value = @id"><xsl:attribute name="selected"><xsl:text>selected</xsl:text></xsl:attribute></xsl:if>
<xsl:value-of select="display"></xsl:value-of></option></xsl:for-each>
<xsl:if test="/eventpage/@action != &#39;CREATE&#39;"><option value="tranfer_event"><xsl:text>更改拥有者...</xsl:text></option></xsl:if></xsl:template>
<xsl:template name="common.widget-classes"><xsl:param name="name"></xsl:param>
<xsl:param name="type"></xsl:param>
<xsl:param name="value"></xsl:param>
<xsl:attribute name="class"><xsl:text>data input field-</xsl:text> <xsl:value-of select="$name"></xsl:value-of> <xsl:text> </xsl:text> <xsl:if test="@editing != &#39;true&#39; and $value = &#39;&#39; and                       $name != &#39;text&#39;"><xsl:text>blank </xsl:text></xsl:if> <xsl:choose><xsl:when test="@access = &#39;editable&#39;"><xsl:text>editable </xsl:text> <xsl:if test="@editing != &#39;true&#39;"><xsl:text>highlight </xsl:text></xsl:if></xsl:when> <xsl:otherwise><xsl:text>readonly </xsl:text></xsl:otherwise></xsl:choose> <xsl:value-of select="$type"></xsl:value-of></xsl:attribute></xsl:template>
<xsl:variable name="dtstart"><xsl:value-of select="substring-before(/eventpage/dates/value, &#39;/&#39;)"></xsl:value-of></xsl:variable>
<xsl:variable name="dtstart-date"><xsl:choose><xsl:when test="contains($dtstart, &#39;T&#39;)"><xsl:value-of select="substring-before($dtstart, &#39;T&#39;)"></xsl:value-of></xsl:when>
<xsl:otherwise><xsl:value-of select="$dtstart"></xsl:value-of></xsl:otherwise></xsl:choose></xsl:variable>
<xsl:variable name="dtstart-time"><xsl:if test="contains($dtstart, &#39;T&#39;)"><xsl:text>T</xsl:text>
<xsl:value-of select="substring-after($dtstart, &#39;T&#39;)"></xsl:value-of></xsl:if></xsl:variable>
<xsl:variable name="base-date"><xsl:choose><xsl:when test="$dtstart-date != &#39;&#39; and                       not(contains($dtstart-date, &#39;?&#39;))"><xsl:value-of select="$dtstart-date"></xsl:value-of></xsl:when>
<xsl:otherwise><xsl:value-of select="/eventpage/ref-date/value"></xsl:value-of></xsl:otherwise></xsl:choose>
<xsl:if test="$dtstart-time != &#39;&#39;"><xsl:choose><xsl:when test="not(contains($dtstart-time, &#39;?&#39;))"><xsl:value-of select="$dtstart-time"></xsl:value-of></xsl:when>
<xsl:otherwise><xsl:text>T120000</xsl:text></xsl:otherwise></xsl:choose></xsl:if></xsl:variable>
<xsl:template name="recurui.interval-options"><xsl:param name="selectedValue"></xsl:param>
<xsl:param name="index"><xsl:text>1</xsl:text></xsl:param>
<xsl:if test="$index &gt;= 1 and $index &lt; 31"><option value="{$index}"><xsl:if test="$selectedValue = $index"><xsl:attribute name="selected"><xsl:text>selected</xsl:text></xsl:attribute></xsl:if>
<xsl:value-of select="$index"></xsl:value-of></option>
<xsl:call-template name="recurui.interval-options"><xsl:with-param name="selectedValue" select="$selectedValue"></xsl:with-param>
<xsl:with-param name="index" select="$index + 1"></xsl:with-param></xsl:call-template></xsl:if></xsl:template>
<xsl:template name="recurui.interval-message"><xsl:param name="freq"></xsl:param>
<xsl:param name="plural"></xsl:param>
<xsl:param name="part"></xsl:param>
<xsl:choose><xsl:when test="$freq = &#39;DAILY&#39;"><xsl:choose><xsl:when test="$plural = &#39;SINGULAR&#39;"><xsl:choose><xsl:when test="$part = &#39;HEADER&#39;">重复间隔：</xsl:when>
<xsl:when test="$part = &#39;PERIOD&#39;">天</xsl:when></xsl:choose></xsl:when>
<xsl:when test="$plural = &#39;PLURAL&#39;"><xsl:choose><xsl:when test="$part = &#39;HEADER&#39;">重复间隔：</xsl:when>
<xsl:when test="$part = &#39;PERIOD&#39;">天</xsl:when></xsl:choose></xsl:when></xsl:choose></xsl:when>
<xsl:when test="$freq = &#39;WEEKLY&#39;"><xsl:choose><xsl:when test="$plural = &#39;SINGULAR&#39;"><xsl:choose><xsl:when test="$part = &#39;HEADER&#39;">重复间隔：</xsl:when>
<xsl:when test="$part = &#39;PERIOD&#39;">周</xsl:when></xsl:choose></xsl:when>
<xsl:when test="$plural = &#39;PLURAL&#39;"><xsl:choose><xsl:when test="$part = &#39;HEADER&#39;">重复间隔：</xsl:when>
<xsl:when test="$part = &#39;PERIOD&#39;">周</xsl:when></xsl:choose></xsl:when></xsl:choose></xsl:when>
<xsl:when test="$freq = &#39;MONTHLY&#39;"><xsl:choose><xsl:when test="$plural = &#39;SINGULAR&#39;"><xsl:choose><xsl:when test="$part = &#39;HEADER&#39;">重复间隔：</xsl:when>
<xsl:when test="$part = &#39;PERIOD&#39;">月</xsl:when></xsl:choose></xsl:when>
<xsl:when test="$plural = &#39;PLURAL&#39;"><xsl:choose><xsl:when test="$part = &#39;HEADER&#39;">重复间隔：</xsl:when>
<xsl:when test="$part = &#39;PERIOD&#39;">个月</xsl:when></xsl:choose></xsl:when></xsl:choose></xsl:when>
<xsl:when test="$freq = &#39;YEARLY&#39;"><xsl:choose><xsl:when test="$plural = &#39;SINGULAR&#39;"><xsl:choose><xsl:when test="$part = &#39;HEADER&#39;">重复间隔：</xsl:when>
<xsl:when test="$part = &#39;PERIOD&#39;">年</xsl:when></xsl:choose></xsl:when>
<xsl:when test="$plural = &#39;PLURAL&#39;"><xsl:choose><xsl:when test="$part = &#39;HEADER&#39;">重复间隔：</xsl:when>
<xsl:when test="$part = &#39;PERIOD&#39;">年</xsl:when></xsl:choose></xsl:when></xsl:choose></xsl:when>
<xsl:otherwise><xsl:if test="$part = &#39;HEADER&#39;">重复间隔：</xsl:if></xsl:otherwise></xsl:choose></xsl:template>
<xsl:template name="recurui.days-of-week"><xsl:param name="selectedDays"></xsl:param>
<xsl:variable name="startIndex"><xsl:text>0</xsl:text></xsl:variable>
<xsl:if test="(0 &gt;= $startIndex)             and (-7 &lt; $startIndex)"><xsl:if test="0&gt;$startIndex"><xsl:text>&#160;&#160;</xsl:text></xsl:if>
<xsl:call-template name="recurui.day-of-week"><xsl:with-param name="selectedDays" select="$selectedDays"></xsl:with-param>
<xsl:with-param name="index" select="0"></xsl:with-param>
<xsl:with-param name="ical-id"><xsl:text>SU</xsl:text></xsl:with-param>
<xsl:with-param name="msg"><xsl:text>日</xsl:text></xsl:with-param></xsl:call-template></xsl:if> <xsl:if test="(1 &gt;= $startIndex)             and (-6 &lt; $startIndex)"><xsl:if test="1&gt;$startIndex"><xsl:text>&#160;&#160;</xsl:text></xsl:if>
<xsl:call-template name="recurui.day-of-week"><xsl:with-param name="selectedDays" select="$selectedDays"></xsl:with-param>
<xsl:with-param name="index" select="1"></xsl:with-param>
<xsl:with-param name="ical-id"><xsl:text>MO</xsl:text></xsl:with-param>
<xsl:with-param name="msg"><xsl:text>一</xsl:text></xsl:with-param></xsl:call-template></xsl:if> <xsl:if test="(2 &gt;= $startIndex)             and (-5 &lt; $startIndex)"><xsl:if test="2&gt;$startIndex"><xsl:text>&#160;&#160;</xsl:text></xsl:if>
<xsl:call-template name="recurui.day-of-week"><xsl:with-param name="selectedDays" select="$selectedDays"></xsl:with-param>
<xsl:with-param name="index" select="2"></xsl:with-param>
<xsl:with-param name="ical-id"><xsl:text>TU</xsl:text></xsl:with-param>
<xsl:with-param name="msg"><xsl:text>二</xsl:text></xsl:with-param></xsl:call-template></xsl:if> <xsl:if test="(3 &gt;= $startIndex)             and (-4 &lt; $startIndex)"><xsl:if test="3&gt;$startIndex"><xsl:text>&#160;&#160;</xsl:text></xsl:if>
<xsl:call-template name="recurui.day-of-week"><xsl:with-param name="selectedDays" select="$selectedDays"></xsl:with-param>
<xsl:with-param name="index" select="3"></xsl:with-param>
<xsl:with-param name="ical-id"><xsl:text>WE</xsl:text></xsl:with-param>
<xsl:with-param name="msg"><xsl:text>三</xsl:text></xsl:with-param></xsl:call-template></xsl:if> <xsl:if test="(4 &gt;= $startIndex)             and (-3 &lt; $startIndex)"><xsl:if test="4&gt;$startIndex"><xsl:text>&#160;&#160;</xsl:text></xsl:if>
<xsl:call-template name="recurui.day-of-week"><xsl:with-param name="selectedDays" select="$selectedDays"></xsl:with-param>
<xsl:with-param name="index" select="4"></xsl:with-param>
<xsl:with-param name="ical-id"><xsl:text>TH</xsl:text></xsl:with-param>
<xsl:with-param name="msg"><xsl:text>四</xsl:text></xsl:with-param></xsl:call-template></xsl:if> <xsl:if test="(5 &gt;= $startIndex)             and (-2 &lt; $startIndex)"><xsl:if test="5&gt;$startIndex"><xsl:text>&#160;&#160;</xsl:text></xsl:if>
<xsl:call-template name="recurui.day-of-week"><xsl:with-param name="selectedDays" select="$selectedDays"></xsl:with-param>
<xsl:with-param name="index" select="5"></xsl:with-param>
<xsl:with-param name="ical-id"><xsl:text>FR</xsl:text></xsl:with-param>
<xsl:with-param name="msg"><xsl:text>五</xsl:text></xsl:with-param></xsl:call-template></xsl:if> <xsl:if test="(6 &gt;= $startIndex)             and (-1 &lt; $startIndex)"><xsl:if test="6&gt;$startIndex"><xsl:text>&#160;&#160;</xsl:text></xsl:if>
<xsl:call-template name="recurui.day-of-week"><xsl:with-param name="selectedDays" select="$selectedDays"></xsl:with-param>
<xsl:with-param name="index" select="6"></xsl:with-param>
<xsl:with-param name="ical-id"><xsl:text>SA</xsl:text></xsl:with-param>
<xsl:with-param name="msg"><xsl:text>六</xsl:text></xsl:with-param></xsl:call-template></xsl:if> <xsl:if test="(7 &gt;= $startIndex)             and (0 &lt; $startIndex)"><xsl:if test="7&gt;$startIndex"><xsl:text>&#160;&#160;</xsl:text></xsl:if>
<xsl:call-template name="recurui.day-of-week"><xsl:with-param name="selectedDays" select="$selectedDays"></xsl:with-param>
<xsl:with-param name="index" select="0"></xsl:with-param>
<xsl:with-param name="ical-id"><xsl:text>SU</xsl:text></xsl:with-param>
<xsl:with-param name="msg"><xsl:text>日</xsl:text></xsl:with-param></xsl:call-template></xsl:if> <xsl:if test="(8 &gt;= $startIndex)             and (1 &lt; $startIndex)"><xsl:if test="8&gt;$startIndex"><xsl:text>&#160;&#160;</xsl:text></xsl:if>
<xsl:call-template name="recurui.day-of-week"><xsl:with-param name="selectedDays" select="$selectedDays"></xsl:with-param>
<xsl:with-param name="index" select="1"></xsl:with-param>
<xsl:with-param name="ical-id"><xsl:text>MO</xsl:text></xsl:with-param>
<xsl:with-param name="msg"><xsl:text>一</xsl:text></xsl:with-param></xsl:call-template></xsl:if> <xsl:if test="(9 &gt;= $startIndex)             and (2 &lt; $startIndex)"><xsl:if test="9&gt;$startIndex"><xsl:text>&#160;&#160;</xsl:text></xsl:if>
<xsl:call-template name="recurui.day-of-week"><xsl:with-param name="selectedDays" select="$selectedDays"></xsl:with-param>
<xsl:with-param name="index" select="2"></xsl:with-param>
<xsl:with-param name="ical-id"><xsl:text>TU</xsl:text></xsl:with-param>
<xsl:with-param name="msg"><xsl:text>二</xsl:text></xsl:with-param></xsl:call-template></xsl:if> <xsl:if test="(10 &gt;= $startIndex)             and (3 &lt; $startIndex)"><xsl:if test="10&gt;$startIndex"><xsl:text>&#160;&#160;</xsl:text></xsl:if>
<xsl:call-template name="recurui.day-of-week"><xsl:with-param name="selectedDays" select="$selectedDays"></xsl:with-param>
<xsl:with-param name="index" select="3"></xsl:with-param>
<xsl:with-param name="ical-id"><xsl:text>WE</xsl:text></xsl:with-param>
<xsl:with-param name="msg"><xsl:text>三</xsl:text></xsl:with-param></xsl:call-template></xsl:if> <xsl:if test="(11 &gt;= $startIndex)             and (4 &lt; $startIndex)"><xsl:if test="11&gt;$startIndex"><xsl:text>&#160;&#160;</xsl:text></xsl:if>
<xsl:call-template name="recurui.day-of-week"><xsl:with-param name="selectedDays" select="$selectedDays"></xsl:with-param>
<xsl:with-param name="index" select="4"></xsl:with-param>
<xsl:with-param name="ical-id"><xsl:text>TH</xsl:text></xsl:with-param>
<xsl:with-param name="msg"><xsl:text>四</xsl:text></xsl:with-param></xsl:call-template></xsl:if> <xsl:if test="(12 &gt;= $startIndex)             and (5 &lt; $startIndex)"><xsl:if test="12&gt;$startIndex"><xsl:text>&#160;&#160;</xsl:text></xsl:if>
<xsl:call-template name="recurui.day-of-week"><xsl:with-param name="selectedDays" select="$selectedDays"></xsl:with-param>
<xsl:with-param name="index" select="5"></xsl:with-param>
<xsl:with-param name="ical-id"><xsl:text>FR</xsl:text></xsl:with-param>
<xsl:with-param name="msg"><xsl:text>五</xsl:text></xsl:with-param></xsl:call-template></xsl:if> <xsl:if test="(13 &gt;= $startIndex)             and (6 &lt; $startIndex)"><xsl:if test="13&gt;$startIndex"><xsl:text>&#160;&#160;</xsl:text></xsl:if>
<xsl:call-template name="recurui.day-of-week"><xsl:with-param name="selectedDays" select="$selectedDays"></xsl:with-param>
<xsl:with-param name="index" select="6"></xsl:with-param>
<xsl:with-param name="ical-id"><xsl:text>SA</xsl:text></xsl:with-param>
<xsl:with-param name="msg"><xsl:text>六</xsl:text></xsl:with-param></xsl:call-template></xsl:if></xsl:template>
<xsl:template name="recurui.day-of-week"><xsl:param name="selectedDays"></xsl:param>
<xsl:param name="index"></xsl:param>
<xsl:param name="ical-id"></xsl:param>
<xsl:param name="msg"></xsl:param>
<xsl:variable name="day-num" select="$index"></xsl:variable>
<span class="group"><input type="checkbox" id="r-recur-0" onclick="_recur_fce(&#39;r-recur&#39;)"><xsl:attribute name="id"><xsl:text>r-recur-</xsl:text>
<xsl:value-of select="$day-num"></xsl:value-of></xsl:attribute>
<xsl:attribute name="value"><xsl:value-of select="$day-num"></xsl:value-of></xsl:attribute>
<xsl:if test="contains($selectedDays, $ical-id)"><xsl:attribute name="checked"><xsl:text>checked</xsl:text></xsl:attribute></xsl:if></input>
<xsl:text>&#160;</xsl:text>
<label><xsl:attribute name="for"><xsl:text>r-recur-</xsl:text>
<xsl:value-of select="$day-num"></xsl:value-of></xsl:attribute>
<xsl:value-of select="$msg"></xsl:value-of></label></span></xsl:template>
<xsl:template match="rrule" mode="recurui.main"><div id="ff-recur"><xsl:if test="@editing = &#39;true&#39;"><xsl:attribute name="style"><xsl:text>display: block</xsl:text></xsl:attribute></xsl:if>
<xsl:attribute name="class"><xsl:text>field </xsl:text> <xsl:value-of select="@access"></xsl:value-of> <xsl:if test="@access != &#39;editable&#39; and value = &#39;&#39;"><xsl:text> blank</xsl:text></xsl:if></xsl:attribute>
<xsl:if test="count(/eventpage/dates) = 0"><h3 class="label"><label for="wi-recur"><xsl:text>时间</xsl:text></label></h3></xsl:if>
<div id="wi-recur"><xsl:if test="@access = &#39;editable&#39; and @editing != &#39;true&#39;"><xsl:attribute name="onclick"><xsl:text>_wi_rewriteOnDemand(this,event)</xsl:text></xsl:attribute></xsl:if>
<xsl:call-template name="common.widget-classes"><xsl:with-param name="name" select="&#39;recur&#39;"></xsl:with-param>
<xsl:with-param name="type" select="&#39;rrule&#39;"></xsl:with-param>
<xsl:with-param name="value" select="&#39;not-blank&#39;"></xsl:with-param></xsl:call-template>
<xsl:choose><xsl:when test="@access != &#39;editable&#39;"><xsl:value-of select="display"></xsl:value-of></xsl:when>
<xsl:otherwise><div id="r-recur-container" class="recurui-container"><div id="r-recur"><xsl:attribute name="class"><xsl:text>recurui-container </xsl:text> <xsl:choose><xsl:when test="@freq=&#39;DAILY&#39;"><xsl:text>recur-daily</xsl:text></xsl:when> <xsl:when test="@freq=&#39;WEEKLY&#39;"><xsl:text>recur-weekly</xsl:text></xsl:when> <xsl:when test="@freq=&#39;MONTHLY&#39;"><xsl:text>recur-monthly</xsl:text></xsl:when> <xsl:when test="@freq=&#39;YEARLY&#39;"><xsl:text>recur-yearly</xsl:text></xsl:when> <xsl:otherwise><xsl:text>recur-not</xsl:text></xsl:otherwise></xsl:choose></xsl:attribute>
<div class="group repeat" style="display:none"><h4>重复频率：</h4>
<select class="recur-persel" onchange="_recur_mc(&#39;r-recur&#39;)" id="r-recur-mperiod"><option value="0"><xsl:if test="not(@freq)"><xsl:attribute name="selected"><xsl:text>selected</xsl:text></xsl:attribute></xsl:if>
<xsl:text>不重复</xsl:text></option>
<option value="1"><xsl:if test="@freq=&#39;DAILY&#39;"><xsl:attribute name="selected"><xsl:text>selected</xsl:text></xsl:attribute></xsl:if>
<xsl:text>每天</xsl:text></option>
<xsl:if test="/eventpage/self/@has-weekends=&#39;true&#39;"><option value="2"><xsl:if test="@freq=&#39;WEEKLY&#39; and                                        @byday=&#39;MO,TU,WE,TH,FR&#39;"><xsl:attribute name="selected"><xsl:text>selected</xsl:text></xsl:attribute></xsl:if>
<xsl:text>每个工作日 （周一到周五）</xsl:text></option>
<option value="3"><xsl:if test="@freq=&#39;WEEKLY&#39; and @byday=&#39;MO,WE,FR&#39;"><xsl:attribute name="selected"><xsl:text>selected</xsl:text></xsl:attribute></xsl:if>
<xsl:text>每周一、周三和周五</xsl:text></option>
<option value="4"><xsl:if test="@freq=&#39;WEEKLY&#39; and @byday=&#39;TU,TH&#39;"><xsl:attribute name="selected"><xsl:text>selected</xsl:text></xsl:attribute></xsl:if>
<xsl:text>每周二和周四</xsl:text></option></xsl:if>
<option value="5"><xsl:if test="@freq = &#39;WEEKLY&#39; and                                      (/eventpage/self/@has-weekends=&#39;false&#39; or                                      not(@byday=&#39;TU,TH&#39; or @byday=&#39;MO,WE,FR&#39; or                                          @byday=&#39;MO,TU,WE,TH,FR&#39;))"><xsl:attribute name="selected"><xsl:text>selected</xsl:text></xsl:attribute></xsl:if>
<xsl:text>每周</xsl:text></option>
<option value="6"><xsl:if test="@freq=&#39;MONTHLY&#39;"><xsl:attribute name="selected"><xsl:text>selected</xsl:text></xsl:attribute></xsl:if>
<xsl:text>每月</xsl:text></option>
<option value="7"><xsl:if test="@freq=&#39;YEARLY&#39;"><xsl:attribute name="selected"><xsl:text>selected</xsl:text></xsl:attribute></xsl:if>
<xsl:text>每年</xsl:text></option></select></div>
<div><div class="recur-secondary group repeat indent"><table class="recur-hr-tab"><tr><td class="recur-hr-cont"><span class="recur-hr" id="rrhr-r-recur"><xsl:choose><xsl:when test="display != &#39;&#39;"><xsl:value-of select="display"></xsl:value-of></xsl:when>
<xsl:otherwise><xsl:text>此工作日程不重复</xsl:text></xsl:otherwise></xsl:choose></span></td></tr></table></div>
<div class="recur-secondary group repeat indent recur-intsel-cont"><xsl:variable name="freq" select="@freq"></xsl:variable>
<xsl:variable name="plural"><xsl:choose><xsl:when test="@interval = 1"><xsl:text>SINGULAR</xsl:text></xsl:when>
<xsl:otherwise><xsl:text>PLURAL&gt;</xsl:text></xsl:otherwise></xsl:choose></xsl:variable>
<h4 id="r-recur-ptitle"><xsl:variable name="digits" select="digits mod 10"></xsl:variable>
<xsl:variable name="tens" select="floor((digits mod 100) div 10)"></xsl:variable>
<xsl:choose><xsl:when test="@freq = &#39;YEARLY&#39; and @tens != 1 and                                  @digits &gt; 1 and @digits &lt; 5">&#1075;&#1086;&#1076;&#1072;</xsl:when>
<xsl:otherwise><xsl:call-template name="recurui.interval-message"><xsl:with-param name="freq" select="$freq"></xsl:with-param>
<xsl:with-param name="plural" select="$plural"></xsl:with-param>
<xsl:with-param name="part" select="&#39;HEADER&#39;"></xsl:with-param></xsl:call-template></xsl:otherwise></xsl:choose></h4>
<select class="recur-intsel" onchange="_recur_ci(&#39;r-recur&#39;)" id="r-recur-interval"><xsl:call-template name="recurui.interval-options"><xsl:with-param name="selectedValue" select="@interval"></xsl:with-param></xsl:call-template></select>
<xsl:text>&#160;</xsl:text>
<span id="r-recur-pdesc"><xsl:call-template name="recurui.interval-message"><xsl:with-param name="freq" select="$freq"></xsl:with-param>
<xsl:with-param name="plural" select="$plural"></xsl:with-param>
<xsl:with-param name="part" select="&#39;PERIOD&#39;"></xsl:with-param></xsl:call-template></span></div>
<div class="recur-secondary recur-dowchecks"><div class="group repeat indent"><h4><xsl:text>重复日期为：</xsl:text></h4>
<div class="recur-cbg"><xsl:call-template name="recurui.days-of-week"><xsl:with-param name="selectedDays" select="@byday"></xsl:with-param></xsl:call-template></div></div></div>
<div class="recur-repeatby"><div class="group repeat indent"><h4><xsl:text>重复标准：</xsl:text></h4>
<div class="recur-cbg"><input type="radio" onclick="_recur_fce(&#39;r-recur&#39;)" id="r-recur-byday-month" name="_dowordom" value="BYMONTHDAY"><xsl:if test="count(@bymonthday) != 0"><xsl:attribute name="checked"><xsl:text>checked</xsl:text></xsl:attribute></xsl:if></input>
<xsl:text>&#160;</xsl:text>
<label for="r-recur-byday-month"><xsl:text>日期</xsl:text></label>
<xsl:text>&#160;&#160;</xsl:text>
<input type="radio" onclick="_recur_fce(&#39;r-recur&#39;)" id="r-recur-byday-week" name="_dowordom" value="BYDAY"><xsl:if test="count(@bymonthday) = 0 and                                         count(@byday) != 0"><xsl:attribute name="checked"><xsl:text>checked</xsl:text></xsl:attribute></xsl:if></input>
<xsl:text>&#160;</xsl:text>
<label for="r-recur-byday-week"><xsl:text>星期几</xsl:text></label></div></div></div></div>
<div class="recur-secondary repeat indent"><table cellspacing="0" cellpadding="0" class="group" id="r-recur-foot"><tr valign="top"><td colspan="3"><h4><xsl:text>范围：</xsl:text></h4></td></tr>
<tr valign="middle"><td id="r-recur-left" style="padding-left: 1em"><h5 class="nobr"><label for="hr-rstart"><xsl:text>开始：</xsl:text></label></h5></td>
<td class="recurfoot"><input type="text" size="12" id="hr-rstart"><xsl:choose><xsl:when test="count(../first-start) = 0 or                                           ../first-start/@access != &#39;editable&#39;"><xsl:attribute name="disabled"><xsl:text>disabled</xsl:text></xsl:attribute></xsl:when>
<xsl:otherwise><xsl:attribute name="onchange"><xsl:text>_wi_rpd(this)</xsl:text></xsl:attribute>
<xsl:attribute name="onkeypress"><xsl:text>return(_wi_ns(this,event))</xsl:text></xsl:attribute>
<xsl:attribute name="onblur"><xsl:text>_wi_b(this)</xsl:text></xsl:attribute>
<xsl:attribute name="onfocus"><xsl:text>_wi_f(this)</xsl:text></xsl:attribute></xsl:otherwise></xsl:choose>
<xsl:attribute name="value"><xsl:choose><xsl:when test="count(../first-start) != 0"><xsl:value-of select="../first-start/display"></xsl:value-of></xsl:when>
<xsl:otherwise><xsl:value-of select="../dates/start-date"></xsl:value-of></xsl:otherwise></xsl:choose></xsl:attribute></input></td>
<td align="right" style="padding-left: 1ex"><h5 class="nobr"><xsl:text>结束时间：</xsl:text></h5></td>
<td width="50%" rowspan="2"><div><table width="100%" cellspacing="0" cellpadding="0"><tr valign="middle"><td align="left"><xsl:variable name="checkOption"><xsl:choose><xsl:when test="count(@until) != 0"><xsl:text>until</xsl:text></xsl:when>
<xsl:when test="count(@count) != 0"><xsl:text>count</xsl:text></xsl:when>
<xsl:otherwise><xsl:text>never</xsl:text></xsl:otherwise></xsl:choose></xsl:variable>
<input type="radio" onclick="_recur_crb(&#39;r-recur&#39;)" id="r-recur-noend" name="_endmode"><xsl:if test="$checkOption = &#39;never&#39;"><xsl:attribute name="checked"><xsl:text>checked</xsl:text></xsl:attribute></xsl:if></input>
<xsl:text>&#160;</xsl:text>
<label id="recur-lbl-r-recur-noend" for="r-recur-noend"><xsl:attribute name="class"><xsl:choose><xsl:when test="$checkOption = &#39;never&#39;"><xsl:text>recur-checked</xsl:text></xsl:when>
<xsl:otherwise><xsl:text>recur-unchecked</xsl:text></xsl:otherwise></xsl:choose></xsl:attribute>
<xsl:text>从不</xsl:text></label>
<br></br>
<input type="radio" onclick="_recur_crb(&#39;r-recur&#39;)" id="r-recur-until" name="_endmode" value="UNTIL"><xsl:if test="$checkOption = &#39;until&#39;"><xsl:attribute name="checked"><xsl:text>checked</xsl:text></xsl:attribute></xsl:if></input>
<xsl:text>&#160;</xsl:text>
<span id="recur-lbl-r-recur-until"><xsl:attribute name="class"><xsl:choose><xsl:when test="$checkOption = &#39;until&#39;"><xsl:text>recur-checked</xsl:text></xsl:when>
<xsl:otherwise><xsl:text>recur-unchecked</xsl:text></xsl:otherwise></xsl:choose></xsl:attribute>
<label for="r-recur-until"><xsl:text>之前</xsl:text></label>
<xsl:text>&#160;</xsl:text>
<input type="text" onfocus="_$(&#39;r-recur-until&#39;).checked=true" class="recur-onchecked" id="r-recur-enddate" onblur="this.onclick(event)" onclick="_recur_fce(&#39;r-recur&#39;)" onchange="this.onclick(event)" size="12"></input></span></td></tr></table></div></td></tr>
<tr><td colspan="2"></td></tr></table></div>
<input type="hidden" id="r-recur-wkst"><xsl:attribute name="value"><xsl:value-of select="@wkst"></xsl:value-of></xsl:attribute></input>
<input type="hidden" id="r-recur-orr"><xsl:attribute name="value"><xsl:value-of select="value"></xsl:value-of></xsl:attribute></input>
<input type="hidden" id="r-recur-odt"><xsl:attribute name="value"><xsl:value-of select="$base-date"></xsl:value-of></xsl:attribute></input>
<input type="hidden" id="r-recur-oedt"><xsl:attribute name="value"><xsl:value-of select="@until"></xsl:value-of></xsl:attribute></input></div></div>
<input type="hidden" id="old-recur" name="old-recur"><xsl:attribute name="value"><xsl:if test="/eventpage/@action != &#39;CREATE&#39;"><xsl:value-of select="value"></xsl:value-of></xsl:if></xsl:attribute></input>
<input type="hidden" id="recur" name="recur"><xsl:attribute name="value"><xsl:value-of select="value"></xsl:value-of></xsl:attribute></input></xsl:otherwise></xsl:choose></div></div>
<pre id="real-recur" style="display: none">
      <xsl:value-of select="value"></xsl:value-of>
    </pre>
<xsl:choose><xsl:when test="@access != &#39;editable&#39;"><xsl:if test="../first-start/@access != &#39;editable&#39;"><div class="field readonly blank" id="ff-rstart"><div id="wi-rstart"><xsl:call-template name="common.widget-classes"><xsl:with-param name="name" select="&#39;rstart&#39;"></xsl:with-param>
<xsl:with-param name="type" select="&#39;date&#39;"></xsl:with-param>
<xsl:with-param name="value" select="../first-start/value"></xsl:with-param></xsl:call-template>
<xsl:value-of select="../first-start/value"></xsl:value-of></div></div></xsl:if></xsl:when>
<xsl:otherwise><xsl:if test="count(../first-start) != 0 and                     ../first-start/@access = &#39;editable&#39;"><input id="rstart" type="hidden" name="rstart" value="{../first-start/value}"></input>
<input id="old-rstart" type="hidden" name="old-rstart" value="{../first-start/value}"></input></xsl:if></xsl:otherwise></xsl:choose></xsl:template>
<xsl:template name="module-attendees.main"><xsl:if test="attendees/@access = &#39;editable&#39; or                   count(attendees/attendee) != 0 or                   attendees/@partial = &#39;true&#39;"><div id="guests" style="display:none"><xsl:attribute name="class"><xsl:text>module </xsl:text> <xsl:call-template name="common.module-expanded"><xsl:with-param name="module-id" select="4"></xsl:with-param></xsl:call-template> <xsl:if test="count(modules/module                                 [@module-id = 3])                           != 0"><xsl:text> add-guests-open</xsl:text></xsl:if></xsl:attribute>
<hr></hr>
<div class="t1"></div><div class="t2"></div>
<h2 class="header"><xsl:if test="@action != &#39;CREATE&#39; and                           @simplified = &#39;true&#39; and                           (organizer/principal/@id != self/principal/@id or                            count(attendees/attendee/principal                                  [@id != /eventpage/self/principal/@id]) != 0)"><xsl:variable name="to-guests" select="count(attendees/attendee/principal                              [@id != /eventpage/organizer/principal/@id and                               @id != /eventpage/self/principal/@id]                              ) != 0"></xsl:variable>
<span style="padding:4px;font-size:77%; float:right;"><a class="actionlink emailguests"><xsl:attribute name="href"><xsl:choose><xsl:when test="$to-guests"><xsl:text>javascript:_EF_MailAttendees()</xsl:text></xsl:when> <xsl:otherwise><xsl:text>javascript:_EF_MailOrganizer()</xsl:text></xsl:otherwise></xsl:choose></xsl:attribute>
<xsl:choose><xsl:when test="$to-guests"><xsl:text>向邀请对象发送电子邮件</xsl:text></xsl:when>
<xsl:otherwise><xsl:text>向组织者发送电子邮件</xsl:text></xsl:otherwise></xsl:choose></a></span></xsl:if>
<a onclick="_wi_tm(_MODULE_TYPE_INVITEES);return false" class="toggle"><xsl:attribute name="href"><xsl:call-template name="common.toggle"><xsl:with-param name="module-id" select="4"></xsl:with-param></xsl:call-template></xsl:attribute>
<xsl:text>邀请对象</xsl:text></a></h2>
<xsl:if test="attendees/@access = &#39;editable&#39;                       or attendees/@access = &#39;extensible&#39;"><p class="actions requiresjs"><a onclick="return _expandAddGuests(this)" class="actionlink add toggle" href="javascript:;"><xsl:text>添加邀请对象</xsl:text></a></p></xsl:if>
<div class="modulebody" id="guestlists"><xsl:if test="attendees/@access = &#39;editable&#39;                         or attendees/@access = &#39;extensible&#39;"><div id="addguests"><xsl:attribute name="class"><xsl:text>module </xsl:text> <xsl:call-template name="common.module-expanded"><xsl:with-param name="module-id" select="3"></xsl:with-param></xsl:call-template></xsl:attribute>
<div id="ep-guestselector"></div></div></xsl:if>
<div id="guestlistscont"><xsl:choose><xsl:when test="count(attendees[@partial = &#39;true&#39;]) = 0"><xsl:if test="@action != &#39;CREATE&#39; and                               count(attendees/attendee) != 0"><xsl:apply-templates select="attendees" mode="module-attendees.count"></xsl:apply-templates></xsl:if></xsl:when>
<xsl:otherwise><xsl:text>应组织者要求，邀请对象名单已被隐藏。</xsl:text></xsl:otherwise></xsl:choose></div>
<div class="fevent" id="guestOptionForm"><xsl:if test="              shared-property[@name = &#39;goo.allowModify&#39;]              /@access = &#39;editable&#39; or              shared-property[@name = &#39;goo.allowInvitesOther&#39;]              /@access = &#39;editable&#39; or              shared-property[@name = &#39;goo.showInvitees&#39;]              /@access = &#39;editable&#39; or              reminder/@access = &#39;editable&#39;"><xsl:if test="@action = &#39;CREATE&#39; or                             (source-calendar/principal/@id =                              organizer/principal/@id)"><xsl:call-template name="module-attendees.option-form"></xsl:call-template></xsl:if></xsl:if></div></div></div></xsl:if></xsl:template>
<xsl:template match="attendees" mode="module-attendees.count"><xsl:variable name="yes-count" select="count(attendee                    [principal/@status = 1]) +              sum(attendee                  [principal/@status = 1]                  /@extra-guests)"></xsl:variable>
<xsl:variable name="maybe-count" select="count(attendee                    [principal/@status = 3]) +              sum(attendee                  [principal/@status = 3]                  /@extra-guests)"></xsl:variable>
<xsl:variable name="no-count" select="count(attendee                    [principal/@status = 2])"></xsl:variable>
<xsl:variable name="none-count" select="count(attendee                    [principal/@status= 0])"></xsl:variable>
<xsl:variable name="editable" select="@access = &#39;editable&#39; and              /eventpage/@action != &#39;CREATE&#39;"></xsl:variable>
<div id="ff-guestcount" class="field readonly"><h3 class="label"><label for="wi-guestcount"><xsl:text>邀请对象数量：</xsl:text></label></h3>
<div id="wi-guestcount" class="data input readonly text"><xsl:if test="$yes-count != 0"><xsl:value-of select="$yes-count"></xsl:value-of> 位回答是</xsl:if>
<xsl:if test="$maybe-count != 0"><xsl:if test="($yes-count) != 0"><xsl:text>, </xsl:text></xsl:if><xsl:value-of select="$maybe-count"></xsl:value-of> 位回答也许</xsl:if>
<xsl:if test="$no-count != 0"><xsl:if test="($yes-count + $maybe-count) != 0"><xsl:text>, </xsl:text></xsl:if><xsl:value-of select="$no-count"></xsl:value-of> 位回答否</xsl:if>
<xsl:if test="$none-count != 0"><xsl:if test="($yes-count + $no-count + $maybe-count) != 0"><xsl:text>, </xsl:text></xsl:if>
<xsl:choose><xsl:when test="$none-count = 1"><xsl:text>有 1 位尚未回复</xsl:text></xsl:when>
<xsl:otherwise>有 <xsl:value-of select="$none-count"></xsl:value-of> 位尚未回复</xsl:otherwise></xsl:choose></xsl:if></div></div>
<xsl:if test="$yes-count != 0"><xsl:call-template name="module-attendees.response-count"><xsl:with-param name="response-group" select="&#39;response-yes&#39;"></xsl:with-param>
<xsl:with-param name="indicator-img" select="&#39;images/icon_r_yes.gif&#39;"></xsl:with-param>
<xsl:with-param name="title"><xsl:text>是</xsl:text></xsl:with-param>
<xsl:with-param name="count" select="$yes-count"></xsl:with-param>
<xsl:with-param name="status" select="1"></xsl:with-param>
<xsl:with-param name="editable" select="$editable"></xsl:with-param></xsl:call-template></xsl:if>
<xsl:if test="$maybe-count != 0"><xsl:call-template name="module-attendees.response-count"><xsl:with-param name="response-group" select="&#39;response-maybe&#39;"></xsl:with-param>
<xsl:with-param name="indicator-img" select="&#39;images/icon_r_maybe.gif&#39;"></xsl:with-param>
<xsl:with-param name="title"><xsl:text>也许</xsl:text></xsl:with-param>
<xsl:with-param name="count" select="$maybe-count"></xsl:with-param>
<xsl:with-param name="status" select="3"></xsl:with-param>
<xsl:with-param name="editable" select="$editable"></xsl:with-param></xsl:call-template></xsl:if>
<xsl:if test="$no-count != 0"><xsl:call-template name="module-attendees.response-count"><xsl:with-param name="response-group" select="&#39;response-no&#39;"></xsl:with-param>
<xsl:with-param name="indicator-img" select="&#39;images/icon_r_no.gif&#39;"></xsl:with-param>
<xsl:with-param name="title"><xsl:text>否</xsl:text></xsl:with-param>
<xsl:with-param name="count" select="$no-count"></xsl:with-param>
<xsl:with-param name="status" select="2"></xsl:with-param>
<xsl:with-param name="editable" select="$editable"></xsl:with-param></xsl:call-template></xsl:if>
<xsl:if test="$none-count != 0"><xsl:call-template name="module-attendees.response-count"><xsl:with-param name="response-group" select="&#39;response-none&#39;"></xsl:with-param>
<xsl:with-param name="indicator-img" select="&#39;images/blank.gif&#39;"></xsl:with-param>
<xsl:with-param name="title"><xsl:text>等待回复</xsl:text></xsl:with-param>
<xsl:with-param name="count" select="$none-count"></xsl:with-param>
<xsl:with-param name="status" select="0"></xsl:with-param>
<xsl:with-param name="editable" select="$editable"></xsl:with-param></xsl:call-template></xsl:if></xsl:template>
<xsl:template name="module-attendees.response-count"><xsl:param name="response-group"></xsl:param>
<xsl:param name="indicator-img"></xsl:param>
<xsl:param name="title"></xsl:param>
<xsl:param name="count"></xsl:param>
<xsl:param name="status"></xsl:param>
<xsl:param name="editable"></xsl:param>
<div><xsl:attribute name="id"><xsl:text>ff-</xsl:text> <xsl:value-of select="$response-group"></xsl:value-of></xsl:attribute>
<xsl:attribute name="class"><xsl:text>field </xsl:text> <xsl:choose><xsl:when test="$editable">editable</xsl:when> <xsl:otherwise>readonly</xsl:otherwise></xsl:choose> <xsl:text> people </xsl:text> <xsl:value-of select="$response-group"></xsl:value-of></xsl:attribute>
<h3 class="subtitle"><label><xsl:attribute name="for"><xsl:text>wi-</xsl:text> <xsl:value-of select="$response-group"></xsl:value-of></xsl:attribute>
<xsl:value-of select="$title"></xsl:value-of>
<xsl:text>&#160;</xsl:text>
<strong class="count"><xsl:text>(</xsl:text>
<xsl:value-of select="$count"></xsl:value-of>
<xsl:text>)&#160;&#160;</xsl:text></strong>
<div style="display:inline"><img alt=""><xsl:attribute name="src"><xsl:value-of select="$indicator-img"></xsl:value-of></xsl:attribute></img></div></label></h3>
<table cellpadding="0" cellspacing="0" style="table-layout:fixed;width:100%"><xsl:attribute name="id"><xsl:text>wi-</xsl:text> <xsl:value-of select="$response-group"></xsl:value-of></xsl:attribute>
<xsl:attribute name="class"><xsl:text>data input field-del </xsl:text> <xsl:choose><xsl:when test="$editable">editable highlight</xsl:when> <xsl:otherwise>readonly</xsl:otherwise></xsl:choose> <xsl:text> rolist</xsl:text></xsl:attribute>
<xsl:variable name="self-id"><xsl:choose><xsl:when test="count(/eventpage/self/principal/value) != 0"><xsl:value-of select="/eventpage/self/principal/value"></xsl:value-of></xsl:when>
<xsl:otherwise><xsl:value-of select="/eventpage/self/principal/@id"></xsl:value-of></xsl:otherwise></xsl:choose></xsl:variable>
<xsl:variable name="organizer-id"><xsl:choose><xsl:when test="count(/eventpage/organizer/principal/value) != 0"><xsl:value-of select="/eventpage/organizer/principal/value"></xsl:value-of></xsl:when>
<xsl:otherwise><xsl:value-of select="/eventpage/organizer/principal/@id"></xsl:value-of></xsl:otherwise></xsl:choose></xsl:variable>
<xsl:for-each select="attendee[principal/@status = $status]"><xsl:variable name="principal-id"><xsl:choose><xsl:when test="count(principal/value) != 0"><xsl:value-of select="principal/value"></xsl:value-of></xsl:when>
<xsl:otherwise><xsl:value-of select="principal/@id"></xsl:value-of></xsl:otherwise></xsl:choose></xsl:variable>
<tr class="roitem guest"><xsl:call-template name="module-attendees.setup-one-attendee"><xsl:with-param name="editable" select="$editable"></xsl:with-param>
<xsl:with-param name="principal-id" select="$principal-id"></xsl:with-param>
<xsl:with-param name="organizer-id" select="$organizer-id"></xsl:with-param>
<xsl:with-param name="self-id" select="$self-id"></xsl:with-param></xsl:call-template></tr></xsl:for-each></table></div></xsl:template>
<xsl:template name="module-attendees.setup-one-attendee"><xsl:param name="editable"></xsl:param>
<xsl:param name="principal-id"></xsl:param>
<xsl:param name="organizer-id"></xsl:param>
<xsl:param name="self-id"></xsl:param>
<td style="width:auto;vertical-align:top"><xsl:if test="principal/@id = /eventpage/self/principal/@id"><xsl:attribute name="class">self</xsl:attribute></xsl:if>
<xsl:if test="string-length(principal/display) &gt; 30"><div id="longAttendeeName" style="display:none"></div></xsl:if>
<div style="width:100%;overflow:hidden;white-space:nowrap;left:0px;right:3em;font-weight:bold;"><xsl:value-of select="principal/display"></xsl:value-of>
<span style="font-weight:normal;"><xsl:if test="@extra-guests &gt; 0"><xsl:text>&#160;</xsl:text>
<em><xsl:choose><xsl:when test="@extra-guests = 1"><xsl:text>
                    增加 1 位邀请对象
                  </xsl:text></xsl:when>
<xsl:otherwise>+外加 <xsl:value-of select="@extra-guests"></xsl:value-of> 位邀请对象</xsl:otherwise></xsl:choose></em></xsl:if></span></div>
<xsl:if test="response-comment/value != &#39;&#39;"><span class="note"><xsl:value-of select="response-comment/value"></xsl:value-of></span></xsl:if></td>
<td style="width:4.5em;vertical-align:top" align="right"><xsl:choose><xsl:when test="$editable and            ($principal-id != $organizer-id or             /eventpage/source-calendar/@access = &#39;editable&#39;)"><div class="rolink"><xsl:attribute name="title"><xsl:text>将此人从邀请对象名单中删除</xsl:text></xsl:attribute>
<xsl:attribute name="onclick"><xsl:text>_wi_ro_rm(this, </xsl:text> <xsl:call-template name="common.js-string"><xsl:with-param name="escapee" select="$principal-id"></xsl:with-param></xsl:call-template> <xsl:text>)</xsl:text></xsl:attribute>
<xsl:attribute name="id"><xsl:text>wi-rem-</xsl:text> <xsl:value-of select="$principal-id"></xsl:value-of></xsl:attribute>
<xsl:text>&#160;&#160;删除</xsl:text></div>
<input type="hidden" class="old-real" id="old-real-{$principal-id}" value="{$principal-id}"></input></xsl:when>
<xsl:otherwise><div class="real" style="display: none"><xsl:value-of select="$principal-id"></xsl:value-of></div></xsl:otherwise></xsl:choose></td></xsl:template>
<xsl:template name="module-attendees.option-form"><div class="module" id="guest-options"><h3 class="label"><xsl:text>邀请对象可以</xsl:text></h3>
<div class="data"><div class="group"><xsl:if test="/eventpage/self/@allow-guest-modify-feature = &#39;true&#39;"><xsl:call-template name="module-attendees.shared-property-value"><xsl:with-param name="baseName" select="&#39;modify&#39;"></xsl:with-param>
<xsl:with-param name="propName" select="&#39;goo.allowModify&#39;"></xsl:with-param>
<xsl:with-param name="fieldId" select="&#39;guests-modify&#39;"></xsl:with-param>
<xsl:with-param name="fieldLabelId" select="&#39;guests-modify-label&#39;"></xsl:with-param>
<xsl:with-param name="fieldLabelText"><xsl:text>
                  修改工作日程
                </xsl:text></xsl:with-param></xsl:call-template></xsl:if>
<xsl:call-template name="module-attendees.shared-property-value"><xsl:with-param name="baseName" select="&#39;invite&#39;"></xsl:with-param>
<xsl:with-param name="propName" select="&#39;goo.allowInvitesOther&#39;"></xsl:with-param>
<xsl:with-param name="fieldId" select="&#39;guests-invite&#39;"></xsl:with-param>
<xsl:with-param name="fieldLabelId" select="&#39;guests-invite-label&#39;"></xsl:with-param>
<xsl:with-param name="fieldLabelText"><xsl:text>
                邀请他人
              </xsl:text></xsl:with-param></xsl:call-template>
<xsl:call-template name="module-attendees.shared-property-value"><xsl:with-param name="baseName" select="&#39;seelist&#39;"></xsl:with-param>
<xsl:with-param name="propName" select="&#39;goo.showInvitees&#39;"></xsl:with-param>
<xsl:with-param name="fieldId" select="&#39;guests-seelist&#39;"></xsl:with-param>
<xsl:with-param name="fieldLabelId" select="&#39;guests-seelist-label&#39;"></xsl:with-param>
<xsl:with-param name="fieldLabelText"><xsl:text>
                查看邀请对象名单
              </xsl:text></xsl:with-param></xsl:call-template></div></div>
<xsl:if test="self/@allow-invite-yourself-feature = &#39;true&#39;"><xsl:call-template name="module-attendees.shared-property-value"><xsl:with-param name="baseName" select="&#39;invite-yourself&#39;"></xsl:with-param>
<xsl:with-param name="propName" select="&#39;goo.allowInviteYourself&#39;"></xsl:with-param>
<xsl:with-param name="fieldId" select="&#39;guests-invite-yourself&#39;"></xsl:with-param>
<xsl:with-param name="fieldLabelId" select="&#39;guests-invite-yourself-label&#39;"></xsl:with-param>
<xsl:with-param name="fieldLabelText"><xsl:text>
              任何人都可以将自己添加到此工作日程中
            </xsl:text></xsl:with-param></xsl:call-template></xsl:if></div></xsl:template>
<xsl:template name="module-attendees.shared-property-value"><xsl:param name="baseName"></xsl:param>
<xsl:param name="propName"></xsl:param>
<xsl:param name="fieldId"></xsl:param>
<xsl:param name="fieldLabelId"></xsl:param>
<xsl:param name="fieldLabelText"></xsl:param>
<xsl:if test="shared-property[@name = $propName]/@access = &#39;editable&#39;"><div><div class="field editable"><xsl:attribute name="id"><xsl:text>ff-guests-</xsl:text> <xsl:value-of select="$baseName"></xsl:value-of></xsl:attribute>
<div class="data input field-sprop editable checkbox"><xsl:attribute name="id"><xsl:text>wi-guests-</xsl:text> <xsl:value-of select="$baseName"></xsl:value-of></xsl:attribute>
<xsl:call-template name="module-attendees.checkbox-sprop"><xsl:with-param name="fieldId" select="$fieldId"></xsl:with-param>
<xsl:with-param name="propName" select="$propName"></xsl:with-param></xsl:call-template></div></div>
<label><xsl:attribute name="id"><xsl:value-of select="$fieldLabelId"></xsl:value-of></xsl:attribute>
<xsl:attribute name="for"><xsl:value-of select="$fieldId"></xsl:value-of></xsl:attribute>
<xsl:value-of select="$fieldLabelText"></xsl:value-of></label></div></xsl:if></xsl:template>
<xsl:template name="module-attendees.checkbox-sprop"><xsl:param name="fieldId"></xsl:param>
<xsl:param name="propName"></xsl:param>
<input type="checkbox" name="sprop"><xsl:attribute name="id"><xsl:value-of select="$fieldId"></xsl:value-of></xsl:attribute>
<xsl:attribute name="value"><xsl:value-of select="$propName"></xsl:value-of> <xsl:text>:true</xsl:text></xsl:attribute>
<xsl:if test="shared-property[@name = $propName]/value = &#39;true&#39;"><xsl:attribute name="checked"><xsl:text>checked</xsl:text></xsl:attribute></xsl:if></input>
<input type="hidden" name="old-sprop"><xsl:attribute name="value"><xsl:if test="/eventpage/@action != &#39;CREATE&#39;"><xsl:value-of select="$propName"></xsl:value-of>
<xsl:text>:</xsl:text>
<xsl:value-of select="shared-property[@name = $propName]/value"></xsl:value-of></xsl:if></xsl:attribute></input></xsl:template>
<xsl:template name="module-comments.main"><xsl:choose><xsl:when test="(/eventpage/features/feature[position() - 1 =          13 and @enabled = &#39;true&#39;])"><xsl:if test="count(comments/comment) != 0"><xsl:call-template name="module-comments.disabled-content"></xsl:call-template></xsl:if></xsl:when>
<xsl:otherwise><xsl:if test="comments/@access = &#39;editable&#39; or             count(comments/comment) != 0"><xsl:call-template name="module-comments.normal-content"></xsl:call-template></xsl:if></xsl:otherwise></xsl:choose></xsl:template>
<xsl:template name="module-comments.disabled-content"><div id="comments-disabled"></div></xsl:template>
<xsl:template name="module-comments.normal-content"><div id="comments"><xsl:attribute name="class"><xsl:text>module </xsl:text> <xsl:call-template name="common.module-expanded"><xsl:with-param name="module-id" select="8"></xsl:with-param></xsl:call-template> <xsl:if test="count(modules/module                           [@module-id = 7]) != 0"><xsl:text> add-comment-open</xsl:text></xsl:if></xsl:attribute>
<div class="t1"></div><div class="t2"></div>
<h2 class="header"><a onclick="_wi_tm(_MODULE_TYPE_COMMENTS);return false" class="toggle"><xsl:attribute name="href"><xsl:call-template name="common.toggle"><xsl:with-param name="module-id" select="8"></xsl:with-param></xsl:call-template></xsl:attribute>
<xsl:text>讨论此工作日程</xsl:text></a></h2>
<xsl:call-template name="module-comments.editbox"></xsl:call-template>
<xsl:apply-templates select="comments"></xsl:apply-templates></div></xsl:template>
<xsl:template name="module-comments.editbox"><xsl:if test="comments/@access = &#39;editable&#39;"><p class="actions requiresjs"><a onclick="return _showCommentField(this)" class="actionlink add"><xsl:attribute name="href"><xsl:call-template name="common.toggle"><xsl:with-param name="module-id" select="7"></xsl:with-param></xsl:call-template></xsl:attribute>
<xsl:text>添加注释</xsl:text></a></p>
<div class="fevent modulebody" id="addCommentForm"><div class="field"><div class="data collapsed" id="addedcomments"><div class="group"><p class="instructions"><xsl:text>在下面输入您的注释，输好以后一定要记得按“发布注释”。</xsl:text></p>
<div id="ff-commenttext" class="field editable"><span id="wi-commenttext" class="input editable textarea field-ec"><textarea onblur="_wi_b(this)" onfocus="_wi_f(this)" id="commenttext" name="ec" class="primitive fieldinput"></textarea>
<input type="hidden" id="old-commenttext" name="old-ec"></input></span></div></div>
<div class="btngroup"><button onclick="_wi_pc(_$(&#39;masterForm&#39;),event); return false" class="btn btnsm"><xsl:text>发布注释</xsl:text></button></div></div></div></div></xsl:if></xsl:template>
<xsl:template match="comments"><div class="modulebody" id="existingComments"><div id="ff-commentlist" class="field readonly"><xsl:choose><xsl:when test="count(comment) != 0"><ol id="wi-commentlist" class="data input field-dec readonly rolist"><xsl:apply-templates select="comment"></xsl:apply-templates></ol></xsl:when>
<xsl:otherwise><div id="wi-commentlist" class="data input field-dec readonly text">抱歉，还没有人发表意见。如果觉得无聊，您不妨看看  <a href="#" target="_new">job18.net 懒人工作通</a>。</div></xsl:otherwise></xsl:choose></div></div></xsl:template>
<xsl:template match="comment"><li class="roitem comment"><em class="comment-date"><xsl:value-of select="rel-time"></xsl:value-of></em>
<cite><xsl:attribute name="class"><xsl:text>name</xsl:text> <xsl:variable name="author-status" select="author/principal/@status"></xsl:variable> <xsl:choose><xsl:when test="$author-status = 1"><xsl:text> response-yes</xsl:text></xsl:when> <xsl:when test="$author-status = 2"><xsl:text> response-no</xsl:text></xsl:when> <xsl:when test="$author-status =                      3"><xsl:text> response-maybe</xsl:text></xsl:when> <xsl:when test="$author-status =                     0"><xsl:text> response-none</xsl:text></xsl:when></xsl:choose> <xsl:if test="/eventpage/self/principal/@id =                           author/principal/@id"><xsl:text> self</xsl:text></xsl:if></xsl:attribute>
<xsl:value-of select="author/principal/display"></xsl:value-of></cite>
<blockquote class="comment-text"><xsl:apply-templates select="html" mode="common.inline-html"></xsl:apply-templates></blockquote></li></xsl:template>
<xsl:template name="module-details.main"><div class="t1"></div><div class="t2"></div>
<div class="module" id="details"><div class="modulebody"><xsl:apply-templates select="summary"></xsl:apply-templates>
<xsl:apply-templates select="dates" mode="field"></xsl:apply-templates>
<xsl:apply-templates select="timezone"></xsl:apply-templates>
<xsl:apply-templates select="rrule" mode="recurui.main"></xsl:apply-templates>
<xsl:call-template name="check-resources"></xsl:call-template>
<xsl:apply-templates select="location"></xsl:apply-templates>
<xsl:apply-templates select="geocode"></xsl:apply-templates>
<xsl:apply-templates select="source-calendar"></xsl:apply-templates>
<xsl:apply-templates select="description"></xsl:apply-templates>
<xsl:call-template name="job18-doc"></xsl:call-template>
<xsl:call-template name="debug-info"></xsl:call-template>
<div class="reset"></div></div></div>
<div class="t2"></div><div class="t1"></div></xsl:template>
<xsl:template match="summary"><div id="ff-title" style="height:50px;"><xsl:attribute name="class"><xsl:text>field </xsl:text> <xsl:value-of select="@access"></xsl:value-of></xsl:attribute>
<h3 class="label"><label for="wi-title"><xsl:text>标题</xsl:text></label></h3>
<div id="wi-title"><xsl:if test="@access = &#39;editable&#39; and @editing != &#39;true&#39;"><xsl:attribute name="onclick"><xsl:text>_wi_rewriteOnDemand(this,event)</xsl:text></xsl:attribute></xsl:if>
<xsl:call-template name="common.widget-classes"><xsl:with-param name="name" select="&#39;text&#39;"></xsl:with-param>
<xsl:with-param name="type" select="&#39;text&#39;"></xsl:with-param>
<xsl:with-param name="value" select="html"></xsl:with-param></xsl:call-template>
<xsl:choose><xsl:when test="@editing = &#39;true&#39;"><input type="text" class="fieldinput text" onkeypress="return(_wi_ns(this,event))" onblur="_wi_b(this)" onfocus="_wi_f(this)" name="text" id="title"><xsl:attribute name="value"><xsl:value-of select="html"></xsl:value-of></xsl:attribute></input>
<input type="hidden" name="old-text" id="old-title"><xsl:attribute name="value"><xsl:if test="/eventpage/@action != &#39;CREATE&#39;"><xsl:value-of select="html"></xsl:value-of></xsl:if></xsl:attribute></input></xsl:when>
<xsl:when test="count(html/text()) != 0"><xsl:apply-templates select="html" mode="common.inline-html"></xsl:apply-templates></xsl:when>
<xsl:otherwise><xsl:text>&#160;</xsl:text></xsl:otherwise></xsl:choose></div></div></xsl:template>
<xsl:template match="dates" mode="field">
  <div id="ff-when" style="height:50px;"><xsl:attribute name="class"><xsl:text>field </xsl:text> <xsl:value-of select="@access"></xsl:value-of></xsl:attribute>
<h3 class="label"><label for="wi-when"><xsl:text>时间</xsl:text></label></h3>
<div id="wi-when"><xsl:if test="@access = &#39;editable&#39; and @editing != &#39;true&#39;"><xsl:attribute name="onclick"><xsl:text>_wi_rewriteOnDemand(this,event)</xsl:text></xsl:attribute></xsl:if>
<xsl:call-template name="common.widget-classes"><xsl:with-param name="name" select="&#39;dates&#39;"></xsl:with-param>
<xsl:with-param name="type" select="&#39;daterange&#39;"></xsl:with-param>
<xsl:with-param name="value" select="value"></xsl:with-param></xsl:call-template>
<xsl:if test="@editing != &#39;true&#39;"><xsl:value-of select="display"></xsl:value-of>
<span id="hr-r-recur"><xsl:if test="../rrule/display != &#39;&#39;"><xsl:text> (</xsl:text> <xsl:value-of select="../rrule/display"></xsl:value-of> <xsl:text>)</xsl:text></xsl:if></span></xsl:if></div></div>
<xsl:if test="value != &#39;&#39;"><pre id="real-when" style="display: none">
        <xsl:value-of select="value"></xsl:value-of>
      </pre></xsl:if></xsl:template>
<xsl:template name="check-resources"><xsl:if test="/eventpage/self/principal/@calendar-settings != &#39;&#39; and                   /eventpage/@simplified = &#39;true&#39; and                   (/eventpage/attendees/@access = &#39;editable&#39; or                    /eventpage/attendees/@access = &#39;extensible&#39;)"><div id="checkR"><h3 class="label"></h3>
<div onmousedown="_ME_ScheduleMeeting()" class="alternative"><xsl:text>
            检查邀请对象是否能参加，资源是否可用
          </xsl:text></div></div></xsl:if></xsl:template>
<xsl:template match="timezone"><xsl:if test="/eventpage/@simplified = &#39;false&#39; and                   /eventpage/@current-action = &#39;TEMPLATE&#39; and                   /eventpage/timezone/@visible = &#39;true&#39;"><div id="ff-timezone" class="field {@access}"><h3 class="label"><label for="wi-timezone"></label></h3>
<div id="wi-timezone"><xsl:call-template name="common.widget-classes"><xsl:with-param name="name" select="&#39;timezone&#39;"></xsl:with-param>
<xsl:with-param name="type" select="&#39;text&#39;"></xsl:with-param>
<xsl:with-param name="value" select="/eventpage/timezone/value"></xsl:with-param></xsl:call-template>
<div id="timezone-msg">开始时间和结束时间都显示在日历的时区 (<xsl:value-of select="/eventpage/timezone/display"></xsl:value-of>) 中</div></div></div></xsl:if></xsl:template>
<xsl:template match="location"><div id="ff-where" style="display:none"><xsl:attribute name="class"><xsl:text>field </xsl:text> <xsl:value-of select="@access"></xsl:value-of> <xsl:if test="@access != &#39;editable&#39; and value = &#39;&#39;"><xsl:text> blank</xsl:text></xsl:if> <xsl:text> auto-location</xsl:text></xsl:attribute>
<h3 class="label"><label for="wi-where"><xsl:text>地点</xsl:text></label></h3>
<xsl:if test="count(link) != 0"><span id="map_link" class="extracontent"><a class="link" target="_blank" onclick="return _gotoMap(&#39;where&#39;);"><xsl:attribute name="href"><xsl:value-of select="link"></xsl:value-of></xsl:attribute>
<xsl:if test="contains(link, &#39;://maps.job18.&#39;)"><xsl:attribute name="title"><xsl:text>点击查看 job18 地图</xsl:text></xsl:attribute></xsl:if>
<xsl:text>地图</xsl:text></a></span></xsl:if>
<div id="wi-where"><xsl:call-template name="common.widget-classes"><xsl:with-param name="name" select="&#39;location&#39;"></xsl:with-param>
<xsl:with-param name="type" select="&#39;text&#39;"></xsl:with-param>
<xsl:with-param name="value" select="value"></xsl:with-param></xsl:call-template>
<xsl:if test="@access = &#39;editable&#39; and @editing != &#39;true&#39;"><xsl:attribute name="onclick"><xsl:text>_wi_rewriteOnDemand(this,event)</xsl:text></xsl:attribute></xsl:if>
<xsl:choose><xsl:when test="@access = &#39;editable&#39; and                           @editing = &#39;true&#39;"><input type="text" class="fieldinput text" onkeypress="return(_wi_ns(this,event))" onblur="_wi_b(this)" onfocus="_wi_f(this)" name="location" id="where"><xsl:attribute name="value"><xsl:value-of select="value"></xsl:value-of></xsl:attribute></input>
<xsl:if test="/eventpage/@action != &#39;CREATE&#39;"><input type="hidden" name="old-location" id="old-where"><xsl:attribute name="value"><xsl:value-of select="value"></xsl:value-of></xsl:attribute></input></xsl:if></xsl:when>
<xsl:otherwise><xsl:value-of select="value"></xsl:value-of></xsl:otherwise></xsl:choose></div>
<xsl:if test="@access = &#39;editable&#39; and @editing != &#39;true&#39; and value = &#39;&#39;"><div class="alternative requiresjs alternativewhere" id="alt-where" onclick="_wi_rewriteOnDemand(_$(&#39;wi-where&#39;),event);_WHACK();return false"><xsl:text>点击以添加地点</xsl:text></div></xsl:if></div></xsl:template>
<xsl:template match="geocode"><h3 class="label"></h3>
<div class="field readonly"><div class="data readonly"><div id="efmap"></div></div></div>
<div id="ff-map"><input type="hidden" id="latitude"><xsl:attribute name="value"><xsl:value-of select="@latitudeE6"></xsl:value-of></xsl:attribute></input>
<input type="hidden" id="longitude"><xsl:attribute name="value"><xsl:value-of select="@longitudeE6"></xsl:value-of></xsl:attribute></input>
<input type="hidden" id="zoomlevel"><xsl:attribute name="value"><xsl:value-of select="@zoomlevel"></xsl:value-of></xsl:attribute></input></div></xsl:template>
<xsl:template match="source-calendar"><xsl:if test="/eventpage/@action != &#39;CREATE&#39;"><input type="hidden" name="src" id="oncalendar"><xsl:attribute name="value"><xsl:value-of select="principal/@id"></xsl:value-of></xsl:attribute></input></xsl:if>
<xsl:choose><xsl:when test="@access = &#39;editable&#39;"><xsl:variable name="field-name"><xsl:choose><xsl:when test="/eventpage/@action = &#39;CREATE&#39;"><xsl:text>oncalendar</xsl:text></xsl:when> <xsl:otherwise><xsl:text>tocalendar</xsl:text></xsl:otherwise></xsl:choose></xsl:variable>
<xsl:variable name="input-name"><xsl:choose><xsl:when test="/eventpage/@action = &#39;CREATE&#39;">src</xsl:when> <xsl:otherwise>targ</xsl:otherwise></xsl:choose></xsl:variable>
<div class="field editable" style="display:none"><xsl:attribute name="id"><xsl:text>ff-</xsl:text><xsl:value-of select="$field-name"></xsl:value-of></xsl:attribute>
<h3 class="label"><label><xsl:attribute name="for"><xsl:text>wi-</xsl:text><xsl:value-of select="$field-name"></xsl:value-of></xsl:attribute>
<xsl:text>日历</xsl:text></label></h3>
<span><xsl:attribute name="id"><xsl:text>wi-</xsl:text><xsl:value-of select="$field-name"></xsl:value-of></xsl:attribute>
<xsl:attribute name="class"><xsl:text>input editable list field-</xsl:text> <xsl:value-of select="$input-name"></xsl:value-of></xsl:attribute>
<select size="1"><xsl:attribute name="id"><xsl:value-of select="$field-name"></xsl:value-of></xsl:attribute>
<xsl:attribute name="name"><xsl:value-of select="$input-name"></xsl:value-of></xsl:attribute>
<xsl:attribute name="onchange"><xsl:text>_EF_CalendarChange(this, &#39;</xsl:text> <xsl:value-of select="principal/@id"></xsl:value-of> <xsl:text>&#39;)</xsl:text></xsl:attribute>
<xsl:call-template name="common.calendar-list"><xsl:with-param name="selected_value" select="principal/@id"></xsl:with-param></xsl:call-template></select>
<input type="hidden"><xsl:attribute name="name"><xsl:text>old-</xsl:text><xsl:value-of select="$input-name"></xsl:value-of></xsl:attribute>
<xsl:attribute name="id"><xsl:text>old-</xsl:text><xsl:value-of select="$field-name"></xsl:value-of></xsl:attribute>
<xsl:attribute name="value"><xsl:if test="/eventpage/@action != &#39;CREATE&#39;"><xsl:value-of select="principal/@id"></xsl:value-of></xsl:if></xsl:attribute></input></span></div></xsl:when>
<xsl:when test="/eventpage/@action = &#39;CREATE&#39;"><input type="hidden" name="src" id="oncalendar"><xsl:attribute name="value"><xsl:value-of select="/eventpage/calendars/principal/@id"></xsl:value-of></xsl:attribute></input>
<input type="hidden" name="old-src" id="old-oncalendar"></input></xsl:when>
<xsl:otherwise><xsl:variable name="self" select="../self/principal/@id"></xsl:variable>
<xsl:variable name="owner" select="../organizer/principal/@id"></xsl:variable>
<xsl:variable name="creator" select="../creator/principal/@id"></xsl:variable>
<xsl:variable name="src" select="principal/value"></xsl:variable>
<xsl:if test="$owner != &#39;&#39; and                       (($creator != &#39;&#39; and $creator != $owner) or                        $owner != $self or $creator != $self or $src != $self)"><div id="ff-by" class="field readonly"><h3 class="label"><label for="wi-by"><xsl:text></xsl:text></label></h3>
<span id="wi-by" class="input readonly text field-owner"><cite class="name"><xsl:choose><xsl:when test="$creator != &#39;&#39; and $creator != $owner">由 <xsl:apply-templates select="../creator/principal" mode="common.person"></xsl:apply-templates> 替 <xsl:apply-templates select="../organizer/principal" mode="common.person"></xsl:apply-templates> 创建</xsl:when>
<xsl:otherwise><xsl:apply-templates select="../organizer/principal" mode="common.person"></xsl:apply-templates></xsl:otherwise></xsl:choose></cite></span></div></xsl:if></xsl:otherwise></xsl:choose></xsl:template>
<xsl:template match="description">
  <div id="ff-descrip" style="height:200px;"><xsl:attribute name="class"><xsl:text>field </xsl:text> <xsl:value-of select="@access"></xsl:value-of> <xsl:if test="@access != &#39;editable&#39; and html = &#39;&#39;"><xsl:text> blank</xsl:text></xsl:if></xsl:attribute>
<h3 class="label"><label for="wi-descrip"><xsl:text>详情</xsl:text></label></h3>
<pre id="wi-descrip">
        <xsl:if test="@access = &#39;editable&#39; and @editing != &#39;true&#39;">
          <xsl:attribute name="onclick">
            <xsl:text>_wi_rewriteOnDemand(this,event)</xsl:text>
          </xsl:attribute>
        </xsl:if>

        <xsl:call-template name="common.widget-classes">
          <xsl:with-param name="name" select="&#39;details&#39;"></xsl:with-param>
          <xsl:with-param name="type" select="&#39;textarea pre-wrap&#39;"></xsl:with-param>
          <xsl:with-param name="value" select="html"></xsl:with-param>
        </xsl:call-template>

        <xsl:choose>
          <xsl:when test="@editing = &#39;true&#39;">

            <textarea class="fieldinput" onblur="_wi_b(this)" onfocus="_wi_f(this)" onclick="_rta(this)" onkeyup="_rta(this)" name="details" id="descrip" rows="5" style="overflow: hidden">
              
              <xsl:apply-templates select="html" mode="common.html-to-text"></xsl:apply-templates>
            </textarea>
            <xsl:if test="/eventpage/@action != &#39;CREATE&#39;">
              <input type="hidden" name="old-details" id="old-descrip">
                <xsl:attribute name="value">
                  <xsl:apply-templates select="html" mode="common.html-to-text"></xsl:apply-templates>
                </xsl:attribute>
              </input>
            </xsl:if>

          </xsl:when>
          <xsl:otherwise>

            <xsl:apply-templates select="html" mode="common.inline-html"></xsl:apply-templates>

          </xsl:otherwise>
        </xsl:choose>
      </pre>
<xsl:if test="@access = &#39;editable&#39; and @editing != &#39;true&#39; and html = &#39;&#39;"><div class="alternative requiresjs alternativedescrip" id="alt-descrip" onclick="_wi_rewriteOnDemand(_$(&#39;wi-descrip&#39;),event);_WHACK();return false"><xsl:text>点击以添加说明</xsl:text></div></xsl:if>
  </div>
</xsl:template>
<xsl:template name="debug-info"><xsl:if test="debug-info"><a><xsl:attribute name="href">javascript:_DI_Alert(&quot;Event details&quot;, &quot;<xsl:value-of select="debug-info"></xsl:value-of>&quot;)</xsl:attribute> Debug Info</a></xsl:if></xsl:template>
<xsl:template name="job18-doc"><xsl:if test="(/eventpage/features/feature[position() - 1 =          9 and @enabled = &#39;true&#39;])"><div id="ff-job18-docs" class="field editable"><div><input type="hidden" id="no-of-gdocs"><xsl:attribute name="value"><xsl:value-of select="count(/eventpage/attachments/attachment)"></xsl:value-of></xsl:attribute></input></div>
<div id="docs-attached"><xsl:for-each select="attachments/attachment"><xsl:call-template name="elements-for-an-attachment"><xsl:with-param name="url-of-doc" select="url"></xsl:with-param>
<xsl:with-param name="title-of-doc" select="title"></xsl:with-param>
<xsl:with-param name="icon-url-of-doc" select="icon-url"></xsl:with-param>
<xsl:with-param name="id-prefix"></xsl:with-param></xsl:call-template>
<xsl:call-template name="elements-for-an-attachment"><xsl:with-param name="url-of-doc" select="url"></xsl:with-param>
<xsl:with-param name="title-of-doc" select="title"></xsl:with-param>
<xsl:with-param name="icon-url-of-doc" select="icon-url"></xsl:with-param>
<xsl:with-param name="id-prefix">old-</xsl:with-param></xsl:call-template></xsl:for-each></div>
<div><input id="can-add-job18-doc" type="hidden"><xsl:attribute name="value"><xsl:choose><xsl:when test="/eventpage/@access-level &gt;=                     60"><xsl:text>true</xsl:text></xsl:when>
<xsl:otherwise><xsl:text>false</xsl:text></xsl:otherwise></xsl:choose></xsl:attribute></input></div>
<xsl:choose><xsl:when test="/eventpage/@access-level &gt;= 60"><xsl:call-template name="draw-job18-doc"></xsl:call-template></xsl:when>
<xsl:otherwise><xsl:if test="count(/eventpage/attachments/attachment) &gt; 0"><xsl:call-template name="draw-job18-doc"></xsl:call-template></xsl:if></xsl:otherwise></xsl:choose></div></xsl:if></xsl:template>
<xsl:template name="draw-job18-doc"><h3 class="label"><label for="display-docs"><xsl:text>附件</xsl:text></label></h3>
<div id="display-docs"><table id="job18-docs-top-table" frame="void"></table></div></xsl:template>
<xsl:template name="elements-for-an-attachment"><xsl:param name="url-of-doc"></xsl:param>
<xsl:param name="title-of-doc"></xsl:param>
<xsl:param name="icon-url-of-doc"></xsl:param>
<xsl:param name="id-prefix"></xsl:param>
<input type="hidden"><xsl:attribute name="name"><xsl:value-of select="$id-prefix"></xsl:value-of>
<xsl:text>gdoc-attachment</xsl:text></xsl:attribute>
<xsl:attribute name="value"><xsl:value-of select="$url-of-doc"></xsl:value-of>
<xsl:text> </xsl:text>
<xsl:value-of select="$title-of-doc"></xsl:value-of>
<xsl:text> </xsl:text>
<xsl:value-of select="$icon-url-of-doc"></xsl:value-of></xsl:attribute></input></xsl:template>
<xsl:variable name="event-is-editable" select="count(/eventpage/*/@access[. != &#39;readonly&#39;]) != 0"></xsl:variable>
<xsl:variable name="event-is-spammable" select="(/eventpage/creator/principal/@id != /eventpage/self/principal/@id)        and (/eventpage/organizer/principal/@id != /eventpage/self/principal/@id)        and count(/eventpage/attendees/*) &gt;= 1"></xsl:variable>
<xsl:template name="module-header-footer.header"><div class="noprint eventborder" style="padding-bottom: 8px; background-color: #c3d9ff; width: 100%"><a class="lk" onmousedown="_EF_Dismiss(false)" onclick="return false" href="javascript:&#39;&#39;" id="btcb_top" style="font-weight: bold; font-size: 90%"><xsl:text>&#171; 返回到日历</xsl:text></a>
<xsl:if test="$event-is-editable"><xsl:text>&#160;</xsl:text>
<button class="ab" onclick="_EV_Blur(this);_wi_s(_$(&#39;masterForm&#39;), true, false,              false)" id="detailSubmitButtonTop" accesskey="s">保存<small> (<u>S</u>)</small></button>
<xsl:text>&#160;</xsl:text>
<button class="ab" onclick="_EV_Blur(this);_EF_Dismiss(true)" id="efcb_top"><xsl:text>取消</xsl:text></button>
<xsl:if test="@action != &#39;CREATE&#39; and                       @access-level &gt;= 40"><xsl:text>&#160;</xsl:text>
<button onclick="_EF_Delete()" class="ab"><xsl:text>删除</xsl:text></button></xsl:if></xsl:if>
<xsl:if test="@action != &#39;CREATE&#39; and                     count(calendars/principal) != 0"><form action="" style="display: none"><select id="more_actions" size="1" class="prefselect" style="vertical-align: middle;" onchange="_EF_moreActionsChange(this)"><option value="n" selected="selected"><xsl:text>其他操作...</xsl:text></option>
<xsl:if test="@access-level &gt;= 60"><option value="t"><xsl:text>更改拥有者...</xsl:text></option></xsl:if>
<option value="d"><xsl:text>重复工作日程</xsl:text></option>
<xsl:for-each select="calendars/principal"><xsl:if test="@id != /eventpage/source-calendar/principal/@id"><option><xsl:attribute name="value"><xsl:text>c</xsl:text>
<xsl:value-of select="@id"></xsl:value-of></xsl:attribute>复制到 <xsl:value-of select="display"></xsl:value-of></option></xsl:if></xsl:for-each></select></form></xsl:if></div></xsl:template>
<xsl:template name="module-header-footer.footer"><div class="noprint eventborder" style="padding-top: 8px; padding-top: 8px; background-color: #c3d9ff; width: 100%"><a class="lk" onmousedown="_EF_Dismiss(false)" onclick="return false" href="javascript:&#39;&#39;" id="btcb_btm" style="font-weight: bold; font-size: 90%"><xsl:text>&#171; 返回到日历</xsl:text></a>
<xsl:if test="$event-is-editable"><xsl:text>&#160;</xsl:text>
<button class="ab" onclick="_EV_Blur(this);_wi_s(_$(&#39;masterForm&#39;), true, false,            false)" id="detailSubmitButtonBtm" accesskey="s">保存<small> (<u>S</u>)</small></button>
<xsl:text>&#160;</xsl:text>
<button class="ab" onclick="_EV_Blur(this);_EF_Dismiss(true)" id="efcb_btm"><xsl:text>取消</xsl:text></button></xsl:if></div></xsl:template>
<xsl:template name="module-hidden.main"><input type="hidden" name="ctz"><xsl:attribute name="value"><xsl:value-of select="timezone/value"></xsl:value-of></xsl:attribute></input>
<input type="hidden" name="rfdt"><xsl:attribute name="value"><xsl:value-of select="ref-date/value"></xsl:value-of></xsl:attribute></input>
<xsl:if test="attendees/@exceptional = &#39;true&#39;"><input type="hidden" id="marker-showntfdlg"></input></xsl:if>
<xsl:if test="/eventpage/@action = &#39;CREATE&#39;"><xsl:for-each select="private-property[@access != &#39;editable&#39;]"><input type="hidden" name="pprop"><xsl:attribute name="id"><xsl:text>prv-props-</xsl:text> <xsl:value-of select="position() - 1"></xsl:value-of></xsl:attribute>
<xsl:attribute name="value"><xsl:value-of select="@name"></xsl:value-of> <xsl:text>:</xsl:text> <xsl:value-of select="value"></xsl:value-of></xsl:attribute></input></xsl:for-each>
<xsl:for-each select="shared-property[@access != &#39;editable&#39;]"><input type="hidden" name="pprop"><xsl:attribute name="id"><xsl:text>prv-props-</xsl:text> <xsl:value-of select="position() - 1"></xsl:value-of></xsl:attribute>
<xsl:attribute name="value"><xsl:value-of select="@name"></xsl:value-of> <xsl:text>:</xsl:text> <xsl:value-of select="value"></xsl:value-of></xsl:attribute></input></xsl:for-each></xsl:if>
<xsl:if test="shared-property[         @name = &#39;goo.allowModify&#39;]/value = &#39;true&#39;"><input type="hidden" id="marker-guests-can-modify"></input></xsl:if>
<xsl:if test="eid"><input type="hidden" name="eid"><xsl:attribute name="value"><xsl:value-of select="eid/value"></xsl:value-of></xsl:attribute></input></xsl:if>
<input type="hidden" name="action"><xsl:attribute name="value"><xsl:value-of select="@action"></xsl:value-of></xsl:attribute></input>
<xsl:if test="secid"><input type="hidden" name="secid"><xsl:attribute name="value"><xsl:value-of select="secid/value"></xsl:value-of></xsl:attribute></input></xsl:if>
<xsl:if test="@lang"><input type="hidden" name="hl"><xsl:attribute name="value"><xsl:value-of select="@lang"></xsl:value-of></xsl:attribute></input></xsl:if>
<xsl:if test="source-calendar/@access != &#39;editable&#39;"><input type="hidden" id="marker-calname"><xsl:attribute name="value"><xsl:value-of select="/eventpage/source-calendar/principal/display"></xsl:value-of></xsl:attribute></input></xsl:if>
<xsl:if test="source-calendar/principal/@id = organizer/principal/@id"><input type="hidden" id="marker-org-cal"></input></xsl:if>
<xsl:if test="source-calendar/principal/@calendar-settings != &#39;&#39;"><input type="hidden" id="domain-marker"><xsl:attribute name="value"><xsl:value-of select="source-calendar/principal/@calendar-settings"></xsl:value-of></xsl:attribute></input></xsl:if>
<xsl:if test="@specialized = &#39;true&#39;"><input type="hidden" id="marker-special"></input></xsl:if>
<xsl:if test="attendees/@partial = &#39;true&#39;"><input type="hidden" id="marker-hiddenguests"></input></xsl:if>
<xsl:if test="@simplified = &#39;true&#39;"><input type="hidden" name="sf" value="true"></input></xsl:if></xsl:template>
<xsl:template name="module-options.main"><xsl:if test="transparent/@access=&#39;editable&#39; or                   class/@access=&#39;editable&#39; or                   (reminders/@access=&#39;editable&#39; and @simplified=&#39;true&#39;)"><div id="options" style="display:none"><xsl:attribute name="class"><xsl:text>module </xsl:text> <xsl:call-template name="common.module-expanded"><xsl:with-param name="module-id" select="6"></xsl:with-param></xsl:call-template></xsl:attribute>
<hr></hr>
<div class="t1"></div><div class="t2"></div>
<h2 class="header"><a onclick="_wi_tm(_MODULE_TYPE_OPTIONS);return false" class="toggle"><xsl:attribute name="href"><xsl:call-template name="common.toggle"><xsl:with-param name="module-id" select="6"></xsl:with-param></xsl:call-template></xsl:attribute>
<xsl:text>选项</xsl:text></a></h2>
<div class="modulebody"><div class="fevent" id="optionForm"><xsl:apply-templates select="reminders"></xsl:apply-templates>
<xsl:apply-templates select="transparent"></xsl:apply-templates>
<xsl:apply-templates select="class"></xsl:apply-templates></div></div></div></xsl:if></xsl:template>
<xsl:template match="reminders"><xsl:if test="@access = &#39;editable&#39;"><div id="ff-op-reminder" class="field editable"><h3 class="subtitle"><label for="wi-op-reminder"><xsl:text>提醒</xsl:text></label></h3>
<div id="wi-op-reminder"><xsl:attribute name="class"><xsl:text>data input field editable reminderBlock</xsl:text></xsl:attribute>
<div id="op-reminder"></div></div></div></xsl:if></xsl:template>
<xsl:template match="transparent"><xsl:if test="@access = &#39;editable&#39;"><div id="ff-op-avail" class="field editable"><h3 class="label"><label for="wi-op-avail"><xsl:text>状态显示为</xsl:text></label></h3>
<span id="wi-op-avail" class="input editable radio field-trp"><div class="data"><div class="group"><input type="radio" name="trp" id="op-avail__0" class="member" value="true"><xsl:if test="value = &#39;true&#39;"><xsl:attribute name="checked"><xsl:text>checked</xsl:text></xsl:attribute></xsl:if></input>
<xsl:text>&#160;</xsl:text>
<label id="lbl-op-avail__0" for="op-avail__0"><xsl:text>有空</xsl:text></label></div>
<div class="group"><input type="radio" name="trp" id="op-avail__1" class="member" value="false"><xsl:if test="value != &#39;true&#39;"><xsl:attribute name="checked"><xsl:text>checked</xsl:text></xsl:attribute></xsl:if></input>
<xsl:text>&#160;</xsl:text>
<label id="lbl-op-avail__1" for="op-avail__1"><xsl:text>忙碌</xsl:text></label></div></div>
<input type="hidden" name="old-trp"><xsl:attribute name="value"><xsl:if test="/eventpage/@action != &#39;CREATE&#39;"><xsl:value-of select="value"></xsl:value-of></xsl:if></xsl:attribute></input></span></div></xsl:if></xsl:template>
<xsl:template match="class"><xsl:if test="@access = &#39;editable&#39;"><div class="field"><h3 class="label"><xsl:text>工作日程性质</xsl:text></h3>
<div class="data"><h4 class="subtitle"><xsl:text>此工作日程是:</xsl:text></h4>
<div id="ff-op-pub" class="field editable"><span id="wi-op-pub" class="input editable radio field-icc"><div class="data"><div class="group"><input type="radio" name="icc" id="op-pub__0" class="member" value="DEFAULT"><xsl:if test="value = &#39;DEFAULT&#39;"><xsl:attribute name="checked"><xsl:text>checked</xsl:text></xsl:attribute></xsl:if></input>
<xsl:text>&#160;</xsl:text>
<label id="lbl-op-pub__0" for="op-pub__0"><xsl:text>默认</xsl:text></label></div></div>
<div class="data"><div class="group"><input type="radio" name="icc" id="op-pub__1" class="member" value="PRIVATE"><xsl:if test="value = &#39;PRIVATE&#39;"><xsl:attribute name="checked"><xsl:text>checked</xsl:text></xsl:attribute></xsl:if></input>
<xsl:text>&#160;</xsl:text>
<label id="lbl-op-pub__1" for="op-pub__1"><xsl:text>私人</xsl:text></label></div></div>
<div class="data"><div class="group"><input type="radio" name="icc" id="op-pub__2" class="member" value="PUBLIC"><xsl:if test="value = &#39;PUBLIC&#39;"><xsl:attribute name="checked"><xsl:text>checked</xsl:text></xsl:attribute></xsl:if></input>
<xsl:text>&#160;</xsl:text>
<label id="lbl-op-pub__2" for="op-pub__2"><xsl:text>公共</xsl:text></label></div></div>
<input type="hidden" name="old-icc"><xsl:attribute name="value"><xsl:if test="/eventpage/@action != &#39;CREATE&#39;"><xsl:value-of select="value"></xsl:value-of></xsl:if></xsl:attribute></input></span></div>
<a id="helplink34580" target="_blank" class="helplink"><xsl:attribute name="href"><xsl:text>#</xsl:text> <xsl:text>/bin/answer.py?answer=34580&amp;hl=</xsl:text> <xsl:value-of select="/eventpage/@lang"></xsl:value-of></xsl:attribute>
<xsl:text>了解私人和公共工作日程</xsl:text></a>
<xsl:if test="/eventpage/@simplified = &#39;true&#39; and                         /eventpage/@action != &#39;CREATE&#39; and                         /eventpage/class/value != &#39;PRIVATE&#39;"><br></br>
<xsl:if test="/eventpage/self/@allow-publish-dialog-feature = &#39;true&#39;"><a class="helplink" href="javascript:void(_EF_OpenPublishDialog())"><xsl:text>发布此工作日程</xsl:text></a></xsl:if>
<xsl:if test="/eventpage/self/@allow-publish-dialog-feature = &#39;false&#39;"><a class="helplink" href="javascript:void(_EF_PublishButtonPopup())"><xsl:text>发布此工作日程</xsl:text></a></xsl:if></xsl:if></div></div></xsl:if></xsl:template>
<xsl:template name="module-response.main"><xsl:call-template name="invite-yourself-if-allowed"></xsl:call-template>
<xsl:if test="@action != &#39;CREATE&#39; and            0 != count(attendees/attendee/principal                       [@id = /eventpage/source-calendar/principal/@id])"><xsl:call-template name="module-response"></xsl:call-template></xsl:if></xsl:template>
<xsl:template name="module-response"><xsl:variable name="editable" select="/eventpage/@access-level &gt;= 30"></xsl:variable>
<xsl:variable name="status" select="/eventpage/source-calendar/         principal/@status"></xsl:variable>
<div id="myresponse"><xsl:call-template name="header-class"><xsl:with-param name="module-to-expand" select="5"></xsl:with-param>
<xsl:with-param name="user-status" select="$status"></xsl:with-param></xsl:call-template>
<hr></hr>
<div class="t1"></div><div class="t2"></div>
<h2 class="header"><xsl:choose><xsl:when test="$editable and /eventpage/@can-respond=&#39;true&#39;"><a onclick="_wi_tm(_MODULE_TYPE_ATTENDING);return false" class="toggle"><xsl:attribute name="href"><xsl:call-template name="common.toggle"><xsl:with-param name="module-id" select="5"></xsl:with-param></xsl:call-template></xsl:attribute>
<xsl:call-template name="module-response.status-messages"></xsl:call-template>
<em><xsl:choose><xsl:when test="/eventpage/source-calendar/principal/@id =                                     /eventpage/self/principal/@id"><xsl:text>更改回复</xsl:text></xsl:when>
<xsl:otherwise>更改对  <xsl:value-of select="/eventpage/source-calendar/principal/display"></xsl:value-of> 的回复</xsl:otherwise></xsl:choose></em></a></xsl:when>
<xsl:otherwise><xsl:call-template name="module-response.status-messages"></xsl:call-template></xsl:otherwise></xsl:choose></h2>
<div class="t2"></div><div class="t1"></div>
<xsl:if test="$editable and /eventpage/@can-respond=&#39;true&#39;"><div class="modulebody"><div class="fevent" id="responseForm"><div id="ff-response" class="field editable"><xsl:call-template name="reponse-radio-buttons"><xsl:with-param name="resp-suffix"></xsl:with-param>
<xsl:with-param name="resp-status" select="$status"></xsl:with-param></xsl:call-template></div>
<xsl:call-template name="resp-comments"><xsl:with-param name="suffix"></xsl:with-param></xsl:call-template></div></div></xsl:if></div></xsl:template>
<xsl:template name="module-response.status-messages"><xsl:param name="invite-yourself"></xsl:param>
<xsl:choose><xsl:when test="/eventpage/source-calendar/principal/@id =                       /eventpage/self/principal/@id or                       $invite-yourself = &#39;true&#39;"><span id="hdr-yes"><xsl:text>是，我会参加</xsl:text></span>
<span id="hdr-no"><xsl:text>不，我不参加</xsl:text></span>
<span id="hdr-maybe"><xsl:text>我可能参加</xsl:text></span>
<span id="hdr-none"><xsl:choose><xsl:when test="$invite-yourself = &#39;true&#39;"><xsl:text>将您自己添加到此工作日程中</xsl:text></xsl:when>
<xsl:otherwise><xsl:text>您尚未回复</xsl:text></xsl:otherwise></xsl:choose></span></xsl:when>
<xsl:otherwise><span id="hdr-yes">是， <xsl:value-of select="/eventpage/source-calendar/principal/display"></xsl:value-of>  将参加</span>
<span id="hdr-no">不， <xsl:value-of select="/eventpage/source-calendar/principal/display"></xsl:value-of>  不参加</span>
<span id="hdr-maybe"> <xsl:value-of select="/eventpage/source-calendar/principal/display"></xsl:value-of>  也许参加</span>
<span id="hdr-none"> <xsl:value-of select="/eventpage/source-calendar/principal/display"></xsl:value-of>  尚未回复</span></xsl:otherwise></xsl:choose></xsl:template>
<xsl:template name="invite-yourself-if-allowed"><xsl:if test="self/@allow-invite-yourself-feature=&#39;true&#39;"><xsl:if test="/eventpage/@can-add-self=&#39;true&#39;"><xsl:call-template name="module-invite-yourself"></xsl:call-template></xsl:if></xsl:if></xsl:template>
<xsl:template name="module-invite-yourself"><div id="invite-yourself"><xsl:variable name="status-invite-yourself" select="/eventpage/self/principal/@status"></xsl:variable>
<xsl:call-template name="header-class"><xsl:with-param name="module-to-expand" select="11"></xsl:with-param>
<xsl:with-param name="user-status" select="$status-invite-yourself"></xsl:with-param></xsl:call-template>
<div class="t1"></div><div class="t2"></div>
<h2 class="header"><xsl:if test="/eventpage/@can-add-self=&#39;true&#39;"><a onclick="_wi_tm(_MODULE_TYPE_INVITE_YOURSELF);return false" class="toggle"><xsl:attribute name="href"><xsl:call-template name="common.toggle"><xsl:with-param name="module-id" select="11"></xsl:with-param></xsl:call-template></xsl:attribute>
<xsl:call-template name="module-response.status-messages"><xsl:with-param name="invite-yourself">true</xsl:with-param></xsl:call-template></a></xsl:if></h2>
<div class="t2"></div><div class="t1"></div>
<xsl:if test="/eventpage/@can-add-self=&#39;true&#39;"><div class="modulebody"><div class="fevent" id="responseForm-invite-yourself"><div id="ff-response-invite-yourself" class="field editable"><xsl:call-template name="reponse-radio-buttons"><xsl:with-param name="resp-suffix">-invite-yourself</xsl:with-param>
<xsl:with-param name="resp-status" select="$status-invite-yourself"></xsl:with-param></xsl:call-template></div>
<xsl:call-template name="resp-comments"><xsl:with-param name="suffix">-invite-yourself</xsl:with-param></xsl:call-template></div></div>
<input type="hidden" id="self-principal-id"><xsl:attribute name="value"><xsl:value-of select="self/principal/@id"></xsl:value-of></xsl:attribute></input></xsl:if></div></xsl:template>
<xsl:template name="header-class"><xsl:param name="module-to-expand"></xsl:param>
<xsl:param name="user-status"></xsl:param>
<xsl:attribute name="class"><xsl:text>module </xsl:text> <xsl:call-template name="common.module-expanded"><xsl:with-param name="module-id" select="$module-to-expand"></xsl:with-param></xsl:call-template> <xsl:choose><xsl:when test="$user-status = 1"><xsl:text> response-yes</xsl:text></xsl:when> <xsl:when test="$user-status =               0"><xsl:text> response-none</xsl:text></xsl:when> <xsl:when test="$user-status = 2"><xsl:text> response-no</xsl:text></xsl:when> <xsl:when test="$user-status = 3"><xsl:text> response-maybe</xsl:text></xsl:when> <xsl:otherwise><xsl:text> response-none</xsl:text></xsl:otherwise></xsl:choose></xsl:attribute></xsl:template>
<xsl:template name="resp-comments"><xsl:param name="suffix"></xsl:param>
<xsl:variable name="self-principal" select="/eventpage/self/principal/@id"></xsl:variable>
<xsl:variable name="source-principal" select="/eventpage/source-calendar/principal/@id"></xsl:variable>
<div class="field"><h3 class="label"><label><xsl:attribute name="for"><xsl:text>rcomment</xsl:text>
<xsl:value-of select="$suffix"></xsl:value-of></xsl:attribute>
添加注释</label></h3>
<div class="data"><div class="group"><div class="field editable"><xsl:attribute name="id"><xsl:text>ff-rcomment</xsl:text>
<xsl:value-of select="$suffix"></xsl:value-of></xsl:attribute>
<span class="input editable textarea field-rcomment"><xsl:attribute name="id"><xsl:text>wi-rcomment</xsl:text>
<xsl:value-of select="$suffix"></xsl:value-of></xsl:attribute>
<textarea onblur="_wi_b(this)" onfocus="_wi_f(this)" class="primitive fieldinput">
                <xsl:attribute name="name">
                  <xsl:text>rcomment</xsl:text>
                  <xsl:value-of select="$suffix"></xsl:value-of>
                </xsl:attribute>
                <xsl:attribute name="id">
                  <xsl:text>rcomment</xsl:text>
                   <xsl:value-of select="$suffix"></xsl:value-of>
                </xsl:attribute>
                <xsl:choose>
                  <xsl:when test="$suffix = &#39;-invite-yourself&#39;">
                    <xsl:value-of select="/eventpage/attendees/attendee                      [principal/@id = $self-principal]/response-comment/value"></xsl:value-of>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="/eventpage/attendees/attendee                      [principal/@id = $source-principal]/                      response-comment/value"></xsl:value-of>
                  </xsl:otherwise>
                </xsl:choose>
              </textarea>
<input type="hidden"><xsl:attribute name="id"><xsl:text>old-rcomment</xsl:text>
<xsl:value-of select="$suffix"></xsl:value-of></xsl:attribute>
<xsl:attribute name="name"><xsl:text>old-rcomment</xsl:text>
<xsl:value-of select="$suffix"></xsl:value-of></xsl:attribute>
<xsl:choose><xsl:when test="$suffix = &#39;-invite-yourself&#39;"><xsl:attribute name="value"><xsl:value-of select="/eventpage/attendees/attendee                        [principal/@id = $self-principal]/                        response-comment/value"></xsl:value-of></xsl:attribute></xsl:when>
<xsl:otherwise><xsl:attribute name="value"><xsl:value-of select="/eventpage/attendees/attendee                        [principal/@id = $source-principal]/                        response-comment/value"></xsl:value-of></xsl:attribute></xsl:otherwise></xsl:choose></input></span></div></div></div>
<div class="data"><div class="btngroup"><xsl:choose><xsl:when test="$suffix = &#39;-invite-yourself&#39;"><input type="button" onclick="_wi_sr(this.form, true)" class="btn btnsm"><xsl:attribute name="value"><xsl:text>提交我的回复</xsl:text></xsl:attribute></input></xsl:when>
<xsl:otherwise><input type="button" onclick="_wi_sr(this.form, false)" class="btn btnsm"><xsl:attribute name="value"><xsl:text>提交我的回复</xsl:text></xsl:attribute></input></xsl:otherwise></xsl:choose></div></div></div></xsl:template>
<xsl:template name="reponse-radio-buttons"><xsl:param name="resp-suffix"></xsl:param>
<xsl:param name="resp-status"></xsl:param>
<xsl:variable name="self-principal" select="/eventpage/self/principal/@id"></xsl:variable>
<xsl:variable name="source-principal" select="/eventpage/source-calendar/principal/@id"></xsl:variable>
<h3 class="label"><label><xsl:attribute name="for"><xsl:text>wi-response</xsl:text>
<xsl:value-of select="$resp-suffix"></xsl:value-of></xsl:attribute>
<xsl:text>您是否会参加？</xsl:text></label></h3>
<span class="input editable radio field-rst"><xsl:attribute name="id"><xsl:text>wi-response</xsl:text>
<xsl:value-of select="$resp-suffix"></xsl:value-of></xsl:attribute>
<div class="data"><div class="group"><input type="radio" class="member" value="1"><xsl:attribute name="name"><xsl:text>rst</xsl:text>
<xsl:value-of select="$resp-suffix"></xsl:value-of></xsl:attribute>
<xsl:attribute name="id"><xsl:text>response__0</xsl:text>
<xsl:value-of select="$resp-suffix"></xsl:value-of></xsl:attribute>
<xsl:if test="$resp-status = 1"><xsl:attribute name="checked"><xsl:text>checked</xsl:text></xsl:attribute></xsl:if></input>
<xsl:text>&#160;</xsl:text>
<label><xsl:attribute name="name"><xsl:text>lbl-response__0</xsl:text>
<xsl:value-of select="$resp-suffix"></xsl:value-of></xsl:attribute>
<xsl:attribute name="for"><xsl:text>response__0</xsl:text>
<xsl:value-of select="$resp-suffix"></xsl:value-of></xsl:attribute>
<xsl:text>是</xsl:text></label>
+
<xsl:choose><xsl:when test="$resp-suffix = &#39;-invite-yourself&#39;"><input type="text" id="xguests-invite-yourself" size="2" name="rgu-invite-yourself" onchange="_wi_vi(this);                 _wi_updateRadio(this.form, &#39;rst-invite-yourself&#39;,                 &#39;1&#39;)"><xsl:attribute name="value"><xsl:value-of select="/eventpage/attendees/attendee                        [principal/@id = $self-principal]/@extra-guests"></xsl:value-of></xsl:attribute></input></xsl:when>
<xsl:otherwise><input type="text" id="xguests" size="2" name="rgu" onchange="_wi_vi(this); _wi_updateRadio(this.form, &#39;rst&#39;,                 &#39;1&#39;)"><xsl:attribute name="value"><xsl:value-of select="/eventpage/attendees/attendee                        [principal/@id = $source-principal]/@extra-guests"></xsl:value-of></xsl:attribute></input></xsl:otherwise></xsl:choose>
<input type="hidden"><xsl:attribute name="name"><xsl:text>old-rgu</xsl:text>
<xsl:value-of select="$resp-suffix"></xsl:value-of></xsl:attribute>
<xsl:choose><xsl:when test="$resp-suffix = &#39;-invite-yourself&#39;"><xsl:attribute name="value"><xsl:value-of select="/eventpage/attendees/attendee                      [principal/@id = $self-principal]/@extra-guests"></xsl:value-of></xsl:attribute></xsl:when>
<xsl:otherwise><xsl:attribute name="value"><xsl:value-of select="/eventpage/attendees/attendee                      [principal/@id = $source-principal]/@extra-guests"></xsl:value-of></xsl:attribute></xsl:otherwise></xsl:choose></input>
邀请对象</div></div>
<div class="data"><div class="group"><input type="radio" class="member" value="3"><xsl:attribute name="name"><xsl:text>rst</xsl:text>
<xsl:value-of select="$resp-suffix"></xsl:value-of></xsl:attribute>
<xsl:attribute name="id"><xsl:text>response__1</xsl:text>
<xsl:value-of select="$resp-suffix"></xsl:value-of></xsl:attribute>
<xsl:if test="$resp-status = 3"><xsl:attribute name="checked"><xsl:text>checked</xsl:text></xsl:attribute></xsl:if></input>
<xsl:text>&#160;</xsl:text>
<label><xsl:attribute name="id"><xsl:text>lbl-response__1</xsl:text>
<xsl:value-of select="$resp-suffix"></xsl:value-of></xsl:attribute>
<xsl:attribute name="for"><xsl:text>response__1</xsl:text>
<xsl:value-of select="$resp-suffix"></xsl:value-of></xsl:attribute>
<xsl:text>也许</xsl:text></label></div></div>
<xsl:if test="$resp-suffix != &#39;-invite-yourself&#39;"><div class="data"><div class="group"><input type="radio" name="rst" id="response__2" class="member" value="2"><xsl:if test="$resp-status = 2"><xsl:attribute name="checked"><xsl:text>checked</xsl:text></xsl:attribute></xsl:if></input>
<xsl:text>&#160;</xsl:text>
<label id="lbl-response__2" for="response__2"><xsl:text>否</xsl:text></label>
<xsl:if test="/eventpage/@simplified = &#39;true&#39; and                     $event-is-spammable and                     $event-is-editable and                     @action != &#39;CREATE&#39; and                     @access-level &gt;= 40"><xsl:text> </xsl:text>
<a onclick="_EF_ReportSpamEvent()" href="javascript:;" id="response-spam"><xsl:text>报告垃圾邮件
                </xsl:text></a></xsl:if></div></div></xsl:if>
<input type="hidden"><xsl:attribute name="name"><xsl:text>old-rst</xsl:text>
<xsl:value-of select="$resp-suffix"></xsl:value-of></xsl:attribute>
<xsl:attribute name="value"><xsl:value-of select="$resp-status"></xsl:value-of></xsl:attribute></input></span></xsl:template>
<xsl:template name="module-revert.main"><xsl:variable name="allow-rejoin" select="@simplified = &#39;true&#39;"></xsl:variable>
<xsl:variable name="can-revert-overrides" select="@has-overrides = &#39;true&#39;              and @access-level &gt;= 40"></xsl:variable>
<xsl:variable name="can-revert-specialization" select="@specialized = &#39;true&#39;              and first-start              and (organizer/principal/@id = source-calendar/principal/@id                   or shared-property[                     @name = &#39;goo.allowModify&#39;]/value = &#39;true&#39;)              and @access-level &gt;= 60"></xsl:variable>
<xsl:if test="$allow-rejoin and @action != &#39;VIEW_ORIGINAL&#39;            and ($can-revert-overrides or $can-revert-specialization)"><div id="revertmsg" class="module"><div class="t1"></div><div class="t2"></div>
<div class="modulebody revertmod"><xsl:choose><xsl:when test="$can-revert-overrides"><xsl:text>您曾经做过一些不会显示给其他邀请对象的更改。</xsl:text></xsl:when>
<xsl:otherwise><xsl:text>此工作日程已更改，不再属于系列工作日程之一。</xsl:text></xsl:otherwise></xsl:choose>
<xsl:text> </xsl:text>
<a><xsl:attribute name="href"><xsl:text>javascript:void(_EF_ShowEventDetails(</xsl:text> <xsl:call-template name="common.js-string"><xsl:with-param name="escapee" select="eid/value"></xsl:with-param></xsl:call-template> <xsl:text>,true,true))</xsl:text></xsl:attribute>
<xsl:choose><xsl:when test="$can-revert-overrides"><xsl:text>恢复原始工作日程详情。</xsl:text></xsl:when>
<xsl:otherwise><xsl:text>撤消更改，并将此工作日程重新纳入到系列工作日程中。</xsl:text></xsl:otherwise></xsl:choose></a></div>
<div class="t2"></div><div class="t1"></div></div></xsl:if></xsl:template>
<xsl:template name="eventpage.standalone"><html><head><title><xsl:choose><xsl:when test="@action != &#39;CREATE&#39;"><xsl:value-of select="summary/html"></xsl:value-of></xsl:when>
<xsl:otherwise><xsl:text>新工作日程</xsl:text></xsl:otherwise></xsl:choose></title>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link type="text/css" rel="stylesheet"><xsl:attribute name="href"><xsl:value-of select="@static-file-prefix"></xsl:value-of>
<xsl:text>standalonecompiled.css</xsl:text></xsl:attribute></link>
<link rel="SHORTCUT ICON" href="/calendar/images/favicon.ico"></link>
<link rel="alternate" media="handheld"><xsl:attribute name="href"><xsl:text>mevent</xsl:text> <xsl:text>?eid=</xsl:text> <xsl:value-of select="eid/value"></xsl:value-of></xsl:attribute></link>
<xsl:element name="script"><xsl:attribute name="type">text/javascript</xsl:attribute> <xsl:text>var init_uid = </xsl:text> <xsl:call-template name="common.js-string"><xsl:with-param name="escapee" select="self/principal/@id"></xsl:with-param></xsl:call-template>; <xsl:text>var init_contactListDispatch = </xsl:text> <xsl:call-template name="standalone.self-contactlist-dispatch"></xsl:call-template>; <xsl:text>var init_prefsDispatch = </xsl:text> <xsl:value-of select="standalone-userprefs/value"></xsl:value-of>;</xsl:element>
<script type="text/javascript"><![CDATA[
window._locale = "zh_CN";
window._ol_serve_ol=false;
]]></script>
<xsl:element name="script"><xsl:attribute name="type">text/javascript</xsl:attribute> <xsl:attribute name="src"><xsl:value-of select="@static-file-prefix"></xsl:value-of> <xsl:text>standalonecompiled__zh_cn.js</xsl:text></xsl:attribute></xsl:element>
<xsl:element name="script"><xsl:attribute name="type">text/javascript</xsl:attribute> <xsl:text>_setStaticFilePrefix(</xsl:text> <xsl:call-template name="common.js-string"><xsl:with-param name="escapee" select="@static-file-prefix"></xsl:with-param></xsl:call-template>); <xsl:text>
function _isIE() {
  return navigator.userAgent.indexOf(&#39;MSIE&#39;) != -1;
}
function _isWebKit() {
  return navigator.userAgent.indexOf(&#39;WebKit&#39;) != -1;
}

function _checkCSS(reload) {
  var ok = true;
  for(var i = 0; i &lt; document.styleSheets.length; ++i) {
    if (!document.styleSheets[i].href) break;
    var sheet = document.styleSheets[i];
    var r = sheet.rules;
    if (r.length == 0 || r[r.length-1].selectorText != &#39;.lastCalRule&#39;) {
      ok = false;
      if (reload) {
        sheet.href += &#39;?rand=&#39; + Math.random();
      }
    }
  }
  return ok;
}

(function(){
  if (_isIE()) {
    if (typeof _lastCalFunc != &#39;function&#39;) {
      var mainjs = document.scripts[1];
      if (mainjs) {
        mainjs.src = mainjs.src + &#39;?rand=&#39; + Math.random();
      }
    }
    _checkCSS(true);
  }
})();</xsl:text></xsl:element>
<script type="text/javascript">
          <![CDATA[
(function(){
  if (_isIE() && (typeof _lastCalFunc != 'function' ||
      !_checkCSS(false))) {
    window.location.href ='#';
  }
})();
]]></script>
<style type="text/css">
body {
  margin:0;
  padding:10px;
}
</style></head>
<body><xsl:attribute name="onload"><xsl:text>_initStandalone([</xsl:text> <xsl:for-each select="/eventpage/features/feature"><xsl:if test="position() &gt; 1"><xsl:text>,</xsl:text></xsl:if> <xsl:choose><xsl:when test="@enabled = &#39;true&#39;"><xsl:text>1</xsl:text></xsl:when> <xsl:otherwise><xsl:text>0</xsl:text></xsl:otherwise></xsl:choose></xsl:for-each> <xsl:text>]);</xsl:text></xsl:attribute> <xsl:attribute name="class"><xsl:text>eventpg
            
              zh_cn
             
              zh
            
          </xsl:text></xsl:attribute>
<div style="display:none" id="event-page-spec"><xsl:apply-templates select="." mode="common.escape-xml"></xsl:apply-templates></div>
<script type="text/javascript"><![CDATA[
var _nav=navigator.userAgent.toLowerCase();
if (_nav.indexOf('msie 6.')!=-1) {document.body.className += ' ie6'};
if (_nav.indexOf('msie 7.')!=-1) {document.body.className += ' ie7'};

var style = '.requiresjs{display:block;}';
if (_isIE() || _isWebKit()) {
  document.writeln('<style type="text/css">' + style + '<\/style>');
} else {
  var styleNode = document.createElement('style');
  styleNode.type = 'text/css';
  styleNode.appendChild(document.createTextNode(style));
  document.body.appendChild(styleNode);
}
]]></script>
<xsl:element name="script"><xsl:attribute name="type">text/javascript</xsl:attribute> <xsl:text>_setUid(init_uid);</xsl:text> <xsl:text>
    _storeEventXml(_$(&#39;event-page-spec&#39;));
    _Dispatch(init_contactListDispatch);
    _Dispatch(init_prefsDispatch);
    </xsl:text></xsl:element>
<div id="nb"><a id="nb-logo" href="render" title="转到 job18 日历"><img src="images/blue_beta_zh-CN.gif" height="34" width="150" style="top: -5px; left: -13px; position: absolute; border: 0px" alt="job18 日历"></img></a>
<xsl:variable name="is-public-principal" select="self/principal/@type = 5"></xsl:variable>
<div id="nb-link"><div id="nb-user"><xsl:if test="not($is-public-principal)"><strong><xsl:value-of select="self/principal/value"></xsl:value-of></strong>
<xsl:if test="not(self/@sign-up-url)"><xsl:text>|</xsl:text>
<xsl:choose><xsl:when test="self/@is-signed-in = &#39;true&#39;"><a href="logout"><xsl:text>退出</xsl:text></a></xsl:when>
<xsl:otherwise><a href="render"><xsl:text>登录</xsl:text></a></xsl:otherwise></xsl:choose></xsl:if></xsl:if></div>
<div id="nb-this"><xsl:choose><xsl:when test="$is-public-principal"><a href="render"><xsl:text>注册 job18 日历</xsl:text></a></xsl:when>
<xsl:when test="self/@sign-up-url"><a><xsl:attribute name="href"><xsl:value-of select="self/@sign-up-url"></xsl:value-of></xsl:attribute>
注册 job18 日历</a></xsl:when>
<xsl:otherwise>&#160;</xsl:otherwise></xsl:choose></div></div></div>
<xsl:if test="self/@gaia-account-email"><div style="height: 2.1ex;" class="nt" id="nt1"><div style="padding-bottom: 4px; padding-top: 4px" align="center"><table cellspacing="0" cellpadding="0"><tr style="height:1px;"><td class="tl"></td>
<td class="nm" rowspan="2" id="nt2"><a href="{self/@transfer-event-url}">添加此工作日程</a>到您的 <xsl:value-of select="self/@gaia-account-email"></xsl:value-of> 日历。</td>
<td class="tr"></td></tr>
<tr style="height:1px;"><td class="bl"></td>
<td class="br"></td></tr></table></div></div></xsl:if>
<xsl:for-each select="messages-to-user/message"><div class="messageToUser"><span><xsl:value-of select="display"></xsl:value-of></span></div></xsl:for-each>
<div id="content"><form action="event" method="POST" onsubmit="return _wi_s(this, false)"><xsl:attribute name="name">masterForm</xsl:attribute>
<xsl:attribute name="id">masterForm</xsl:attribute>
<xsl:call-template name="eventpage.body"></xsl:call-template>
<xsl:if test="count(@event-auth-token) != 0"><input type="hidden" name="tok"><xsl:attribute name="value"><xsl:value-of select="@event-auth-token"></xsl:value-of></xsl:attribute></input></xsl:if>
<xsl:if test="@access-level = 20"><input type="button"><xsl:attribute name="value"><xsl:text>添加到我的日历</xsl:text></xsl:attribute>
<xsl:attribute name="onclick"><xsl:text>window.location = </xsl:text> <xsl:call-template name="common.js-string"><xsl:with-param name="escapee"><xsl:text>event</xsl:text> <xsl:text>?action=TEMPLATE</xsl:text> <xsl:text>&amp;tmeid=</xsl:text> <xsl:value-of select="eid/value"></xsl:value-of> <xsl:text>&amp;tmsrc=</xsl:text> <xsl:value-of select="source-calendar/principal/@id"></xsl:value-of></xsl:with-param></xsl:call-template></xsl:attribute></input></xsl:if>
<xsl:if test="@access-level &gt;= 30"><input type="submit" id="submitButton" value="保存更改"><xsl:attribute name="style"><xsl:if test="@action != &#39;CREATE&#39;                               and count(*[@editing = &#39;true&#39;]) = 0"><xsl:text>display:none</xsl:text></xsl:if></xsl:attribute></input>
<xsl:text>&#160;</xsl:text>
<script type="text/javascript"><![CDATA[
if (window.opener && window.opener !== window) {
  var button = document.createElement('button');
  button.onclick = function () { window.close(); };
  button.appendChild(document.createTextNode(_MSG_CANCEL));
  _$('masterForm').appendChild(button);
}
]]></script></xsl:if></form></div></body></html></xsl:template>
<xsl:template name="standalone.self-contactlist-dispatch"><xsl:text>[&#39;ap&#39;,[</xsl:text>
<xsl:call-template name="common.js-string"><xsl:with-param name="escapee" select="self/principal/@id"></xsl:with-param></xsl:call-template>
<xsl:text>,</xsl:text>
<xsl:value-of select="self/principal/@type"></xsl:value-of>
<xsl:text>,</xsl:text>
<xsl:call-template name="common.js-string"><xsl:with-param name="escapee" select="self/principal/display"></xsl:with-param></xsl:call-template>
<xsl:text>,</xsl:text>
<xsl:call-template name="common.js-string"><xsl:with-param name="escapee" select="self/principal/value"></xsl:with-param></xsl:call-template>
<xsl:text>]]</xsl:text></xsl:template>
<xsl:template match="/eventpage"><xsl:choose><xsl:when test="@simplified = &#39;true&#39;"><xsl:call-template name="eventpage.simplified"></xsl:call-template></xsl:when>
<xsl:otherwise><xsl:call-template name="eventpage.standalone"></xsl:call-template></xsl:otherwise></xsl:choose></xsl:template>
<xsl:template name="eventpage.simplified"><top><xsl:call-template name="module-header-footer.header"></xsl:call-template>
<form method="post" name="masterForm" id="masterForm" onsubmit="return _wi_s(this, false)" action="event"><div class="eventpg"><div id="content"><xsl:call-template name="eventpage.body"></xsl:call-template></div></div></form>
<xsl:call-template name="module-header-footer.footer"></xsl:call-template></top></xsl:template>
<xsl:template name="eventpage.body"><xsl:call-template name="module-hidden.main"></xsl:call-template>
<div class="fevent" id="eventdetails"><div id="details-container"><xsl:call-template name="module-details.main"></xsl:call-template></div></div>
<xsl:choose><xsl:when test="((/eventpage/features/feature[position() - 1 =            14 and @enabled = &#39;true&#39;])             and @simplified = &#39;true&#39;)"><xsl:call-template name="eventpage.new"></xsl:call-template></xsl:when>
<xsl:otherwise><xsl:call-template name="eventpage.old"></xsl:call-template></xsl:otherwise></xsl:choose>
<div class="reset"></div></xsl:template>
<xsl:template name="eventpage.old"><div id="extras"><xsl:call-template name="module-response.main"></xsl:call-template>
<xsl:call-template name="module-attendees.main"></xsl:call-template>
<xsl:if test="@action != &#39;CREATE&#39;"><xsl:call-template name="module-options.main"></xsl:call-template></xsl:if></div>
<xsl:call-template name="module-revert.main"></xsl:call-template>
<xsl:if test="@action = &#39;CREATE&#39;"><xsl:call-template name="module-options.main"></xsl:call-template></xsl:if>
<xsl:if test="not(/eventpage/rrule and not(/eventpage/dates))"><xsl:call-template name="module-comments.main"></xsl:call-template></xsl:if></xsl:template>
<xsl:template name="eventpage.new"><div id="extras"><xsl:call-template name="module-response.main"></xsl:call-template>
<xsl:call-template name="module-options.main"></xsl:call-template></div>
<xsl:call-template name="module-revert.main"></xsl:call-template>
<div class="reset"></div>
<div id="ep-guests"></div></xsl:template></xsl:stylesheet>
