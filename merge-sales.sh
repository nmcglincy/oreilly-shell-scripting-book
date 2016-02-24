#! /bin/sh

# merge-sales.sh
# combine quota and sales data

# remove comments and sort datafiles
sed '/^#/d' quotas | sort > quotas.sorted
sed '/^#/d' sales | sort > sales.sorted

# combine on first key, result to standard output
join quotas.sorted sales.sorted

# remove temp files
rm quotas.sorted sales.sorted
