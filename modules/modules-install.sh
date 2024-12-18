#  module:  modules-install.sh          cygwin modules configurator
#  project: manufacture cygwin          cygwin.manufacture.net
#  author:  Francis Korning             <fkorning@yahoo.ca>
#  rights:  (c) 2016 Francis Korning    manufacture.net
#  license: GNU LGPL license            https://www.gnu.org/licenses/lgpl.html



echo installing MIT modules
VER="3.2.10"
SRC=modules-"${VER}"

PWD=`pwd`
DIR=`dirname $0`


pushd $DIR

echo creating local Modules repository
mkdir -p /usr/local/Modules


if [ ! -d /usr/local/bin/modulecmd ]; then
 echo modulecmd not found. installing modulecmd.		
 pushd ${DIR}/${SRC}

 echo compiling sources
 ./configure --prefix=/usr/local
 make

 echo installing binaries
 make install

echo cleaning build
 make clean

 echo installing modulecmd links
 ln -s /usr/local/Modules/${VER} /usr/local/Modules/default
 ln -s /usr/local/Modules/default/bin/* /usr/local/bin/
 echo installed modulecmd links

 echo installed modulecmd
 popd
fi


echo configuring module scripts


echo configured module scripts

popd
echo installed MIT modules


