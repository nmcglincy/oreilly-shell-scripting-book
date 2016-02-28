#! /bin/sh
# Filter an input stream formatted like etc/passwd
# and output an office directory derived from that data

# Usage:
#     passwd-to-directory < /etc/passwd > office-directory.txt
#     ypcat passwd | passwd-to-directory > office-directory-file
#     niscat passwd.org_dir | passwd-to-directory > office-directory-file
umask 077

PERSON=/tmp/pd.key.person.$$
OFFICE=/tmp/pd.key.office.$$
TELEPHONE=/tmp/pd.key.telephone.$$
USED=/tmp/pd.key.user.$$

