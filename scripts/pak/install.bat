@echo off
setlocal

call "%~dp0\..\..\devenv.bat" --quiet || goto :End

set PAK=%~1

del /q "%MOD_PATH%\%PAK%*.pak" 1>nul 2>&1
copy "%PAK%*.pak" "%MOD_PATH%\" 1>nul 2>&1

:End
    exit /b