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
title Windows-Activator

::===========================================================================

setlocal enabledelayedexpansion
setlocal EnableExtensions
pushd "%~dp0"
cd /d "%~dp0"

:MAINMENU
echo.
echo.  :=======================================================:
echo.                    WINDOWS ACTIVATOR PRO                              
echo.  :=======================================================:
echo.
echo.
echo.    [1] Activate Windows10 with Digital Licence
echo.
echo.    [2] Activate Windows11 with Digital Licence
echo.
echo.    [3] Remove Old Windows Key
echo.
echo.    [4] Check Windows Activation Status
echo.
echo.    [5] Tool Description
echo.						
echo.  :=======================================================:
echo.
choice /C:12345 /N /M "YOUR CHOICE : "

if errorlevel 5 goto :ABoutme
if errorlevel 4 goto :Check
if errorlevel 3 goto :RemoveKEYS
if errorlevel 2 goto :Windows11
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
echo. Removing old windows keys .

echo. Successfully removed windows keys.
cls 
call :Header "WINDOWS 10 DIGITAL LICENSE [Windows 10 %osedition% %vera%]"
echo:
if [%osedition%] == [Cloud] (
	set "edition=Cloud"
	set "key=V3WVW-N2PV2-CGWC3-34QGF-VMJ2C"
	set "sku=178"
	set "editionId=X21-32983"
	goto :parseAndPatchWindow10
)
if [%osedition%] == [CloudN] (
	set "edition=CloudN"
	set "key=NH9J3-68WK7-6FB93-4K3DF-DJ4F6"
	set "sku=179"
	set "editionId=X21-32987"
	goto :parseAndPatchWindow10
)
if [%osedition%] == [Core] (
	set "edition=Core"
	set "key=YTMG3-N6DKC-DKB77-7M9GH-8HVX7"
	set "sku=101"
	set "editionId=X19-98868"
	goto :parseAndPatchWindow10
)
if [%osedition%] == [CoreCountrySpecific] (
	set "edition=CoreCountrySpecific"
	set "key=N2434-X9D7W-8PF6X-8DV9T-8TYMD"
	set "sku=99"
	set "editionId=X19-99652"
	goto :parseAndPatchWindow10
)
if [%osedition%] == [CoreN] (
	set "edition=CoreN"
	set "key=4CPRK-NM3K3-X6XXQ-RXX86-WXCHW"
	set "sku=98"
	set "editionId=X19-98877"
	goto :parseAndPatchWindow10
)
if [%osedition%] == [CoreSingleLanguage] (
	set "edition=CoreSingleLanguage"
	set "key=BT79Q-G7N6G-PGBYW-4YWX6-6F4BT"
	set "sku=100"
	set "editionId=X19-99661"
	goto :parseAndPatchWindow10
)
if [%osedition%] == [Education] (
	set "edition=Education"
	set "key=YNMGQ-8RYV3-4PGQ3-C8XTP-7CFBY"
	set "sku=121"
	set "editionId=X19-98886"
	goto :parseAndPatchWindow10
)
if [%osedition%] == [EducationN] (
	set "edition=EducationN"
	set "key=84NGF-MHBT6-FXBX8-QWJK7-DRR8H"
	set "sku=122"
	set "editionId=X19-98892"
	goto :parseAndPatchWindow10
)
if [%osedition%] == [Enterprise] (
	set "edition=Enterprise"
	set "key=XGVPP-NMH47-7TTHJ-W3FW7-8HV2C"
	set "sku=4"
	set "editionId=X19-99683"
	goto :parseAndPatchWindow10
)
if [%osedition%] == [EnterpriseN] (
	set "edition=EnterpriseN"
  set "key=WGGHN-J84D6-QYCPR-T7PJ7-X766F"
	set "sku=27"
	set "editionId=X19-98746"
	goto :parseAndPatchWindow10
)
if [%osedition%] == [EnterpriseS] (
	set "edition=EnterpriseS"
	set "key=NK96Y-D9CD8-W44CQ-R8YTK-DYJWX"
	set "sku=125"
	set "editionId=X21-05035"
	goto :parseAndPatchWindow10
)
if [%osedition%] == [EnterpriseSN] (
	set "edition=EnterpriseSN"
	set "key=RW7WN-FMT44-KRGBK-G44WK-QV7YK"
	set "sku=126"
	set "editionId=X21-04921"
	goto :parseAndPatchWindow10
)
if [%osedition%] == [Professional] (
	set "edition=Professional"
	set "key=VK7JG-NPHTM-C97JM-9MPGT-3V66T"
	set "sku=48"
	set "editionId=X19-98841"
	goto :parseAndPatchWindow10
)
if [%osedition%] == [ProfessionalEducation] (
	set "edition=ProfessionalEducation"
	set "key=8PTT6-RNW4C-6V7J2-C2D3X-MHBPB"
	set "sku=164"
	set "editionId=X21-04955"
	goto :parseAndPatchWindow10
)
if [%osedition%] == [ProfessionalEducationN] (
	set "edition=ProfessionalEducationN"
	set "key=GJTYN-HDMQY-FRR76-HVGC7-QPF8P"
	set "sku=165"
	set "editionId=X21-04956"
	goto :parseAndPatchWindow10
)
if [%osedition%] == [ProfessionalN] (
	set "edition=ProfessionalN"
	set "key=2B87N-8KFHP-DKV6R-Y2C8J-PKCKT"
	set "sku=49"
	set "editionId=X19-98859"
	goto :parseAndPatchWindow10
)
if [%osedition%] == [ProfessionalWorkstation] (
	set "edition=ProfessionalWorkstation"
	set "key=DXG7C-N36C4-C4HTG-X4T3X-2YV77"
	set "sku=161"
	set "editionId=X21-43626"
	goto :parseAndPatchWindow10
)
if [%osedition%] == [ProfessionalWorkstationN] (
	set "edition=ProfessionalWorkstationN"
	set "key=WYPNQ-8C467-V2W6J-TX4WX-WT2RQ"
	set "sku=162"
	set "editionId=X21-43644"
	goto :parseAndPatchWindow10
)
if [%osedition%] == [ServerRdsh] (
	set "edition=ServerRdsh"
	set "key=NJCF7-PW8QT-3324D-688JX-2YV66"
	set "sku=175"
	set "editionId=X21-41295"
	goto :parseAndPatchWindow10
)
::===============================================================================================================
:parseAndPatchWindow10
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

