@echo off
setlocal

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

if "%~1"=="/q" goto :End
if "%~1"=="/Q" goto :End

cmd /K "@title Hax Shader Development Environment"

:End