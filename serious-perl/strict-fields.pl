#!/usr/bin/perl -w
#$Id: strict-fields.pl,v 1.1 2010/02/11 14:53:48 oraz Exp $

use strict;

package Student;

use fields 'name',
           'registration',
           'grades';

sub new {
    my($class, $name) = @_;
    my $self = fields::new($class);  # returns an empty "strict" object
    $self->{name} = $name;        # attributes get accessed as usual
    return $self;                 # $self is already blessed
}

package main;
#use Student;

my $clara = Student->new('Clara');
$clara->{name} = 'WonderClara';  # works
$clara->{gobbledegook} = 'foo';  # blows up


