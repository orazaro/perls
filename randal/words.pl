#!/usr/bin/perl -w
#
while(<>) {
	@words = split(/\W+/);
	$count{$ARGV} += @words;
}
for $file (sort by_count keys %count) {
	print "$file has $count{$file} words\n";
}
sub by_count {
	$count{$b} <=> $count{$a};
}
