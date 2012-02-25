#!/usr/bin/perl -w
#
while(<>) {
	@words = split(/\W+/);
	foreach $word (@words) {
		$count{$word} ++;
	}
}
for $word (sort by_count keys %count) {
	print "$word occures $count{$word} times\n";
}
sub by_count {
	$count{$b} <=> $count{$a};
}
