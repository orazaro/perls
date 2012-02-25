#!/bin/sh
N=0 && while prove; do N=`expr $N + 1`;echo "$N ok -- next";done
