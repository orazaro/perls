#!/usr/bin/perl -w

use strict;
my $af = "asurk-pg.txt";
open (AF, "<$af") || die("can't open $af!");
my @apgs = ();
while(<AF>)
{
	chomp;
	push @apgs, $_;
}
close AF;

my %pids = ();
open (PIDS, "<p.txt") || die("can't open p.txt");
while(<PIDS>)
{
	chomp;
	my @d = split /,/;
	$pids{$d[0]} = $d[1];
	#print STDERR $d[0]," ",$d[1],"\n";
}
close PIDS;

print STDERR "ok \n";
while(<>)
{
  chomp;
  my $line = $_;
  my @elms = split /,/, $line;
  if( defined($elms[0]) )
  {
    map{
	  if($elms[0] == $_)
	  {
		my $pidshows = 0;
		if(defined($pids{$elms[0]}))
		{
			$pidshows = $pids{$elms[0]};
		}
        printf("%d,%d,%s\n", $elms[0],$pidshows,$elms[6]);
	  }
    } @apgs;
  }
}

