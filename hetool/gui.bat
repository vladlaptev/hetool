cd %~dp0
echo off
:start
cls
echo [0;1;36;40m
echo    __  __     ______     ______   ______     ______     __        
echo   /\ \_\ \   /\  ___\   /\__  _\ /\  __ \   /\  __ \   /\ \       
echo   \ \  __ \  \ \  __\   \/_/\ \/ \ \ \/\ \  \ \ \/\ \  \ \ \____  
echo    \ \_\ \_\  \ \_____\    \ \_\  \ \_____\  \ \_____\  \ \_____\ 
echo     \/_/\/_/   \/_____/     \/_/   \/_____/   \/_____/   \/_____/
echo [0;1;36;40m
echo                      ver 1.3 (september 2015)
echo [1;33;40m
echo ============================Register and Login============================[0;1;32;40m
echo 10 - Register accs from list            11 - Add contact to friends 
echo      (register.txt)                          from addcontact.txt       
echo 13 - Login to all accounts![1;33;40m
echo ============================Working with IP list==========================[0;1;32;40m
echo 1 - Create IP list (ping.log)           2 - Delete IP list 
echo 3 - Generate CSV (if IP list created)   4 - Upload spam to IP list [1;33;40m
echo ================================Operations================================[0;1;32;40m
echo 5 - Clear all processes                 6 - Send BTC to contact
echo 7 - Bypass'n'Crack from list(proc.log)  8 - Buy soft
echo 9 - Take money from hacked IP's         0 - Collect money from other accs
echo 90- Send [1;33;40m
echo ===================================Other==================================[0;1;32;40m
echo 20 - Ip2Id                              21 - Crack bank
echo 12 - Account info                       22 - Crack from IP list(ping.log)
echo     (Spam info, money, processes, etc)  23 - Crack Firewall
echo                                         25 - Download victim's log
echo                                         26 - Write to victim's log
echo 666 - README!   [1;33;40m
echo ===========================================================================
echo [0m
set /p var="Option: "
echo.

if %var% equ 1 goto first
if %var% equ 2 goto rmfile
if %var% equ 3 goto second
if %var% equ 4 goto third
if %var% equ 5 goto four
if %var% equ 6 goto five
if %var% equ 7 goto borc
if %var% equ 8 goto purch
if %var% equ 9 goto hb
if %var% equ 0 goto sendmonFromContacts
if %var% equ 10 goto reg
if %var% equ 11 goto addcon
if %var% equ 12 goto getinfo
if %var% equ 13 goto autoLogin
if %var% equ 90 goto roboBuy
if %var% equ 91 goto sendmoney
if %var% equ 20 goto ip2id
if %var% equ 21 goto usersoft
if %var% equ 22 goto usersoft2
if %var% equ 23 goto hackFirewall
if %var% equ 25 goto getUserLog
if %var% equ 26 goto logUpdate
if %var% equ 666 goto readme
if %var% equ 999 goto test

cls
echo "%var%" is not a valid option.
echo.
goto start

:autoLogin
cls
ruby gui.rb add autoLogin
pause
goto start

:test
cls
ruby gui.rb add test
pause
goto start

:getUserLog
cls
set /p var="ID: "
ruby gui.rb add getUserLog %var%
pause
goto start

:readme
cls
type readme.txt
pause
goto start

:logUpdate
cls
set /p var="ID: "
set /p var2="Text: "
ruby gui.rb add logUpdate %var% %var2%
pause
goto start

:hackFirewall
cls
set /p var="ID: "
ruby gui.rb add hackFirewall %var%
pause
goto start

:usersoft2
cls
ruby gui.rb add usersoft2
pause
goto start

:usersoft
cls
set /p var="ID: "
ruby gui.rb add usersoft %var%
pause
goto start

:roboBuy
cls
echo [1;37;46m==========================
echo [1;33;40m0 = 'Network'
echo [1;32;40m1 = 'Firewall'
echo [1;33;40m2 = 'Bypasser'
echo [1;32;40m3 = 'Password Cracker'
echo [1;33;40m4 = 'Password Encryptor'
echo [1;32;40m5 = 'Antivirus'
echo [1;33;40m6 = 'Spam'
echo [1;32;40m7 = 'Spyware'
echo [1;33;40m8 = 'Notepad'
echo [1;32;40m9 = 'Device'
echo [1;37;46m==========================[0m
set /p var2="Send money: "
set /p var3="What software to buy: "
set /p var4="How many: "
ruby.exe gui.rb add roboBuy %var2% %var3% %var4%
pause
goto start

:ip2id
cls
set /p var="IP: "
ruby gui.rb add ip2id %var%
pause
goto start

:getinfo
ruby gui.rb add getinfo
pause
goto start

:addcon
ruby gui.rb add addcon
pause
goto start

:reg
ruby gui.rb add reg
pause
goto start

:sendmonFromContacts
ruby gui.rb add sendmonFromContacts
pause
goto start

:first
cls
set /p var="Count IP/5: "
ruby gui.rb add ping %var%
pause
goto start

:rmfile
del /Q "log\ping.log"
pause
goto start

:second
cls
set /p var3="user_id(y or n): "
set /p var5="Money > "
set /p var4="Password Encryptor < "
ruby gui.rb add CSV %var3% %var5% %var4%
pause
goto start

:third
cls
echo 1 - Upload spam from one account
echo 2 - Upload spam from many accounts(in file spam.txt)
set /p m="Option:"
if %m% equ 1 goto ss
if %m% equ 2 goto sm

:ss
cls
echo Upload spam from one account
set /p var="Spam Level: "
ruby gui.rb add spam %var%
echo Finish
pause
goto start

:sm
cls
echo Upload spam from many accounts
set /p var="Spam Level: "
ruby gui.rb add megaspam %var%
echo Finish
pause
goto start

:four
cls
echo 1 - Clear spam process in one account
echo 2 - Clear spam process in many accounts(in file spam.txt)
set /p m="Option:"
if %m% equ 1 goto cs
if %m% equ 2 goto cm

:cs
cls
echo Clear spam process in one account
ruby gui.rb add clean
pause
goto start

:cm
cls
echo Clear spam process in many accounts
ruby gui.rb add megaCleaner
pause
goto start

:five
cls
set /p var="IP: "
set /p var2="All/set amount(a/c): "
ruby.exe gui.rb add sendmon %var% %var2%
pause
goto start

:borc
cls
set /p var="Bypass/Crack(b/c): "
ruby gui.rb add borc %var%
pause
goto start

:purch
cls
echo [1;37;46m==========================
echo [1;33;40m0 = 'Network'
echo [1;32;40m1 = 'Firewall'
echo [1;33;40m2 = 'Bypasser'
echo [1;32;40m3 = 'Password Cracker'
echo [1;33;40m4 = 'Password Encryptor'
echo [1;32;40m5 = 'Antivirus'
echo [1;33;40m6 = 'Spam'
echo [1;32;40m7 = 'Spyware'
echo [1;33;40m8 = 'Notepad'
echo [1;32;40m9 = 'Device'
echo [1;37;46m==========================[0m
set /p var3="Buy: "
set /p var4="Quantity: "

ruby.exe gui.rb add purchase %var3% %var4%
pause
goto start

:hb
cls
ruby.exe gui.rb add getmonfromcrack
pause
goto start