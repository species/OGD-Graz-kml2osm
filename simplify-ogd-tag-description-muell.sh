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
sed -i 's/&#xd;&#xd;&#xa;//g' $FILENAME

sed -i 's/<\/html>//g' $FILENAME
sed -i 's/<head>//g' $FILENAME
sed -i 's/<\/head>//g' $FILENAME

sed -i 's/ style=&quot;font-family:Arial,Verdana,Times;font-size:12px;text-align:left;width:100%;border-collapse:collapse;padding:3px 3px 3px 3px&quot;//g' $FILENAME
sed -i 's/ style=&quot;text-align:center;font-weight:bold;background:#9CBCE2&quot;//g' $FILENAME
sed -i 's/ style=&quot;font-family:Arial,Verdana,Times;font-size:12px;text-align:left;width:100%;border-spacing:0px; padding:3px 3px 3px 3px&quot;//g' $FILENAME
sed -i 's/ bgcolor=&quot;#D4E4F3&quot;//g' $FILENAME
sed -i 's/&amp;lt;Null&amp;gt;//g' $FILENAME

#sed -i 's///g' $FILENAME

# "header"
sed -i 's/<html xmlns:fo=&quot;http:\/\/www.w3.org\/1999\/XSL\/Format&quot; xmlns:msxsl=&quot;urn:schemas-microsoft-com:xslt&quot;><META http-equiv=&quot;Content-Type&quot; content=&quot;text\/html&quot;><meta http-equiv=&quot;content-type&quot; content=&quot;text\/html; charset=UTF-8&quot;><body style=&quot;margin:0px 0px 0px 0px;overflow:auto;background:#FFFFFF;&quot;>//g' $FILENAME
# "footer"
sed -i 's/<a target=&quot;_blank&quot; href=&quot;http:\/\/www.holding-graz.at\/abfallwirtschaft\/kundinnenservice.html&quot;>http:\/\/www.holding-graz.at\/abfallwirtschaft\/kundinnenservice.html<\/a><\/td><\/tr><\/table><\/td><\/tr><\/table>//g' $FILENAME


# description -> hgl:desc
sed -i 's/description" v="<table><tr><td>/hgl:description" v="/g' $FILENAME

#here follows description text

# SAMMELSTELLENART -> recycling:material
sed -i 's/<\/td><\/tr><tr><td><table><tr><td>SAMMELSTELLENART<\/td><td>/"\/>\
    <tag k="recycling:material" v="/g' $FILENAME

#here follows SAMMELSTELLENART text

# SAMMELSTELLENNAME -> hgl:name
sed -i 's/<\/td><\/tr><tr><td>SAMMELSTELLENNAME<\/td><td>/"\/>\
    <tag k="hgl:name" v="/g' $FILENAME

#here follows SAMMELSTELLENNAME text

# STRASSENNAME -> hgl:street
sed -i 's/<\/td><\/tr><tr><td>STRASSENNAME<\/td><td>/"\/>\
    <tag k="hgl:street" v="/g' $FILENAME

#here follows STRASSENNAME text

# HAUSNUMMER -> hgl:housenumber
sed -i 's/<\/td><\/tr><tr><td>HAUSNUMMER<\/td><td>/"\/>\
    <tag k="hgl:housenumber" v="/g' $FILENAME

#here follows HAUSNUMMER

#BEZIRKS_NR -> delete
echo HNR ok
sed -i 's/<\/td><\/tr><tr><td>BEZIRKS_NR<\/td><td>[0-9]*<\/td><\/tr>/"\/>\
/g' $FILENAME

echo BNR ok
sed -i 's/<tr><td>BEZIRKSNAME<\/td><td>[a-zA-Zßö.]*<\/td><\/tr>//g' $FILENAME

echo BNAME ok
# LAGE -> hgl:position
sed -i 's/<tr><td>LAGE<\/td><td>/    <tag k="hgl:position" v="/g' $FILENAME

# LINK -> contact:url
#set source="data.graz.gv.at"
#set operator="Holding Graz"
#set recycling_type=container
sed -i 's/<\/td><\/tr><tr><td>LINK<\/td><td><\/body>/"\/>\
    <tag k="source" v="data.graz.gv.at"\/>\
    <tag k="operator" v="Holding Graz"\/>\
    <tag k="recycling_type" v="container/g' $FILENAME



#sed -i 's///g' $FILENAME
