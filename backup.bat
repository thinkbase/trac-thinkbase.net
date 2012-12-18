@echo off

SETLOCAL
cd /d %~dp0%
set SITE_BASE=%cd%
call ..\PortableTrac-git\trac-backup.cmd main
call ..\PortableTrac-git\trac-backup.cmd trac
ENDLOCAL

pause