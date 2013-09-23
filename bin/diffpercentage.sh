#!/bin/sh

# returns the percentage difference between two files

file1="$1"
file2="$2"

file1size=$( cat "$file1" | wc -c )
file2size=$( cat "$file2" | wc -c )

if [ $file1size -lt $file2size ]; then
    size=$file1size
else
    size=$file2size
fi

dc -e "
3k
$( cmp -n $size -l "$file1" "$file2" | wc -l )
$size
/
100*
p"
