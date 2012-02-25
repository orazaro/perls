#!/usr/bin/perl -w
#$Id: urlencode.pl,v 1.1 2010/03/18 10:46:39 oraz Exp $
use strict;

use Getopt::Std;

my %opts = ();
getopts('d',\%opts);
if(@ARGV!=1){
	print STDERR "Usage: $0 [-d] <string>\n";
	exit 1;
}
my $str = shift;
print"i: $str\n";
if($opts{d}){
	# decode
	$str =~ s/\%([A-Fa-f0-9]{2})/pack('C',hex($1))/seg;
}else{
	# encode
	$str =~ s/([^A-Za-z0-9])/sprintf("%%%02X",ord($1))/seg;
}
print"o: $str\n";