:: WIndows 11 Activation Steps

:Windows11
cls
echo. ======================
echo. Windows11 Activation 
echo. ======================
echo

slmgr.vbs /ckms >nul
slmgr.vbs /upk >nul
slmgr.vbs /cpky >nul

sleep 1

setlocal enabledelayedexpansion

set slp=SoftwareLicensingProduct
set sps=SoftwareLicensingService

FOR /F "tokens=3" %%I IN ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" ^| findstr CurrentVersion ^| findstr REG_SZ') DO (SET winver=%%I)
for /f "tokens=2* delims= " %%a in ('reg query "HKLM\System\CurrentControlSet\Control\Session Manager\Environment" /v "PROCESSOR_ARCHITECTURE"') do if "%%b"=="AMD64" (set vera=x64) else (set vera=x86)
for /f "tokens=2 delims== " %%A in ('"wmic path %slp% where (Name LIKE '%%Windows%%' and PartialProductKey is not null) get LicenseStatus /format:list"') do set status=%%A
for /f "tokens=2 delims=, " %%A in ('"wmic path %slp% where (Name LIKE '%%Windows%%' and LicenseStatus='%status%') get name /value"') do set osedition=%%A

if not exist "bin" md "bin"
set "gatherosstate=bin\%vera%\gatherosstate.exe"
set "slc=bin\%vera%\slc.dll"
GOTO :parseAndPatchWindows11

