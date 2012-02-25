#!/usr/bin/perl -w
use strict;
package Hello;
use base 'Exporter';
our @EXPORT_OK = qw(say_hello);

sub new {
	my($class,$name) = @_;
	my $self = { name => $name };
	bless $self, $class;
	return $self;
}

sub say_hello {
	my ($self,$name) = @_;
	if(defined($name)) {
		print "Hi $name!\n";
	} else {
		print "Hi $self->{name}!\n";
	}
}
1;
