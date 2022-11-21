@echo off

R --slave -e "install.packages('languageserver', repos = 'https://cran.r-project.org')"

echo @echo off ^

R --slave -e "languageserver::run()" ^

> r-languageserver.cmd

