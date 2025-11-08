@echo off
:: if ur paths are not same as mine make sure they look same

set sounduxPath=C:\Program Files (x86)\Soundux\
set sounduxExe=soundux.exe

set obsPath=C:\Program Files\obs-studio\bin\64bit\
set obsExe=obs64.exe

:: bot token doesnt need any permissions

set botToken=12345

echo 1 - Webhook spammer
echo 2 - Webhook deleter
echo 3 - Webhook checker
echo 4 - Run Soundux
echo 5 - Run OBS
echo 6 - List of temp mail websites
echo 7 - Invite checker
echo 8 - User checker (must have bot token)
echo.
echo 111 - Clear console
echo 1111 - Exit
echo.

:main

set /p choice=Enter an number: 
echo.

if %choice% == 1 goto :spammer
if %choice% == 2 goto :deleter
if %choice% == 3 goto :checker
if %choice% == 4 goto :soundux
if %choice% == 5 goto :obs
if %choice% == 6 goto :tempMail
if %choice% == 7 goto :serverChecker
if %choice% == 8 goto :userChecker

if %choice% == 111 cls
if %choice% == 1111 exit

:error
echo Error
echo.
goto :main

:checker
set /p webhook=Webhook: 
echo.
curl %webhook%
echo.
goto :main

:deleter
set /p webhook=Webhook: 
echo.
curl -X DELETE %webhook%
echo.
goto :main

:spammer
set /p webhook=Webhook: 
set /p username=Username: 
set /p message=Message: 
set /p amount=Amount: 
set /p delay=Delay: 

for /l %%x in (1, 1, %amount%) do (
   timeout /t %delay% /nobreak >nul
   curl -H "Content-Type: application/json" -d "{\"username\": \"%username%\", \"content\":\"%message%\"}" %webhook%
)

echo.
goto :main

:soundux
cd "%sounduxPath%"
start "" "%sounduxPath%%sounduxExe%"
goto :main

:obs
cd "%obsPath%"
start "" "%obsPath%%obsExe%"
goto :main

:tempMail

echo temp-mail.org
set /p choice=Open in browser? (Y/n): 
if %choice% == Y start "" "https://www.temp-mail.org/"

echo.

echo eztempmail.com
set /p choice=Open in browser? (Y/n): 
if %choice% == Y start "" "https://www.eztempmail.com/"

echo.
goto :main

:serverChecker
set /p invite=Server invite code: 
echo.
curl https://discord.com/api/v10/invites/%invite%
echo.
goto :main

:userChecker
set /p userID=User ID: 
echo.
curl -H "Authorization: Bot %botToken%" https://discordapp.com/api/v9/users/%userid%
echo.
goto :main

echo Are you sure you want to exit?
pause >nul
exit