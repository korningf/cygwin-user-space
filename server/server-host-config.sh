#  module:  server-host-config.sh       cygwin cygserver configurator
#  project: manufacture cygwin          cygwin.manufacture.net
#  author:  Francis Korning             <fkorning@yahoo.ca>
#  rights:  (c) 2016 Francis Korning    manufacture.net
#  license: GNU LGPL license            https://www.gnu.org/licenses/lgpl.html



PWD=`pwd`
DIR=`dirname $0`


echo configuring cygserver
pushd $DIR


echo stopping cygserver service
cygrunsrv --stop cygserver || echo cygserver not running

echo remmoving openssh sshd service
cygrunsrv --remove cygserver || echo cygserver not installed


echo configuring cygserver service
/usr/bin/cygserver-config --yes
chmod a+x sshd
cp sshd /etc/rc.d/init.d/
/etc/rc.d/init.d/sshd install


echo configured cygserver
popd


