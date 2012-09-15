#!/usr/bin/env bash
cday=`date "+%d"`
chour=${1:-'10'}
fdate=$(date "+%y%m")${cday}
echo "extract from log ${fdate} for ${chour} hour and ${cday} day"
# 10:00
d_from=`perl -mPOSIX -e 'print POSIX::mktime( 0, 0, '${chour}', '${cday}', 6, 112 )'`
# 10:30
d_to=`perl -mPOSIX -e 'print POSIX::mktime( 0, 30, '${chour}', '${cday}', 6, 112 )'`
fname='log_pids_8612_8613_'${fdate}'_'${d_from}
echo 'd_from='${d_from}' d_to='${d_to}' fname='${fname}
rm -f $fname
for i in {1..6};
do 
	echo $i;
	ssh bsbot@rad0$i "cat stats/n$i.stat${fdate}.log|grep \"PID8612\|PID8613\"|perl -lane '\$line=\$_;if(/DATE(\d+)/){if(\$1>=${d_from} and \$1<=${d_to}){print\$line}}'" >>${fname} &
done
wait
echo 'ok'
