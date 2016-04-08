#! /bin/sh
# Convert a tab-separated value file to grammar-conformant HTML
# 
# Usage:
# 	tsv-to-html < infile > outfile

cat << EOFILE
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML//EN//3.0">
<HTML>
	<HEAD>
		<TITLE>
			Office directory
		</TITLE>
		<LINK REV="made" HREF="mailto:$USER@`hostname`">
	</HEAD>
	<BODY>
		<TABLE>
EOFILE

