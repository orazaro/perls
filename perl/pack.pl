#!/usr/bin/perl -w
# $Id: pack.pl,v 1.20 2010/11/11 12:55:49 oraz Exp $
use strict;
#use Test::More qw(no_plan);
use Test::More tests=>15;

my($s,$s1,$i,$hex,@w);

my $mem = "1234567890 - Hello, world";
( $hex ) = unpack( 'H*', $mem );
print "$hex\n";
is($hex,"31323334353637383930202d2048656c6c6f2c20776f726c64",
	"hex output");
my @hex = unpack('(a)*', $mem);
print "@hex\n";
is(join('',@hex),$mem,"ascii (nulled) unpack");

@w = map {"3$_"} (0..9);
#$s = pack('H2' x @w, @w );
$s = pack('(H2)*', @w );
print "s=$s\n";
is $s,"0123456789","pack from hex list to string";

@w = ('one','two','three');
$s = pack( 'A*' x (@w*2), 
	         map{$w[$_],'_'}(0..$#w) 
					 );
print "$s\n";
is $s,"one_two_three_","gaps in list filled with _";

$s = pack "C4", 65..68;
$s1 = pack "A3"x4, 65..68;
print "s=$s s1='$s1'\n";
is $s, "ABCD", "pack nums to chars";

print pack "C*", unpack "(x C)*", "Hello world!\n\n";
$s = pack "C*", unpack 
"(
C # select odd char
x # skip even char
)*", "Hello world!\n\n";
is $s,"Hlowrd\n","skip even chars using (Cx) unpack and pack";

# numbers
# check big-low endian
my @s = unpack "C*", pack "L", 0x04030201;
print "@s : ",$s[0] == '1'?"low":"high"," endian\n";
is $s[0], '1', "low endian on intel machines";

my @hello_as_hex = unpack "(H2)*", "hello"; # "68656c6c6f"
print "@hello_as_hex","=>",pack ("(H2)*", @hello_as_hex),"\n"; # say hello!
is(pack ("(H2)*", @hello_as_hex),"hello","pach haxadecimal");

$s = unpack ("B*", "hi!");  
is $s, "011010000110100100100001", "unpack as binary string";

$s = "hello world!";
print $s,"=>";
print "$_ " for unpack "(B8)*", $s; print"\n";
$s1 = join(" ", unpack "(B8)*", $s);
is $s1, "01101000 01100101 01101100 01101100 01101111 00100000 01110111 01101111 01110010 01101100 01100100 00100001", "string to delemeted binary bites";

@w = map {lc} unpack "A5 x A5", "Hello-World!";
print "@w\n";
is join(" ",@w), "hello world", "split using 'x' as delimiter" ;

# x* - to the end of string
# X3 - back 3 letters
# A* - get remains as string
my ($ing) = unpack "x* X3 A*", "suffixing";
print "ing=$ing\n";
is $ing, "ing", "get suffix using unpack";

# skip abs positions
# use single quotas!!!
print unpack('@6 a3',"suffixing"),"\n";
is join('',  unpack('@6 a3',"suffixing")), "ing", "cut at absolute pos and get suffix";

# get char as char
# go back
# get same char as number
my @pairs = unpack '(a X C)*', "Hello";
print "@pairs\n";
is join(' ',@pairs), "H 72 e 101 l 108 l 108 o 111", "double read field in unpack";

# parse who command
for(`who`) {
	chomp;
	my($user,$tty,$time) = unpack "A8 A8 A*", $_;
	print "user=$user;tty=$tty;time=$time\n";
}

$i = 1961;
#$s = unpack("B32", $i);
$s = sprintf("%b", $i);
print "s=$s i=$i b=",bintodec($s),"\n";
is $i, bintodec($s), "convet binary string to decimal";

sub bintodec {
	unpack("N", pack("B32", substr("0" x 32 . shift, -32)));
}
