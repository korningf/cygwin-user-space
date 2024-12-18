@rem  module:  cyg-setup.bat                cygwin auto installer
@rem project:  manufacture cygwin           cygwin.manufacture.net      
@rem author:   Francis Korning              <fkorning@yahoo.ca>
@rem rights:   (c) 2014 Francis Korning     manufacture.net
@rem license:   GNU LGPL license            https://www.gnu.org/licenses/lgpl.html

@rem echo off

@echo NOTE: do not forget to set the password for the administrator!
@echo NOTE: do not forget to set the password for user cyg_server!
@echo NOTE: do not forget to set the password for mysql root!


:CHECK
@echo checking for manufacture syswin sysinternals junction
if exist "c:/syswin/bin/junction.exe" goto SYSWIN
@echo ERROR: manufacture syswin is missing sysinternals junction. 
goto END


:SYSWIN
@echo SUCCESS manufacture syswin junction found. continuing install.


:STOP
@echo stopping cygwin cygserver
@net stop cygserver

@echo stopping cygwin mysqld
@net stop mysqld

@echo stopping cygwin httpd
@net stop httpd

@echo stopping cygwin sshd
@net stop sshd


:ENVS
@echo installing manufacture cygwin

@set CYGWIN=c:/cygwin
@setx CYGWIN c:/cygwin
@rem setx /m CYGWIN c:/cygwin

@set PATH=c:/cygwin;c:/cygwin/bin;%PATH%
@setx PATH=c:/cygwin;c:/cygwin/bin;%PATH%
@rem todo: gtools pathed: add path to system path
@rem setx /m PATH c:/cygwin;c:/cygwin/bin;%PATH%


:FETCH
@echo fetching cygwin setup binary
@rem httpget -u https://cygwin.com/setup-x86.exe -d c:/users/public/downloads -f cyg-setup-x86.exe
httpget -u https://cygwin.com/setup-x86_64.exe -d c:/users/public/downloads -f cyg-setup-x64.exe


:SETUP
@echo installing manufacture cygwin


@rem use --proxy host:port with local ntlm proxy settings
@rem use http site for those behind corporate firewall
@rem --site ftp://mirrors.kernel.org/sourceware/cygwin/ ^
@rem --site http://mirrors.kernel.org/sourceware/cygwin/ ^
@rem use proxy for those with firewall proxy passthrough
@rem --proxy localhost:5681 ^
@rem use download for 2 staged install: (1) download
@rem --download ^
@rem use local-install for staged install: (2) install
@rem --local-install ^


@rem cyg-setup-x86.exe ^
cyg-setup-x64.exe ^
--quiet-mode ^
--root c:/cygwin ^
--site http://mirrors.kernel.org/sourceware/cygwin/ ^
--local-package-dir c:/users/public/downloads ^
--disable-buggy-antivirus ^
--categories ^
Base,^
System,^
Perl,^
PHP ^
--packages ^
sed,^
gawk,^
cygutils,^
cygutils-extra,^
sysvinit,^
initscripts,^
mintty,^
chere,^
chkconfig,^
dos2unix,^
openssh,^
keepassx,^
less,^
ed,^
vim,^
bison,^
gcc-core,^
gcc-g++,^
gcc-mingw,^
mingw-gcc-core,^
mingw-gcc-g++,^
atool,^
autoconf,^
automake,^
autossh,^
libtool,^
cygport,^
cygrunsrv,^
binutils,^
diffutils,^
patchutils,^
cvs,^
subversion,^
git,^
python,^
tcl,^
tcl-tk,^
ruby,^
ruby-tcltk,^
expect,^
whois,^
wget,^
wput,^
curl,^
unzip ^
zip,^
bzip2,^
zlib,^
libxml2,^
crypt,^
libcrypt,^
libcrypt-devel,^
libgcrypt-devel,^
libmcrypt-devel,^
pcre,^
mysql,^
mysqld,^
lynx ^

@echo manufacture cygwin installed


@echo installing apt-cyg package manager
:PACKAGE
@c:/cygwin/bin/bash -c "./cyg-package.sh"


@echo launching cygwin configurator
:CONFIG
@c:/cygwin/bin/bash -c "./cyg-config.sh"


@echo installing winpty TTY-master 
:PACKAGE
@c:/cygwin/bin/bash -c "./cyg-winpty.sh"


:END
@echo done.

