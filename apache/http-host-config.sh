#  module:  http-host-config.sh         cygwin httpd configurator
#  project: manufacture cygwin          cygwin.manufacture.net      
#  author:  Francis Korning             <fkorning@yahoo.ca>
#  rights:  (c) 2014 Francis Korning    manufacture.net
#  license: GNU LGPL license            https://www.gnu.org/licenses/lgpl.html


# NOTE: do not forget to set the password for the administrator!
# NOTE: do not forget to set the password for user cyg_server!


# we use this script instead of httpd2-config because we want
# httpd, like all our other daemons to run as the cyg_server
# privileged authenticated user instead of SYSTEM or daemon.


echo configuring Apache httpd
user=cyg_server
group=SYSTEM
PWD=`pwd`
DIR=`dirname $0`
pushd $DIR


echo stopping apache httpd service
cygrunsrv --stop httpd || echo httpd not running
cygrunsrv --stop httpd2 || echo httpd2 not running
cygrunsrv --stop apache || echo apache not running
cygrunsrv --stop apache2 || echo apache2 not running


echo killing all httpd service instances
if [ -f "/var/run/httpd/httpd2.pid" ] ; then
    PID=`cat /var/run/httpd/httpd2.pid`
    if [ "${PID}" != "" ] ; then
        PIDS=`ps -ef | grep " ${PID} " | grep http | awk '{print $2} | xargs`
        kill -9 ${PIDS}
    fi
fi


echo remmoving apache httpd service
cygrunsrv --remove httpd || echo httpd not installed
cygrunsrv --remove httpd2 || echo httpd2 not installed
cygrunsrv --remove apache || echo apache not installed
cygrunsrv --remove apache2 || echo apache2 not installed


echo removing httpd logs
rm -rf /var/log/http*
rm -rf /var/log/apache*
rm -rf /var/run/http*
rm -rf /var/log/apache*


echo configuring apache dirs
mkdir -p /usr/lib/apache2
mkdir -p /usr/local/httpd/bin
mkdir -p /var/log/httpd
mkdir -p /var/run/httpd


echo configuring apache links
[ -L /etc/apache2 ]   || ln -s /etc/httpd  /etc/apache2
[ -L /var/log/apache2 ]   || ln -s /var/log/httpd  /var/log/apache2
[ -L /var/run/apache2 ]   || ln -s /var/run/httpd  /var/run/apache2

if [ !  -d /usr/local/apache2 ] ; then
  [ -L /usr/local/apache2 ]   || ln -s /usr/local/httpd /usr/local/apache2
  [ -L /usr/local/apache2/bin/apachectl ]   || ln -s /usr/sbin/apachectl /usr/local/apache2/bin/
  [ -L /usr/local/apache2/bin/httpd ]   || ln -s /usr/sbin/httpd  /usr/local/apache2/bin/
  [ -L /usr/local/apache2/etc ]   || ln -s /etc/apache2  /usr/local/apache2/etc
  [ -L /usr/local/apache2/modules ]   || ln -s /usr/lib/httpd/modules  /usr/local/apache2/modules
fi


echo configuring apache modules
if [ !  -d /usr/lib/apache2 ] ; then
  mkdir -p /usr/lib/apache2
  ln -s /usr/lib/httpd/modules/* /usr/lib/apache2/
fi


echo instaling and configuring apache httpd
#/usr/sbin/httpd2-config


echo configuring apache httpd server
cp /etc/apache2/conf/httpd.conf /etc/apache2/conf/httpd.conf.0  
cp httpd.conf /etc/apache2/conf/httpd.conf  


echo configuring default server root
mkdir -p /srv/www/htdocs
cp favicon.ico /srv/www/htdocs/
cp phpinfo.php /srv/www/htdocs/
cp robots.txt /srv/www/htdocs/

echo configuring additional servers
cp conf.d/* /etc/httpd/conf.d


echo configuring apache permissions 
chown -R ${user}:${group} /srv/www
chown -R ${user}:${group} /var/run/httpd
chown -R ${user}:${group} /var/log/httpd
chown -R ${user}:${group} /usr/local/httpd
chown -R ${user}:${group} /usr/lib/apache2


echo configuring apache init scripts
chmod a+x httpd
cp httpd /etc/rc.d/init.d/
/etc/rc.d/init.d/httpd install


echo configured apache httpd
popd

