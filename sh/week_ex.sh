#!/bin/sh
sweek="";
for i in 1 2 3 4 5 6 7; 
do 
	sd=`date -v-${i}d +%y%m%d`; 
	sweek=$sweek" stat"$sd".log.gz"; 
done; 
cd /work/stats.backup
ls -al $sweek;

