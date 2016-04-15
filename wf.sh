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
# I don't really understand the last command, I'll try to come back to it when I get to variables.
# Now I get is ${1} is the first command line argument "n", it's not some sort of numerical range.
