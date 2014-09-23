#!/bin/bash

MAIN=${1:-main.tex}
VALID_CHARS=":!#$&@%+/-.a-Z0-9_//\-"

get_figures() {
    [ -f $MAIN ] && grep -v "^ *%" $MAIN \
	| grep includegraphics \
	| sed "s/.*includegraphics.*{\([$VALID_CHARS]*\).*$/\1/g" \
	| sort | uniq \
	| grep -v ^/
}

print() {
    for i in $FIGURES; do
	if [[ $(echo $i | grep -o "http://.*") ]]; then
	    basename $i;
	else
	    echo $i
	fi
    done
}

download() {
    for i in $FIGURES; do
	if [[ $(echo $i | grep -o "http://.*") ]]; then
	    wget $i -O $(basename $i) -q
	fi
    done
}

FIGURES=$(get_figures)
download
print
