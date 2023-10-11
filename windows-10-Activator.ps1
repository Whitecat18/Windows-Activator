@echo off
fltmc >nul 2>&1 || (
  echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\GetAdmin.vbs"
  echo UAC.ShellExecute "%~fs0", "", "", "runas", 1 >> "%temp%\GetAdmin.vbs"
  cmd /u /c type "%temp%\GetAdmin.vbs">"%temp%\GetAdminUnicode.vbs"
  cscript //nologo "%temp%\GetAdminUnicode.vbs"
  del /f /q "%temp%\GetAdmin.vbs" >nul 2>&1
  del /f /q "%temp%\GetAdminUnicode.vbs" >nul 2>&1
  exit
)
mode con cols=60 lines=25
color 06
title WIN-GEN 

::===========================================================================
setlocal enabledelayedexpansion
setlocal EnableExtensions
pushd "%~dp0"
cd /d "%~dp0"
goto :Banner
:MAINMENU

echo.  :=======================================================:
echo.
Echo.    [1] Activate Windows 10 with Digital Licence
Echo.
Echo.    [2] Check Windows Activation Status
echo.
Echo.    [3] Smukx Tools
echo.						BY Smukx
echo.  :=======================================================:
choice /C:123 /N /M "YOUR CHOICE : "

if errorlevel 3 goto :ABoutme
if errorlevel 2 goto :Check
if errorlevel 1 goto :HWIDActivate
::===========================================================================

:HWIDActivate
set slp=SoftwareLicensingProduct
set sps=SoftwareLicensingService
FOR /F "tokens=3" %%I IN ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" ^| findstr CurrentVersion ^| findstr REG_SZ') DO (SET winver=%%I)
for /f "tokens=2* delims= " %%a in ('reg query "HKLM\System\CurrentControlSet\Control\Session Manager\Environment" /v "PROCESSOR_ARCHITECTURE"') do if "%%b"=="AMD64" (set vera=x64) else (set vera=x86)
for /f "tokens=2 delims== " %%A in ('"wmic path %slp% where (Name LIKE '%%Windows%%' and PartialProductKey is not null) get LicenseStatus /format:list"') do set status=%%A
for /f "tokens=2 delims=, " %%A in ('"wmic path %slp% where (Name LIKE '%%Windows%%' and LicenseStatus='%status%') get name /value"') do set osedition=%%A

if not exist "bin" md "bin"
set "gatherosstate=bin\%vera%\gatherosstate.exe"
set "slc=bin\%vera%\slc.dll"
::===============================================================================================================
:GenerateHWIDA
cd /d "%~dp0"
cls
call :Header "WINDOWS 10 DIGITAL LICENSE [Windows 10 %osedition% %vera%]"
echo:

::===============================================================================================================
:parseAndPatch
cls
mode con cols=97 lines=15
call :Header "WINDOWS 10 DIGITAL LICENSE [Windows 10 %osedition% %vera%]"
echo Files are being prepared...
if not exist %gatherosstate% (
	call :Footer
	echo gatherosstate.exe not found. Enter ISO drive letter to copy.
	call :Footer
	set /p ogspath=Enter drive letter : ^>
	xcopy "!ogspath!:\sources\gatherosstate.exe" /s ".\bin" /Q /Y >nul 2>&1
)
set "ps=bin\
if [%osedition%] == [EnterpriseN] (
	set "ps=bin\entn.ps1"
	xcopy "!ps!" /s ".\bin" /Q /Y >nul 2>&1
	cd /d "bin"
	set "ps=entn.ps1"
	for /f "tokens=*" %%a in ('powershell -executionpolicy bypass -File !ps!') do set "key=%%a"
	if exist "!ps!" del /s /q "!ps!" >nul 2>&1
)
if [%osedition%] == [EnterpriseSN] (
	set "ps=bin\entsn.ps1"
	xcopy "!ps!" /s ".\bin" /Q /Y >nul 2>&1
	cd /d "bin"
	set "ps=entsn.ps1"
    for /f "tokens=*" %%a in ('powershell -executionpolicy bypass -File !ps!') do set "key=%%a"
	if exist "!ps!" del /s /q "!ps!" >nul 2>&1
)
call :Footer
cls
mode con cols=97 lines=48
call :Header "WINDOWS 10 DIGITAL LICENSE [Windows 10 %osedition% %vera%]"
echo Creating registry entries...
reg add "HKLM\SYSTEM\Tokens" /v "Channel" /t REG_SZ /d "Retail" /f
reg add "HKLM\SYSTEM\Tokens\Kernel" /v "Kernel-ProductInfo" /t REG_DWORD /d %sku% /f
reg add "HKLM\SYSTEM\Tokens\Kernel" /v "Security-SPP-GenuineLocalStatus" /t REG_DWORD /d 1 /f
call :Footer
echo  Default product key is installing for Windows 10 %edition% %vera%...
echo:
cscript /nologo %windir%\system32\slmgr.vbs -ipk %key%
call :Footer
echo Create GenuineTicket.XML file for Windows 10 %edition% %vera%...
start /wait "" "%gatherosstate%"
timeout /t 3 >nul 2>&1
call :Footer
echo GenuineTicket.XML file is installing for Windows 10 %edition% %vera%...
echo:
clipup -v -o -altto bin\%vera%\
call :Footer
echo Windows 10 %edition% %vera% activating...
echo:
cscript /nologo %windir%\system32\slmgr.vbs -ato
call :Footer
echo Deleting registry entries...
reg delete "HKLM\SYSTEM\Tokens" /f
call :Footer
echo Press any key to continue...
pause >nul
CLS
mode con cols=60 lines=25
goto:MainMenu
::===============================================================================================================
:Header
echo.
echo %~1
echo.
echo:
goto:eof
::===============================================================================================================
:Footer
echo:
echo.
echo:
goto:eof
::===============================================================================================================
: HWIDA_EXIT
CLS
GOTO MAINMENU
::===============================================================================================================
:Check
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  cmd /u /c echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && ""%~s0""", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
CLS
mode con cols=60 lines=25
ECHO ************************************************************
ECHO ***                   Windows Status                     ***
ECHO ************************************************************
cscript //nologo %systemroot%\System32\slmgr.vbs /dli
cscript //nologo %systemroot%\System32\slmgr.vbs /xpr
ECHO ____________________________________________________________
)
echo.
echo Press any key to continue...
pause >nul
CLS
mode con cols=60 lines=25
GOTO MAINMENU
::===============================================================================================================
:ABoutme
CLS

timeout 3
CLS

ECHO ************************************************************
ECHO ***                      About Me 		         ***
ECHO ************************************************************
echo.
Echo. 
Echo. 	   Visit my Webpage to know more about me 
echo.
Echo.		 ----smukx.site----
echo.
Echo.     	     Enjoy Your Windows           
echo.
Echo. Press any key to continue...
pause > nul
CLS
mode con cols=60 lines=30
GOTO MAINMENU
::================================================================================================================
:Banner
echo. :*******************************************************:
echo. :		           WIN-GEN			 :
echo. :*******************************************************:
echo.
Echo.   		    WINDOWS 10 ACTIVATOR
echo.
Echo.   Win-Gen is a tool Used to activate Windows 10 Machines
Echo.  
Echo.     Written by Smukx.
echo.
echo.
echo.
Echo.Press any Key to Continue ...
pause > nul
CLS
goto :MAINMENU



