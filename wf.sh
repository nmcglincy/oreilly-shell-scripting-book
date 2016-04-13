#! /bin/sh
# Read a stream on standard input, and output a list of
# the n (default: 25) most frequently occuring words and
# their frequency counts, in order of descending counts, on
# standard output.
# 
# Usage:
# 	wf [n]

tr -cs A-Za-z\' '\n' \
	| tr A-Z a-z \
	| sort \
	| uniq -c \
	| sort -k1,1nr -k2 \
	| sed ${1:-25}q
