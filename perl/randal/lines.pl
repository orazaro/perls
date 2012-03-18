#!/usr/bin/perl -w
#
while(<>) {
	$count{$ARGV}++;
}
for $file (sort by_count keys %count) {
	print "$file has $count{$file} lines\n";
}
sub by_count {
	$count{$b} <=> $count{$a};
}
