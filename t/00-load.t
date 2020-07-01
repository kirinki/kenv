#!perl -T

use 5.030;
use strict;
use warnings;
use Test::More;

plan tests => 3;

BEGIN {
	use_ok( 'kirinki::env' ) || print "Kirinki::env bailed out!\n";
	use_ok( 'kirinki::env::config' ) || print "Kirinki::env::config bailed out!\n";
	use_ok( 'kirinki::git' ) || print "Kirinki::git bailed out!\n";
}

diag( "Testing kirinki::env $kirinki::env::VERSION, Perl $], $^X" );
diag( "Testing kirinki::env::config $kirinki::env::config::VERSION, Perl $], $^X" );
diag( "Testing kirinki::git $kirinki::git::VERSION, Perl $], $^X" );
