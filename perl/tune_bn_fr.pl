#!/usr/bin/perl -w
# $Id: tune_bn_fr.pl,v 1.1 2010/07/22 10:28:04 oraz Exp $
# extract tune_bn_fr params from bns.log and mysql:bns_stat

use strict;
use DBI;

my %fper = (
1 => "day",
2 => "week",
3 => "book",
);

my $DSN = "DBI:mysql:database=bns_stat;host=adstat.rambler.ru;mysql_read_default_file=$ENV{HOME}/.my.cnf";
my $dbh = DBI->connect($DSN)
	|| die "Cannot connect: $DBI::errstr\n";

while(<>)
{
	if(/cmd=tune_bn_fr\&id=(\d+)\&tune=on\&freq_max=(\d+)\&freq_per=(\d+)/)
	{
		my ($bn, $freq_max, $freq_per) = ($1,$2,$3);
		my @r = get_bn_info($dbh, $bn);
		next if(@r != 4);
		if($r[3] =~ /_(\w+)$/) {
			$r[3] = $1;
		}
		print join(',', @r),",",$freq_max."-",$fper{$freq_per},"\n";
	}
}

$dbh->disconnect;
exit;

sub get_bn_info
{
	my($dbh, $bn) = @_;
	my $sql = 
	"SELECT id,start,stop,type FROM banners WHERE id=$bn
	";
	my $sth = $dbh->prepare($sql) || die "$DBI::errstr\n$sql\n";
	my $nrows = $sth->execute() || die "$DBI::errstr\n$sql\n";
	if($nrows != 1){
		warn "do not found one banner $bn";
		return undef;
	}
	my $row = $sth->fetchrow_arrayref;
	$sth->finish;
	return @$row;
}

