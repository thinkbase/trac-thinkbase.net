@echo off

SETLOCAL
cd /d %~dp0%
set SITE_BASE=%cd%
set SITE_IDX_FILE=etc\index.html
call ..\PortableTrac\start-httpd.cmd
ENDLOCAL
