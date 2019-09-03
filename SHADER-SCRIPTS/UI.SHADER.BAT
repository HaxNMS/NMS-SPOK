@echo off
setlocal EnableDelayedExpansion

pushd "%~dp0\..\"
call "devenv.bat" --quiet || goto :End

set SRC_DIR=SHADERS\CODE
set DST_DIR=GAMEDATA\SHADERS\CODE\BIN\PC

set SRC=%SRC_DIR%\IMMEDIATEMODEVERTEX.SHADER.H

set DCONTEXT=-DD_TEX_QUAD -DD_UI
call glsl-x-spv.bat "%SRC%" "%DST_DIR%" "UI" "VERT" "UI"              "0" %DCONTEXT% || goto :End
call glsl-x-spv.bat "%SRC%" "%DST_DIR%" "UI" "VERT" "SCREENEFFECT"    "0" %DCONTEXT% || goto :End

set DCONTEXT=-DD_TEX_QUAD -DD_UI -DD_LUT
call glsl-x-spv.bat "%SRC%" "%DST_DIR%" "UI" "VERT" "SCREENEFFECT_VR" "0" %DCONTEXT% || goto :End

set SRC=%SRC_DIR%\FULLSCREEN\UIFRAGMENT.SHADER.H

set DCONTEXT=-DD_UI
call glsl-x-spv.bat "%SRC%" "%DST_DIR%" "UI" "FRAG" "UI"              "0" %DCONTEXT% || goto :End
call glsl-x-spv.bat "%SRC%" "%DST_DIR%" "UI" "COMP" "UI"              "0" %DCONTEXT% || goto :End

set DCONTEXT=-DD_SCREENEFFECT
call glsl-x-spv.bat "%SRC%" "%DST_DIR%" "UI" "FRAG" "SCREENEFFECT"    "0" %DCONTEXT% || goto :End
call glsl-x-spv.bat "%SRC%" "%DST_DIR%" "UI" "COMP" "SCREENEFFECT"    "0" %DCONTEXT% || goto :End

set DCONTEXT=-DD_SCREENEFFECT -DD_SCREENEFFECT_VR -DD_LUT
call glsl-x-spv.bat "%SRC%" "%DST_DIR%" "UI" "FRAG" "SCREENEFFECT_VR" "0" %DCONTEXT% || goto :End
call glsl-x-spv.bat "%SRC%" "%DST_DIR%" "UI" "COMP" "SCREENEFFECT_VR" "0" %DCONTEXT% || goto :End

goto :End

:End
    popd
    exit /b
