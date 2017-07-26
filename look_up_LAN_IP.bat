COLOR 0A
CLS
@ECHO Off
Title Looking up LAN IP
:send
@ECHO off&setlocal enabledelayedexpansion 
 
ECHO Getting local IP, please wait... 
for /f "tokens=3 skip=2 delims=: " %%i in ('nbtstat -n') do ( 
set "IP=%%i"
set IP=!IP:~1,-1! 
ECHO Localhost IP: !IP! 
goto :next 
)
 
:next 
for /f "delims=. tokens=1,2,3,4" %%i in ("%IP%") do set range=%%i.%%j.%%k 
ECHO.&ECHO Getting, please wait... 
ECHO Cuurent segment[%range%.*]computer:
for /f "delims=" %%i in ('net view') do ( 
set "var=%%i"
::Computer name
if "!var:~0,2!"=="\\" ( 
set "var=!var:~2!"
ECHO !var! 
ping -n 1 !var!>nul 
)) 
ECHO.
ECHO Getting ips, please wait... 
for /f "skip=3 tokens=1,* delims= " %%i in ('arp -a') do ECHO IP:  %%i up
 
ECHO.
ECHO Over, press to exit...
pause>nul