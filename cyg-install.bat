@rem module:   cyg-install.bat              cygwin auto installer
@rem project:  manufacture cygwin           cygwin.manufacture.net      
@rem author:   Francis Korning              <fkorning@yahoo.ca>
@rem rights:   (c) 2014 Francis Korning     manufacture.net
@rem license:  GNU LGPL license            https://www.gnu.org/licenses/lgpl.html


@echo off

if "%1"=="/?" goto USAGE
if "%1"=="/h" goto USAGE
if "%1"=="-h" goto USAGE


:INSTALL
@rem su --login --mimic --elev --user administrator --cmd cyg-setup.bat
runas /user:%COMPUTERNAME%\administrator "cmd /c ^cd /d %CD% && cyg-setup.bat^"


GOTO END


:USAGE
echo "usage:  cyg-install"
goto END


:END
echo done.
