#!/usr/bin/perl -w
# $Id: slist2.pl,v 1.3 2010/05/01 17:51:44 oraz Exp $
use strict;

package SList;
sub new {
	my($class,$n,$parent) = @_;
	if($parent && (!defined $parent->{n}))
	{
		$parent->{n} = $n;
		return $parent;
	}
	my $self = { 
		next => undef,
		n => $n
		};
	$parent->next($self) if $parent;
	bless($self,$class);
	return $self;
}

sub new_arr {
	my $class = shift;
	my $root = new SList;
	my $last = $root;
	map {$last = SList->new($_,$last)} @_;
	return $root;
}

sub next {
	my($self,$next) = @_;
	$self->{next} = $next if defined $next;
	return $self->{next};
}

sub n {
	my($self,$n) = @_;
	$self->{n} = $n if defined $n;
	return $self->{n};
}

sub lout {
	my($self) = @_;
	while($self) {
		print"$self->{n} " if defined $self->{n};
		$self = $self->{next};
	}
	print"\n";
}
sub rev {
	my($self) = @_;
	my $last = $self;
	my $r = undef;
	while($last) {
		my $node = SList->new($last->{n});
		$node->next($r);
		$r = $node;
		$last = $last->{next};
	}
	return $r;
}
1;
package Prog;
my @nums = (1,2,3,6,11,8);
my $root = SList->new_arr(@nums);
$root->lout();
my $r = $root->rev();
$r->lout();

