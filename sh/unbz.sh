#!/bin/sh

list=`ls *.bz2`;
for x in $list; do
echo -n bzip2 -d $x.. 
bzip2 -d $x
echo ok
done

