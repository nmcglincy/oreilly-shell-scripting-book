#! /bin/bash

# password-to-mailing-list.sh
# 
# Generate a mailing list of all user of a particular shell
# 
# Usage:
# ./password-to-mailing-list.sh < /etc/passwd

# Possibily a bit of overkill
rm -f *.mailing-list

# Read from the standard input
while IFS=: read user passwd uid gid name home shell
do
	shell=${shell:-/bin/sh} #empty shell field means /bin/sh
	file="$(echo $shell | sed -e 's;^/;;' -e 's;/;-;g').mailing-list"
	echo $user, >> $file
done
