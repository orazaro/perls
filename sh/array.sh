#!/bin/bash

FOO=( bar string 'some text' )
foonum=${#FOO}

for ((i=0;i<$foonum;i++)); do
   echo ${FOO[${i}]}

done
