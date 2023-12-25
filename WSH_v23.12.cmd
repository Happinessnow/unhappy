@echo off&mode con cols=74 lines=17
:admincheck
net session > nul 2> nul
if not "%errorlevel%" == "0"  (
echo 
echo  관리자 권한으로 실행해 주세요.
echo 
timeout /t 5 > nul
goto exit
)
set WSHver=23.12
title 윈도우 초기 설정 도우미 v%WSHver% By Remiz
:main
@echo off&mode con cols=74 lines=46
cls
echo 
echo  [ 윈도우 초기 설정 도우미 v%WSHver% By Remiz ]
echo 
echo  [1] 최대 절전 모드 켜기 / 끄기
echo  [2] 우클릭 메뉴 설정하기
echo  [3] 윈도우 디펜더 끄기 / 켜기
echo  [4] 윈도우 방화벽 끄기 / 켜기
echo  [5] 윈도우 업데이트 끄기 / 켜기
echo  [6] 전원 옵션 균형조정 / 고성능 설정하기
echo  [7] 원드라이브(OneDrive) / 코타나(Cortana) 제거하기
echo  [8] 윈도우 알림센터 비활성화 / 활성화
echo  [9] 윈도우 기본 프로그램 제거하기
echo  [0] 시스템 정보 화면으로 변경하기 (20H2부터 시스템 정보 UI 변경됨)
echo  [B] 바로가기 아이콘 화살표 추가 / 제거
echo  [S] SSD 최적화 (Superfetch, Windows Search 비활성화)
echo  [A] Administrator 최고 관리자 계정 활성화 / 비활성화
echo  [W] Windows10의 개인정보 수집 기능 비활성화
echo  [E] Windows 에디션 변환하기
echo 
set menu=
set /p menu= [ 원하시는 작업을 선택해 주세요 ] :
if "%menu%" == "1" goto economy
if "%menu%" == "2" goto rightmenu
if "%menu%" == "3" goto antion
if "%menu%" == "4" goto fw
if "%menu%" == "5" goto ub
if "%menu%" == "6" goto pwcf
if "%menu%" == "7" goto ctna
if "%menu%" == "8" goto push
if "%menu%" == "9" goto ba
if "%menu%" == "0" goto sys
if "%menu%" == "S" goto sopt
if "%menu%" == "s" goto sopt
if "%menu%" == "A" goto admin
if "%menu%" == "a" goto admin
if "%menu%" == "B" goto arow
if "%menu%" == "b" goto arow
if "%menu%" == "W" goto wx
if "%menu%" == "w" goto wx
if "%menu%" == "E" goto edi
if "%menu%" == "e" goto edi
goto main
:arow
@echo off&mode con cols=74 lines=21
cls
echo 
echo  [ 바로가기 아이콘 화살표 ]
echo 
echo  [1] 바로가기 아이콘 화살표 제거하기
echo  [2] 바로가기 아이콘 화살표 추가하기 (원복)
echo  [3] 매인 메뉴로 가기
echo 
set menu=
set /p menu= [ 원하시는 작업 번호를 입력 후 엔터(Enter)키를 눌러주세요 ] :
if "%menu%" == "1" goto delarow
if "%menu%" == "2" goto addarow
if "%menu%" == "3" goto main
goto arow
:delarow
cls
echo 
echo  바로가기 아이콘 화살표를 제거 중입니다...
echo 
xcopy /y /s /h "%~dp0remiz\bk\blank.ico" "%SystemRoot%\system32\"
taskkill /f /im explorer.exe
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29 /d %SystemRoot%\system32\blank.ico /f
start explorer.exe
cls
echo 
echo  바로가기 아이콘 화살표를 제거 중입니다...
echo 
echo 
echo  바로가기 아이콘 화살표를 제거하였습니다!
echo 
pause
goto main
:addarow
cls
echo 
echo  바로가기 아이콘 화살표를 추가(원복) 중입니다...
echo 
taskkill /f /im explorer.exe
attrib "%userprofile%\appdata\local\iconcache.db" -s -r -h
del /q "%userprofile%\appdata\local\iconcache.db"
del /q "%SystemRoot%\system32\blank.ico"
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer /v "Max Cached Icons" /t REG_SZ /d 4096 /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /f
start explorer.exe
cls
echo 
echo  바로가기 아이콘 화살표를 추가(원복) 중입니다...
echo 
echo 
echo  바로가기 아이콘 화살표를 추가(원복)하였습니다!
echo 
pause
goto main
:sopt
@echo off&mode con cols=74 lines=27
cls
echo 
echo  SSD 최적화를 시작합니다...
echo 
net stop SysMain
sc config SysMain start=disabled
net stop WSearch
sc config WSearch start=disabled
echo 
echo  SSD 최적화가 완료되었습니다!
echo 
pause
goto main
:fw
@echo off&mode con cols=74 lines=21
cls
echo 
echo  [ 윈도우 방화벽 ]
echo 
echo  [1] 윈도우 방화벽 켜기
echo  [2] 윈도우 방화벽 끄기 (권장)
echo  [3] 매인 메뉴로 가기
echo 
set menu=
set /p menu= [ 원하시는 작업 번호를 입력 후 엔터(Enter)키를 눌러주세요 ] :
if "%menu%" == "1" goto fon
if "%menu%" == "2" goto foff
if "%menu%" == "3" goto main
goto fw
:fon
netsh advfirewall set allprofiles state on
cls
echo 
echo  [ 윈도우 방화벽 ]
echo 
echo 
echo  정상적으로 적용되었습니다.
echo 
pause
goto main
:foff
netsh advfirewall set allprofiles state off
cls
echo 
echo  [ 윈도우 방화벽 ]
echo 
echo 
echo  정상적으로 적용되었습니다.
echo 
pause
goto main
:ctna
@echo off&mode con cols=74 lines=21
cls
echo 
echo  [ 원드라이브(OneDrive) / 코타나(Cortana) 제거하기 ]
echo 
echo  [1] 원드라이브(OneDrive) 제거하기
echo  [2] 코타나(Cortana) 제거하기
echo  [3] 매인 메뉴로 가기
echo 
set menu=
set /p menu= [ 원하시는 작업 번호를 입력 후 엔터(Enter)키를 눌러주세요 ] :
if "%menu%" == "1" goto onedi
if "%menu%" == "2" goto cordi
if "%menu%" == "3" goto main
goto ctna
:onedi
@echo off&mode con cols=74 lines=39
netsh advfirewall set allprofiles state on
cls
set x86="%SYSTEMROOT%\System32\OneDriveSetup.exe"
set x64="%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe"
echo 
echo  원드라이브(OneDrive) 제거가 시작됩니다...
echo 
taskkill /f /im OneDrive.exe > NUL 2>&1
ping 127.0.0.1 -n 5 > NUL 2>&1
echo 
echo  OneDrive 관련 프로세스 닫는 중... (조금 오래 걸릴 수 있습니다)
echo 
if exist %x64% (
%x64% /uninstall
) else (
%x86% /uninstall
)
ping 127.0.0.1 -n 5 > NUL 2>&1
echo 
echo  OneDrive 관련 파일 제거 중...
echo 
timeout /t 2 >nul
rd "%USERPROFILE%\OneDrive" /Q /S > NUL 2>&1
rd "C:\OneDriveTemp" /Q /S > NUL 2>&1
rd "%LOCALAPPDATA%\Microsoft\OneDrive" /Q /S > NUL 2>&1
rd "%PROGRAMDATA%\Microsoft OneDrive" /Q /S > NUL 2>&1
echo 
echo  OneDrive 관련 레지스트리 정보 제거 중...
echo 
timeout /t 2 >nul
REG DELETE "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > NUL 2>&1
echo 
echo  OneDrive를 정상적으로 제거하였습니다!
echo 
pause
goto ctna
:cordi
@echo off&mode con cols=74 lines=25
netsh advfirewall set allprofiles state off
cls
echo 
echo  코타나(Cortana) 제거가 시작됩니다...
echo 
echo 
echo  Cortana 제거 중...
echo 
powershell "Get-AppxPackage -allusers Microsoft.549981C3F5F10 | Remove-AppxPackage"
timeout /t 2 >nul
echo 
echo  Cortana를 정상적으로 제거하였습니다!
echo 
pause
goto ctna
:push
@echo off&mode con cols=74 lines=21
cls
echo 
echo  [ 윈도우 알림센터 ]
echo 
echo  [1] 윈도우 알림센터 활성화
echo  [2] 윈도우 알림센터 비활성화
echo  [3] 매인 메뉴로 가기
echo 
set menu=
set /p menu= [ 원하시는 작업 번호를 입력 후 엔터(Enter)키를 눌러주세요 ] :
if "%menu%" == "1" goto pushon
if "%menu%" == "2" goto pushoff
if "%menu%" == "3" goto main
goto push
:pushon
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /v "ToastEnabled" /t REG_DWORD /d "1" /f
cls
echo 
echo  [ 윈도우 알림센터 ]
echo 
echo 
echo  정상적으로 적용되었습니다. 시스템 재시작 후 반영됩니다.
echo 
pause
goto main
:pushoff
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /v "ToastEnabled" /t REG_DWORD /d "0" /f
cls
echo 
echo  [ 윈도우 알림센터 ]
echo 
echo 
echo  정상적으로 적용되었습니다. 시스템 재시작 후 반영됩니다.
echo 
pause
goto main
:pwcf
@echo off&mode con cols=74 lines=21
cls
echo 
echo  [ 전원 옵션 ]
echo 
echo  [1] 균형 조정
echo  [2] 고성능 (권장)
echo  [3] 매인 메뉴로 가기
echo 
set menu=
set /p menu= [ 원하시는 작업 번호를 입력 후 엔터(Enter)키를 눌러주세요 ] :
if "%menu%" == "1" goto bal
if "%menu%" == "2" goto per
if "%menu%" == "3" goto main
goto pwcf
:bal
POWERCFG -SETACTIVE 381b4222-f694-41f0-9685-ff5bb260df2e
POWERCFG /Change /standby-timeout-ac 0
POWERCFG /Change /disk-timeout-ac 0
cls
echo 
echo  [ 전원 옵션: 균형 조정 ]
echo 
echo 
echo  정상적으로 적용되었습니다.
echo 
pause
goto main
:per
POWERCFG -SETACTIVE 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
POWERCFG /Change /standby-timeout-ac 0
POWERCFG /Change /disk-timeout-ac 0
cls
echo 
echo  [ 전원 옵션 : 고성능 ]
echo 
echo 
echo  정상적으로 적용되었습니다.
echo 
pause
goto main
:economy
@echo off&mode con cols=74 lines=21
cls
echo 
echo  [ 최대 절전 모드 ]
echo 
echo  [1] 최대 절전 모드 켜기
echo  [2] 최대 절전 모드 끄기 (권장)
echo  [3] 매인 메뉴로 가기
echo 
set menu=
set /p menu= [ 원하시는 작업 번호를 입력 후 엔터(Enter)키를 눌러주세요 ] :
if "%menu%" == "1" goto make
if "%menu%" == "2" goto delete
if "%menu%" == "3" goto main
goto economy
:make
powercfg -h on
cls
echo 
echo  [ 최대 절전 모드 ]
echo 
echo 
echo  정상적으로 적용되었습니다.
echo 
pause
goto main
:delete
powercfg -h off
cls
echo 
echo  [ 최대 절전 모드 ]
echo 
echo 
echo  정상적으로 적용되었습니다.
echo 
pause
goto main
:rightmenu
@echo off&mode con cols=74 lines=25
cls
echo 
echo  [ 우클릭 메뉴 ]
echo 
echo  [1] 윈11 우클릭 메뉴 전통방식으로 변경하기 (권장)
echo  [2] 윈11 우클릭 메뉴 기본방식으로 되돌리기
echo  [3] 우클릭 메뉴 "제어판" 보이기 (권장)
echo  [4] 우클릭 메뉴 "제어판" 감추기
echo  [5] 매인 메뉴로 가기
echo 
set menu=
set /p menu= [ 원하시는 작업 번호를 입력 후 엔터(Enter)키를 눌러주세요 ] :
if "%menu%" == "1" goto righta11
if "%menu%" == "2" goto rightd11
if "%menu%" == "3" goto rightadd
if "%menu%" == "4" goto rightdel
if "%menu%" == "5" goto main
goto rightmenu
:righta11
reg add "HKEY_CURRENT_USER\SOFTWARE\CLASSES\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /t REG_SZ /f
reg add "HKEY_CURRENT_USER\SOFTWARE\CLASSES\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /t REG_SZ /d "" /f
cls
echo 
echo  [ 윈11 우클릭 메뉴 전통방식으로 변경하기 ]
echo 
echo 
echo  윈도우 재시작후 정상적으로 적용됩니다.
echo 
pause
goto main
:rightd11
reg delete "HKEY_CURRENT_USER\SOFTWARE\CLASSES\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f
cls
echo 
echo  [ 윈11 우클릭 메뉴 기본방식으로 되돌리기 ]
echo 
echo 
echo  정상적으로 적용되었습니다.
echo 
pause
goto main
:rightadd
reg add "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Control Panel" /t REG_SZ /d "제어판" /f
reg add "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Control Panel" /v "icon" /t REG_SZ /d "Control.exe" /f
reg add "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Control Panel\command" /t REG_SZ /d "Control.exe" /f
cls
echo 
echo  [ 우클릭 메뉴 "제어판" 보이기 ]
echo 
echo 
echo  정상적으로 적용되었습니다.
echo 
pause
goto main
:rightdel
reg delete "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Control Panel" /f
cls
echo 
echo  [ 우클릭 메뉴 "제어판" 감추기 ]
echo 
echo 
echo  정상적으로 적용되었습니다.
echo 
pause
goto main
:ub
start %~dp0remiz\ub\Wub.exe
goto main
:ba
start %~dp0remiz\ba\ba.exe
goto main
:antion
start %~dp0remiz\de\dControl.exe
goto main
:admin
@echo off&mode con cols=74 lines=21
cls
echo 
echo  [ 최고 관리자(Administrator) 계정 관리 ]
echo 
echo  [1] Administrator 최고 관리자 계정 활성화 하기
echo  [2] 활성화된 Administrator 최고 관리자 계정 비활성화 하기
echo  [3] 매인 메뉴로 가기
echo 
set menu=
set /p menu= [ 원하시는 작업 번호를 입력 후 엔터(Enter)키를 눌러주세요 ] :
if "%menu%" == "1" goto a
if "%menu%" == "2" goto b
if "%menu%" == "3" goto main
goto admin
:a
net user administrator /active:yes
cls
echo 
echo  [ 최고 관리자(Administrator) 계정 관리 ]
echo 
echo 
echo  정상적으로 적용되었습니다.
echo 
pause
goto main
:b
net user Administrator /active:no
cls
echo 
echo  [ 최고 관리자(Administrator) 계정 관리 ]
echo 
echo 
echo  정상적으로 적용되었습니다.
echo 
pause
goto main
:sys
@echo off&mode con cols=74 lines=21
cls
echo 
echo  [ 시스템 정보 화면으로 변경하기 ]
echo 
echo  [1] 이전 시스템 정보 화면으로 변경하기 (기존 시스템 정보 화면)
echo  [2] 새로운 시스템 정보 화면으로 변경하기 (20H2 부터 바뀐 새 화면)
echo  [3] 매인 메뉴로 가기
echo 
set menu=
set /p menu= [ 원하시는 작업 번호를 입력 후 엔터(Enter)키를 눌러주세요 ] :
if "%menu%" == "1" goto osy
if "%menu%" == "2" goto nsy
if "%menu%" == "3" goto main
goto sys
:osy
@cd /d %~dp0remiz\ti
@if /i "%PROCESSOR_ARCHITECTURE%"=="x86" (set bit=x86) else (set bit=x64)
@if exist %bit%\remiz.exe path %bit%\;%path%
remiz.exe -U:T reg.exe add HKLM\SYSTEM\ControlSet001\Control\FeatureManagement\Overrides\0\2093230218 /v EnabledState /t REG_DWORD /d "1" /f
cls
echo 
echo  [ 시스템 정보 화면으로 변경하기 ]
echo 
echo 
echo  정상적으로 변경되었습니다. 시스템 재시작 후 반영됩니다.
echo 
pause
goto main
:nsy
@cd /d %~dp0remiz\ti
@if /i "%PROCESSOR_ARCHITECTURE%"=="x86" (set bit=x86) else (set bit=x64)
@if exist %bit%\remiz.exe path %bit%\;%path%
remiz.exe -U:T reg.exe add HKLM\SYSTEM\ControlSet001\Control\FeatureManagement\Overrides\0\2093230218 /v EnabledState /t REG_DWORD /d "2" /f
cls
echo 
echo  [ 시스템 정보 화면으로 변경하기 ]
echo 
echo 
echo  정상적으로 변경되었습니다. 시스템 재시작 후 반영됩니다.
echo 
pause
goto main
:edi
@echo off&mode con cols=74 lines=25
cls
echo 
echo  [ 윈도우10 에디션 변환하기 ]
echo 
echo  [1] Professional 에디션으로 변환
echo  [2] Professional Workstation 에디션으로 변환
echo  [3] Education 에디션으로 변환
echo  [4] Enterprise 에디션으로 변환
echo  [5] 매인 메뉴로 가기
echo 
set menu=
set /p menu= [ 변환하실 에디션을 선택해주세요 ] :
if "%menu%" == "1" goto fpro
if "%menu%" == "2" goto fwork
if "%menu%" == "3" goto fedu
if "%menu%" == "4" goto fent
if "%menu%" == "5" goto main
goto edi
:fpro
cscript /nologo %SystemRoot%\System32\slmgr.vbs /ipk VK7JG-NPHTM-C97JM-9MPGT-3V66T > nul
echo 
echo  Pro 에디션으로 변경되었습니다. 시스템 재시작 후 반영됩니다.
echo 
pause
goto main
:fwork
cscript /nologo %SystemRoot%\System32\slmgr.vbs /ipk DXG7C-N36C4-C4HTG-X4T3X-2YV77> nul
echo 
echo  Pro Work 에디션으로 변경되었습니다. 시스템 재시작 후 반영됩니다.
echo 
pause
goto main
:fedu
cscript /nologo %SystemRoot%\System32\slmgr.vbs /ipk YNMGQ-8RYV3-4PGQ3-C8XTP-7CFBY > nul
echo 
echo  Edu 에디션으로 변경되었습니다. 시스템 재시작 후 반영됩니다.
echo 
pause
goto main
:fent
cscript /nologo %SystemRoot%\System32\slmgr.vbs /ipk XGVPP-NMH47-7TTHJ-W3FW7-8HV2C > nul
echo 
echo  Ent 에디션으로 변경되었습니다. 시스템 재시작 후 반영됩니다.
echo 
pause
goto main
:wx
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f
cls
echo 
echo  Windows10의 개인 정보 수집 기능을 비활성화 중입니다...
echo 
timeout /t 2 >nul
echo 
echo  Windows10의 개인 정보 수집 기능이 정상적으로 비활성화 되었습니다!
echo 
pause
goto main
