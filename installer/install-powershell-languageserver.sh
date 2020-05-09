#!/usr/bin/env bash

set -e

curl -L -o PowerShellEditorServices.zip "https://github.com/PowerShell/PowerShellEditorServices/releases/download/v2.1.0/PowerShellEditorServices.zip"
unzip PowerShellEditorServices.zip
rm PowerShellEditorServices.zip
mkdir session

cat <<EOF >powershell-languageserver
#!/usr/bin/env bash

DIR=\$(cd \$(dirname \$0); pwd)
PSES_BUNDLE_PATH=\$DIR/PowerShellEditorServices
SESSION_TEMP_PATH=\$DIR/session
pwsh -NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command "\$PSES_BUNDLE_PATH/PowerShellEditorServices/Start-EditorServices.ps1 -BundledModulesPath \$PSES_BUNDLE_PATH -LogPath \$SESSION_TEMP_PATH/logs.log -SessionDetailsPath \$SESSION_TEMP_PATH/session.json -FeatureFlags @() -AdditionalModules @() -HostName 'My Client' -HostProfileId 'myclient' -HostVersion 1.0.0 -Stdio -LogLevel Normal"
EOF

chmod +x powershell-languageserver
