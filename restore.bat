@echo off

SETLOCAL
cd /d %~dp0%
set SITE_BASE=%cd%
call ..\PortableTrac-git\bin\init-env.bat
call ..\PortableTrac-git\bin\do_restore.bat main
call ..\PortableTrac-git\bin\do_restore.bat trac
ENDLOCAL

pause