:parseAndPatchWindows11
cd /d "%~dp0"
cls
call :Header "WINDOWS 11 DIGITAL LICENSE [Windows 11 %osedition% %vera%]"
echo:
if [%osedition%] == [Home] (
    echo "Activating Windows 11 %osedition% %osedition%"
    slmgr /ipk TX9XD-98N7V-6WMQ6-BX7FG-H8Q99
    slmgr /skms kms8.MSGuides.com
    slmgr /ato
    slmgr /ipk TX9XD-98N7V-6WMQ6-BX7FG-H8Q99
    echo Windows version Home activated with key "TX9XD-98N7V-6WMQ6-BX7FG-H8Q99"
    goto end1
)
if [%osedition%] == [HomeN] (
    echo "Activating Windows 11 %osedition% %osedition%"
    slmgr /ipk 3KHY7-WNT83-DGQKR-F7HPR-844BM
    slmgr /skms kms8.MSGuides.com
    slmgr /ato
    slmgr /ipk 3KHY7-WNT83-DGQKR-F7HPR-844BM
    echo Windows version Home N activated with key "3KHY7-WNT83-DGQKR-F7HPR-844BM"
    goto end1
)
if [%osedition%] == [Education] (
    echo "Activating Windows 11 %osedition% %osedition%"
    slmgr /ipk NW6C2-QMPVW-D7KKK-3GKT6-VCFB2
    slmgr /skms kms8.MSGuides.com
    slmgr /ato
    slmgr /ipk NW6C2-QMPVW-D7KKK-3GKT6-VCFB2
    echo Windows version Education activated with key "NW6C2-QMPVW-D7KKK-3GKT6-VCFB2"
    goto end1
)
if [%osedition%] == [EducationN] (
    echo "Activating Windows 11 %osedition% %osedition%"
    slmgr /ipk 2WH4N-8QGBV-H22JP-CT43Q-MDWWJ
    slmgr /skms kms8.MSGuides.com
    slmgr /ato
    slmgr /ipk 2WH4N-8QGBV-H22JP-CT43Q-MDWWJ
    echo Windows version Education N activated with key "2WH4N-8QGBV-H22JP-CT43Q-MDWWJ"
    goto end1
)
if [%osedition%] == [Enterprise] (
    echo "Activating Windows 11 %osedition% %osedition%"
    slmgr /ipk NPPR9-FWDCX-D2C8J-H872K-2YT43
    slmgr /skms kms8.MSGuides.com
    slmgr /ato
    slmgr /ipk NPPR9-FWDCX-D2C8J-H872K-2YT43
    echo Windows version Enterprise activated with key "NPPR9-FWDCX-D2C8J-H872K-2YT43"
    goto end1
)
if [%osedition%] == [EnterpriseN] (
    echo "Activating Windows 11 %osedition% %osedition%"
    slmgr /ipk DPH2V-TTNVB-4X9Q3-TJR4H-KHJW4
    slmgr /skms kms8.MSGuides.com
    slmgr /ato
    slmgr /ipk DPH2V-TTNVB-4X9Q3-TJR4H-KHJW4
    echo Windows version Enterprise N activated with key "DPH2V-TTNVB-4X9Q3-TJR4H-KHJW4"
    goto :end1
)
::Main KEYS and Versions
if [%osedition%] == [Professional] (
    echo "Activating Windows 11 %osedition% %osedition%"
    slmgr /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX
    slmgr /skms kms8.MSGuides.com
    slmgr /ato
    slmgr /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX
    echo Windows version Professional activated with key "W269N-WFGWX-YVC9B-4J6C9-T83GX"
    goto :end1
)
if [%osedition%] == [ProfessionalEducation] (
    echo "Activating Windows 11 %osedition% %osedition%"
    slmgr /ipk 6TP4R-GNPTD-KYYHQ-7B7DP-J447Y
    slmgr /skms kms8.MSGuides.com
    slmgr /ato
    slmgr /ipk 6TP4R-GNPTD-KYYHQ-7B7DP-J447Y
    echo Windows version Professional Education activated with key "6TP4R-GNPTD-KYYHQ-7B7DP-J447Y"
    goto :end1
)
if [%osedition%] == [ProfessionalEducationN] (
    echo "Activating Windows 11 %osedition% %osedition%"
    slmgr /ipk 6TP4R-GNPTD-KYYHQ-7B7DP-J447Y
    slmgr /skms kms8.MSGuides.com
    slmgr /ato
    slmgr /ipk 6TP4R-GNPTD-KYYHQ-7B7DP-J447Y
    echo Windows version Professional Education activated with key "6TP4R-GNPTD-KYYHQ-7B7DP-J447Y"
    goto :end1
)
if [%osedition%] == [ProfessionalN] (
    echo "Activating Windows 11 %osedition% %osedition%"
    slmgr /ipk MH37W-N47XK-V7XM9-C7227-GCQG9
    slmgr /skms kms8.MSGuides.com
    slmgr /ato
    slmgr /ipk MH37W-N47XK-V7XM9-C7227-GCQG9
    echo Windows version Professional N activated with key "MH37W-N47XK-V7XM9-C7227-GCQG9"
    goto :end1
)
if [%osedition%] == [ProfessionalWorkstation] (
    echo "Activating Windows 11 %osedition% %osedition%"
    slmgr /ipk NRG8B-VKK3Q-CXVCJ-9G2XF-6Q84J
    slmgr /skms kms8.MSGuides.com
    slmgr /ato
    slmgr /ipk NRG8B-VKK3Q-CXVCJ-9G2XF-6Q84J
    echo Windows version Professional Workstations activated with key "NRG8B-VKK3Q-CXVCJ-9G2XF-6Q84J"
    goto :end1
)
if [%osedition%] == [ProfessionalWorkstationN] (
    echo "Activating Windows 11 %osedition% %osedition%"
    slmgr /ipk 9FNHH-K3HBT-3W4TD-6383H-6XYWF
    slmgr /skms kms8.MSGuides.com
    slmgr /ato
    slmgr /ipk 9FNHH-K3HBT-3W4TD-6383H-6XYWF
    echo Windows version Professional Workstations N activated with key "9FNHH-K3HBT-3W4TD-6383H-6XYWF"
    goto :end1
)
:end1
cls
echo. Windows 11 %osedition% has been activated successfully. 
echo. If this tool was helpful , please leave a star at my repo.
echo.
Echo.Press any Key to Continue ...
pause > nul
CLS
goto :MAINMENU
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

