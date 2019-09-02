@echo off
setlocal EnableDelayedExpansion

goto :Main

:Help
    echo]GLSL to SPIRV Compiler
    echo]
    echo]Syntax:
    echo]   %~nx0 "<SRC_FILE>" "<DST_DIR>" "<SHADER_NAME>" "<STAGE> [<STAGE>...]" "<CONTEXT>" "<FLAGSMASK>" ["<DEFINE>"...]
    echo]
    echo] ^<SRC_FILE^> ..... The source shader file to be compiled.
    echo] ^<DST_DIR^> ...... The directory where spirv output fles will be created.
    echo] ^<SHADER_NAME^> .. Used to construct the name of the output file.
    echo] ^<STAGE^> ........ At least one stage must be declared. Multiple stages can be declared in
    echo]                  the same argument, separated by spaces.
    echo]                  A shader program will be compiled foreach stage.
    echo]
    echo]                  Valid stages are: VERT FRAG HULL DOMN COMP
    echo]
    echo] ^<CONTEXT^> ...... Used to construct the name of the output file. The context corresponds
    echo]                  with certain defines being used. In the example above, the
    echo]                  "-DD_PSTREAM" and "-DD_PSTREAM_STARS" define the "PSTREAM_STARS" context.
    echo] ^<FLAGSMASK^> .... Used to construct the name of the output file. The flagsmask is a 64-bit
    echo]                  integer that represents a bitfield indicating which material flags are
    echo]                  defined for the shader variant. This value should match the _Fxx_ material
    echo]                  flags being defined^^!
    echo]
    echo]
    echo]Example:
    echo]   %~nx0 "PSTREAM.SHADER.H" "GAMEDATA\SHADERS\CODE\BIN\PC" "VERT FRAG" "PSTREAM_STARS" "0" "-DD_PSTREAM" "-DD_PSTREAM_STARS"
    echo]
    echo]Output Files:
    echo]   GAMEDATA\SHADERS\CODE\BIN\PC\PSTREAM_VERT_PSTREAM_STARS_0.SPV
    echo]   GAMEDATA\SHADERS\CODE\BIN\PC\PSTREAM_FRAG_PSTREAM_STARS_0.SPV
    echo]
    goto :End

:Main
    set "SRC=%~1"       && set "SRC"       1>nul 2>&1 || goto :Help
    set "DST_DIR=%~2"   && set "DST_DIR"   1>nul 2>&1 || goto :Help
    set "SHADER=%~3"    && set "SHADER"    1>nul 2>&1 || goto :Help
    set "STAGES=%~4"    && set "STAGES"    1>nul 2>&1 || goto :Help
    set "CONTEXT=%~5"   && set "CONTEXT"   1>nul 2>&1 || goto :Help
    set "FLAGSMASK=%~6" && set "FLAGSMASK" 1>nul 2>&1 || goto :Help

    set OPTIONS=-std=450 -fauto-bind-uniforms -fauto-map-locations
    set INCLUDES=-I "%~dp0\..\SHADERS\CODE"
    set DEFINES=-DD_PLATFORM_PC -DD_SPIRV

    set STAGE_VERT=-DD_VERTEX   -fshader-stage=vert
    set STAGE_FRAG=-DD_FRAGMENT -fshader-stage=frag
    set STAGE_HULL=-DD_HULL     -fshader-stage=tessc
    set STAGE_DOMN=-DD_DOMAIN   -fshader-stage=tesse
    set STAGE_COMP=-DD_COMPUTE  -fshader-stage=comp

    call :SetDefines %* || goto :End

    for %%I in (%STAGES%) do (
        call :SetStage %%I
        call set DST=%DST_DIR%\%SHADER%_!STAGE!_%CONTEXT%_%FLAGSMASK%.SPV
        echo]Compiling !DST!
        glslc.exe %OPTIONS% !OSTAGE! %INCLUDES% !DSTAGE! %DEFINES% "%SRC%" -o "!DST!" || goto :End
        echo]
    )

    goto :End

:SetDefines
    for /L %%I in (1,1,6) do shift & rem discard fixed args
    :SetDefinesNext
        if not "%~1"=="" (
            set DEFINES=%DEFINES% %~1
            shift & goto :SetDefinesNext
        )
    exit /b
    
:SetStage
    set STAGE=%~1
    call "%~dp0\common\to-upper.bat" STAGE
    call set STAGE=%%STAGE_%STAGE%%%
    for /f "tokens=1,2*" %%I in ("%STAGE%") do (
        set DSTAGE=%%I
        set OSTAGE=%%J
    )
    set STAGE=%~1
    exit /b

:EmitError
    echo] >&2
    echo]ERROR: %* >&2
    exit /b 1
    
:End
    exit /b