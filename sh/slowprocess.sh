#!/bin/sh
# seeks if slow process is still running
it_seconds=4
interval_seconds=0.5
run_your_test_case &
pid=$!
max=`expr "$wait_seconds / $interval_seconds"`
for (( I=0; I<$max; I++ ));do
    if kill -0 $pid >/dev/null;then
       echo 'test failed'
    else
       echo 'test ok'
       break
    fi
    sleep $interval_seconds
done

# alternative
./slowprogram.sh >/dev/null &
pid=$!
exitbreak=0
for c in {0..1}; do
        sleep 1
        kill -0 $pid 2>/dev/null
        if [ $? -ne 0 ] ;then
            exitbreak=1
            break
        fi
done
if  [ $exitbreak == 1 ]; then
        echo '[ OK ]'
else
        echo '[FAIL]'
        kill -9 $pid 2>/dev/null 
fi

