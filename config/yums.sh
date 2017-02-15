#!/bin/bash

SED=`which sed`
YUM=`which yum`
WGET=`which wget`
CHMOD=`which chmod`
CHOWN=`which chown`
CHKCON=`which chkconfig`

if [ -f /etc/yum.repos.d/mod-pagespeed.repo ]; then sed "s/enabled=1/enabled=0/g"; fi

$SED -i "s/DBCONNECTION/$1:$2@$3:5432\/$4/g" /var/www/webroot/ROOT/config/config.json 2>&1
$YUM install -q -y python-setuptools 2>&1
easy_install -q supervisor 2>&1
$WGET -q -O /etc/init.d/supervisord http://jps.layershift.com/mattermost/init 2>&1
$CHMOD +x /etc/init.d/supervisord 2>&1
$CHKCON supervisord on 2>&1
$CHKCON php-fpm off 2>&1

if `grep -q "7.1" /etc/redhat-release`; then systemctl start supervisrod --quiet; else service supervisord start; fi
if `grep -q "7.1" /etc/redhat-release`; then systemctl stop php-fpm --quiet; else service php-fpm stop; fi

