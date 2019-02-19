#!/bin/bash

# We crawl the sitemap and fetch all URLs

DOMAIN='https://www.yourdomain.com'
echo ---- Start reading from $DOMAIN ----
wget -q $DOMAIN/sitemap.xml --no-cache -O - | egrep -o "$DOMAIN[^<]+" | while read subsite;
do
	echo --- Reading Sub Sitemap: $subsite: ---
	wget -q $subsite --no-cache -O - | egrep -o "$DOMAIN[^<]+" | while read line;
	do
		echo $line:
	  # time curl -A 'Cache Warmer' -s -L $line > /dev/null 2>&1
		time curl -o /dev/null -s -w "%{http_code}" $line 2>&1
	done
	echo --- FINISHED reading sub-sitemap: $subsite: ---
done
