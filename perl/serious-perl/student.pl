#!/usr/bin/perl -w
#$Id: student.pl,v 1.3 2010/02/11 14:33:35 oraz Exp $
use strict;

package Student;
sub foo_new
{
	my($class, $name) = @_;
	my $self = { name => $name };
	print "$self | $class | $name\n";
	bless($self, $class);
	print "$self | $class | $name\n";
	return $self;
}

sub new {
	my($class, $name) = @_;
	my $self = $class->foo_new($name);
	return $self;
}

sub work {
	my($self) = @_;
	print "$self->{name} is working\n";
}

sub sleeps {
	my($self) = @_;
	print "$self->{name} is sleeping\n";
}

package Student::Busy;
use base 'Student';

sub hello {
	my($self) = @_;
	print "Hello, $self->{name}!\n";
}

package main;
#use Student; # online defined here
my $amy = Student->foo_new('Amy');
print "$amy->{name}\n";

my $x = Student::foo_new('Student','x');
print "$x->{name}\n";

$amy->work();
$x->sleeps();
$x->work();
$amy->sleeps();

my $bman = Student::Busy->new("bman");
$bman->hello();

