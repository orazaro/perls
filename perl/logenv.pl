#!/usr/bin/perl
print "Content-type: text/html\n\n";
open(my $fh, '>>', "/usr2/ban_sys/httpd/cgi-bin/logenv.log") or die $!;
print $fh "=====================================================\n";
print $fh "LOGENV: date: ",scalar localtime(time),"\n";
print $fh "=====================================================\n";
foreach $key (keys(%ENV)) {
	print $fh $key,"=",$ENV{$key},"<br>\n"
}
print $fh "=====================================================\n";
close $fh;
