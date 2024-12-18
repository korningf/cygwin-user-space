#  module:  mysql-host-config.sh        cygwin mysqld configurator
#  project: manufacture cygwin          cygwin.manufacture.net      
#  author:  Francis Korning             <fkorning@yahoo.ca>
#  rights:  (c) 2014 Francis Korning    manufacture.net
#  license: GNU LGPL license            https://www.gnu.org/licenses/lgpl.html


# NOTE: do not forget to set the password for the administrator!
# NOTE: do not forget to set the password for user cyg_server!
# NOTE: do not forget to set the password for mysql root user!


# we use this script instead of mysql_install_db because we want
# mysqld, like all our other daemons to run as the cyg_server
# privileged authenticated user instead of SYSTEM or daemon.


echo configuring mysqld
PWD=`pwd`
DIR=`dirname $0`
pushd $DIR


echo stopping mysqld service
cygrunsrv --stop mysqld || echo "mysqld not running"


echo remmoving mysqld mysqld service
cygrunsrv --remove mysqld || echo "mysql not installed"

echo removing mysqld logs
rm -f /var/log/mysqld*.log
rm -f /var/log/mysqld*.log


echo removing old installation
rm -fr /var/lib/mysql/*


echo configuring mysql dirs
mkdir -p /var/lib/mysql
mkdir -p /var/log/mysql
mkdir -p /var/run/mysql
mkdir -p /usr/local/mysql/bin


echo configuring mysqld links
[ -L /usr/local/mysql/bin/mysqladmin ]   || ln -s /usr/bin/mysqladmin  /usr/local/mysql/bin/
[ -L /usr/local/mysql/bin/mysqld ]  || ln -s /usr/sbin/mysqld  /usr/local/mysql/bin/
[ -L /usr/local/mysql/bin/mysql ]  || ln -s /usr/bin/mysql  /usr/local/mysql/bin/


echo configuring permissions
chown -R mysqld:daemon /var/lib/mysql
chown -R mysqld:daemon /var/run/mysql
chown -R mysqld:daemon /var/log/mysql
chown -R mysqld:daemon /usr/local/mysql


# install as regular user
echo installing default mysqld database
/usr/bin/mysql_install_db --no-defaults --user mysqld

# run mysqld safe 
echo run mysqld safe 
/usr/bin/mysqld_safe --no-default --user mysqld & 

# securing mysqld installation
#echo securing mysqld installation
/usr/bin/mysql_secure_installation --no-defaults --user mysqld


# configure service first as we need to restart it for init
echo configuring mysqld service
#cygrunsrv -I mysqld -d 'CYGWIN mysqld' -p c:/cygwin/usr/sbin/mysqld -e 'CYGWIN=ntsec nosmbntsec binmode tty' -u mysqld -a '--user mysqld --basedir=/usr --datadir=/var/lib/mysql --plugin-dir=/usr/lib/mysql/plugins --log-error=/var/log/mysql/mysqld.err --pid-file=/var/run/mysql/mysqld.pid'
chmod a+x mysqld
cp mysqld /etc/rc.d/init.d/
/etc/rc.d/init.d/mysqld install


# init database to recreate vault password hash
#echo initializing mysqld database
#./mysql-init.sh


echo configured mysqld
popd
