@echo off
:: include guard
call :IsSet INCLUDE_DEVENV && goto :End
set INCLUDE_DEVENV=1

:: if the first argument is -Q or ---QUIET
set _ARG_=%~1
call "%~dp0\scripts\common\to-upper.bat" _ARG_
set _OPT_QUIET=&rem unset
if "%_ARG_%"=="-Q"      set _OPT_QUIET_=1
if "%_ARG_%"=="--QUIET" set _OPT_QUIET_=1
set _ARG_=

call :IsSet _OPT_QUIET_ && shift
call :IsSet _OPT_QUIET_ || setlocal

set NMS_PATH=U:\SteamLibrary\steamapps\common\No Man's Sky
set MOD_PATH=%NMS_PATH%\GAMEDATA\PCBANKS\MODS

set NMSTools=X:\Media\Games\No Mans Sky\Tools
set HaxTools=%NMSTools%\HaxTools

set MBINC_PATH=X:\Media\Games\No Mans Sky\Tools\MBINCompiler\Build\Release

set PATH=%PATH%;%HaxTools%;%HaxTools%\bin
set PATH=%PATH%;%NMSTools%\google-shaderc\bin
set PATH=%PATH%;%MBINC_PATH%
set PATH=%PATH%;%~dp0%\scripts

doskey mbinc=MBINCompiler.exe $*

call :IsSet _OPT_QUIET_ && goto :End

set _TITLE_=NMS Shader Development Kit
cmd /K "@title %_TITLE_%&@echo]%_TITLE_%&echo]"

:IsSet
    set %~1 1>nul 2>&1
    exit /b

:End
    set _OPT_QUIET_=
    set _TITLE_=
    exit /b