﻿<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  >
  <xsl:output method="xml" version="1.0" encoding="utf-8" indent="yes"/>
  <xsl:variable name="file2" select="document('D:\develop\vsworkspace\WebFormCases\MyWebFormCases\xml\sampleDoc.xml')" />
  <xsl:template match="comment()"/>
  <!-- Entry point into transform: file loading and processing occurs here -->
  <xsl:template  match="/">
    <xsl:variable name="IDs2" select="$file2/." />
        <xsl:variable name="output">
          <xsl:call-template name="splitter">
          <xsl:with-param name="tree" select="*"/>
          <xsl:with-param name="comparer" select="$IDs2/*"></xsl:with-param>
          <xsl:with-param name="comparer-original" select="$IDs2/*"></xsl:with-param>
        </xsl:call-template>
        </xsl:variable>
    <root>
        <xsl:copy-of select="msxsl:node-set($output)"/>
    </root>
  </xsl:template>
  <!-- Main recursive looping algorithm through nodes or leaves in current branch -->
  <xsl:template name="splitter" >
    <xsl:param name="comparer"/>
    <xsl:param name="tree"/>
    <xsl:param name="tree2"/>
    <xsl:param name="tree3"/>
    <xsl:param name="comparer-original"/>
    <compare-result>
      <xsl:variable name="current-comparison">
        <xsl:call-template name="match-node">
          <xsl:with-param name="node1" select="msxsl:node-set($tree)[1]"></xsl:with-param>
          <xsl:with-param name="node2" select="msxsl:node-set($comparer)[1]"></xsl:with-param>
        </xsl:call-template>
      </xsl:variable>
      <xsl:if test="msxsl:node-set($current-comparison)/match">
        <xsl:if test="msxsl:node-set($tree)[1]/*">
          <xsl:variable name="recurse-result-children">
            <xsl:call-template name="splitter">
              <xsl:with-param name="comparer" select="$comparer[1]/*"/>
              <xsl:with-param name="tree" select="$tree[1]/*"/>
              <xsl:with-param name="comparer-original" select="msxsl:node-set($comparer)[1]/*"/>
            </xsl:call-template>
          </xsl:variable>
          <!-- record mismatch -->
          <xsl:if test="not(msxsl:node-set($current-comparison)//match)">
            <xsl:copy-of select="msxsl:node-set($current-comparison)/node()"/>
          </xsl:if>
          <!-- append child mismatch found from child recursions -->
          <xsl:copy-of select="msxsl:node-set($recurse-result-children)/compare-result//mismatch"/>
        </xsl:if>
      </xsl:if>
      <!-- loop to next node comparison -->
      <xsl:if test="msxsl:node-set($current-comparison)//match and msxsl:node-set($tree)[1]/following-sibling::*">
          <xsl:variable name="removeMatch">
          <xsl:call-template name="excludeNodeFromTree">
              <xsl:with-param name="node" select="msxsl:node-set($tree[1])"></xsl:with-param>
              <xsl:with-param name="branch-layer" select="msxsl:node-set($comparer-original)"/>
          </xsl:call-template>
          </xsl:variable>
          <!-- recurse to next node in branch with excluding nodes that were matched -->
        <xsl:variable name="oCount" select="count(msxsl:node-set($tree[1])/following-sibling::*)"></xsl:variable>
        <xsl:variable name="Range1">
          <xsl:call-template name="Range">
            <xsl:with-param name="Array" select="msxsl:node-set($tree[1])/following-sibling::*"/>
            <xsl:with-param name="StartIndex" select="0"/>
            <xsl:with-param name="EndIndex" select="$oCount div 3"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="Range2">
          <xsl:call-template name="Range">
            <xsl:with-param name="Array" select="msxsl:node-set($tree[1])/following-sibling::*"/>
            <xsl:with-param name="StartIndex" select="$oCount div 3"/>
            <xsl:with-param name="EndIndex" select="$oCount * 2 div 3"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="Range3">
          <xsl:call-template name="Range">
            <xsl:with-param name="Array" select="msxsl:node-set($tree[1])/following-sibling::*"/>
            <xsl:with-param name="StartIndex" select="$oCount * 2 div 3"/>
            <xsl:with-param name="EndIndex" select="$oCount"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:if test="not($oCount > 6)">
          <xsl:call-template name="splitter">
            <xsl:with-param name="tree" select="msxsl:node-set($tree[1])/following-sibling::*"></xsl:with-param>
            <xsl:with-param name="comparer" select="msxsl:node-set($removeMatch)/sub-tree/*"></xsl:with-param>
            <xsl:with-param name="comparer-original" select="msxsl:node-set($removeMatch)/sub-tree/*"/>
          </xsl:call-template>
        </xsl:if>
        <xsl:if test="$oCount > 6">
          <xsl:call-template name="splitter">
            <xsl:with-param name="tree" select="msxsl:node-set($Range1)/root/*"></xsl:with-param>
            <xsl:with-param name="comparer" select="msxsl:node-set($removeMatch)/sub-tree/*"></xsl:with-param>
            <xsl:with-param name="comparer-original" select="msxsl:node-set($removeMatch)/sub-tree/*"/>
          </xsl:call-template>
          <xsl:call-template name="splitter">
            <xsl:with-param name="tree" select="msxsl:node-set($Range2)/root/*"></xsl:with-param>
            <xsl:with-param name="comparer" select="msxsl:node-set($removeMatch)/sub-tree/*"></xsl:with-param>
            <xsl:with-param name="comparer-original" select="msxsl:node-set($removeMatch)/sub-tree/*"/>
          </xsl:call-template>
          <xsl:call-template name="splitter">
            <xsl:with-param name="tree" select="msxsl:node-set($Range3)/root/*"></xsl:with-param>
            <xsl:with-param name="comparer" select="msxsl:node-set($removeMatch)/sub-tree/*"></xsl:with-param>
            <xsl:with-param name="comparer-original" select="msxsl:node-set($removeMatch)/sub-tree/*"/>
          </xsl:call-template>
        </xsl:if>
        <match>
          <xsl:copy-of select="$tree[1]"></xsl:copy-of>
        </match>
      </xsl:if>
      <xsl:if test="not(msxsl:node-set($current-comparison)//match) and msxsl:node-set($comparer)[1]/following-sibling::*">
        <!-- recurse to next node in branch -->
        <xsl:call-template name="splitter">
          <xsl:with-param name="tree" select="$tree"></xsl:with-param>
          <xsl:with-param name="comparer" select="msxsl:node-set($comparer)[1]/following-sibling::*"></xsl:with-param>
          <xsl:with-param name="comparer-original" select="msxsl:node-set($comparer-original)"/>
        </xsl:call-template>
      </xsl:if>
      <xsl:if test="not(msxsl:node-set($comparer)[1]/following-sibling::*) and not(msxsl:node-set($current-comparison)//match)">
        <!-- mismatched nodes in current branch are detected as orphaned here -->
        <orphan>
          <mismatch>
            <xsl:copy-of select="msxsl:node-set($tree[1])"></xsl:copy-of>
          </mismatch>
        </orphan>
        <xsl:variable name="oCount" select="count(msxsl:node-set($tree[1])/following-sibling::*)"></xsl:variable>
        <xsl:variable name="Range1">
          <xsl:call-template name="Range">
            <xsl:with-param name="Array" select="msxsl:node-set($tree[1])/following-sibling::*"/>
            <xsl:with-param name="StartIndex" select="0"/>
            <xsl:with-param name="EndIndex" select="$oCount div 3"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="Range2">
          <xsl:call-template name="Range">
            <xsl:with-param name="Array" select="msxsl:node-set($tree[1])/following-sibling::*"/>
            <xsl:with-param name="StartIndex" select="$oCount div 3"/>
            <xsl:with-param name="EndIndex" select="$oCount * 2 div 3"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="Range3">
          <xsl:call-template name="Range">
            <xsl:with-param name="Array" select="msxsl:node-set($tree[1])/following-sibling::*"/>
            <xsl:with-param name="StartIndex" select="$oCount * 2 div 3"/>
            <xsl:with-param name="EndIndex" select="$oCount"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:if test="msxsl:node-set($tree[1])/following-sibling::*">
          <xsl:if test="not($oCount > 6)">
            <xsl:call-template name="splitter">
              <xsl:with-param name="tree" select="msxsl:node-set($tree[1])/following-sibling::*"></xsl:with-param>
              <xsl:with-param name="comparer" select="msxsl:node-set($comparer-original)"></xsl:with-param>
              <xsl:with-param name="comparer-original" select="msxsl:node-set($comparer-original)"/>
            </xsl:call-template>
          </xsl:if>
          <xsl:if test="$oCount > 6">
            <xsl:call-template name="splitter">
              <xsl:with-param name="tree" select="msxsl:node-set($Range1)/root/*"></xsl:with-param>
              <xsl:with-param name="comparer" select="msxsl:node-set($comparer-original)"></xsl:with-param>
              <xsl:with-param name="comparer-original" select="msxsl:node-set($comparer-original)"/>
            </xsl:call-template>
            <xsl:call-template name="splitter">
              <xsl:with-param name="tree" select="msxsl:node-set($Range2)/root/*"></xsl:with-param>
              <xsl:with-param name="comparer" select="msxsl:node-set($comparer-original)"></xsl:with-param>
              <xsl:with-param name="comparer-original" select="msxsl:node-set($comparer-original)"/>
            </xsl:call-template>
            <xsl:call-template name="splitter">
              <xsl:with-param name="tree" select="msxsl:node-set($Range3)/root/*"></xsl:with-param>
              <xsl:with-param name="comparer" select="msxsl:node-set($comparer-original)"></xsl:with-param>
              <xsl:with-param name="comparer-original" select="msxsl:node-set($comparer-original)"/>
            </xsl:call-template>
          </xsl:if>
        </xsl:if>
      </xsl:if>
    </compare-result>
  </xsl:template>
  <xsl:template name="Range">
    <xsl:param name="Array" />
    <xsl:param name="StartIndex"/>
    <xsl:param name="EndIndex"/>
    <root>
      <xsl:copy-of select="$Array[position() > $StartIndex and not(position() > $EndIndex)]" />
    </root>
  </xsl:template>
  <!-- sub function for matching single nodes -->
  <xsl:template name="match-node">
    <xsl:param name="node1"></xsl:param>
    <xsl:param name="node2"></xsl:param>
    <xsl:if test="name($node1) = name($node2)">
        <xsl:variable name="attribute-mismatch">
          <xsl:call-template name="attribute-value-mismatch">
            <xsl:with-param name="attributes1" select="$node1/@*"></xsl:with-param>
            <xsl:with-param name="attributes2" select="$node2/@*"></xsl:with-param>
          </xsl:call-template>
        </xsl:variable>
        <xsl:if test="count(msxsl:node-set($attribute-mismatch)//attribute) = 0">
          <xsl:if test="(not(msxsl:node-set(translate(normalize-space($node1/text()),'&#xa;', ''))) and not(msxsl:node-set(translate(normalize-space($node2/text()),'&#xa;', '')))) or (translate(normalize-space($node1/text()),'&#xa;', '') = translate(normalize-space($node2/text()),'&#xa;', ''))">
            <match>
              <xsl:copy-of select="$node1 | @*"></xsl:copy-of>
            </match>                        
          </xsl:if>
          <xsl:if test="not(not(msxsl:node-set(translate(normalize-space($node1/text()),'&#xa;', ''))) and not(msxsl:node-set(translate(normalize-space($node2/text()),'&#xa;', '')))) or (translate(normalize-space($node1/text()),'&#xa;', '') = translate(normalize-space($node2/text()),'&#xa;', ''))">
            <mismatch>
              <xsl:copy-of select="$node1 | @*"></xsl:copy-of>
            </mismatch>
          </xsl:if>
        </xsl:if>
        <xsl:if test="count(msxsl:node-set($attribute-mismatch)//attribute) > 0">
          <mismatch>
            <xsl:copy-of select="$node1 | @*"></xsl:copy-of>
          </mismatch>
        </xsl:if>
    </xsl:if>
    <xsl:if test="name($node1) != name($node2)">
      <mismatch>
        <xsl:copy-of select="$node1 | @*"></xsl:copy-of>
      </mismatch>      
    </xsl:if>
  </xsl:template>
  <!-- sub function for matching attributes in two nodes - outputs an attribute node only when an attibute mismatches -->
  <xsl:template name="attribute-value-mismatch">
    <xsl:param name="attributes1" />
    <xsl:param name="attributes2" />
    <attribute-match>
      <xsl:if test="(count($attributes1) != count($attributes2))">
        <attribute />
      </xsl:if>
      <xsl:if test="(count($attributes1) = count($attributes2))">
        <xsl:for-each select="$attributes1">
          <xsl:variable name="attribute1" select="."/>
          <xsl:variable name="result">
            <attroot>
              <xsl:for-each select="$attributes2">
                <xsl:if test="name(.) = name($attribute1/.)">
                  <xsl:if test="not(. = $attribute1/.)">
                    <not-matched-name/>
                  </xsl:if>
                </xsl:if>
                <xsl:if test="name(.) != name($attribute1/.)">
                  <not-matched-name/>
                </xsl:if>
              </xsl:for-each>
            </attroot>
          </xsl:variable>
          <xsl:if test="count(msxsl:node-set($result)//not-matched-name) = count(msxsl:node-set($attributes2))">
            <attribute />
          </xsl:if>
        </xsl:for-each>
      </xsl:if>
    </attribute-match>
  </xsl:template>
  <!-- sub function: exclude node from branch -->
  <xsl:template name="excludeNodeFromTree">
    <xsl:param name="branch-layer"></xsl:param>
    <xsl:param name="node"></xsl:param>
    <xsl:if test="name(msxsl:node-set($branch-layer)[1]) = name($node)">
      <xsl:variable name="attribute-value-mismatch-count-exclude">
        <xsl:call-template name="attribute-value-mismatch">
          <xsl:with-param name="attributes1" select="$branch-layer[1]/@*"/>
          <xsl:with-param name="attributes2" select="$node/@*"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:if test="count(msxsl:node-set($attribute-value-mismatch-count-exclude)/attribute-match/attribute) = 0">
        <sub-tree>
          <xsl:for-each select="msxsl:node-set($branch-layer[1])/preceding-sibling::*">
            <xsl:copy-of select="."/>
          </xsl:for-each>
          <xsl:for-each select="msxsl:node-set($branch-layer[1])/following-sibling::*">
            <xsl:copy-of select="."/>
          </xsl:for-each>
        </sub-tree>
      </xsl:if>
      <xsl:if test="count(msxsl:node-set($attribute-value-mismatch-count-exclude)/attribute-match/attribute) > 0">
        <xsl:call-template name="excludeNodeFromTree">
          <xsl:with-param name="branch-layer" select="$branch-layer[1]/following-sibling::*"></xsl:with-param>
          <xsl:with-param name="node" select="$node"></xsl:with-param>
        </xsl:call-template>
      </xsl:if>
    </xsl:if>
    <xsl:if test="name($branch-layer[1]) != name($node) and msxsl:node-set($branch-layer)[1]/following-sibling::*">
      <xsl:call-template name="excludeNodeFromTree">
        <xsl:with-param name="branch-layer" select="$branch-layer[1]/following-sibling::*"/>
        <xsl:with-param name="node" select="$node"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="not(msxsl:node-set($branch-layer)[1]/following-sibling::*)">
      <sub-tree>
      </sub-tree>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>