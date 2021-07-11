@echo off
color 0a
title Quota OS 1.0-ALPHA-003

:desktop
cls
if %username%==guest goto desktopguest
type user\%username%\background\bg.txt
echo.
echo     Welcome to QuotaOS
echo.
echo        User: %username%
echo 1       Go to Apps
echo 2     About QuotaOS
echo 3     Exit QuotaOS
echo 4    System Settings
echo 5     Reboot system
echo 6       Add User
set/p "choose1=Choose:"
if %choose1%==1 goto apps
if %choose1%==2 goto about
if %choose1%==3 goto quit
if %choose1%==4 goto settings
if %choose1%==5 goto restart
if %choose1%==6 goto usradd

:desktopguest
cls
type user\default\background\bg.net
echo.
echo     Welcome to QuotaOS
echo.
echo       Guest Session
echo 1       Go to Apps
echo 2     About QuotaOS
echo 3     Exit QuotaOS
echo 4       Add User
echo 5       Log Out
set/p "choose4=Choose:"
if %choose4%==1 goto apps
if %choose4%==2 goto about
if %choose4%==3 goto quit
if %choose4%==4 goto usraddg
if %choose4%==5 login.bat
goto desktopguest


:usraddg
cls
echo.
set/p "user-add=What username?"
set/p "pass-add-g=What password?"
echo useradd **GUEST** :%username-add%,%pass-add%>>login-add.net
goto desktop

:usradd
cls
echo.
echo Checking your permissions...
if %username%==guest goto usraddg
if %username%==admin goto usraddv
if %username%==qlog goto usraddv
if not %username%==quota goto usradde
if not %username%==admin goto usradde

:usradde
cls
echo.
echo You are not a admin user!
echo.
echo Press any key to go back to the desktop.
pause >nul
goto desktop

:usraddv
cls
echo.
echo Add a user!
echo.
echo Note: you will have to contact a admin to get
echo your account added to the accounts list.
echo.
set/p "username-add=What username? "
set/p "pass-add=What password? "
echo useradd:%username-add%,%pass-add%>>login-add.net
echo.
echo Press any key to go back to your desktop.
pause >nul
goto desktop

:restart
cd system
reboot.bat

:quit
cd system\zorg\images\maven\filetype\netfiles\system
cls
type shutdown.net
ping localhost-n 3 nul
exit

:about
cls
type system\zorg\images\maven\filetype\netfiles\system\about.net
pause>nul
goto desktop

:settings
cls
echo /#####################################\
echo ######## System settings ##############
echo \#####################################/
echo.
echo 1.Change system colors
echo 2.Go to desktop
echo 3.Open wallpaper folder
set/p "choose2=Choose:"
if %choose2%==1 goto colors
if %choose2%==2 goto desktop
if %choose2%==3 goto wallfolder

:wallfolder
start c:\windows\explorer.exe user\%username%\background
goto desktop

:colors
cls
set/p "colors=Type colors value:"
echo Applying changes...
ping localhost-n 5 nul
color %colors%
goto desktop

:apps
cls
cd soft
echo     Apps:
type applist.net
echo.
echo or type: softapp to open your downloaded apps.
set/p "softname=Type app name to run:"
if %softname%==softapp goto sapps
start %softname%.bat
cd..
goto desktop

:sapps
cls
cd ..
cd user
cd %username%
cd download
set/p "softname=Type downloaded app name to run:"
if %softname%==softapp goto sapps
start %softname%.bat
cd..
goto desktop