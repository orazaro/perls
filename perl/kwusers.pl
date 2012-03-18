#!/usr/bin/perl -w

use strict;
my %kwusers;
open(KWU,"<kwusers.txt") || die("can't open kwusers.txt");
while(<KWU>){
  chomp;
  $kwusers{$_}=1;
}
while(<>){
	my $line = $_;
  chomp;
	my($u1,$u2,$u3) = split(/,/);
	if(defined($kwusers{$u1})){
		print $u1,"\t",$u2,"\t",$u3,"\n";	
	}
}

