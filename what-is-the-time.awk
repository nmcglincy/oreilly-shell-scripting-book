BEGIN{
	"date" | getline now
	close("date")
	print "The current time is", now
}
