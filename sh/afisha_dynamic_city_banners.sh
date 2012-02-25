#!/usr/local/bin/bash

remote_host=ad4
remote_dir=/usr2/ban_sys/home/r4/
remote_cmd_prefix="sudo -u oraz"

data=(
http://rhead.park.rambler.ru/afisha/?geo_id=54118936 1.html
http://rhead.park.rambler.ru/afisha/?geo_id=54119023 2.html
http://rhead.park.rambler.ru/afisha/?geo_id=54119163 3.html
http://rhead.park.rambler.ru/afisha/?geo_id=54119122 4.html
http://rhead.park.rambler.ru/afisha/?geo_id=54119134 5.html
http://rhead.park.rambler.ru/afisha/?geo_id=54119162 5_1.html
http://rhead.park.rambler.ru/afisha/?geo_id=54119139 7.html
http://rhead.park.rambler.ru/afisha/?geo_id=54119040 8.html
http://rhead.park.rambler.ru/afisha/?geo_id=54119154 9.html
http://rhead.park.rambler.ru/afisha/?geo_id=54119165 10.html
http://rhead.park.rambler.ru/afisha/?geo_id=54119030 11.html
http://rhead.park.rambler.ru/afisha/?geo_id=54119133 12.html
http://rhead.park.rambler.ru/afisha/?geo_id=54119121 13.html
http://rhead.park.rambler.ru/afisha/?geo_id=54119156 14.html
http://rhead.park.rambler.ru/afisha/?geo_id=54119111 15.html
http://rhead.park.rambler.ru/afisha/?geo_id=54119119 16.html
http://rhead.park.rambler.ru/afisha/?geo_id=54119026 17.html
http://rhead.park.rambler.ru/afisha/?geo_id=54119215 18.html
http://rhead.park.rambler.ru/afisha/?geo_id=54119015 19.html
http://rhead.park.rambler.ru/afisha/?geo_id=54119096 20.html
http://rhead.park.rambler.ru/afisha/?geo_id=54119115 21.html
http://rhead.park.rambler.ru/afisha/?geo_id=54119062 22.html
http://rhead.park.rambler.ru/afisha/?geo_id=54119164 23.html
http://rhead.park.rambler.ru/afisha/?geo_id=54119173 24_1.html
) 

for ((i=0;i<$((${#data[@]} / 2));i++)); do
  url=${data[$(($i * 2))]}
  file=$remote_dir/${data[$((($i * 2) + 1))]}
  ssh $remote_host "$remote_cmd_prefix sh -c 'fetch -o - $url | iconv -sc -f UTF-8 -t KOI8-R > $file'"
done

