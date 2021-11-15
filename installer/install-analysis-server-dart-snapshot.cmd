@echo off

curl -o dartsdk-windows-x64-release.zip "https://storage.googleapis.com/dart-archive/channels/dev/release/latest/sdk/dartsdk-windows-x64-release.zip"
call "%~dp0\run_unzip.cmd" dartsdk-windows-x64-release.zip
del dartsdk-windows-x64-release.zip

echo @echo off ^

%%~dp0\dart-sdk\bin\dart language-server %%* ^

> analysis-server-dart-snapshot.cmd
