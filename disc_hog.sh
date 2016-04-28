#! /bin/sh
# Sends a "here document" mail to disk hogs

# cd /home
du -s * \
	| sort -nr \
	| sed 10q \
	| while read amount name
	do
		printf <<- EOF
			Greetings. You are one of the top 10 consumers 
			of disk space on the system. Your home directory
			uses $amount disk blocks.

			Please clean up unneeded files, as soon as possible.

			Thanks,

			Your friendly neighborhood system administrator
			EOF
	done

# this doesn't work the way I expect, maybe I can fix it once I've read more about 
# printf.