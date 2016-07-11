#! /bin/sh

sort u1_passwd u2_passwd > merge1

awk -f splitout.awk merge1

awk -F: '{ print $3 }' merge1 | sort -n -u > unique-ids

rm -f old-new-list

old_ifs=$IFS
IFS=:
while read user passwd uid gid fullname homedir shell
do
	if read user2 passwd2 uid2 gid2 fullname2 homedir2 shell2
	then
		if [ $user = $user2 ]
		then
			printf "%s\t%s\t%s\n" $user $uid $uid2 >> old-new-list
			echo "$user:$passwd:$uid2:$gid:$fullname:$homedir:$shell"
		else
			echo $0: out of sync: $user and $user2 >&2
			exit 1
		fi
	else
		echo $0: no duplicate for $user >&2
			exit 1
	fi
done < dupusers > unique2
IFS=$old_ifs

count=$(wc -l < dupids)

set -- $(./newuids.sh -c $count unique-ids)

IFS=:
while read user passwd uid gid fullname homedir shell
do
	newuid=$1
	shift

	echo "$user:$passwd:$newuid:$gid:$fullname:$homedir:$shell"

	printf "%s\t%s\t%s\n" $user $uid $newid >> old-new-list
done < dupids > unique3
IFS=$old_ifs

sort -k 3 -t : -n unique[123] > final.passwd
