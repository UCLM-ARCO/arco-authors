#!/bin/bash
MAIN=${1:-main.tex}
[ -f $MAIN ] && grep -v "^ *%" $MAIN \
    | grep includegraphics \
    | sort | uniq \
    | sed "s/.*includegraphics.*{\([.a-zA-Z0-9_//\-]*\).*$/\1/g" \
    | grep -v ^/
