function gcd(x, y, 		r){
	# return the greatest common denominator of integer x, y

	x = int(x)
	y = int(y)
	print x, y
	r = x % y
	return (r == 0) ? y : gcd(y, r)
}
{
	g = gcd($1, $2); print "gcd(" $1 ", " $2 ") =", g
}
