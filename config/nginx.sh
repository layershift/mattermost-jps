#!/bin/bash

SED=`which sed`
WGET=`which wget`

$WGET -q -O /root/nginx-mattermost http://jps.layershift.com/mattermost/nginx-mattermost
$WGET -q -O /root/nginxgzip http://jps.layershift.com/mattermost/nginxgzip
$WGET -q -O /root/nginxcaching http://jps.layershift.com/mattermost/nginxcaching

$SED -i "59r /root/nginx-mattermost" /etc/nginx/nginx.conf
$SED -i "35r /root/nginxgzip" /etc/nginx/nginx.conf
$SED -i "63r /root/nginxcaching" /etc/nginx/nginx.conf
$SED -i "26r /root/nginx-mattermost" /etc/nginx/conf.d/ssl.conf.disabled
$SED -i "7d" /etc/php-fpm.conf

