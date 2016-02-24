# sed-head -- print first n lines using sed
# usage: head n file

count=$1
sed ${count}q "$2"
