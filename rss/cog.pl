#!/usr/bin/perl -w
#$Id: cog.pl,v 1.2 2010/03/20 09:22:39 oraz Exp $
# example of RSS parsing
use strict;

my $state = 'n';
my $title = "";
my $url = "";
while(<>)
{
	#print; print"state=$state\n";
	if($state eq 'n') {
		$state='i' if(/^\s*<item>$/);
	}
	elsif($state eq 'i') {
		if(/^\s*<title>Lecture\s+(\d+):\s*([^<]+)<\/title>/){
			$title = sprintf "%02d %s",$1,$2;
			print"title=$title\n";
			$state = 't';
		}
	}
	elsif($state eq 't') {
		if(/^\s*<enclosure\surl=\"([^\"]+)\"/){
			$url = $1;
			print"url=$url\n";
			# getit
			my $cmd = 'wget -O"'.$title.'.m4a" '.$url;
			print"cmd=$cmd\n";
			`$cmd`;
			#
			$state = 'n';
		}
	}
}
