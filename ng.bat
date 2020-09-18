@echo off
SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)

@echo off
if [%1]==[] goto BadCommand
@echo off
if "%~1"=="build" (goto CustomBuild) else goto SomeOtherCommand

:CustomBuild
@echo.
call :ColorText 0b "Lets check for Code Quality."
@echo.
node --max_old_space_size=8192 ./node_modules/@angular/cli/bin/ng lint

@echo.
call :ColorText 0a "Good Code, Now Building Project, This may take some time, so sit back and relax.."
@echo.
node --max_old_space_size=8192 ./node_modules/@angular/cli/bin/ng build %2
goto Credits

:BadCommand
call :ColorText 0C "BAD COMMAND   %0 Can not be used alone."
goto Credits

:SomeOtherCommand
call :ColorText 0b "Executing %1 Command, Please Wait.."
@echo.
node --max_old_space_size=8192 ./node_modules/@angular/cli/bin/ng %1
goto Credits

:ColorText
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
goto :eof

:Credits
@echo.
@echo.
call :ColorText 19 "-"
call :ColorText 2F "Thanks For Using"
call :ColorText 4e "CUSTOM NG"
call :ColorText 19 "-"
@echo.
@echo.
@echo off
exit /B 1
