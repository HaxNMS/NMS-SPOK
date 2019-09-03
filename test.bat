@echo off
setlocal

call "%~dp0\devenv.bat" --quiet || goto :End

call pak-dev.bat PAK || goto :End
call scripts\pak\install.bat "%PAK%" || goto :End

"%NMS_PATH%\Binaries\NMS.exe"

goto :End

:End
    exit /b
