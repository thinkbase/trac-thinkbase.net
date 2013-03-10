@echo off

SETLOCAL
cd /d %~dp0%
set SITE_BASE=%cd%
call ..\PortableTrac\bin\init-env.bat
call ..\PortableTrac\bin\do_restore.bat main
call ..\PortableTrac\bin\do_restore.bat trac
ENDLOCAL

pause