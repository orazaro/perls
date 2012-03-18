#!/usr/bin/perl -w

use warnings;
use strict;

while(1){
	print "what's your name: ";
	my $name = <STDIN>;
	chomp $name;
	last unless $name;
	print "hello, $name!\n";
}
