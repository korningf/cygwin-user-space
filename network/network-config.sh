#  module:  network-config.sh           cygwin networking configurator
#  project: manufacture cygwin          cygwin.manufacture.net
#  author:  Francis Korning             <fkorning@yahoo.ca>
#  rights:  (c) 2016 Francis Korning    manufacture.net
#  license: GNU LGPL license            https://www.gnu.org/licenses/lgpl.html



echo configuring manufacture network
PWD=`pwd`
DIR=`dirname $0`
pushd $DIR


echo configuring hosts file
cp hosts /etc/

echo configuring networks file
cp networks /etc/


echo configuring manufacture network
popd
