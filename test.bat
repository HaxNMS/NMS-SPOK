@echo off
setlocal

call pak-dev.bat PAK || goto :end

call scripts\install-pak.bat "%PAK%" || goto :end

"%NMS_PATH%\Binaries\NMS.exe"

goto :end

:end
