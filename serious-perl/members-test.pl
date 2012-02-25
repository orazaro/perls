#!/usr/bin/perl -w
#$Id: members-test.pl,v 1.1 2010/02/11 15:26:44 oraz Exp $

use strict;

package Student;
use members 'name',
            'registration',
            'grades';

sub new {
    my($class, $name) = @_;
    $self = fields::new($class);
    $self->{name} = $name;
    return $self;
}

package main;
my $eliza = Student->new('Eliza');
print $eliza->name,"\n";            # Look Ma, no curly brackets! Same as $eliza->name()
$eliza->name = 'WonderEliza';  # Works because our accessors are lvalue methods
print $eliza->name,"\n";            # Prints "WonderEliza"

