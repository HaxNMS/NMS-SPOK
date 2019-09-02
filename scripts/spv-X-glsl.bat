@echo off

set ARG1=%~1
call "%~dp0\common\to-upper.bat" ARG1

set ENABLE_REFLECT=&rem unset
if "%ARG1%"=="-R"        set ENABLE_REFLECT=1
if "%ARG1%"=="--REFLECT" set ENABLE_REFLECT=1
set ENABLE_REFLECT && shift

:Next
    if "%~1"=="" goto :end
    for %%I in (%~1) do call :Decompile "%%~I" || goto :End
    shift & goto :Next

goto :End

:Decompile
    set ENABLE_REFLECT && spirv-cross "%~1" --reflect > "%~dpn1.JSON" || exit /b
    spirv-cross "%~1"           > "%~dpn1.GLSL" || exit /b
    exit /b
    
:End
    exit /b