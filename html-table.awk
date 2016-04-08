BEGIN{
	FS="\t"
	OFS="</TD><TD>"
}
{
	print "<TR><TD>" $1, $2, $3 "</TD></TR>"
}
