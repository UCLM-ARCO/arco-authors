#!/bin/bash

MAIN=${1:-main.tex}
BASE=$(basename $MAIN .tex)
BIBFILE=$BASE.bib
LOG=$BASE.log
ERR=$BASE-compile.err

run-pdflatex() {
    pdflatex -interaction=nonstopmode $MAIN > /dev/null
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
    grep -n --color FIXME *.tex
    return 0
}


run-pdflatex 1
run-bibtex
run-pdflatex 2
run-pdflatex 3

echo "--"

if check-result; then
    echo -- OK
else
    echo -- FAIL
fi

rm -f $OUT $ERR
