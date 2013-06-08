#!/bin/bash

# written by Michael Maier (s.8472@aon.at)
# 
# 22.01.2013   - intial release
#

# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# version 2 as published by the Free Software Foundation.

###
### Standard help text
###

if [ ! "$1" ] || [ "$1" = "-h" ] || [ "$1" = " -help" ] || [ "$1" = "--help" ]
then 
cat <<EOH
Usage: $0 [OPTIONS] {filename}

$0 is a program to simplify the description tag in .osm files generated from KML files from data.graz.gv.at

OPTIONS:
   -h -help --help     this help text
   

EOH
fi

###
### variables
###

FILENAME="$1"

###
### working part
###

sed -i 's/&lt;/</g' $FILENAME
sed -i 's/&quot;//g' $FILENAME
sed -i 's/&#xd;&#xd;&#xa;//g' $FILENAME
sed -i 's/&gt;&#13;&#13;&#10;//g' $FILENAME

sed -i 's/<\/html>//g' $FILENAME
sed -i 's/<head>//g' $FILENAME
sed -i 's/<\/head>//g' $FILENAME

sed -i 's/ style=&quot;font-family:Arial,Verdana,Times;font-size:12px;text-align:left;width:100%;border-collapse:collapse;padding:3px 3px 3px 3px&quot;//g' $FILENAME
sed -i 's/ style=font-family:Arial,Verdana,Times;font-size:12px;text-align:left;width:100%;border-spacing:0px; padding:3px 3px 3px 3px//g' $FILENAME
sed -i 's/ style=&quot;text-align:center;font-weight:bold;background:#9CBCE2&quot;//g' $FILENAME
sed -i 's/ style=&quot;font-family:Arial,Verdana,Times;font-size:12px;text-align:left;width:100%;border-spacing:0px; padding:3px 3px 3px 3px&quot;//g' $FILENAME
sed -i 's/ bgcolor=&quot;#D4E4F3&quot;//g' $FILENAME
sed -i 's/&amp;lt;Null&amp;gt;//g' $FILENAME

#sed -i 's///g' $FILENAME

# "header"
sed -i 's/<html xmlns:fo=http:\/\/www.w3.org\/1999\/XSL\/Format xmlns:msxsl=urn:schemas-microsoft-com:xslt<head<META http-equiv=Content-Type content=text\/html<meta http-equiv=content-type content=text\/html; charset=UTF-8<\/head<body style=margin:0px 0px 0px 0px;overflow:auto;background:#FFFFFF;<table style=font-family:Arial,Verdana,Times;font-size:12px;text-align:left;width:100%;border-collapse:collapse;padding:3px 3px 3px 3px<tr style=text-align:center;font-weight:bold;background:#9CBCE2//g' $FILENAME
# "footer"
sed -i 's/<\/td<\/tr<\/table<\/td<\/tr<\/table<\/body<\/html//g' $FILENAME
#sed -i 's/<a target=&quot;_blank&quot; href=&quot;http:\/\/www.holding-graz.at\/abfallwirtschaft\/kundinnenservice.html&quot;>http:\/\/www.holding-graz.at\/abfallwirtschaft\/kundinnenservice.html<\/a><\/td><\/tr><\/table><\/td><\/tr><\/table>//g' $FILENAME


# description -> hg:desc
sed -i 's/description" v="<td&gt;/hg:description" v="/g' $FILENAME

#here follows description text

# SAMMELSTELLENNAME -> hg:name
sed -i 's/<\/td<\/tr<tr<td<table<tr<td&gt;SAMMELSTELLENNAME<\/td<td&gt;/"\/>\
    <tag k="hg:name" v="/g' $FILENAME

#here follows SAMMELSTELLENNAME text
echo NAME ok

# STRASSENNAME -> hg:street
sed -i 's/<\/td<\/tr<tr bgcolor=#D4E4F3<td&gt;STRASSENNAME<\/td<td&gt;/"\/>\
    <tag k="hg:street" v="/g' $FILENAME

#here follows STRASSENNAME text
echo STR ok

# HAUSNUMMER -> hg:housenumber
sed -i 's/<\/td<\/tr<tr<td&gt;HAUSNUMMER<\/td<td&gt;/"\/>\
    <tag k="hg:housenumber" v="/g' $FILENAME

#here follows HAUSNUMMER
echo HNR ok

#BEZIRKS_NR -> delete
sed -i 's/<\/td<\/tr<tr bgcolor=#D4E4F3<td&gt;BEZIRKS_NR<\/td<td&gt;[0-9]*<\/td<\/tr<tr<td&gt;/"\/>\
/g' $FILENAME

echo BNR ok

#BEZIRKSNAME -> delete
sed -i 's/BEZIRKSNAME<\/td<td&gt;[a-zA-Zßö.[:space:]]*<\/td<\/tr<tr bgcolor=#D4E4F3<td&gt;//g' $FILENAME

echo BNAME ok

# LAGE -> hg:position
sed -i 's/LAGE<\/td<td&gt;/    <tag k="hg:position" v="/g' $FILENAME

#here follows text lage
echo LAGE ok

#RM LINK
sed -i 's/<\/td<\/tr<tr<td&gt;LINK<\/td<td&gt;<a target=_blank href=http:\/\/www.oekostadt.graz.at\/cms\/ziel\/1343895\/DE\/&gt;http:\/\/www.oekostadt.graz.at\/cms\/ziel\/1343895\/DE\/<\/a&gt;<\/td<\/tr<tr bgcolor=#D4E4F3<td&gt;GS_P_INT<\/td<td&gt;[01]<\/td<\/tr<tr<td&gt;//g' $FILENAME

#Papier ja/nein
sed -i 's/Papier<\/td<td&gt;/"\/>\
    <tag k="recycling:paper" v="/g' $FILENAME

#Glas ja/nein
sed -i 's/<\/td<\/tr<tr bgcolor=#D4E4F3<td&gt;GS_GV_INT<\/td<td&gt;[01]<\/td<\/tr<tr<td&gt;Glas<\/td<td&gt;/"\/>\
    <tag k="recycling:glass_bottles" v="/g' $FILENAME

#Altkleider ja/nein
sed -i 's/<\/td<\/tr<tr bgcolor=#D4E4F3<td&gt;GS_AK_INT<\/td<td&gt;[01]<\/td<\/tr<tr<td&gt;Altkleider<\/td<td&gt;/"\/>\
    <tag k="recycling:clothes" v="/g' $FILENAME



#sed -i 's///g' $FILENAME
