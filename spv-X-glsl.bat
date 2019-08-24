@echo off
setlocal

set BIN_PATH=.\BIN
if not "%~1" == "" set BIN_PATH=%BIN_PATH%\%~1

for %%I in (%BIN_PATH%\*.SPV) do call :x-compile "%%I"

goto end

:x-compile
    spirv-cross "%~1" --reflect > "%~dpn1.JSON"
    spirv-cross "%~1"           > "%~dpn1.GLSL"
    exit /b
    
:end
    exit /b