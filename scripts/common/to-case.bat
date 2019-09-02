@echo off

:convert-case
    if not defined %~1 goto :convert-case-end
    for %%a in ("a=A" "b=B" "c=C" "d=D" "e=E" "f=F" "g=G" "h=H" "i=I"
                "j=J" "k=K" "l=L" "m=M" "n=N" "o=O" "p=P" "q=Q" "r=R"
                "s=S" "t=T" "u=U" "v=V" "w=W" "x=X" "y=Y" "z=Z" ) do (
        for /f "tokens=1,2* delims==" %%i in ("%%~a") do set lo=%%i&set up=%%j
        REM call echo]%%~a %%lo%% %%up%%
        call call set %~1=%%%%%~1:%~2%%%%
    )
    :convert-case-end
        set lo=
        set up=
        exit /b
    