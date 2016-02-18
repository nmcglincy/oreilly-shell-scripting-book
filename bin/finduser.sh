#! /bin/sh
# finduser -- see if user named by first argument is logged on

who | grep $1

