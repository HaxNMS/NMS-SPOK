@echo off
setlocal EnableDelayedExpansion

pushd "%~dp0\..\"
call "devenv.bat" --quiet || goto :End

set SRC_DIR=SHADERS\CODE
set DST_DIR=GAMEDATA\SHADERS\CODE\BIN\PC

set SRC=%SRC_DIR%\PSTREAM.SHADER.H

set DCONTEXT=-DD_CARDS
call glsl-x-spv.bat "%SRC%" "%DST_DIR%" "PSTREAM" "VERT" "PSTREAM_CARDS" "0" %DCONTEXT% || goto :End
call glsl-x-spv.bat "%SRC%" "%DST_DIR%" "PSTREAM" "FRAG" "PSTREAM_CARDS" "0" %DCONTEXT% || goto :End

set DCONTEXT=-DD_PSTREAM -DD_PSTREAM_STARS
call glsl-x-spv.bat "%SRC%" "%DST_DIR%" "PSTREAM" "VERT" "PSTREAM_STARS" "0" %DCONTEXT% || goto :End
call glsl-x-spv.bat "%SRC%" "%DST_DIR%" "PSTREAM" "FRAG" "PSTREAM_STARS" "0" %DCONTEXT% || goto :End

set DCONTEXT=-DD_PSTREAM -DD_PSTREAM_STARS -DD_PSTREAM_SOLARSYSTEM
call glsl-x-spv.bat "%SRC%" "%DST_DIR%" "PSTREAM" "VERT" "PSTREAM_SYSTEM" "0" %DCONTEXT% || goto :End
call glsl-x-spv.bat "%SRC%" "%DST_DIR%" "PSTREAM" "FRAG" "PSTREAM_SYSTEM" "0" %DCONTEXT% || goto :End

set DCONTEXT=-DD_PSTREAM -DD_PSTREAM_FIELD
call glsl-x-spv.bat "%SRC%" "%DST_DIR%" "PSTREAM" "VERT" "PSTREAM_FIELD" "0" %DCONTEXT% || goto :End
call glsl-x-spv.bat "%SRC%" "%DST_DIR%" "PSTREAM" "FRAG" "PSTREAM_FIELD" "0" %DCONTEXT% || goto :End

goto :End

:End
    popd
    exit /b