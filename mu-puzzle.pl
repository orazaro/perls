#!/usr/bin/perl -w
# $Id: mu-puzzle.pl,v 1.9 2010/11/27 12:31:30 oraz Exp $
# MIU formal system:
# elements M,I,U
# rules (x,y can be null):
# 1) xI => xIU
# 2) Mx => Mxx
# 3) xIIIy => xUy
# 4) xUUy => xy

use strict;
no warnings "recursion";

use Test::More;
plan tests => 1;

my %Dic = ();
my $Maxword = 10;
my $Keys = 0;

my $Target = 
"MU";
#"MIUUU";

if(@ARGV == 1) {
	$Maxword = $ARGV[0];
} elsif(@ARGV == 2) {
	$Maxword = $ARGV[0];
	$Target = $ARGV[1];
}

test_steps();

my $Start = "MI";
$Dic{$Start} = length $Start;
print"Found!\n" if(product($Start));

my $keys = scalar keys %Dic;
my $maxkeys = 2 ** ($Maxword-1);
print"keys=$keys\tpercent=",$keys/$maxkeys*100,"%\n";

exit;

sub steps
{
	my ($word) = @_;
	my @steps = ();
	my @word = split //,$word;
# 4) xUUy => xy
	if($word =~ /UU/) {
		for(0..$#word) {
			my $pos = $_;
			last if($pos + 1 > $#word);
			if($word[$pos] eq 'U' 
				and $word[$pos+1] eq 'U') {
				my @next = ();
				push @next, @word[0..$pos-1] if($pos > 0);
				push @next, @word[$pos+2..$#word] if($pos+2 <= $#word);
				push @steps, join('',@next);
			}
		}
	}
# 3) xIIIy => xUy
	if($word =~ /III/) {
		for(0..$#word) {
			my $pos = $_;
			last if($pos + 2 > $#word);
			if($word[$pos] eq 'I' 
				and $word[$pos+1] eq 'I'
				and $word[$pos+2] eq 'I') {
				my @next = ();
				push @next, @word[0..$pos-1] if($pos > 0);
				push @next, 'U';
				push @next, @word[$pos+3..$#word] if($pos+3 <= $#word);
				push @steps, join('',@next);
			}
		}
	}
# 1) xI => xIU
	if($word[$#word] eq 'I') {
		my @next = @word;
		push @next, 'U';
		push @steps, join('',@next);
	}
# 2) Mx => Mxx
	if($word[0] eq 'M') {
		my @rest = @word[1..$#word];
		my @next = ('M', @rest, @rest);
		push @steps, join('',@next);
	}

	return @steps;
}

sub product {
	my ($gword) = @_;
	print "$Keys: $gword\n"
		if length $gword < 11;
	if($gword eq $Target){
		return $gword;
	}
	for(steps $gword) {
		my $word = $_;
		my $n = length($word);
		next if($n > $Maxword);
		next if(exists($Dic{$word}));
		$Dic{$word} = $n;
		$Keys++;
		my $res = product($word);
		return $res if($res);
	}
	return undef;
}

sub test_steps
{
	my $in = 'MUUIII';
	my $out = 'MIII MUUIIIU MUUIIIUUIII MUUU';
	my $steps = join " ",sort(steps($in));
	#print "steps=$steps\n";
	Test::More::is $steps, $out, "all possible steps from $in";
	Test::More::BAIL_OUT('wrong algorithm for steps!') if $steps ne $out;
}

