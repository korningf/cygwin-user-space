

care must be taken with NTSEC permissions and extended non-POSIX ACLs



many cygwin paths and binaries need to have permissions fixed

note user cyg_server needs specific NTSEC server rights to allow logons



see https://cygwin.com/faq.html#faq.using.ssh-pubkey-stops-working


see http://www.tux.org/~mayer/cygwin/cygwin_sshd.pdf
see https://microtechnology-services.github.io/2016/04/29/cygwin-sshd-on-windows-domain.html



see https://blog.peterwurst.com/2016/09/15/ssh-server-on-windows-with-cygwin/



0) (as admin), uninstall old sshd and remove any cyg_server user from /etc/passwd



1) use ssh-host-config to recreate the service and cyg_server as a domain user



2) re-generate /etc/passwd and /etc/group using mkpaswd & mkgroup


	mkpasswd -d > /etc/passwd

	echo "" >> /etc/passwd

	mkpasswd -l >> /etc/passwd

	echo "" >> /etc/passwd


	mkgroup -d > /etc/group

	echo "" >> /etc/group

	mkgroup -l > /etc/group

	echo "" >> /etc/group




3) create cyg_server user password and manually logon at least once in windows.



3) use services.msc and manually ensure sshd logs on as cyg_server



4) use editrights to add the NTSEC token and Logon policies:
	

	echo granting NTSEC logon rights to user cyg_server

	editrights -a SeTcbPrivilege -u cyg_server

	editrights -a SeCreateTokenPrivilege -u cyg_server

	editrights -a SeAssignPrimaryTokenPrivilege -u cyg_server

	editrights -a SeServiceLogonRight -u cyg_server

	editrights -r SeDenyInteractiveLogonRight -u cyg_server

	editrights -r SeDenyRemoteInteractiveLogonRight -u cyg_server

	editrights -l -u cyg_server

	gpupdate



5) start the sshd service



	net start sshd



6) from your user shell, try ssh'ng into localhost



	ssh -v localhost

