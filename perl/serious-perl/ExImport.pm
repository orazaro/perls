#$Id: ExImport.pm,v 1.2 2010/02/11 15:10:24 oraz Exp $

package ExImport;

sub import {
	my($class, @params) = @_;
	print "Look, [" . caller() . "] is trying to import me[$class]!\n";
	print "params: @params\n";
}

1.
