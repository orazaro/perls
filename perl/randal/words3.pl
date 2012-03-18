#!/usr/bin/perl -w
#
while(<>) {
	@words = split(/\W+/);
	foreach $word (@words) {
		$count{$word}{$ARGV} ++;
	}
}
for $word (sort keys %count) {
	print 
		"$word: ",
		join(", ",
			map "$_: $count{$word}{$_}",
			sort keys %{$count{$word}}
			),
		"\n";
}
