#!/usr/bin/env bash 
POSTFIX_TARGET='build.xml\|asm\|ASM\|s\|S\|A51\|asp\|asa\|awk\|gawk\|mawk\|bas\|bi\|bb\|pb\|bet\|c\|c++\|cc\|cp\|cpp\|cxx\|h\|h++\|hh\|hp\|hpp\|hxx\|cs\|cbl\|cob\|CBL\|COB\|bat\|cmd\|e\|erl\|ERL\|hrl\|HRL\|as\|mxml\|f\|for\|ftn\|f77\|f90\|f95\|htm\|html\|java\|js\|cl\|clisp\|el\|l\|lisp\|lsp\|lua\|mak\|mk\|m\|ml\|mli\|p\|pas\|pl\|pm\|plx\|perl\|php\|php3\|phtml\|py\|pyx\|pxd\|pxi\|scons\|cmd\|rexx\|rx\|rb\|ruby\|SCM\|SM\|sch\|scheme\|scm\|sm\|sh\|SH\|bsh\|bash\|ksh\|zsh\|sl\|sml\|sig\|sql\|tcl\|tk\|wish\|itcl\|tex\|vr\|vri\|vrh\|v\|vhdl\|vhd\|vim\|y\|xml\|inl\|xsl\|proto'

CTAGS_FLAG='--totals=yes -R --c-kinds=+lpx --c++-kinds=+lpx --java-kinds=+l --SQL-kinds=+dlr --Perl-kinds=+d --Fortran-kinds=+iL --C#-kinds=+l --Vera-kinds=+Px --VHDL-kinds=+Cl --fields=+iaS --extra=+q'

CSCOPE_FLAG='-Rbkuq'
CSCOPE_FILES="$(pwd)/cscope.files"

clear
echo -e "\033[33mStart to gather files that need to be indexed...\033[0m"

find ./ -regex ".*\.\(${POSTFIX_TARGET}\)" | sed 's/\(["'\''\]\)/\\\1/g;s/^/"/;s/$/"/' > ${CSCOPE_FILES}

printf "\v"
echo -e "\033[32mStart to generate ctags database...\033[0m"
ctags ${CTAGS_FLAG}

printf "\v"
echo -e "\033[32mStart to generate cscope database...\033[0m"
cscope ${CSCOPE_FLAG} -i ${CSCOPE_FILES}

printf "\v"
echo -e "\033[36mAll done...\033[0m"