echo.
echo Press any key to continue...
pause >nul
CLS
mode con cols=60 lines=25
GOTO :MAINMENU
::======================================================================================


:RemoveKEYS
echo. Removing Old Windows Keys ...

 slmgr.vbs /ckms >nul
cscript slmgr.vbs /upk >nul	
cscript //nologo slmgr.vbs /cpky >nul
echo. Removed Keys
echo.
Echo.Press any Key to Continue ...
pause > nul
CLS
goto :MAINMENU
::======================================================================================

:ABoutme
mode con: cols=110 lines=60
CLS
timeout 2
CLS

ECHO **********************************************************************************************
ECHO ***                                      About Me 		                           
ECHO **********************************************************************************************
echo.
Echo. Win-Gen is an bashfile script used to activate WIN10/11 Machines. 
Echo. 
Echo. For Guides. Please visit my github repository. 
Echo. 
Echo. Scripts are automated By Smukx . To know more visit https://github.com/Whitecat18/Windows-Activator
echo. 
Echo. Legal Disclaimer . The tool i write is completly for Education purpose only.
echo.
Echo. Souce code is MIT Licence
echo.
echo. If you Like my work please leave a star at my repository . 
echo.
timeout 2
start https://github.com/Whitecat18/Windows-Activator
Echo. Press any key to continue...
pause > nul
CLS
mode con cols=60 lines=30
GOTO :MAINMENU
::================================================================================================================
