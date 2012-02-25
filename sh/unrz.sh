#!/bin/sh

list=`ls *.rz`;
for x in $list; do
echo -n rzip -d $x.. 
rzip -d $x
echo ok
done

