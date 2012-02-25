seq 1 10|perl -pe '$_="prefix: ".$_'

oraz@oraz-desktop:~/owrk/perls$ tail /home/oraz/stats/stat090413.log |head -10|perl -lane '$d=$1if/DATE(\d+)/;print "@F[0..1] DATE(",scalar localtime $d,") @F[3..$#F]"'

[park.rambler.ru]$ perl -e 'for$x((1..50000)){$f=sprintf"%05d.txt",$x;open F,">$f" or die;print F "hello $f\n",$x**2,"\n";close F;}'

pages statistics from access_log:
[oraz@ad6 ~/logs]$ tail -100000 access_log |perl -lane '$m{$1}++ if(/(pg=\d+)/);}END{print "$_ $m{$_}" for(sort{$m{$a}<=>$m{$b}}keys %m)'

perl -e 'for(1..2){$i=$_;print"r$_ = ";$d=<>;eval"\$r$i=$d";}print "$r1*$r2=",$r1*$r2,"\n";'

# edit files in place: change Root in CVS
find ban_edit -name "Root"|xargs perl -pi -e's/pserver:(\w+)\@/pserver:oraz\@/'
# test it
find ban_edit -name "Root"|xargs cat
# from adstat to rad10
find bs -name "Root"|xargs perl -pi -e's/pserver:oraz\@adstat\.rambler\.ru:/ext:bsbot\@adstat02\.rambler\.ru:/'

#converts from bhex to string
echo 73706c742e7472622e3232392b73706c742e7472622e3732392b73706c742e7472622e3135372b73706c742e7472622e3138372b73706c742e7472622e3434302b73706c742e7472622e3434332b73706c742e7472622e34392b73706c742e7472622e39322b73706c742e7472622e3733362b73706c742e7472622e3630 |perl -e '$l=<>;while($l != ""){print chr(hex(substr $l,0,2));$l=substr $l,2;}print"\n"'
splt.trb.229+splt.trb.729+splt.trb.157+splt.trb.187+splt.trb.440+splt.trb.443+splt.trb.49+splt.trb.92+splt.trb.736+splt.trb.60
# mean-square deviation
oraz@orazh:~$ perl -le '@a=(1.3,1.7,1.3,0.92,1.3,0.9);map{$s+=$_}@a;$s/=@a;;map{$q+=($s-$_)**2}@a;$q=sqrt($q/@a);print"x=$s +- $q\n"'
x=1.23666666666667 +- 0.270903836977051
# list most active hosts connected to current server:
netstat -n|perl -lane 'if($F[4]=~/((\d+\.){4})/){print $1}'|sort|uniq -c|sort -n|tail -100
#
