#!/usr/bin/perl -w

use warnings;
use strict;

use Storable qw(store retrieve store_fd retrieve_fd);

my %t;
$t{x}=[];
$t{y}=[];
push @{$t{x}},1;
push @{$t{x}},2;
push @{$t{y}},11;
push @{$t{y}},12;

out(\%t);
#print "== serial ==\n";
#my $fh = *STDOUT;
#store_fd \%t, \$fh;

print "== stored ==\n";
store \%t,'x';

my $hr = retrieve('x');
out($hr);

exit;

sub out
{
	my $h = shift;
	foreach my $key (keys %{$h})
	{
		print "key=$key\n";
		foreach my $i (@{$h->{$key}})
		{
			print "val=$i\n";
		}
	}
}

