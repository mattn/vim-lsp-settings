@echo off

setlocal
set VERSION=2.1.0
curl -L -o PowerShellEditorServices.zip "https://github.com/PowerShell/PowerShellEditorServices/releases/download/v%VERSION%/PowerShellEditorServices.zip"
call "%~dp0\run_unzip.cmd" PowerShellEditorServices.zip
del PowerShellEditorServices.zip
if not exist "%~dp0session" mkdir "%~dp0session"

echo @echo off^

setlocal^

set PSES_BUNDLE_PATH=%%~dp0PowerShellEditorServices^

set SESSION_TEMP_PATH=%%~dp0session^

powershell -NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command ^"%%PSES_BUNDLE_PATH: =` %%\PowerShellEditorServices\Start-EditorServices.ps1^" -BundledModulesPath '%%PSES_BUNDLE_PATH%%' -LogPath '%%SESSION_TEMP_PATH%%\logs.log' -SessionDetailsPath '%%SESSION_TEMP_PATH%%\session.json' -FeatureFlags @() -AdditionalModules @() -HostName 'My Client' -HostProfileId 'myclient' -HostVersion 1.0.0 -Stdio -LogLevel Normal^

> powershell-languageserver.cmd
