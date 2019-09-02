@echo off
setlocal

set PAK=%~1

del /q "%MOD_PATH%\%PAK%*.pak" 2>&1 > nul
copy "%PAK%*.pak" "%MOD_PATH%\" 2>&1 > nul
