<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xhtml" indent="yes" encoding="utf-8" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
    <xsl:template match="/">
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="skyrimGreensburg.css"/>
                <title>Skyrim</title>
            </head>
            <body>
                <h1>Modal XSLT, &lt;xsl:sort&gt;, and the translate() Function Through Skyrim</h1>
                <ul>
                    <xsl:apply-templates select="//QuestEvent" mode="toc">
                        <!--        We want to sort based on the first letter, regardless of capitalization, and to ignore the apostrophe that throws a wrench in this.            -->
                        <xsl:sort select='translate(upper-case(.), "&apos;", "")'/>
                    </xsl:apply-templates>
                </ul>
                <xsl:apply-templates/>
                <!--       Simply for display purposes so that we can see that the linking jumps directly to each <span> as it should     -->
                <span id="padSpan"/>
            </body>
        </html>
    </xsl:template>
    <!--        Create a table of contents, switching the first letter to upper-case to display use of string manipulation.       -->
    <xsl:template match="QuestEvent" mode="toc">
        <li>
            <!--        Use of attribute value template to create linking from table of contents to spans.    -->
            <a href="#qe{count(preceding::QuestEvent) + 1}">
                <!--        Easiest to see what's going on by working from the inside out with this string. The two functions nested most deeply
                are the two substring() functions. Based on their arguments, we see that the first will spit out only the first character
                in the string, and the second will spit out the remainder. The first substring() is inside an upper-case() function, meaning
                that this first character will be capitalized. These two are then concatenated, and we finally use normalize-space to put it all
                onto one line. -->
                <xsl:value-of
                    select="
                    normalize-space(concat(upper-case(substring(., 1, 1)), substring(., 2)))"
                />
            </a>
        </li>
    </xsl:template>
    <xsl:template match="title">
        <h3>
            <xsl:apply-templates/>
        </h3>
    </xsl:template>
    <xsl:template match="attribution">
        <h4>
            <xsl:apply-templates/>
        </h4>
    </xsl:template>
    <xsl:template match="subtitle">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="paragraph">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="QuestEvent">
        <!--    Use of attribute value template to assign number: same as above, see the count of preceding QuestEvent tags and add 1.    -->
        <span id="qe{count(preceding::QuestEvent) + 1}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
</xsl:stylesheet>
