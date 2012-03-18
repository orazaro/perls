cat past.xml|perl -lane 'print $1 if(/"(http.*\.mp3)"/)'|xargs wget -w 1
perl -e 'for(<*.mp3*>){$s1=$s=$_;$s1=~s/(.*mp3)\?.*/$1/;$cmd="mv $s $s1";$cmd=~s/\&/\\\&/g;system "$cmd\n" unless $s eq $s1}'
perl -e 'for(<EC*.mp3>){$s1=$_;if(/EC(\d+)\.mp3/){$s=sprintf("EC%03d.mp3",$1); system "mv $s1 $s\n"}}
