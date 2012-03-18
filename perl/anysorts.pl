#!/usr/bin/perl -w
#$Id: anysorts.pl,v 1.1 2010/03/19 03:53:50 oraz Exp $
# (c) Oleg Razgulyaev, 2010
# examples of any sorts: bubble, selects, merge, quick
# and forked verion of merge (parallel)
# perl sort also included
use strict;
use Getopt::Std;

#use IO::Handle;
# need to autoflush only

my %opts;
getopts("ibsqpfdto",\%opts);

srand;
my @arr;
my $n = 10;
my $m = 1000;
if($opts{t}){
	push @arr, @ARGV;
	$n = scalar @arr;
}
else{
	$n = $ARGV[0] if(@ARGV>0);
	$m = $n if($m < $n);
	while($n--)
	{
		push @arr, rand($m)%$m;
	}
}

print "in: @arr\n" if $opts{i};

if($opts{p}){
	@arr = sort{$a<=>$b}@arr;
}
elsif($opts{b}){
	@arr = bubble_sort(@arr);
}
elsif($opts{s}){
	@arr = select_sort(@arr);
}
elsif($opts{f}){
	@arr = merge_sort_fork(@arr);
}
elsif($opts{q}){
	@arr = quick_sort(@arr);
}
else{
	@arr = merge_sort(@arr);
}

print "out: @arr " if $opts{i};
if($opts{o}){
	my $ok = "ok";
	for(my $i = 0; $i < $#arr; $i++)
	{
		if($arr[$i] > $arr[$i+1]){
			$ok = "bad";
			last;
		}
	}
	print "$ok\n";
}
else{print"\n";}


sub swap
{
	my ($a, $i, $j) = @_;
	my $tmp = $a->[$i];
	$a->[$i] = $a->[$j];
	$a->[$j] = $tmp;
}

sub qsort
{
	my ($a, $i, $j) = @_;
	return unless($i < $j);
	if($j - $i == 1){
		swap($a,$i,$j) if($a->[$i]>$a->[$j]);
		return;
	}
	my $k = $i + int(rand($j - $i + 1));
	my $pivot = $a->[$k];
	my ($l,$r) = ($i,$j);
	while($l <= $r)
	{
		if($opts{d}){
			print("l=$l r=$r p=$pivot a[l]=$a->[$l] a[r]=$a->[$r]\n");
			print("a: @$a[$i..$l]- @$a[$l+1..$r]+ @$a[$r+1..$j]\n");
			my $x = <STDIN>;
		}
		if($a->[$l] < $pivot){$l++;next}
		if($a->[$r] > $pivot){$r--;next}
		print("swap: l=$l r=$r p=$pivot a[l]=$a->[$l] a[r]=$a->[$r]\n") 
			if($opts{d});
		swap($a,$l,$r);
		$l++; $r--;
	}
	
	if($opts{d})
	{
		print"separated: p=$pivot l=$l r=$r\n";
		print("left: @$a[$i..$l-1]\n");
		print("right: @$a[$l..$j]\n");
	}
	qsort($a,$i,$l-1);
	qsort($a,$l,$j);
}

sub quick_sort
{
	my @a = @_;
	qsort(\@a, 0, $#a);
	return @a;
}

sub merge;

sub merge_sort_fork
{
	return @_ if @_ < 2;
	
	my $fsort = \&merge_sort;

	#split
	my @arr = @_;
	my @arr1 = splice(@arr,0,@arr/2);

	my($READER, $WRITER);
	pipe($READER, $WRITER);
	#$WRITER->autoflush(1);
	my $pid;
	if($pid = fork)
	{
		#parent
		close $WRITER;
		@arr1 = &$fsort(@arr1);
		@arr = ();
		while(<$READER>)
		{
			chomp;
			push @arr, $_;
		}
		waitpid($pid,0);
	}
	else
	{
		#child
		die "cannot fork: $!" unless defined $pid;
		@arr = &$fsort(@arr);
		close $READER;
		for(@arr)
		{
			print $WRITER "$_\n";
		}
		close $WRITER;
		exit(0);
	}
	
	#merge
	my @res = merge(\@arr,\@arr1);

	return @res;
}

sub merge_sort
{
	return @_ if @_ < 2;
	
	#split
	my @arr = @_;
	my @arr1 = splice(@arr,0,@arr/2);
	@arr1 = merge_sort(@arr1);
	@arr = merge_sort(@arr);
	
	#merge
	my @res = merge(\@arr,\@arr1);

	return @res;
}

sub bubble_sort
{
	my @arr = @_;
	my $n = $#arr + 1;
	my $m = $n;

	while($m--)
	{
		my $swapped = 0;
		for(my $i = 0; $i < $n-1; $i++)
		{
			if($arr[$i] > $arr[$i+1])
			{
				my $tmp = $arr[$i];
				$arr[$i] = $arr[$i+1];
				$arr[$i+1] = $tmp;
				$swapped = 1;
			}
		}
		last if(!$swapped);
	}
	return @arr;
}

sub select_sort
{
	my @arr = @_;
	my $n = $#arr + 1;

	for(my $i = 0; $i < $n; $i++)
	{
		my $jmin = $i;
		for(my $j = $i+1; $j < $n; $j++)
		{
			if($arr[$j] < $arr[$jmin])
			{
				$jmin = $j;
			}
		}
		if($jmin > $i)
		{
			my $tmp = $arr[$i];
			$arr[$i] = $arr[$jmin];
			$arr[$jmin] = $tmp;
		}
	}

	return @arr;
}

# Implementation
#

sub merge
{
	my($arra,$arrb) = @_;
	
	#merge
	my @res = ();
	my $a = shift @$arra;
	my $b = shift @$arrb;
	while(1)
	{
		if(!defined($a)){
			push @res, $b;
			push @res, @$arrb;
			last;
		}
		if(!defined($b)){
			push @res, $a;
			push @res, @$arra;
			last;
		}
		if($a > $b) {
			push @res,$b;
			$b = shift @$arrb;
		}
		else{
			push @res,$a;
			$a = shift @$arra;
		}
	}

	return @res;
}

