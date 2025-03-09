```

#=============================================================================#
# Manufakture cygwin-user-space
#-----------------------------------------------------------------------------#

                              _____        __      __                        
  _____ _____    ____  __ ___/ ____\____  |  | ___/  |_ __ _________   ____  
 /     \\__  \  /    \|  |  \   __\\__  \ |  |/ /\   __\  |  \_  __ \_/ __ \ 
|  Y Y  \/ __ \|   |  \  |  /|  |   / __ \|    <  |  | |  |  /|  | \/\  ___/ 
|__|_|  (____  /___|  /____/ |__|  (____  /__|_ \ |__| |____/ |__|    \___  >
      \/     \/     \/                  \/     \/                         \/

#-----------------------------------------------------------------------------#

#=============================================================================#

```	
	
Manufakture cygwin POSIX in user-space on secondary drive (L:)


[TOC]


#-----------------------------------------------------------------------------#
# Manufakture syswin-user-space
#-----------------------------------------------------------------------------#
	
	
	Manufacture relies on the excellent Cygwin POSIX emulator for windows written
	by Larry Hall and maintained by RedHat.  Our Manufacture provides a number of 
	enhancements and customisations, centered around automation and providing a
	consistent POSIX interface and structure for application development languages.
	
	You must install the prerequisite Manufacture Syswin suite of utilities first!
 
	Manufacture Cygwin then installs programatically from within an admin shell.


        Credits:

        Manufacture-cygwin adds Ryan Prichard's WinPTY to bind TTY-master functionality
        to DOS consoles and cygwin's MINTTY (see https://github.com/rprichard/winpty).
        This is necessary to support shell remote execute on cygwin docker, kubernetes.


#-----------------------------------------------------------------------------#
# Capabilities:
#-----------------------------------------------------------------------------#

	Capabilities:
	
		- POSIX unified directory file structure
		- POSIX users, groups, hosts, networks
		- bash, base, system, utils, admin tools
		- archivers, cygutils, cyg-utils-extra
		- chere, dos2unix, unix2dos
		- lynx, wget, wput, whois, curl
		- chkconfig, sysvinit, initscripts
		- apt-cyg, service cmd
		- MIT modules, cygport
		- sed, awk, expect, bc, tcl-tk
		- php, ruby, python
		- perl, libperl, cpan
		- gcc, glibc, atool, libtool, binutils
		- ELFIO, libelf, libelf-devel, MINGW
		- automake, autoconf
		- rcs, cvs, svn, git, mercurial
		- diffutils, patchutils
		- cygserver / cygrunsrv
		- open ssh / open sshd
		- LAMP apache 2 httpd
		- LAMP apache mod PHP, LWP, PCRE, FCGI
		- LAMP mysqld
		
	
#-----------------------------------------------------------------------------#
# POSIX Structure:
#-----------------------------------------------------------------------------#

	POSIX Structure:

		/windows/		windows installation
		/cygwin/		cygwin binaries
		/syswin/		syswin binaries

		/				main cygwin mountpoint 
		/mnt/			additional mountpoints
		cygdrive/		mounted windows drives

		dev/			devices (virtual)
		proc/			processes (virtual)

		var/			var files (permanent)
		tmp/			tmp files (volatile)
		
		etc/			configuration files
		lib/			runtime libraries

		usr/			user programs
		bin/			user binaries
		sbin/			admin binaries	
		setup/			setup directory
		
		home/			posix user profiles
		users/			windows user profiles
		
		vault/			private passwd vault
		work/			work apps and workspaces
		
		share/			shared data, libs, programs 
		srv/			shared public data, servers
	
			
#-----------------------------------------------------------------------------#
# Requirements:
#-----------------------------------------------------------------------------#

	Requirements:

	    - windows vista/7/8/10+  x86 or x64(recommended)
	    
	    - windows user with local administrator rights
	    
	    - internet / proxy access and zip/unzip archiver 
	    
	    - space for cygwin in the default drive c:\cygwin
    

	Prerequisites:

	    - manufacture syswin already installed in c:\syswin
	
	    - set the administrator account and password using syswin
	    
	    - create a new cyg_server user with Administrators profile
	    
	    - login as cyg_server and set the password (memorize it!)
	
	    - logout and log back in as administrator.
    


#-----------------------------------------------------------------------------#
# Preparation:
#-----------------------------------------------------------------------------#

	Cygwin setup assumes it not already running and locking the cygwin dll.
 
 	If Manufakture Cygwin has previsouly been installed, kill all shells,

  	terminate all process, and crucially kill all running services daemons.
   

	    net stop cygserver
	    net stop cyghttpd     
	    net stop cygsshd
     
	    
	

#-----------------------------------------------------------------------------#
# Installation:
#-----------------------------------------------------------------------------#

	Installation:
        
	    - from an interactive administator shell run cyg-install.bat
	    
	    	cyg-install.bat
    
    
	
#-----------------------------------------------------------------------------#
# Configuration:
#-----------------------------------------------------------------------------#



#-----------------------------------------------------------------------------#
# Operation:
#-----------------------------------------------------------------------------#



#-----------------------------------------------------------------------------#
# Appendix
#-----------------------------------------------------------------------------#

	Links:
	
		https://superuser.com/questions/1270302/install-cygwin-on-new-machine-from-local-directory


#-----------------------------------------------------------------------------#
# LICENSE
#-----------------------------------------------------------------------------#


  [LICENSE.txt](LICENSE.txt)

```   

#-----------------------------------------------------------------------------#
# (c) Francis Korning 2024.
#=============================================================================#

```
