@echo off
:: include guard
call :IsSet INCLUDE_DEVENV && goto :End
set INCLUDE_DEVENV=1

:: if the first argument is -Q or --QUIET
set _OPT_QUIET_=%~1
call :GetOption _OPT_QUIET_ -Q --QUIET && shift
call :IsSet _OPT_QUIET_ || setlocal

set NMS_PATH=U:\SteamLibrary\steamapps\common\No Man's Sky
set MOD_PATH=%NMS_PATH%\GAMEDATA\PCBANKS\MODS

set HAXTOOLS=%~dp0\modules\HaxTools

set PATH=%PATH%;%~dp0\scripts
set PATH=%PATH%;%HAXTOOLS%
set PATH=%PATH%;%HAXTOOLS%\bin
set PATH=%PATH%;%~dp0\modules\google-shaderc\bin

call :IsSet _OPT_QUIET_ && goto :End

set _TITLE_=NMS Shader Development Kit
cmd /K "@title %_TITLE_%&@echo]%_TITLE_%&echo]"

:GetOption
    :: set "VAR=%~1" & set "SHORT=%~2" & set "LONG=%~3"
    call "%~dp0\scripts\common\to-upper.bat" %1
    call set VAL=%%%1%%
    if "%VAL%"=="%2" set %1=%3
    if not "%VAL%"=="%3" set %1=
    set VAL=
    call :IsSet %1
    exit /b

:IsSet
    set %~1 1>nul 2>&1
    exit /b

:End
    set _OPT_QUIET_=
    set _TITLE_=
    exit /b