#!/usr/bin/env bash

set -e

echo 'install.packages("languageserver")' > install.r
Rscript install.r

cat <<EOF >r-languageserver
#!/usr/bin/env bash

R --slave -e 'languageserver::run()'
EOF

chmod +x r-languageserver
