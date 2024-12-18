#  module:  cyg-package.sh              cygwin package configurator
#  project: manufacture cygwin          cygwin.manufacture.net     
#  author:  Francis Korning             <fkorning@yahoo.ca>
#  rights:  (c) 2014 Francis Korning    manufacture.net
#  license: GNU LGPL license            https://www.gnu.org/licenses/lgpl.html


# apt-cyg package manager: apt-get for cygwin
# see https://code.google.com/p/apt-cyg/


echo installing apt-cyg package manager

# permissions  
chmod +x ./bin/*

#if [ ! -f "/usr/bin/apt-cyg" ]; then
#  lynx -source rawgit.com/transcode-open/apt-cyg/master/apt-cyg > apt-cyg
#  install apt-cyg /bin
#fi

# install binaries
install ./bin/service /bin
install ./bin/apt-cyg /bin

# use standard apt commands, ex:
# apt-cyg install nano

