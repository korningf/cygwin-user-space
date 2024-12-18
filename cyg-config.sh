#  module:  cyg-config.sh               cygwin auto configurator
#  project: manufacture cygwin          cygwin.manufacture.net     
#  author:  Francis Korning             <fkorning@yahoo.ca>
#  rights:  (c) 2014 Francis Korning    manufacture.net
#  license: GNU LGPL license            https://www.gnu.org/licenses/lgpl.html


# NOTE: do not forget to set the password for the administrator!
# NOTE: do not forget to set the password for user cyg_server!


echo configuring manufacture cygwin


#CHECK:
echo checking for manufacture syswin sysinternals junction
if [ ! -e "c:/syswin/bin/junction.exe" ] ; then
    echo "ERROR: manufacture syswin is missing sysinternals junction."
    exit 1
fi


#VAULT:
echo configuring cygwin vault permissions
[ -d "c:/vault/" ] || mkdir "c:/vault/"
chmod 1770 "c:/vault"


#MOUNT
#mount -f c:/cygwin/sbin /sbin
#mount -f c:/cygwin/usr/sbin /usr/sbin


#ACCOUNTS:
export USER=`whoami`


#SYSTEM:
echo creating the system account
mkpasswd --local | head -1 > /vault/system.passwd
export SYSTEM=`cat /vault/system.passwd | cut -d: -f1`
echo "system account is ${SYSTEM}"

#ADMIN:
echo creating the admin account
mkpasswd --local --user Administrator > /vault/admin.passwd
#mkpasswd --local --user Administrateur >> /vault/admin.passwd
export ADMIN=`cat /vault/admin.passwd | cut -d: -f1`
echo "admin account is ${ADMIN}"

#USER:
echo creating the user account
mkpasswd --local --user ${USER} > /vault/user.passwd
mkpasswd --domain --user ${USER} >> /vault/user.passwd
echo "user account is ${USER}"

#GUEST:
echo creating the guest account
mkpasswd --local --user Guest > /vault/guest.passwd
#mkpasswd --domain --user Invit� >> /vault/guest.passwd
export GUEST=`cat /vault/guest.passwd | cut -d: -f1`
echo "guest account is ${GUEST}"

#DAEMON:
echo creating the daemon group
mkgroup --local | head -1 > /vault/system.group
export DAEMON=`cat /vault/system.group | cut -d: -f1`
echo "system group is ${DAEMON}"

#ADMINS:
echo creating the admins group
mkgroup --local --group Administrators > /vault/admins.group
#mkgroup --local --group Administrateurs >> /vault/admins.group
export ADMINS=`cat /vault/admins.group | cut -d: -f1`
echo "admins group is ${ADMINS}"

#GROUP:
echo creating the user group
mkgroup --local --group "HomeUsers" > /vault/group.group
mkgroup --domain --group "Domain Users" >> /vault/group.group
export GROUP=`cat /vault/group.group | cut -d: -f1`
echo "user group is ${GROUP}"

#USERS:
echo creating the users group
mkgroup --local --group Users > /vault/users.group
#mkgroup --local --group Utilisateurs >> /vault/users.group
export USERS=`cat /vault/users.group | cut -d: -f1`
echo "users group is ${USERS}"

#GUESTS:
echo creating the guests group
mkgroup --local --group Guests > /vault/guests.group
#mkgroup --local --group Invit�s >> /vault/guests.group
export GUESTS=`cat /vault/guests.group | cut -d: -f1`
echo "users group is ${GUESTS}"


#PASSWD:
echo creating the local password file
/usr/bin/mkpasswd --local > /etc/passwd


echo normalising the local password file
cat /vault/system.passwd | sed -e 's/^\w*/system/' >> /etc/passwd

cat /vault/admin.passwd | sed -e 's/^\w*/admin/g' >> /etc/passwd
cat /vault/admin.passwd | sed -e 's/^\w*/root/g' >> /etc/passwd

cat /vault/user.passwd >> /etc/passwd
cat /vault/user.passwd | sed -e 's/^\w*/user/' >> /etc/passwd

cat /vault/guest.passwd >> /etc/passwd
cat /vault/guest.passwd | sed -e 's/^\w*/guest/' >> /etc/passwd


#GROUPS:
echo creating the local group file
/usr/bin/mkgroup --local > /etc/group

echo normalising the local group file
cat /vault/system.group | sed -e 's/^\w*/system/g' >> /etc/group
cat /vault/system.group | sed -e 's/^\w*/server/g' >> /etc/group
cat /vault/system.group | sed -e 's/^\w*/daemon/g' >> /etc/group

cat /vault/admins.group | sed -e 's/^\w*/admins/g' >> /etc/group
cat /vault/admins.group | sed -e 's/^\w*/root/g' >> /etc/group

cat /vault/users.group >> /etc/group
cat /vault/users.group | sed -e 's/^\w*/users/g' >> /etc/group

cat /vault/group.group >> /etc/group
cat /vault/group.group | sed -e 's/^\w*/group/g' >> /etc/group

cat /vault/guests.group >> /etc/group
cat /vault/guests.group | sed -e 's/^\w*/guests/g' >> /etc/group


#PACKAGES:
echo installing apt-cyg package manager
./cyg-package.sh


#PERL:
echo configuring cyg-perl CPAN package manager
./cyg-perl.sh


#MODULES:
echo configuring MIT Modules command
./modules/modules-install.sh



#SERVERS:

#SERVER:
echo configuring cygwin cygserver
cygrunsrv --query cygserver && cygrunsrv --stop cygserver
/usr/bin/cygserver-config --yes

#SERVICE:
echo starting cygwin cygserver
cygrunsrv --start cygserver


#SSHD:
echo configuring cygwin sshd
./ssh/ssh-host-config.sh
grep "cyg_server:" /etc/passwd | sed -e 's/\/var\/empty/\/home\/cyg_server/g' > /vault/server.passwd
grep -v "cyg_server" /etc/passwd > /vault/passwd
cat /vault/passwd > /etc/passwd
cat /vault/server.passwd >> /etc/passwd
cat /vault/server.passwd | sed -e 's/^\w*/sshd/' >> /etc/passwd

#MYSQLD:
echo configuring cygwin mysqld
cat /vault/server.passwd | sed -e 's/^\w*/mysqld/' >> /etc/passwd
./mysql/mysql-host-config.sh

#HTTPD:
echo configuring cygwin httpd
cat /vault/server.passwd | sed -e 's/^\w*/httpd/' >> /etc/passwd
./apache/http-host-config.sh



#PERMISSIONS:
echo fixing server permissions
chmod 600 /etc/ssh_host_*key
chown cyg_server /var/*
chmod 711 /var
chmod 755 /var/*
chmod 700 /var/empty


#SERVICES:
echo starting cygwin sshd
cygrunsrv --start sshd

echo starting cygwin mysqld
cygrunsrv --start mysqld

echo starting cygwin httpd
cygrunsrv --start httpd


#PROFILE:
cp profile/.bashrc ~/
cp profile/.profile ~/
cp profile/.bash_profile ~/
cp profile/.bash_ssh ~/


#TERMINAL:
echo configuring chere prompt
chere -i -t mintty -f


#END:
echo manufacture cygwin configured
