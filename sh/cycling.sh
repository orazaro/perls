#!/bin/sh
#$Id: cycling.sh,v 1.2 2010/01/14 10:08:41 oraz Exp $
echo "example of shell cycling"
N=0 && while [ $N -lt 100 ]; do echo -n "$N: " >>x;date >> x; N=`expr $N + 1`;done
echo "example of string filling through cycle"
n=0 && s='' && while [ $n -lt 100 ]; do s=$s"$n ";n=`expr $n + 1`;done && echo $s
