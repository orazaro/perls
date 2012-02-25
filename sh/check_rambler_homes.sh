#!/bin/sh

for i in {1..8};do if [ $i -ne 5 ]; then ping -c1 home$i; fi done
