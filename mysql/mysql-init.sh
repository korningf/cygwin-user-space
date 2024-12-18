#  module:  mysql-init.sh               cygwin mysqld db initialisation
#  project: manufacture cygwin          cygwin.manufacture.net      
#  author:  Francis Korning             <fkorning@yahoo.ca>
#  rights:  (c) 2014 Francis Korning    manufacture.net
#  license: GNU LGPL license            https://www.gnu.org/licenses/lgpl.html


# This script generates Mysql password hashes and stores them in /vault/
# The mysql hash algo is not the Unix bcrypt but [ sha1(bin(sha1(*))) ]


pwd=`pwd`
dir=`dirname $0`
pushd $dir


echo "initializing mysql accounts"
if [ -f "/vault/mysqld.sha1" ] ; then
    echo "password already hashed: del /vault/mysqld.sha1 and rerun to reset."
    p0=`cat "/vault/mysqld.sha1" | awk '{ print $1 }'`
else 
    echo "mysqld password hash not found: generating it."

    read -s -p "please enter mysqld root password: " p1
    echo ""
    read -s -p "now re-enter mysqld root password: " p2 
    echo ""
    
    if [ "$p1" != "$p2" ] ; then
    	echo "passwords do not match!"
    	exit 1
    fi

    #mysqladmin -u root password $p1
	
	
    echo "starting mysqld service"
    cygrunsrv --start mysqld

    echo "sleeping 10s"
    sleep 10s

    echo "creating mysqld passwd hash"
    p0=`mysql --execute "select password('"$p1"')" | tail -1 | awk '{ print $1 }'`
    
    echo ${p0} > "/vault/mysqld.sha1"
    chmod 600 "/vault/mysqld.sha1"
    
    echo "stopping mysqld service"
    cygrunsrv --stop mysqld    
fi


echo "initializing mysql database"
if [ -f "/vault/mysql-init.sql" ] ; then 
    echo "database already initalised: del mysql-init.run and re-run to reset."
else 
    echo "creating mysqld init-file"
    touch "/vault/mysql-init.sql"
    chmod 600 "/vault/mysql-init.sql"
    cat mysql-init.sql | sed -e "s/PASSWORD/$p0/g" > "/vault/mysql-init.sql"

    echo "stopping mysqld service"
    cygrunsrv --stop mysqld

    echo "killing mysqld instances"
    pids=`ps -ef | grep mysqld | awk '{ print $2 }' | xargs`
    if [ "$pids" != "" ] ; then
    	kill -9 $pids
    fi

    echo "running mysqld with init-file"
    /usr/sbin/mysqld --init-file /vault/mysql-init.sql &
    
    echo "sleeping 10s"
    sleep 10s
    
    echo "killing mysqld instances"
    pids=`ps -ef | grep mysqld | awk '{ print $2 }' | xargs`
    if [ "$pids" != "" ] ; then
    	kill -9 $pids
    fi
    
    echo "stopping mysqld service"
    cygrunsrv --stop mysqld    
fi


echo "mysqld initialised and ready to run as service"
popd
