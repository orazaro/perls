#!/usr/bin/perl -w
use strict;

my $line;
my $status;
my $tmp = "/tmp/vi.GMEiLOS4pb";
my $out = ">".$tmp;
my $cleanup = "rm -f ".$tmp;
print "=> ";
while(defined($line=<>)){
	chomp $line;
	last if($line eq 'q' or $line eq 'quit' or $line eq 'bye');
	$line.=$out;
	#print $line,"\n";
	$status = system($line);
	if($status){
		print "error: %status\n";
	}
	else{
		open(X,$tmp) || die{"can't open $tmp"};
		while(<X>){
			print $_;
		}
		close X;
		system($cleanup);
	}
	print "=> ";
}
