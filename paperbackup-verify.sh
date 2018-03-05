#!/usr/bin/bash

# USAGE: verify.sh backup.pdf
#   where backup.pdf should be the pdf created with paperbackup.py

RESTOREPROG=paperrestore.sh

bPDF=$( $RESTOREPROG $1 | b2sum | cut -d ' ' -f 1 )
bEmbedded=$(pdftotext $1 - | grep b2sum -A2 | tail -2 | tr -d '\n')

if [ "x$bPDF" == "x$bEmbedded" ]; then
    echo "b2sums MATCH :-)"
    echo
    exit 0
else
    echo "b2sums do NOT match!"
    echo "restored from PDF: " $bPDF
    echo "original embedded: " $bEmbedded
    echo
    exit 11
fi
