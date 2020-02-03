@echo off

curl -o PowerShellEditorServices.zip "https://github.com/PowerShell/PowerShellEditorServices/releases/download/2.0.0-preview.8/PowerShellEditorServices.zip"
call "%~dp0\run_unzip.cmd" PowerShellEditorServices.zip
del PowerShellEditorServices.zip

echo @echo off ^

setlocal ^

set PSES_BUNDLE_PATH=%%~dp0PowerShellEditorServices ^

set SESSION_TEMP_PATH=%%~dp0session ^

powershell -NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command "%%PSES_BUNDLE_PATH:\=/%%/PowerShellEditorServices/Start-EditorServices.ps1 -BundledModulesPath %%PSES_BUNDLE_PATH:\=/%% -LogPath %%SESSION_TEMP_PATH:\=/%%/logs.log -SessionDetailsPath %%SESSION_TEMP_PATH:\=/%%/session.json -FeatureFlags @() -AdditionalModules @() -HostName 'My Client' -HostProfileId 'myclient' -HostVersion 1.0.0 -Stdio -LogLevel Normal" ^

> powershell-languageserver.cmd
