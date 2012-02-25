#!/usr/bin/perl -w

use strict;
use warnings;

use Time::Local;

print "now=>";
my $now = <>;
$now = mytime($now);

print "start=>";
my $start = <>;
$start = mytime($start);

print "shows=>";
my $shows = <>;
$shows += 0;

my $sperd = $shows/($now-$start)*24*3600;
print "shows per day = $sperd\n";

exit;

sub mytime
{
	my $line = shift;
	chomp $line;
	my ($year,$mon,$mday,$hours,$min,$sec) = split /-/,$line;
	$sec = 0 unless defined $sec;
	$year -= 1900;
	$mon -= 1;
	my $time = timelocal($sec, $min, $hours, $mday, $mon, $year);
	return $time;
}
