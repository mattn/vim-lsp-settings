#!/bin/sh

set -e

echo 'install.packages("languageserver", repos = "https://cran.r-project.org")' >install.r
Rscript install.r

cat <<EOF >r-languageserver
#!/bin/sh

R --slave -e 'languageserver::run()'
EOF

chmod +x r-languageserver
