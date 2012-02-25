#!/usr/bin/perl -w -T

package MyPackage;

use strict;
use base qw(Net::Server::PreFork); # any personality will do

MyPackage->run(
	port => 8000
);

### over-ridden subs below

sub process_request {
	my $self = shift;
	eval {

		local $SIG{'ALRM'} = sub { die "Timed Out!\n" };
		my $timeout = 30; # give the user 30 seconds to type some lines

		my $previous_alarm = alarm($timeout);
		while (<STDIN>) {
			s/\r?\n$//;
			print "You said '$_'\r\n";
			print STDERR "$_\r\n";
			alarm($timeout);
			last if /quit/i;
		}
		alarm($previous_alarm);

	};

	if ($@ =~ /timed out/i) {
		print STDOUT "Timed Out.\r\n";
		return;
	}

}

1;
