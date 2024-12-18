#  module:  ssh-host-config.sh          cygwin openssh configurator
#  project: manufacture cygwin          cygwin.manufacture.net
#  author:  Francis Korning             <fkorning@yahoo.ca>
#  rights:  (c) 2016 Francis Korning    manufacture.net
#  license: GNU LGPL license            https://www.gnu.org/licenses/lgpl.html



PWD=`pwd`
DIR=`dirname $0`


echo configuring OpenSSH sshd service
pushd $DIR


echo stopping sshd service
cygrunsrv --stop sshd || echo sshd not running

echo remmoving sshd service
cygrunsrv --remove sshd || echo sshd not installed


echo installing and configuring sshd
/usr/bin/ssh-host-config --yes --cygwin 'binmode ntsec tty'


echo granting NTSEC logon rights to user cyg_server
editrights -a SeTcbPrivilege -u cyg_server
editrights -a SeCreateTokenPrivilege -u cyg_server
editrights -a SeAssignPrimaryTokenPrivilege -u cyg_server
editrights -a SeServiceLogonRight -u cyg_server
editrights -r SeDenyInteractiveLogonRight -u cyg_server
editrights -r SeDenyRemoteInteractiveLogonRight -u cyg_server
editrights -l -u cyg_server
gpupdate


echo configuring sshd service
chmod a+x sshd
cp sshd /etc/rc.d/init.d/
/etc/rc.d/init.d/sshd install


echo configured OpenSSH sshd service
popd


