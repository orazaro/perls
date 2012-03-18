#!/usr/bin/perl -w
#
while(<>) {
	@words = split(/\W+/);
	foreach $word (@words) {
		$count{$word}{$ARGV} ++;
	}
}
for $word (sort keys %count) {
		$left = "$word: ";
		$right =
		join(", ",
			map "$_: $count{$word}{$_}",
			sort keys %{$count{$word}}
			);
		write;	
}

format STDOUT =
@<<<<<<<<<<<<<<<<<<^<<<<<<<<<<<<<<<<<<<<<<<<<<<
$left,             $right
                   ^<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< ~~
                   $right
.

