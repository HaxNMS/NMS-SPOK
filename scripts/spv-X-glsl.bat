@echo off
setlocal EnableDelayedExpansion
call "%~dp0\..\devenv.bat" --quiet || goto :Error

:: if the first arg is -R or --REFLECT
set _ARG_=%~1
call "%~dp0\common\to-upper.bat" _ARG_
set _OPT_REFLECT_=&rem unset
if "%_ARG_%"=="-R"        set _OPT_REFLECT_=1
if "%_ARG_%"=="--REFLECT" set _OPT_REFLECT_=1
set _ARG_=

call :IsSet _OPT_REFLECT_ && shift

:Next
    if not "%~1"=="" (
        for %%I in (%~1) do call :Decompile "%%~I" || goto :Error
        shift & goto :Next
    )

goto :End

:Decompile
    set _OPT_REFLECT_ 1>nul 2>&1 || goto :Decompile-GLSL
    spirv-cross "%~1" --reflect > "%~dpn1.JSON" || exit /b
    :Decompile-GLSL
    spirv-cross "%~1"           > "%~dpn1.GLSL" || exit /b
    exit /b
    
:IsSet
    set %~1 1>nul 2>&1
    exit /b

:Error
    pause

:End
    exit /b