<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<html> 
 <head>
    <title> BigBlueButton | Meeting Stats</title>
    <meta http-equiv="refresh" content="30" ></meta>
    <link rel="icon" type="image/x-icon" href="./favicon.ico"/>
  </head>
<body>
   <div style="position: relative; text-align: center">
     <img src="./logo.png" alt="Company Logo" height="88" width="" border="0"/>
    <p></p>
  <br></br>
    <p></p>
  <br></br>
    <p></p>
  <br></br>
  <table style="border:0; width: auto;margin-left:auto;margin-right:auto;">
    <tr bgcolor="#e4000e">
      <th style="padding: 5px;text-align:center;font-size:20px;color:#fff;">Raum</th>
      <th style="padding: 5px;text-align:center;font-size:20px;color:#fff;">Teilnehmer</th>
      <th style="padding: 5px;text-align:center;font-size:20px;color:#fff;">Moderator</th>
      <th style="padding: 5px;text-align:center;font-size:20px;color:#fff;">Gäste</th>
    </tr>
    <xsl:for-each select="meetings/meeting">
    <tr>
      <td style="padding: 5px"><xsl:value-of select="meetingName"/></td>
      <td style="padding: 5px; text-align:center"><xsl:value-of select="participantCount"/></td>
 <td style="padding: 5px; text-align:center"><xsl:for-each select="attendees/attendee[role='MODERATOR']"><xsl:value-of select="fullName"/></xsl:for-each></td>
 <td style="padding: 5px; text-align:center"><xsl:for-each select="attendees/attendee[role!='MODERATOR']"><xsl:value-of select="fullName"/><xsl:if test="not(position()=last())"><xsl:text>, </xsl:text></xsl:if></xsl:for-each></td>
    </tr>
    </xsl:for-each>
    <tr bgcolor="#e4000e">
      <td/>
      <td style="padding: 5px;text-align:center;font-size:20px;color:#fff"><b><xsl:value-of select="sum(meetings/meeting/participantCount)"/></b></td>
      <td/>
      <td/>
    </tr>
  </table>
 <p style="position: fixed; bottom: 0; width:100%;font-size:11px; font-family: Arial; color:#999;"> h t t p s : / / g i t h u b . c o m / k o r o v a m i l k / b b b - s t a t s </p>
   </div>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
