@echo off
setlocal

call "%~dp0\devenv.bat" --quiet || goto :End

set RESULT_VAR=%~1
call :SetProjectName PAK "%CD%"
del /q "%PAK%*.pak" 1>nul 2>&1

call PSARC_PACK_DEV.BAT GAMEDATA

goto :End

:SetProjectName
    set "%~1=%~n2"
    exit /b

:End
    if not "%RESULT_VAR%"=="" endlocal && set "%~1=%PAK%"
    exit /b