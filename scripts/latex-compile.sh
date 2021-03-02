#!/bin/bash

MAIN=${1:-main.tex}
BASE=$(basename $MAIN .tex)
BIBFILE=$BASE.bib
LOG=$BASE.log
ERR=$BASE-compile.err
LATEX_ENGINE="${LATEX_ENGINE:-pdflatex}"

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
    if grep --text --color -A3 "^!" $LOG > $ERR; then
        cat $ERR
        echo "-- see '$LOG' for details"
        return 1
    fi
    grep --text --color Reference $LOG
    grep --text --color Citation $LOG
    grep --text --color "multiply defined" $LOG
    grep --text "acronym Warning" $LOG | sort | uniq | grep --color "acronym Warning"
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

check-result
RETVAL=$?

if [ $RETVAL -eq 0 ]; then
    echo -e "-- ok\n"
else
    echo -e "-- FAIL!\n"
fi

rm -f $ERR
exit $RETVAL
