#!/bin/bash

function parts() {
    files=$(grep -v "^%" "$1" \
	| grep "\\input{" \
	| sort | uniq \
	| sed "s/.*\\input{\([[:alnum:]_//\.\-]\+\)}.*/\1/g")

    for f in $files; do
         echo $f
	 parts $f
    done
}

MAIN=${1:-main.tex}
echo $MAIN
parts $MAIN
