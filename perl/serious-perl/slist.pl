#!/usr/bin/perl -w
# $Id: slist.pl,v 1.3 2010/05/01 16:13:17 oraz Exp $
use strict;

package Node;
sub new {
	my($class,$n,$parent) = @_;
	my $self = { 
		next => undef,
		n => $n
		};
	$parent->{next} = $self if defined $parent;
	bless($self,$class);
	return $self;
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
	my $last = $self->{next};
	while($last) {
		print"$last->{n} ";
		$last = $last->{next};
	}
	print"\n";
}
sub rev {
	my($self) = @_;
	my $last = $self->next;
	my $r = undef;
	while($last) {
		my $node = Node->new($last->{n});
		$node->next($r);
		$r = $node;
		$last = $last->{next};
	}
	my $rr = Node->new();
	$rr->next($r);
	return $rr;
}
1;
package SList;
my @nums = (1,2,3,6,11,8);
my $root = new Node;
my $last = $root;
for my $i (@nums)
{
	$last = Node->new($i,$last);
}
$root->lout();
my $r = $root->rev();
$r->lout();

