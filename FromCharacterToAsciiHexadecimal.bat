@REM SVN-Id: $$Id:$$
@REM SVN-Url: $$HeadURL: $$
@echo off
setlocal EnableDelayedExpansion

REM #############################################################################
REM # Configure Merge Environment Parameters
REM #############################################################################

set input=%1
set output=%2

rem from character to ascii in decmial 
set target=%input:~0,1%
set Chr=-
 
    for /L %%i in (32, 1, 126) do (
        rem cmd /c exit /b %%i
        call FromAsciiToCharacter.bat %%i Chr
        rem set Chr=^!=ExitCodeAscii!
        if [^!Chr!] EQU [^!target!] set code=%%i & goto END
    )
goto :EOF
 
:END

rem from decimal to hexadecimal value
set LOOKUP=0123456789abcdef
set HEXSTR=
set PREFIX=

set /a A=%code% || exit /b 1
if !A! LSS 0 set /a A=0xfffffff + !A! + 1 & set PREFIX=f
:loop
set /a B=!A! %% 16 & set /a A=!A! / 16
set HEXSTR=!LOOKUP:~%B%,1!%HEXSTR%
if %A% GTR 0 Goto :loop
set "hexValue=%PREFIX%%HEXSTR%"
rem set "%2=%PREFIX%%HEXSTR%"

rem echo !code!
rem echo !hexValue!

endlocal & set %2=^%PREFIX%%HEXSTR%
rem pause