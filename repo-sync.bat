@echo off

SETLOCAL
cd /d %~dp0%
set SITE_BASE=%cd%
call ..\PortableTrac\trac-admin.cmd main repository sync *
ENDLOCAL
