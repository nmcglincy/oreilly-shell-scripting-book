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

while test $# -gt 0
do
	case $1 in
		--all | --al | --a | -all | -al | -a )
			all=yes
			;;
		--help | --hel | --he | --h | '--?' | -help | -hel | -he | -h | '-?' )
			usage_and_exit 0
			;;
		--version | --versio | --versi | --vers | --ver | --ve | --v | \
		-version | -versio | -versi | -vers | -ver | -ve | -v )
			version
			exit 0
			;;
		-*)
			error "Unrecognized option: $1"
			;;
		*)
			break
			;;
	esac
	shift
done

envar="$1"
test $# -gt 0 && shift

test "x$envar" = "xPATH" && envar=OLDPATH

dirpath=`eval echo '${'"$envar"'}' 2>/dev/null | tr :  ' '`

# sanity checks for error conditions
if test -z "$envar"
then
	error Environment variable missing or empty
elif test "x$dirpath" = "x$envar"
then
	error "Broken sh on this platform: cannot expand $envar"
elif test -z "$dirpath"
then
	error Empty directory search path
elif test $# -eq 0
then
	exit 0
fi

for pattern in "$@"
do
	result=
	for dir in $dirpath
	do
		for file in $dir/$pattern
		do
			if test -f "$file"
			then
				result="$file"
				echo $result
				test "$all" = "no" && break 2
			fi
		done
	done
	test -z "$result" && warning "$pattern: not found"
done

#  Limit exit status to common Unix practice
# this errors on some test command and I'm not sure why 20160601
test $EXITCODE -gt 125 && EXITCODE=125

exit $EXITCODE
