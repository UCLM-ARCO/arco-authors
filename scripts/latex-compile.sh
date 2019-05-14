#!/bin/bash

MAIN=${1:-main.tex}
BASE=$(basename $MAIN .tex)
BIBFILE=$BASE.bib
LOG=$BASE.log
ERR=$BASE-compile.err

run-latex() {
    $LATEX_ENGINE -interaction=nonstopmode $MAIN > /dev/null
}

run-bibtex() {
    if ! [ -f $BIBFILE ]; then
	echo "-- bib file absent"
	return
    fi

    echo "-- bibtex"
    bibtex $BASE
}

check-result() {
    if grep --color -A2 "^!" $LOG > $ERR; then
	cat $ERR
	echo "-- see '$BASE.log' for details"
	return 1
    fi
    grep --color Reference $LOG
    grep --color Citation $LOG
    grep --color "multiply defined" $LOG
    grep "acronym Warning" $LOG | sort | uniq | grep --color "acronym Warning"
    find . -type f -name "*.tex" -exec grep -H --color FIXME {} \;
    return 0
}

if [ $LATEX_ENGINE != "pdflatex" ]; then
    echo "-- latex engine: $LATEX_ENGINE"
fi

run-latex 1
run-bibtex
run-latex 2
run-latex 3

if check-result; then
    echo -e "-- ok\n"
else
    echo -e "-- FAIL!\n"
fi

rm -f $OUT $ERR
