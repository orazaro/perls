#!/usr/bin/perl -w

use strict;

package MyProg;
use Hello;

my $hello = Hello->new('default');
$hello->say_hello();
$hello->say_hello('oleg');
