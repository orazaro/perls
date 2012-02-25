#!/usr/bin/perl -w
use strict;

my $mailprog = '/usr/sbin/sendmail -t';
my $eaddr;
my $esub = "Enthusiast Internet Award";
my $etext = <<TTT;
Some text
TTT

my ($nskip,$nsel,$nmax);
if(@ARGV == 2)
{
	$nskip = shift(@ARGV);
	print STDERR "skipping $nskip\n";
	my $snum = shift(@ARGV);
	if($snum =~ /^(\d+):(\d+)$/)
	{
		$nsel = $1;
		$nmax = $2;
		print STDERR "selecting $nsel/$nmax\n";
	}
	else
	{
		die("bad snum [$snum]");
	}
}
else
{
	die("usage: $0 <nskip> <nsel>:<max>");
}

open (TO, "to.txt") || die("Can't open to.txt!");
my $i = 0;
while(<TO>)
{
chomp;
$_ =~ s/\s//g;
$eaddr = $_;
$i++;
next if($i <= $nskip);
next if($i % $nmax != $nsel);

print STDERR ".";
#print "$i:$eaddr..";
if( $eaddr =~ /\@/ )
{
	&mail_out();
	print "$i:$nsel:$eaddr..ok\n";
}
else
{
	print "$i:$nsel:$eaddr..bad\n";
}
}

sub mail_out
{
	open (MA, "|$mailprog") || &error("Can't open the mail program!"); 
	print MA "From: Rambler Top100<top100\@top105.rambler.ru>\n";
	print MA "To: $eaddr \n"; 
	print MA "Subject: $esub\n";
	print MA "Content-Type: text/plain; charset=\"koi8-r\"\n";
	print MA "\n";
	print MA "$etext\n\n"; 
	close (MA);
}

