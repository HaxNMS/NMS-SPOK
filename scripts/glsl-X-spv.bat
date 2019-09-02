@echo off
setlocal enabledelayedexpansion

rem glsl-x-spv  "PSTREAM.SHADER.H"
rem             -DD_VERTEX
rem             -DD_PSTREAM
rem             -DD_PSTREAM_STARS
rem > "PSTREAM_VERT_PSTREAM_STARS_0.SPV"

rem glslc -std=450
rem       -I "SHADERS/CODE"
rem       -fauto-bind-uniforms
rem       -fauto-map-locations
rem       -DD_PLATFORM_PC
rem       -DD_SAMPLERS_ARE_GLOBAL
rem       -fshader-stage=vertex -DD_VERTEX
rem       -DD_PSTREAM -DD_PSTREAM_STARS
rem       "SHADERS\CODE\PSTREAM.SHADER.H"
rem > "BIN\PSTREAM_VERT_PSTREAM_STARS_0.SPV"

set SRC=%~1

set OPTIONS=-std=450 -fauto-bind-uniforms -fauto-map-locations
set INCLUDES=-I "SHADERS/CODE"
set DEFINES=-DD_PLATFORM_PC -DD_SAMPLERS_ARE_GLOBAL

call :get-defines %*

echo DEFINES="%DEFINES%"

set BIN_PATH="BIN"

set GLSLC=glslc.exe -std=450
set GLSLC=%GLSLC% -fauto-bind-uniforms -fauto-map-locations
set GLSLC=%GLSLC% -I "SHADERS/CODE"
set GLSLC=%GLSLC% -DD_PLATFORM_PC -DD_SAMPLERS_ARE_GLOBAL

set FRAG=-fshader-stage=frag -DD_FRAGMENT
set VERT=-fshader-stage=vert -DD_VERTEX

goto end

:get-defines
    rem shift && rem discard the cmd path
    shift && rem discard the src arg
    :next-define
        if "%~1"=="" exit /b
        rem call :get-stage %~1
        set DEFINES=%DEFINES% %~1
        shift
        goto next-define
    exit /b

:get-stage
    exit /b

:end
    exit /b