#!/usr/bin/perl -w
# input file with records:
# <num> <server>
# result:
# <num> <domain>

use strict;
use warnings;

my %dom;
while(<>){
	chomp;
	my ($n,$u) = split;
	my @parts = split /\./, $u;
	next if @parts < 2;
	my $domain = $parts[-2].'.'.$parts[-1];
	$dom{$domain}+=$n;
}

foreach my $domain (sort {$dom{$b} <=> $dom{$a}} keys %dom)
{
	print "$dom{$domain} $domain\n";
}
