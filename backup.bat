@echo off

SETLOCAL
cd /d %~dp0%
set SITE_BASE=%cd%
call ..\PortableTrac\trac-backup.cmd main
call ..\PortableTrac\trac-backup.cmd trac
ENDLOCAL

pause