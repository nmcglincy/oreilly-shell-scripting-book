#! /bin/sh -
# 
# Search for one or more ordinary files or file patterns on a search path defined by a specified environment variable.

# The output on standard output is normally either the full path to the first instance of each file found on the search path, or "filename: not found" on standard error.

# The exit code is 0 if all files are found, and otherwise a nonzero value equal to the number of files not found (subject to the shell limit of 125).

# Usage:
# 	pathfind [--all] [--?] [--help] [--version] envar pattern(s)

# With the --all option, every directory in the path is searched, instead of stopping with the first one found.

# IFS= unsure how to assign this in real life

OLDPATH="$PATH"

PATH=/bin:/usr/bin
export PATH

error()
{
	echo "$@" 1>&2
	usage_and_exit 1
}

usage()
{
	echo "Usage: $PROGRAM [--all] [--?] [--help] [--version] envar pattern(s)"
}

usage_and_exit()
{
	usage
	exit $1
}

version()
{
	echo "$PROGRAM version $VERSION"
}

warning()
{
	echo "$@" 1>&2
	EXITCODE=`expr $EXITCODE +1`
}

all=no
envar=
EXITCODE=0
PROGRAM=`basename $0`
VERSION=1.0

