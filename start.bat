@echo off

SETLOCAL
cd /d %~dp0%
set SITE_BASE=%cd%
call ..\PortableTrac-git\start-httpd.cmd
ENDLOCAL
