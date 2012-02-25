#!/usr/bin/perl -w
# $Id: findholes.pl,v 1.1 2010/10/20 09:04:05 oraz Exp $
#
# compares 2 days stats
#
# select banner_id,sum(shows) from ban_stat where date='2010-10-09' GROUP BY banner_id;
#
# to find holes in ban_stat (banner not shown for one day)
#
use strict;
use DBI;
use POSIX qw(strftime mktime);
use Getopt::Long;
$Getopt::Long::ignorecase=0;

my $shows_pre = 1000;

my $dateh;
GetOptions("date_holes|d=s"=>\$dateh);
unless(defined($dateh)) {
	use File::Basename;
	print STDERR "Usage: ",basename($0)," -d <datecheck>\n";
	exit(1);
}

my $datep = day_pre($dateh);
die("bad date: $dateh") unless(defined $datep);

print("dateh=$dateh datep=$datep\n");

my $DSN = "DBI:mysql:database=bns_stat;host=adstat.rambler.ru;mysql_read_default_file=$ENV{HOME}/.my.cnf";
my $dbh = DBI->connect($DSN)
	|| die "Cannot connect: $DBI::errstr\n";


my $h8 = load_bn_stats($dbh,$datep);
my $h9 = load_bn_stats($dbh,$dateh);

for my $k (keys %$h9) {
	if($h9->{$k} > 0 && $h9->{$k} < 2){
		if($h8->{$k} && $h8->{$k} > $shows_pre) {
			print "$k .. $h9->{$k}";
			my $user = find_user($dbh,$datep,$k);
			print " hole: user=$user\n";
		} else {
#			print "$k .. $h9->{$k}";
#			print " ?\n";
		}
	}
}

$dbh->disconnect;
exit;

sub load_bn_stats
{
	my ($dbh,$date) = @_;
	my $sql =
	"select banner_id,sum(shows) from ban_stat where date='$date' GROUP BY banner_id;";
	my $sth = $dbh->prepare($sql) || die "$DBI::errstr\n$sql\n";
	my $nrows = $sth->execute() || die "$DBI::errstr\n$sql\n";
	my @row;
	my %h;

	while(@row = $sth->fetchrow_array) {
			#print "@row\n";
			$h{$row[0]} = $row[1];
	}
	return \%h;
}

sub find_user
{
	my ($dbh,$date,$bid) = @_;
	my $sql =
	"select u.nick,u.group_id from ban_stat,pages as p,users as u where date='$date' AND banner_id=$bid AND p.id=page_id AND u.id=p.user_id;";
	my $sth = $dbh->prepare($sql) || die "$DBI::errstr\n$sql\n";
	my $nrows = $sth->execute() || die "$DBI::errstr\n$sql\n";
	return undef if $nrows < 1;
	my @row = $sth->fetchrow_array;
	return $row[0];
}

sub day_pre
{
	my $dateh = shift;
	my $datep = undef;
  if($dateh =~ /^(20\d\d)-(\d\d)-(\d\d)$/)
	{
		$datep = strftime("%Y-%m-%d",
		(0,0,0,$3-1,$2-1,$1-1900)
		);
	}
	return $datep;
}
