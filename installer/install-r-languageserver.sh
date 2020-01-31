#!/usr/bin/env bash

set -e

R --slave -e 'install.packages("languageserver")'

cat <<EOF >r-languageserver
#!/usr/bin/env bash

R --slave -e 'languageserver::run()'
EOF

chmod +x r-languageserver
