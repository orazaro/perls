#!usr/bin/perl -w

sub newprint {
	my $x = shift;
	return sub { my $y = shift; print "$x, $y!\n"; };
}

$h = newprint("ha");
$g = newprint{"ga"};
#...
#$f = newprint("HAA","GAA");
#..
&$h("world");
&$g("earthlings");

