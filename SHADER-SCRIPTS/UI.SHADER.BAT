@echo off
setlocal EnableDelayedExpansion

set SRC_DIR=SHADERS\CODE
set DST_DIR=GAMEDATA\SHADERS\CODE\BIN\PC

set SRC=%SRC_DIR%\IMMEDIATEMODEVERTEX.SHADER.H
call glsl-x-spv.bat "%SRC%" "%DST_DIR%" "UI" "VERT" "UI"              "0" -DD_TEX_QUAD -DD_UI         || goto :fail
call glsl-x-spv.bat "%SRC%" "%DST_DIR%" "UI" "VERT" "SCREENEFFECT"    "0" -DD_TEX_QUAD -DD_UI         || goto :fail
call glsl-x-spv.bat "%SRC%" "%DST_DIR%" "UI" "VERT" "SCREENEFFECT_VR" "0" -DD_TEX_QUAD -DD_UI -DD_LUT || goto :fail

set SRC=%SRC_DIR%\FULLSCREEN\UIFRAGMENT.SHADER.H
call glsl-x-spv.bat "%SRC%" "%DST_DIR%" "UI" "FRAG COMP" "UI"              "0" -DD_UI                                       || goto :fail
call glsl-x-spv.bat "%SRC%" "%DST_DIR%" "UI" "FRAG COMP" "SCREENEFFECT"    "0" -DD_SCREENEFFECT                             || goto :fail
call glsl-x-spv.bat "%SRC%" "%DST_DIR%" "UI" "FRAG COMP" "SCREENEFFECT_VR" "0" -DD_SCREENEFFECT -DD_SCREENEFFECT_VR -DD_LUT || goto :fail

:pass
    echo]
    echo]Success
    echo]
    goto :end

:fail
    echo]
    echo]Failed^^!
    echo]
    goto :end

:end
    exit /b
