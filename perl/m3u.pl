#!/usr/bin/perl -w
#$Id: m3u.pl,v 1.3 2009/10/04 15:40:57 oraz Exp $
use strict;

print"#EXTM3U\n";
while(<*.mp3>)
{
	my $l=$_;
	print "#EXTINF:0,$1\n$l\n" if($l=~/(.+)\.mp3/);
}
