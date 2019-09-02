@echo off

:upper-case
    call "%~dp0\to-case.bat" "%~1" "%%%%lo%%%%=%%%%up%%%%"
    exit /b
