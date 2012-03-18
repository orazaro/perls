#!/usr/bin/perl -w
# $Id: herosi.pl,v 1.6 2010/07/28 19:21:19 oraz Exp $
# sort objects by rules (partial sort: topological sort)

use strict;

my @a = ( 'e', 'h', 'i', 'o', 'r', 's' );
my @rules = ('h<o','r>e','h<e','i>s','e<o','s>r','h<s');
print "@a\n@rules\n";

# hash objects
my %a = ();
$a{$_} = 0 for(@a);

my @out = ();
my $numa = @a;
while($numa > 0) {
	for my $r (@rules){
		my ($x,$op,$y) = split //,$r;
		#print"$x $op $y\n";
		if(exists($a{$x}) && exists($a{$y}))
		{
			if($op eq '>') {
				$a{$x}++;
			} elsif($op eq '<'){
				$a{$y}++;
			} else {
				die("bad rule: $r");
			}
		}
	}
	# find minimal elems and reset others
	for (keys%a) {
		if($a{$_} == 0) {
			push @out, $_;
			delete $a{$_};
			$numa--;
		} else {
			$a{$_} = 0;
		}
	}
}

print "result: @out\n";


