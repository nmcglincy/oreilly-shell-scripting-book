#! /bin/sh -

# newuids --- print one or more unused uids
# 
# usage:
# 	newuids [-c N] list-of-ids-file
# 	-c N 		print N unused uids

# How many uids to print
count=1  

# parse arguments, let sh issue diagnostics
# and exit if need be

while getopts "c:" opt
do
	case $opt in
		c) count=$OPTARG ;;
	esac
done

shift $(($OPTIND - 1))

IDFILE=$1

awk -v count=$count '
	BEGIN {
		for (i = 1; getline id > 0; i++)
			uidlist[i] = id

			totalids = i

		for (i = 2; i <= totalids; i++) {
			if (uidlist[i-1] != uidlist[i]) {
				for (j = uidlist[i-1] + 1; j < uidlist[i]; j++) {
					print j
					if (--count == 0)
						exit
				}
			}
		}
	}' $IDFILE
