#!/usr/bin/perl -w
use strict;


open(DFPROC, "df -k|") || die "df: $!";
my $line;
while($line=<DFPROC>)
{
  chomp($line);
  my @fields = split(/\s+/,$line);

  if($fields[-1] =~ /\/ram/)
  {
    print "FOUND: ",$line,"\n";
    if( $fields[3] < 45000 )
    {
      print "RAM too small: CLEANING", "\n";
      my $res = `/bin/sh /usr2/ban_sys/bns/backup/clean_ram.sh`;
    }
  }
}
close(DFPROC);
