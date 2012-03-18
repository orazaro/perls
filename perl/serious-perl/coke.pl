#!/usr/bin/perl -w
#$Id: coke.pl,v 1.3 2010/02/11 14:19:48 oraz Exp $

package Coke;
my %CACHE;

sub new {
    my($class, $type) = @_;
    return $CACHE{$type} if $CACHE{$type};   # Use cache copy if possible
    my $self = $class->from_db($type);       # Fetch it from the database
    $CACHE{$type} = $self;                   # Cache the fetched object
    return $self;
}

sub from_db {
    my($class, $type) = @_;

#    my $self = ...         # Fetch data from the database 
	my $tx = localtime(time);
   	my $self = {
		name => uc($type)." at ".$tx
		,type => undef
		,array => []
		,hash => {}
		};

    bless($self, $class);  # Make $self an instance of $class
    return $self;
}

sub test {
	print join("|", @_),"\n";
	my($self,$argv1) = @_;
	print "$argv1: ",join("|",keys%{$self}),"\n";
}

package main;
#use Coke;

while(<>)
{
	chomp;
	my $foo = Coke->new($_);
	print"$foo->{name}\n";
	$foo->test("hello from foo");
	Coke->test("hello from Coke");
}

