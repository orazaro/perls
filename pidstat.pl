#!/usr/bin/perl -w
use strict;

my (%pids);
while(<>)
{
	#@s = m/^(\w+)\s+(\w+)\s+DATE(\d+)\s+PID(\d+)/;
	my @s = m/PID(\d+)/;
	#print "found=", @s, "\n";
	last if(!@s);
	#print $s[0],"\n"; 
	$pids{$s[0]} ++;
}
my $sum = 0;
foreach my $key (sort {$a<=>$b} keys(%pids))
{
	$sum += $pids{$key};
	print "pg=", $key, "\tshows=", $pids{$key},"\n";
}
print "-------------------------------------------------\n";
print "sum=$sum\n";
