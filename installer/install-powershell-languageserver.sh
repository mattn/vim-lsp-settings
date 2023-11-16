#!/bin/sh

set -e

VERSION=3.14.0
curl -L -o PowerShellEditorServices.zip "https://github.com/PowerShell/PowerShellEditorServices/releases/download/v$VERSION/PowerShellEditorServices.zip"
unzip PowerShellEditorServices.zip
rm PowerShellEditorServices.zip
mkdir session

cat <<EOF >powershell-languageserver
#!/bin/sh

DIR=\$(cd \$(dirname \$0); pwd)
PSES_BUNDLE_PATH=\$DIR
SESSION_TEMP_PATH=\$DIR/session
pwsh -NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command "\$PSES_BUNDLE_PATH/PowerShellEditorServices/Start-EditorServices.ps1 -BundledModulesPath \$PSES_BUNDLE_PATH -LogPath \$SESSION_TEMP_PATH/logs.log -SessionDetailsPath \$SESSION_TEMP_PATH/session.json -FeatureFlags @() -AdditionalModules @() -HostName 'My Client' -HostProfileId 'myclient' -HostVersion 1.0.0 -Stdio -LogLevel Normal"
EOF

chmod +x powershell-languageserver
