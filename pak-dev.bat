@echo off

call :set-project-name PAK "%CD%"

del /q "%PAK%*.pak" 1>nul 2>&1
call PSARC_PACK_DEV.BAT GAMEDATA

goto :end

:set-project-name
    set "%~1=%~n2"
    exit /b

:end
    exit /b