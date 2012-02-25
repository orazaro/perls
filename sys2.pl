#!/usr/bin/perl -w
use strict;

my $line;
my $status;
my $cmd;
print "=> ";
while(defined($line=<>)){
	chomp $line;
	last if($line eq 'q' or $line eq 'quit' or $line eq 'bye');
	$line.="|";
	#print $line,"\n";
	$status = open(CMD,$line);
	if(not $status){
		print "error: $status\n";
	}
	else{
		while(<CMD>){
			print $_;
		}
	}
	close CMD;
	print "=> ";
}
