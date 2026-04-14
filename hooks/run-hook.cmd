@echo off
setlocal enabledelayedexpansion

set "HOOK_NAME=%~1"
set "SCRIPT_DIR=%~dp0"

if "%HOOK_NAME%"=="" (
  echo Missing hook name argument 1>&2
  exit /b 1
)

shift
bash "%SCRIPT_DIR%%HOOK_NAME%" %*
exit /b %errorlevel%
