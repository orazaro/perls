package members;

sub import {

	my($class, @fields) = @_;
	return unless @fields;
	my $caller = caller();

	# Build the code we're going to eval for the caller
	# Do the fields call for the calling package
	my $eval = "package $caller;\n" .
	           "use fields qw( " . join(' ', @fields) . ");\n";

	# Generate convenient accessor methods
	foreach my $field (@fields) {
		$eval .= "sub $field : lvalue { \$_[0]->{$field} }\n";
	}

	# Eval the code we prepared
	eval $eval;

	# $@ holds possible eval errors
	$@ and die "Error setting members for $caller: $@";
}
1.
