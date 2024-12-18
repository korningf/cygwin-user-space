#  module:  subversion-config.sh        subversion configurator
#  project: manufacture cygwin          cygwin.manufacture.net
#  author:  Francis Korning             <fkorning@yahoo.ca>
#  rights:  (c) 2016 Francis Korning    manufacture.net
#  license: GNU LGPL license            https://www.gnu.org/licenses/lgpl.html



PWD=`pwd`
DIR=`dirname $0`

echo configuring subversion
pushd $DIR


mkdir -p /etc/subversion


cp config /etc/subversion


echo configured subversion
popd


