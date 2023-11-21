#!/bin/bash

MAIN=${1:-main.tex}
VALID_CHARS=":!#$&@%+.[:alnum:]_//\-"

get_figure_paths() {
    [ -f $MAIN ] && grep -v "^ *%" $MAIN \
	| grep includegraphics \
	| sed "s/.*includegraphics.*{\([$VALID_CHARS]*\).*$/\1/g" \
	| sort | uniq \
	| grep -v ^/
}

check_existing_figures() {
    for f in $FIGURES; do
	if [ -f $f ] || [[ $f == *"/"* ]]; then

	    echo $f
	else
	    echo ./figures/$f
	fi
    done
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
	    wget $i -O $FIGDIR/$(basename $i) -q
	fi
    done
}

FIGURES=$(get_figure_paths)
FIGURES=$(check_existing_figures)
download
print
