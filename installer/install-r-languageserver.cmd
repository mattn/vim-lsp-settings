@echo off

R --slave -e install.packages('languageserver')

echo @echo off ^

R --slave -e "languageserver::run()" ^

> r-languageserver.cmd

